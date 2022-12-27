%% DCM转换为姿态角  横滚 俯仰 航向
function [att] = m2att(Cnb)
% Convert direction cosine matrix(DCM) to Euler attitude angles.
%
% Prototype: [att, attr] = m2att(Cnb)
% Input: Cnb - DCM from navigation-frame(n) to body-frame(b)
% Outputs: att - att=[pitch; roll; yaw] in radians, in yaw->pitch->roll
%                (3-1-2) rotation sequence
%          attr - in yaw->roll->pitch (3-2-1) roation sequence
% Test:
%   att0=randn(3,1)/10; [Cnb,Cnbr]=a2mat(att0); att=m2att(Cnb); [~,attr]=m2att(Cnbr); [att0, att, attr]

    att = [atan2(Cnb(3,2),Cnb(3,3)); %-pi~pi 
           atan(-Cnb(3,1)/(sqrt(Cnb(3,2)^2 + Cnb(3,3)^2)));            
           atan2(Cnb(2,1),Cnb(1,1)) ];
end