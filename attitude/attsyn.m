%% 任意形式转换成为四元数，欧拉角，DCM
function [qnb, att, Cnb] = attsyn(attForm)
% Attitude synchronization, i.e. let qnb, att and Cnb to represent the 
% same attitude value.
% 
% Prototype: [qnb, att, Cnb] = attsyn(attForm)
% Input: attForm - attitude in Euler angles, DCM or quaternion form
% Outputs: qnb - attitude quaterinon
%          att - Euler angles, att=[pitch; roll; yaw] in arcdeg
%          Cnb - DCM from body-frame to navigation-frame

    [m, n] = size(attForm);
    mn = m*n;
    if mn==9         % if the input is direct cosine matirx
        Cnb = attForm; 
        qnb = m2qua(Cnb);%DCM转换成四元数
        att = m2att(Cnb);
    elseif mn==4     % if the input is quaternion
        qnb = attForm;
        Cnb = q2mat(qnb); 
        att = m2att(Cnb);
    elseif mn==3     % if the input is Euler attitude angles
        att = attForm;
        Cnb = a2mat(att);
        qnb = m2qua(Cnb);
    end
end