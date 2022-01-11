function trimLinearizeOpPoint()
% trimLinearizeOpPoint - Trim and Linearize aircraft model
% This function creates a linear system object that contains a linear model
% of the aircraft based on an trimmed operating point. The linear system
% object is assigned to linsys and saved to a .mat file. It uses Simulink
% Control Design(TM).

% Copyright 2013-2017 The MathWorks, Inc.

% Obtain variables from workspace
Vehicle = evalin('base','Vehicle');
rho = evalin('base','rho');
g = evalin('base','g');


%% Variants Conditions
oldVariantVehicle = evalin('base','VSS_VEHICLE');

% Set up variants for trimming
VSS_VEHICLE = 1;

%Send variants to the workspace
assignin('base','VSS_VEHICLE',VSS_VEHICLE);

%% Obtain inputs and outputs from the model
modelTrim = 'trimNonlinearAirframe';
modelNonlinear = 'nonlinearAirframe';
if ~bdIsLoaded(modelTrim)
    load_system(modelTrim);
end
if ~bdIsLoaded(modelNonlinear)
    load_system(modelNonlinear);
end

% Set input type to doube for linearization
set_param('nonlinearAirframe/Actuators','OutDataTypeStr','double');

% Get input/output object
io = getlinio(modelTrim);

%% Create the operating point specification object.
opspec = operspec(modelTrim);

%% Set the constraints on the inputs in the model.
% - The defaults for all inputs are Known = false, Min = -Inf, and
% Max = Inf.

% Input (1) - trimNonlinearAirframe/Actuators
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(1).Min = [Vehicle.Motor.minLimit;-Vehicle.Motor.maxLimit;Vehicle.Motor.minLimit;-Vehicle.Motor.maxLimit];
opspec.Inputs(1).Max = [Vehicle.Motor.maxLimit;-Vehicle.Motor.minLimit;Vehicle.Motor.maxLimit;-Vehicle.Motor.minLimit];

% Input (2) - trimNonlinearAirframe/Gravity ned
opspec.Inputs(2).u = [0;0;g];
opspec.Inputs(2).Known = [true;true;true];

% Input (3) - trimNonlinearAirframe/Air Temp
opspec.Inputs(3).u = 288;
opspec.Inputs(3).Known = true;

% Input (4) - trimNonlinearAirframe/speed sound
opspec.Inputs(4).u = 340;
opspec.Inputs(4).Known = true;

% Input (5) - trimNonlinearAirframe/pressure
opspec.Inputs(5).u = 101300;
opspec.Inputs(5).Known = true;

% Input (6) - trimNonlinearAirframe/air density
opspec.Inputs(6).u = rho;
opspec.Inputs(6).Known = true;

% Input (7) - trimNonlinearAirframe/Magnetic Field
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(7).Known = [true;true;true];

%% Set the constraints on the outputs in the model.
% - The defaults for all outputs are Known = false, Min = -Inf, and
% Max = Inf.

% Output (1) - trimNonlinearAirframe/V_body
% - Default model initial conditions are used to initialize optimization.
opspec.Outputs(1).Known = [true;true;true];

% Output (2) - trimNonlinearAirframe/Omega_body
% - Default model initial conditions are used to initialize optimization.
opspec.Outputs(2).Known = [true;true;true];

%% Create the options
opt = findopOptions('DisplayReport','iter');
opt.OptimizationOptions.FinDiffRelStep = 1e-4;
opt.OptimizationOptions.Algorithm = 'interior-point';

%% Perform the operating point search.
[op,opreport] = findop(modelTrim,opspec,opt); %#ok<ASGLU>

% Linearize the model for the given operating and inputs/outputs.
linopt = linearizeOptions('BlockReduction', 'off');
linsys = linearize(modelTrim,io,op, linopt); %#ok<NASGU>

% Restore Variants
assignin('base','VSS_VEHICLE',oldVariantVehicle);

% Save trim points and linear model
p = simulinkproject;
save(fullfile(p.RootFolder,'linearAirframe','linearizedAirframe.mat'),...
    'linsys','op','opreport');

% Close models
close_system(modelTrim,0);
close_system(modelNonlinear,0);
