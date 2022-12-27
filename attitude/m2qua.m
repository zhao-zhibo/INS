%% DCM转换成为四元数
function qnb = m2qua(Cnb)
% Convert direction cosine matrix(DCM) to attitude quaternion.
%
% Prototype: qnb = m2qua(Cnb)
% Input: Cnb - DCM from body-frame to navigation-frame
% Output: qnb - attitude quaternion

att = m2att(Cnb);
qnb = a2qua(att);
end