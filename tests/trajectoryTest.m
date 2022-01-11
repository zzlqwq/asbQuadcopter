function tests = trajectoryTest()
% trajectoryTest - Sample test file with one test point
% "testTrajectoryGeneration" that makes sure that the trajectory generation
% tool does not fail or throws warnings for a specific set of poses. To run
% the test simply run "runtests('trajectoryTest')" from the command window
% or runProjectTests.

% Copyright 2015 The MathWorks, Inc.

tests = functiontests(localfunctions);

end

function testTrajectoryGeneration(testCase) %#ok<INUSD>
    %% Go to private directory
    oldDir = pwd;
    p = slproject.getCurrentProject;
    projectRoot = p.RootFolder;
    cd(fullfile(projectRoot,'tasks','private'));
    
    %% Set up poses
    % Waypoints
    p = [1 1 0;7 8 0; 3 -5 0; -5 -7 0;8 2 0;-5 8 0];
    % Heading
    t = [100 300 60 20 200 90];
    % Turn direction
    d = [1 -1 1 -1 1 1];
    % Curvatures for each turn
    kk = [1 .5 2 .2 3 1];
    % No-Fly zone center coordinates
    noflyc = [-5 2 0; 3.5 3 0;10 10 0];
    % No-Fly zone radii
    noflyr = [.5;1;.5];
    % No-Fly zone safety margin
    dr = [.1;0.1;.1];
    %% Run trajectory tool
    h = axes;
    wp = dubinPathGeneration(p,t,d,kk,noflyc,noflyr,dr);
    plotWaypoint(h,wp,noflyc,noflyr);
    %% Clean up
    close(get(h,'Parent'));
    cd(oldDir);
end