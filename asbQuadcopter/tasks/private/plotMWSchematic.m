function plotMWSchematic(ax)
% This function plots the aerial schematic of MathWorks Apple Hill campus
% in Natick, MA. for the quadcopter example. This is a private function not
% to be used directly.

% Copyright 2015 The MathWorks, Inc.

% Load image
imScale = 0.254; %meter/pixel
mapMW = imread('MWAerial.png');
sizeMap = size(mapMW);

% Display mage with the correct orientation and scale in meters
image(imScale*(0:1:sizeMap(2)+0.5),imScale*(sizeMap(1))+0.5:-1:0.5,mapMW,'Parent',ax);
axis(ax,'equal','xy');
xlabel('East [m]')
ylabel('North [m]')
grid(ax,'on');