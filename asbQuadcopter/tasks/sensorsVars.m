%% Sensors Library Block Variables

% This file is derived from the work by Fabian Riether.
% Copyright 2013-2018 The MathWorks, Inc.

% Load data calibration
load('sensorCalibration.mat');

%Bias (some assumed, simulated default)
Sensors.IMUAccelGain = [+1.00596 +1.00383 +0.99454];
Sensors.IMUGyroGain = [0.99861 1.00644 0.99997];

% IMU
% Main
Sensors.IMU.cg = [0 0 0];
% Accelerometer
Sensors.IMU.location = [0 0 0];  %IMU pos relative to datum
Sensors.IMU.accNatFreq = 190; %Accelerometer natural frequency
Sensors.IMU.accDamping = 0.707; %Accelerometer damping ratio
Sensors.IMU.accScaleCross = diag(Sensors.IMUAccelGain);
Sensors.IMU.accBias = sensorCalibrationData(1:3)+[0 0 g];
Sensors.IMU.accLimits = [-50 -50 -50 50 50 50];
% Gyroscope
Sensors.IMU.gyroNatFreq = 190;
Sensors.IMU.gyroDamping = 0.707;
Sensors.IMU.gyroScaleCross = diag(Sensors.IMUGyroGain);
Sensors.IMU.gyroBias = sensorCalibrationData(4:6);
Sensors.IMU.gyroGBias = [0 0 0];
Sensors.IMU.gyroLimits = [-10 -10 -10 10 10 10];
% Noise
Sensors.IMU.noiseSeeds = 41*ones(6,1);
Sensors.IMU.noiseWeights = [0.8 0.8 0.8 0.025 0.025 0.025];
Sensors.IMU.noisePower = Sensors.IMU.noiseWeights.*[0.0165195073635001 0.0152648883285633 0.0215786550496705 ...
    0.000652733165165932 0.000721701528439517 0.000690781425279554].^2;
Sensors.Sonar.noisePower = 1;
Sensors.Sonar.noiseSeeds = 41;
%Vision
Sensors.NO_VIS_X = -99.0;
Sensors.NO_VIS_YAW = -9.0;
Sensors.dummy.posVISNoVisionAvail = [Sensors.NO_VIS_X;0.0;0.0;Sensors.NO_VIS_YAW ]; %drone sends this position to Drone_compensator when no marker to reconstruct position found
Sensors.dummy.usePosVISFlag = 0;

%Delay (all sensor data)
Sensors.sensorDelay = 1; %in samples of 200Hz;

%Gains
Sensors.airDensity = 1.225;
Sensors.altToPrsGain = g*Sensors.airDensity;
Sensors.altToPrsBias = 101270.95;
Sensors.inverseIMUGain = [1./Sensors.IMUAccelGain 1./Sensors.IMUGyroGain];

%Saturations
Sensors.altSensorMin = 0.44;

%Battery DUMMY
Sensors.dummy.batteryStatus = [3.5 70];

%Vision
switch model
    case 'Mambo'
        Sensors.velocityToOpticalFlowGain = 1;
    case 'RollingSpider'
        Sensors.velocityToOpticalFlowGain = 1/20;
end
Sensors.cameraResolution = [160 120];