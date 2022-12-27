%
function ins = insUpdateAlog(ins, imu)
% SINS Updating Alogrithm including attitude, velocity and position
% updating.
%
% Prototype: ins = insupdate(ins, imu)
% Inputs: ins - SINS structure array created by function 'insinit'
%         imu - gyro & acc incremental sample(s)
% Output: ins - SINS structure array after updating
    nn = size(imu,1);
    nts = nn*ins.ts;  nts2 = nts/2;  ins.nts = nts;
    [phim, dvbm] = cnscl(imu,2);    % coning & sculling compensation  圆锥效应补偿后的角度增量 和 划桨效应补偿后的速度增量
    %% earth & angular rate updating 
    %根据上一时刻的速度和上一个时刻的加速度外推中间时刻的速度
    vn01 = ins.vn+ins.an*nts2; 
    %根据上一时刻的位置和纬度、经度、高度微分方程外推  ins.Mpv为纬度 经度 高程微分方程的系数阵
    pos01 = ins.pos+ins.Mpv*vn01*nts2;  
    ins.eth = ethupdate(ins.eth, pos01, vn01);
    ins.wib = phim/nts; ins.fb = dvbm/nts;  % 计算陀螺的三轴角速度Wib和计算Fb比力
    %% (1)velocity updating
    % 严老师的计算公式
    ins.fn = qmulv(ins.qnb, ins.fb); %将Fb转换成Fn
    ins.an = qmulv(rv2q(-ins.eth.wnin*nts2),ins.fn) + ins.eth.gcc;%先将等效旋转矢量转换成四元数，然后将fn通过四元数进行旋转
    vn1 = ins.vn + ins.an*nts; %当前时刻的速度
    
    % 牛老师的计算公式
    vectorWnin = ins.eth.wnin * ins.ts;
    ins.vnfk = (eye(3) - 1.0/2 * setMat(vectorWnin)) * ins.Cnb * dvbm;
    ins.ngcork = ins.eth.gcc * ins.ts;
    vn1 = ins.vn + ins.vnfk + ins.ngcork; 
    ins.an = (ins.vnfk + ins.ngcork) / ins.ts;
    % 对比结果发现二者相同   
   
    %% (2)position updating
    %用处理好的系数阵和速度相乘
    ins.Mpv = [ 1/ins.eth.RMh, 0,0; 0, 1/ins.eth.clRNh, 0; 0, 0, -1];
    ins.Mpvvn = ins.Mpv*(ins.vn+vn1)/2; %ins.vn为上一时刻的速度 vn1为当前时刻的速度
    ins.pos1 = ins.pos + ins.Mpvvn*nts;
    
    % 展开计算位置
    ins.lastPos = ins.pos;
    ins.pos(3) = ins.pos(3) - 0.5 * (ins.vn(3) + vn1(3)) *nts; 
    ins.pos(1) = ins.pos(1) + 0.5 * (ins.vn(1) + vn1(1)) *nts / ...
        (ins.eth.RM + 0.5 *(ins.pos(3) + ins.lastPos(3))); 
    ins.pos(2) = ins.pos(2) + 0.5 * (ins.vn(2) + vn1(2)) *nts / ...
        ((ins.eth.RN + 0.5 *(ins.pos(3) + ins.lastPos(3)))*cos(0.5*(ins.pos(1) + ins.lastPos(1)))); 
    %对比完之后，二者结果一致
    ins.vn = vn1;
    ins.an0 = ins.an;
    %% (3)attitude updating
    ins.Cnb0 = ins.Cnb;
    % 传进去的参数分别为上一个时刻的qnb，惯导器件经过圆锥补偿的三个姿态角，n系相对i系在n系投影的三个角度
    ins.qnb = qupdt2(ins.qnb, phim, ins.eth.wnin*nts);   
    [ins.qnb, ins.att, ins.Cnb] = attsyn(ins.qnb);
    %% 整理最终结果
    ins.avp = [ins.att; ins.vn; ins.pos];
end
%