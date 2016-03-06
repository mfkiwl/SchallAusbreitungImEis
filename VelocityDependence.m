%
% Function returns the speed velocity depending on the depth coordinate 
%
% Author: Dmitry Eliseev 
% Date: 01.03.2016

function Velocity = VelocityDependence(z)


% the set of values for an exemplary depth-velocity dependence
% ----
ZCoordinate = [0 20 40 60 80 100 120 140 160 180 200 ...
               220 240 260 280 300 320 340 360 380 400];
           
Velocities  = [2000 2300 2700 3000 3300 3500 3000 2500 2500 2500 ...
               2600 2500 3000 3000 3000 3000 3000 3000 3000 3500 3300];

Velocity = interp1(ZCoordinate, Velocities, z);


% exponentially approximated velocity of the P-Waves based on the data 
% from the South Pole (Weihaupt, SPATS)
% ----
% a =  -10243.2 ;
% b =  0.0200857;
% c =  1.3007;
% d =  3853.14;
% Velocity = a*exp(-b*z-c)+d;

% light linear anisotropy 
% ----
%  gp = 0.087;
%  Vp = 3878;
%  Velocity = (z-375)*gp+Vp;

% some more exemplary taken dependencies
% ----
%Velocity = 3000+0.000000001*z;% +20*z-0.0001*z.^3;

