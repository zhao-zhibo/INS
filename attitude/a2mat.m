%% 欧拉角（横滚 俯仰 航向）转换为DCM
function [Cnb] = a2mat(att)
% Convert Euler angles to direction cosine matrix(DCM).
%
% Prototype: [Cnb, Cnbr] = a2mat(att)
% Input: att - att=[pitch; roll; yaw] in radians
% Outputs: Cnb - DCM from navigation-frame(n) to body-frame(b), in yaw->pitch->roll
%                (3-1-2) rotation sequence
%          Cnbr - DCM in yaw->roll->pitch (3-2-1) roation sequence
% Test:
%   att0=randn(3,1)/10; [Cnb,Cnbr]=a2mat(att0); att=m2att(Cnb); [~,attr]=m2att(Cnbr); [att0, att, attr]

    s = sin(att); c = cos(att);
    s1 = s(1); s2 = s(2); s3 = s(3); 
    c1 = c(1); c2 = c(2); c3 = c(3);     
    Cnb = [ c2*c3, -c1*s3 + s1*s2*c3,  s1*s3+c1*s2*c3;
            c2*s3,  c1*c3 + s1*s2*s3,  -s1*c3+c1*s2*s3;
           -s2,           s1*c2,     c1*c2           ];
end
