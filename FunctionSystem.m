%
% This function calculates the resulting values for the right side of 
% the diff equation system which are then passed to the Runge-Kutta calc.
%
% Author: Dmitry Eliseev 
% Date: 01.03.2016
%

function y = FunctionSystem(t, arg, Depth0 ,TracesNumber)

AngleStep = pi/(TracesNumber-1);


% Firstly the value for the point on the vertical axis below the emitter 
% is calculated (for this point the angle partial diff is zero)
y(1) = VelocityDependence(arg(1)+Depth0); 

for  i= 2:TracesNumber
    theta = (i-1)*AngleStep;
    partial_theta = (arg(i-1)-arg(i))/AngleStep;
    
    y(i) = VelocityDependence(arg(i)*cos(theta)+Depth0)*...
                              sqrt(1+(partial_theta/arg(i))^2);
end;


