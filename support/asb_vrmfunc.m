function asb_vrmfunc(hBlk)
%ASB_VRMFUNC  Helper function for On-Board Camera model

% Copyright 2020 The MathWorks, Inc.

vrmfunc('FnInit', hBlk);
ud = get_param(hBlk, 'UserData');
if ~strcmp(get(ud.VideoFigure, 'Viewpoint'),'Quadcopter Camera')
    set(ud.VideoFigure, 'Viewpoint', 'Quadcopter Camera');
end
end