function xygo(xtext, ytext)
% Xlable 'xtext', Ylabel 'ytext' & Grid On
%
% Prototype: xygo(xtext, ytext)
% Inputs: xtext, ytext - text labels to show in figure x-axis & y-axis, 
%             but if nargin==1, then the xtext will show in y-axis  
%             with time label shown defaultly in x-axis.

    if nargin==0 % xygo
        ytext = 'value';
        xtext = '\itt \rm / s';
    end
    if nargin==1 % xygo(ytext)
        ytext = xtext;
        xtext = '\itt \rm / s';
    end
	xlabel(labeldef(xtext));
    ylabel(labeldef(ytext));
    grid on;  hold on;