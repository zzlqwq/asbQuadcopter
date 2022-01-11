function wpList = wpListCreation(wp)
% This function takes a waypoint cell matrix from the Trajectory Tool GUI
% and returns a character string to populate the GUI's list for
% visualization. This is a private function it is not meant for direct use.

% Copyright 2015 The MathWorks, Inc.

% Check that the list is not empty.
if isempty(wp)
    wpList = '';
else
    % Preallocate output character list
    wpList={zeros(length(wp),1)};
    
    % Process waypoint cell
    for k=1:length(wp)
        wpk = wp(k);
        if wpk.d==1
            dstr = 'CW';
        else
            dstr = 'CCW';
        end
        wpList{k} = ['N: ' wpk.y ';' 'E: ' wpk.x ';' 'H: ' wpk.h ';' ...
            'K: ' wpk.k ';' 'D: ' dstr ';'];
    end
end