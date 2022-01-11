function nfzList = nfzListCreation(nfz)
% This function takes a no-fly zone cell matrix from the Trajectory Tool GUI
% and returns a character string to populate the GUI's list for
% visualization. This is a private function it is not meant for direct use.

% Copyright 2015 The MathWorks, Inc.

% Check that the list is not empty.
if isempty(nfz)
    nfzList = '';
else
    % Preallocate output character list
    nfzList={zeros(length(nfz),1)};
    
    % Process no-fly zone cell
    for k=1:length(nfz)
        nfzk = nfz(k);
        nfzList{k} = ['CN: ' nfzk.y ';' 'CE: ' nfzk.x ';' 'R: ' nfzk.r ';' ...
            'M: ' nfzk.m ';'];
    end
end