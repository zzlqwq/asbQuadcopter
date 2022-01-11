%% Command Vars
% Copyright 2017 The MathWorks, Inc.

% Yaw Command
Command.yawStepAmplitude = 0;
Command.yawStepTime = 0;
Command.yawStepDuration = 0;

% Pitch command
Command.pitchStepAmplitude = 0;
Command.pitchStepTime = 0;
Command.pitchStepDuration = 0;

% Roll Command
Command.rollStepAmplitude = 0;
Command.rollStepTime = 0; 
Command.rollStepDuration = 0;

% Altitude Command
Command.takeoffDuration = 0;
Command.altitude = 0;

% Joystick
Command.rollDeadZoneEnd = 0.5;
Command.rollDeadZoneStart = -0.5;
Command.rollSatUpper = 1;
Command.rollSatLower = -1;
Command.rollGain = 1;
Command.pitchDeadZoneEnd = 0.5;
Command.pitchDeadZoneStart = -0.5;
Command.pitchSatUpper = 1;
Command.pitchSatLower = -1;
Command.pitchGain = 1;
Command.yawDeadZoneEnd = 0.5;
Command.yawDeadZoneStart = -0.5;
Command.yawSatUpper = 1;
Command.yawSatLower = -1;
Command.yawGain = 1;