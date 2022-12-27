function [antiMat] = setMat(vector)
%根据向量生成反对称阵 antisymmetric matrix

antiMat = zeros(3,3);
antiMat(1,2) = -vector(3); antiMat(1,3) = vector(2);
antiMat(2,1) =  vector(3); antiMat(2,3) = -vector(1);
antiMat(3,1) = -vector(2); antiMat(3,2) =  vector(1);
end

