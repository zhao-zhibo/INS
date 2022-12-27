function [Gnp] = Calgnp(h,lat)

%   重力模型见牛小骥老师PPT第二部分最后一页
a = 6378137; %m
% b = 6356752.3141; %m
We = 7.292115e-5; %rad/s
f = 1.0/298.257222101;
b=(1-f)*a;
GM = 3.986005e14; %m3/s2
gamaa = 9.7803267715; %m/s2
gamab = 9.8321863685; %m/s2

m = We^2 * a^2 * b/GM; 

gama = CalGama(lat);
Gnp = gama * (1 - 2 * (1 + f + m - 2 * f * (sin(lat)^2)) * h / a + 3 * h^2 /(a^2) );
end

function [gama] = CalGama(lat)
a = 6378137; %m
% b = 6356752.3141; %m
We = 7.292115e-5; %rad/s
f = 1.0/298.257222101;
b=(1-f)*a;
GM = 3.986005e14; %m3/s2
gamaa = 9.7803267715; %m/s2
gamab = 9.8321863685; %m/s2
firstNum = (a * gamaa * (cos(lat)^2) + b * gamab * (sin(lat)^2) );
secondNum = (sqrt(a^2 * (cos(lat)^2) + b^2 * (sin(lat)^2)));
gama = firstNum/secondNum;
end

