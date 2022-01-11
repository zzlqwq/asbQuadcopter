function results = runProjectTests()
% runProjectTests.m - Run project tests
% This file runs all the tests registered in the the project. To
% differentiate actual tests from helper files, the test file should have a
% "Test" classification in the project.

% Copyright 2013 The MathWorks.Inc.

% Get current project directory
p = slproject.getCurrentProject;
testList = {};
for k=1:length(p.Files)
    if ~isempty(p.Files(k).findLabel('Classification','Test'))
        testList = [{p.Files(k).Path};testList]; %#okAGROW
    end
end
results = runtests(testList);