%主函数

%% 声明全局变量添加搜索路径
global glv
glv = glvf;
rootpath = pwd;
addpath(append(rootpath,'\attitude'));
addpath(append(rootpath,'\compensation'));
addpath(append(rootpath,'\math'));
addpath(append(rootpath,'\earth'));
addpath(append(rootpath,'\rotationVector'));
%% 测试四元数和欧拉角、DCM之间的转换是否正确,结果发现正确
att = [-0.5;0.3;-1];
att1 = m2att(q2mat(a2qua(att)));
qu1 = m2qua(a2mat(att));
qu2 = a2qua(att);
%% 读取标定数据
isRead = 0;
if isRead ~= 1 
   %读取惯导数据
   fileID = fopen('IMU.bin','r');
   imuData = fread(fileID,'double'); 
   transImuData = reshape(imuData,7,size(imuData, 1)/7)'; %把数据按照七行进行读取，坐标系是北东地坐标系
   fclose(fileID);
   %读取参考结果（参考结果非真值，是另一套惯导算法推算的结果）
   refFileID = fopen('Reference.bin','r');
   refImuData = fread(refFileID,'double'); %读取文件
   refInsResult = reshape(refImuData,10,size(refImuData, 1)/10)'; %把数据按照十行进行读取
   fclose(refFileID);
end

%北东地坐标系
imuData =  [transImuData(:,2:7), transImuData(:,1)];
firstPos = find(imuData(:,7) == 91620);
% 记录到开始积分时刻的陀螺和加计增量
imuData = imuData((firstPos+1):end, :);

ts = 0.005;% 采样间隔
% 设置初始姿态 速度和位置，att=[roll横滚角; pitch俯仰角; yaw航向角（北偏东为正0-pi，北偏西为负0-(-pi)）]  北东地坐标系
avp0 = [ 0.0107951084511778*glv.deg;-2.14251290749072*glv.deg; -75.7498049314083*glv.deg;...
    0;0;0;...
    23.1373950708*glv.deg;113.3713651222*glv.deg;2.175];
ins = initIns(avp0, ts);
% 下面两项用于将纬度和经度转换成N和E方向的距离
initRmh = ins.eth.RMh;
initclRNh = ins.eth.clRNh;
nn = 1;len = length(imuData);
% 核心部分，开始进行计算了
avp = zeros(fix(len/nn), 10);
for k=1:nn:len-nn+1
    k1 = k+nn-1;
    wvm = imuData(k:k1, 1:6);  t = imuData(k1,7);
    ins = insUpdateAlog(ins, wvm);  
    %存储姿态 速度 位置，最后一列是时间
    avp(k,:) = [ins.avp; t]';
end

%% 和参考计算结果做对比，需要将格式和参考结果对齐 北东地坐标系  att=[roll横滚角;pitch俯仰角; yaw航向角] 
transAvp = [avp(:,10),avp(:,7:8)/glv.deg, avp(:,9),...
    avp(:,4:6),...
    avp(:,1:3)/glv.deg]; 
t = transAvp(:,1);
errWithRef = transAvp - refInsResult; %计算结果和参考结果的差值
strk = '-';
phi_mu = 'phi';
myfigure; %绘图
subplot(311), hold on, plot(t, errWithRef(:,8:10), strk, 'LineWidth',2); xygo('phi_degree'); mylegend([phi_mu,'roll'],[phi_mu,'pitch'],[phi_mu,'yaw']);
subplot(312), hold on, plot(t, errWithRef(:,5:7), strk, 'LineWidth',2); xygo('dV'); mylegend('dVN','dVE','dVD');
subplot(313), hold on, plot(t, errWithRef(:,2:3), strk, 'LineWidth',2); xygo('dP_latlon'); mylegend('dlat','dlon');
% 计算NED方向的差值
errN = errWithRef(:,2)*glv.deg*initRmh;
errE = errWithRef(:,3)*glv.deg*initclRNh;
errD = -errWithRef(:,4);
errNED = [errN,errE,errD];
myfigure;
plot(t, errNED(:,1:3), strk, 'LineWidth',2); xygo('dP'); mylegend('dN','dE','dD');
