%
% Calculation of the expanding sound front in an vertically anisotropic 
% environment. 
%
% Author: Dmitry Eliseev 
% Date: 01.03.2016
% ---------------------------------------------------------------------
% Usage: 
% 1. Make sure that the files: AusbreitungStatic.m; rk4plus.m; 
%    FunctionSystem.m; VelocityDependence.m are in the working directory
% 2. Set the configuration variables in this file as needed for your task 
% 3. The vertical profile of the sound speed is given in the file
%    VelocityDependence.m - you may choose one of the examplary given or
%    add your own.
% 4. Run this file in MATLAB
%

clear all;
clc;

% Number of fronts to be calculated
CalcPointsProTrace = 500; 

% Number of fronts to be shown in the resulting diagramm
ShowFrontsNumber = 4; 

% Number of the directions along which the sound propagation is calculated
% These directions cover the right half-plane; the solution for the left
% part is symmetric
TracesNumber = 181;

% Vector defining the initial form of the excitation 
% For example: all "1" defines the circle with 1m radius
InitRadius(1:TracesNumber) = 1;

% Where the center of the transmitter
InitDepth = 30;

% Time in seconds during which the front expandation to be calculated
EndTime = 0.055;

% Argument step for the fronts to be shown in the resulting diagramm
FrontsAbstand = CalcPointsProTrace/ShowFrontsNumber;

% Each angle gives the direction for which the R(t) is calculated
Angles = linspace(0,pi,TracesNumber);

% here the FunctionSystem is numerically calculated with given parameters
FrontsCurves  = rk4plus(@FunctionSystem, 0, EndTime, InitRadius(1,:), ...
                        InitDepth, CalcPointsProTrace, TracesNumber);

% for further representation tuning the furthest curve is needed
FurthestCurve = FrontsCurves(CalcPointsProTrace+1, :);

% max vertical dimensions for the Diagramm
MaxDimensionZ = ceil(FurthestCurve(1)+20+InitDepth);

% max horizontal dimensions for the Diagramm
MaxDimensionX = ceil(max(FurthestCurve.*sin(Angles))+20); 

% Plot the speed-vs-depth profile
Depth = linspace(1,MaxDimensionZ);
VelocityProfile = VelocityDependence (Depth);

plot(Depth,VelocityProfile,'LineWidth',1);
axis ([0,MaxDimensionZ,0,4000]);
ylabel('Speed (m/s)');
xlabel('Depth (m)');

% save the speed-vs-depth profile as PDF
set(gcf,'papersize',[21,15])
set(gcf,'paperposition',[-1.8,0,25,15])
print -dpdf SpeedDepthProfile.pdf

% Plotting the fronts
PlotCounter = 1; 
for j=FrontsAbstand:FrontsAbstand:CalcPointsProTrace
   x=FrontsCurves(j,:).*sin(Angles);
   z=-(FrontsCurves(j,:).*cos(Angles)+InitDepth);
   
   PlotRef(PlotCounter)=plot ([x fliplr(-x)],[z fliplr(z)],'LineWidth',1);
   hold on;
      
   DisplayTime{PlotCounter} = strcat(num2str(ceil((EndTime/...
                                CalcPointsProTrace)*j*1000)), ' ms'); 
   PlotCounter=PlotCounter+1;
end;


% make the plots fine
plot (0,-InitDepth,'ko','MarkerSize',5,'MarkerFaceColor',[0.7,0.7,0.7]);
legend (PlotRef(1,:), DisplayTime{1,:},'Location','southwest');
legend ('boxoff');
xlabel('Horizontal coordinate (m)');
ylabel('Depth (m)');
axis equal;
axis ([-MaxDimensionX,MaxDimensionX,-MaxDimensionZ,0]);

% output to a pdf file
set(gcf,'papersize',[21,13])
set(gcf,'paperposition',[-1.8,-0.5,25,14])
print -dpdf FrontsVsTime.pdf
