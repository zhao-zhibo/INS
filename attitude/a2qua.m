%% 欧拉角转换为四元数 ，att的顺序为横滚 俯仰 航向 ；公式来源于牛小骥PPT第二部分附录
function qnb = a2qua(att)
% Convert Euler angles to attitude quaternion.
% 转换欧拉角到四元数
% Prototype: qnb = a2qua(att)
% Input: att - att=[pitch; roll; yaw] in radians
% Output: qnb - attitude quaternion
    
    att2 = att/2;
    s = sin(att2); c = cos(att2);
    s1 = s(1); s2 = s(2); s3 = s(3); 
    c1 = c(1); c2 = c(2); c3 = c(3); 
    qnb = [ c1*c2*c3 + s1*s2*s3;
            s1*c2*c3 - c1*s2*s3;
            c1*s2*c3 + s1*c2*s3;
            c1*c2*s3 - s1*s2*c3 ];
end 