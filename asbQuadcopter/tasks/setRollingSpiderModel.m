function setRollingSpiderModel
% SETROLLINGSPIDERMODEL Helper function to set the quadcopter properties to
% the Rolling Spider model.

% Copyright 2017 The MathWorks, Inc.

% Obtain current project
p = slproject.getCurrentProject;
% Obtain project root
projectRoot = p.RootFolder;
% Set Rolling Spider model
model = 'RollingSpider';
% Save variabe to .MAT fie for persistence
save(fullfile(projectRoot,'mainModels','modelParrot.mat'),'model');
% Update title
mainModel = 'asbQuadcopter';
load_system(mainModel);
ah = find_system(mainModel,'FindAll','on','type','annotation','tag','ModelTitle');
ao = get_param(ah,'object');
modelTitle = 'Quadcopter Flight Simulation Model - Rolling Spider';
if ~strcmp(modelTitle,ao.Text)
    ao.Text = modelTitle;
    save_system(mainModel);
end
% Assign variables according to Rolling Spider
evalin('base','Vehicle.Airframe.mass = 0.068;');
evalin('base','Vehicle.Airframe.inertia = diag([0.0686e-3 0.092e-3 0.1366e-3]);');
evalin('base','Estimator.pos.opticalFlowToVelocityGain = 20;');
evalin('base','Sensors.velocityToOpticalFlowGain = 1/20;');
evalin('base','Controller.takeoffGain = 0.2;');
assignin('base','model',model);
