function [phim, dvbm, dphim, rotm, scullm] = cnscl(imu, coneoptimal)
% Coning & sculling compensation.
%
% Prototype: [phim, dvbm, dphim, rotm, scullm] = cnscl(imu, coneoptimal)
% Inputs:  imu(:,1:3) - gyro angular increments
%          imu(:,4:6) - acc velocity increments (may not exist)
%          coneoptimal - 0 for optimal coning compensation method,
%                        1 for polinomial compensation method.
%                        2 single sample+previous sample
%                        3 high order coning compensation
% Outputs: phim - rotation vector after coning compensation
%          dvbm - velocity increment after rotation & sculling compensation
%          dphim - attitude coning error
%          rotm - velocity rotation error
%          scullm - velocity sculling error
global glv
    if nargin<2,  coneoptimal=0;  end
    [n, m] = size(imu);
    %% coning compensation
    wm = imu(:,1:3);
	if n==1
        wmm = wm;
        if coneoptimal==2
            dphim = 1/12*cros(glv.wm_1,wm);  if m<6, glv.wm_1 = wm; end
        else
            dphim = [0, 0, 0];
        end
	end
    phim = (wmm+dphim)';  dvbm = [0; 0; 0];
    %% sculling compensation
    if m>=6
        vm = imu(:,4:6); 
        if n==1
            vmm = vm;
            if coneoptimal==0
                scullm = [0, 0, 0];
            else
                scullm = 1/12*(cros(glv.wm_1,vm)+cros(glv.vm_1,wm));  glv.wm_1 = wm; glv.vm_1 = vm;
            end
        rotm = 1.0/2*cros(wmm,vmm);
        dvbm = (vmm+rotm+scullm)';
        end
    end