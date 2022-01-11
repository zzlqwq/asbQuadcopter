function setMamboModel
% SETMAMBOMODEL Helper function to set the quadcopter properties to the
% Mambo model.

% Copyright 2017 The MathWorks, Inc.

% Obtain current project
p = slproject.getCurrentProject;
% Obtain project root
projectRoot = p.RootFolder;
% Set Mambo model
model = 'Mambo';
% Save variabe to .MAT fie for persistence
save(fullfile(projectRoot,'mainModels','modelParrot.mat'),'model');
% Update title
mainModel = 'asbQuadcopter';
load_system(mainModel);
ah = find_system(mainModel,'FindAll','on','type','annotation','tag','ModelTitle');
ao = get_param(ah,'object');
modelTitle = 'Quadcopter Flight Simulation Model - Mambo';
if ~strcmp(modelTitle,ao.Text)
    ao.Text = modelTitle;
    save_system(mainModel);
end
% Assign variables according to Mambo
evalin('base','Vehicle.Airframe.mass = 0.063;');
evalin('base','Vehicle.Airframe.inertia = diag([0.0000582857 0.0000716914 0.0001]);');
evalin('base','Estimator.pos.opticalFlowToVelocityGain = 1;');
evalin('base','Sensors.velocityToOpticalFlowGain = 1;');
evalin('base','Controller.takeoffGain = 0.45;');
assignin('base','model',model);
