function eth = ethupdate(eth, pos, vn)
% Update the Earth related parameters, much faster than 'earth'.
%
% Prototype: eth = ethupdate(eth, pos, vn)
% Inputs: eth - input earth structure array
%         pos - geographic position [lat;lon;hgt]
%         vn - velocity
% Outputs: eth - parameter structure array

    if nargin==2,  vn = [0; 0; 0];  end
    eth.pos = pos;  eth.vn = vn;
    eth.sl = sin(pos(1));  eth.cl = cos(pos(1));  eth.tl = eth.sl/eth.cl; 
    eth.sl2 = eth.sl*eth.sl;  sl4 = eth.sl2*eth.sl2;
    sq = 1-eth.e2*eth.sl2;  RN = eth.Re/sqrt(sq); 
    eth.RNh = RN+pos(3);  eth.clRNh = eth.cl*eth.RNh;
    eth.RMh = RN*(1-eth.e2)/sq+pos(3);
    eth.RM = RN*(1-eth.e2)/sq;
    eth.RN = RN;

    eth.wnie = [ eth.wie*eth.cl; 0; -eth.wie*eth.sl];  %北东地坐标系
    eth.wnen = [vn(2)/eth.RNh; -vn(1)/eth.RMh;  -vn(2)/eth.RNh*eth.tl]; %北东地坐标系
    eth.wnin = eth.wnie + eth.wnen;
    eth.wnien = eth.wnie + eth.wnin;

%   eth.g = eth.g0*(1+5.27094e-3*eth.sl2+2.32718e-5*sl4)-3.086e-6*pos(3); %
%   上面这个是严老师的计算公式
    eth.g = Calgnp(pos(3), pos(1)); %%%求出当前位置的正常重力   
    eth.gn = [0; 0; eth.g];
    eth.gcc = eth.gn - cros(eth.wnien,vn);   % Gravitational/Coriolis/Centripetal acceleration
end 