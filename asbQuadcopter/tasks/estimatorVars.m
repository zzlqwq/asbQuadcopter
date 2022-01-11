%% Estimator Variables

% This file was derived from work by Fabian Riether.

% Copyright 2017 The MathWorks, Inc.

Estimator.inverseIMUGain = [1./Sensors.IMUAccelGain 1./Sensors.IMUGyroGain];

%IMU
Estimator.IMU.filterAccel = designfilt('lowpassfir', 'FilterOrder',5, ...
    'CutoffFrequency', 0.1);
[Estimator.IMU.filterGyroNum,Estimator.IMU.filterGyroDen] = cheby2(5,40,0.8);

Estimator.gyroAngleUpdateAccThreshold = 0.002;
Estimator.gyroAngleUpdateAccWeight = 0.001;
Estimator.gyroAngleUpdateVisWeight = 0.2;
Estimator.gyroscopeSensitivity = 1;
Estimator.complementaryFilterInit = single([0 0 0]);

%Altitude
[Estimator.alt.filterPrsNum,Estimator.alt.filterPrsDen] = butter(3,0.01);
[Estimator.alt.filterSonarNum,Estimator.alt.filterSonarDen] = butter(3,0.01);

%KF
Estimator.alt.kf.G = [0;1];
Estimator.alt.kf.H = 0;
Estimator.alt.kf.Q = 0.0005;
Estimator.alt.kf.R = [0.1];
Estimator.alt.kf.N = 0;

%outlier Thresholds
Estimator.alt.deltaSonarToCurrentMax             = 0.3;
Estimator.alt.deltaPrsToCurrentThreshold         = 0.8;
Estimator.alt.deltaSonarToFilteredThreshold      = 0.4;

%Position
%--
Estimator.pos.opticalFlowZMax = -0.4;
Estimator.pos.accelerationInputGain = 0.2;
switch model
    case 'Mambo'
        Estimator.pos.opticalFlowToVelocityGain = 1;
    case 'RollingSpider'
        Estimator.pos.opticalFlowToVelocityGain = 20;
end


%OpticalFlow Outlier Handling
Estimator.pos.ofPitchRollMax = 0.6;
Estimator.pos.ofPQMax = 7.0;
Estimator.pos.ofPQHovMax = 0.5;
Estimator.pos.ofDPQMax = 80;

Estimator.pos.deltaDXYMax = 5; %m/s

%KF velocity
Estimator.pos.kfVelo.G = eye(2);
Estimator.pos.kfVelo.H = 0;
Estimator.pos.kfVelo.Q = 0.09.*eye(2);
Estimator.pos.kfVelo.R = 5*eye(2);
Estimator.pos.kfVelo.N = 0;

%KF position
Estimator.pos.kfPos.G = 0.1*eye(2);
Estimator.pos.kfPos.H = 0;
Estimator.pos.kfPos.Q = 0.001*eye(2);
Estimator.pos.kfPos.R = 0.3*eye(2);
Estimator.pos.kfPos.N = 0;

%Visually reconstructed position from marker setup - Outlier Handling
Estimator.pos.visOrientMax = 0.18;
Estimator.pos.visDeltaXYMax = 1;
