function varargout = asbTrajectoryTool(varargin)
% ASBTRAJECTORYTOOL MATLAB code for asbTrajectoryTool.fig
%      ASBTRAJECTORYTOOL, by itself, creates a new ASBTRAJECTORYTOOL or raises the existing
%      singleton*.
%
%      H = ASBTRAJECTORYTOOL returns the handle to a new ASBTRAJECTORYTOOL or the handle to
%      the existing singleton*.
%
%      ASBTRAJECTORYTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASBTRAJECTORYTOOL.M with the given input arguments.
%
%      ASBTRAJECTORYTOOL('Property','Value',...) creates a new ASBTRAJECTORYTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before asbTrajectoryTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to asbTrajectoryTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help asbTrajectoryTool

% Last Modified by GUIDE v2.5 14-May-2015 08:31:17

% Copyright 2015-2018 The MathWorks, Inc.

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @asbTrajectoryTool_OpeningFcn, ...
                   'gui_OutputFcn',  @asbTrajectoryTool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && (ischar(varargin{1}) || isstring(varargin{1}))
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before asbTrajectoryTool is made visible.
function asbTrajectoryTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to asbTrajectoryTool (see VARARGIN)

% Choose default command line output for asbTrajectoryTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Initialize image
plotMWSchematic(handles.MappedTrajectoryAxes);

% Load pre-recorded values (loads wp and nfz)
load('wpData.mat')

%Assign values to the user data
set(handles.WaypointList,'UserData',wp);
set(handles.NoFlyList,'UserData',nfz); 

% Update Lists
wpList = wpListCreation(wp);
set(handles.WaypointList,'String',wpList,'Value',1);
nfzList = nfzListCreation(nfz);
set(handles.NoFlyList,'String',nfzList,'Value',1);

%Update edit boxes
set(handles.WaypointEditEast,'String',wp(1).x);
set(handles.WaypointEditNorth,'String',wp(1).y);
set(handles.HeadingEdit,'String',wp(1).h);
set(handles.CurvatureEdit,'String',wp(1).k);
set(handles.NoFlyEditEast,'String',nfz(1).x);
set(handles.NoFlyEditNorth,'String',nfz(1).y);
set(handles.RadiusEdit,'String',nfz(1).r);
set(handles.MarginEdit,'String',nfz(1).m);

% UIWAIT makes asbTrajectoryTool wait for user response (see UIRESUME)
% uiwait(handles.TrajectoryToolFig);


% --- Outputs from this function are returned to the command line.
function varargout = asbTrajectoryTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in WaypointList.
function WaypointList_Callback(hObject, eventdata, handles)
% hObject    handle to WaypointList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns WaypointList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WaypointList


% --- Executes during object creation, after setting all properties.
function WaypointList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WaypointList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','');

function WaypointEditEast_Callback(hObject, eventdata, handles)
% hObject    handle to WaypointEditEast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WaypointEditEast as text
%        str2double(get(hObject,'String')) returns contents of WaypointEditEast as a double


% --- Executes during object creation, after setting all properties.
function WaypointEditEast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WaypointEditEast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function WaypointEditNorth_Callback(hObject, eventdata, handles)
% hObject    handle to WaypointEditNorth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WaypointEditNorth as text
%        str2double(get(hObject,'String')) returns contents of WaypointEditNorth as a double


% --- Executes during object creation, after setting all properties.
function WaypointEditNorth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WaypointEditNorth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function HeadingEdit_Callback(hObject, eventdata, handles)
% hObject    handle to HeadingEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HeadingEdit as text
%        str2double(get(hObject,'String')) returns contents of HeadingEdit as a double


% --- Executes during object creation, after setting all properties.
function HeadingEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HeadingEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CurvatureEdit_Callback(hObject, eventdata, handles)
% hObject    handle to CurvatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurvatureEdit as text
%        str2double(get(hObject,'String')) returns contents of CurvatureEdit as a double


% --- Executes during object creation, after setting all properties.
function CurvatureEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurvatureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddWaypointButton.
function AddWaypointButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddWaypointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.WaypointList,'Value');

% Get values from edit boxes
wpAdd.x =get(handles.WaypointEditEast,'String');
wpAdd.y =get(handles.WaypointEditNorth,'String');
wpAdd.h =get(handles.HeadingEdit,'String');
wpAdd.k =get(handles.CurvatureEdit,'String');
wpAdd.d =get(handles.DirectionToggle,'Value');

% Get values from User data
wpGUI = get(handles.WaypointList,'UserData');
wpList = get(handles.WaypointList,'String');

if idx == 1
    if isempty(wpList)
        wpGUI(1) = wpAdd;
        set(handles.WaypointList,'Value',1);
    else
        wpGUI = [wpGUI(1) wpAdd wpGUI(2:end)];
        set(handles.WaypointList,'Value',2);
    end
else
    wpGUI = [wpGUI(1:idx) wpAdd wpGUI(idx+1:end)];
    if idx == length(wpGUI)
        set(handles.WaypointList,'Value',idx);
    else
        set(handles.WaypointList,'Value',idx+1);
    end
end
wpList = wpListCreation(wpGUI);
set(handles.WaypointList,'String',wpList);
set(handles.WaypointList,'UserData',wpGUI);

% --- Executes on button press in DeleteWaypointButton.
function DeleteWaypointButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteWaypointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.WaypointList,'Value');

% Get values from User data
wpGUI = get(handles.WaypointList,'UserData');
sizeWP = length(wpGUI);

if ~isempty(wpGUI)
    if idx == 1
        wpGUI = wpGUI(2:end);
        set(handles.WaypointList,'Value',1);
    elseif idx==sizeWP
        wpGUI = wpGUI(1:end-1);
        set(handles.WaypointList,'Value',idx-1);
    else
        wpGUI = [wpGUI(1:idx-1) wpGUI(idx+1:end)];
        set(handles.WaypointList,'Value',idx-1);
    end
    wpList = wpListCreation(wpGUI);
    set(handles.WaypointList,'String',wpList);
    set(handles.WaypointList,'UserData',wpGUI);
else
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:wpListError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
end

% --- Executes on button press in CancelWaypointButton.
function CancelWaypointButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelWaypointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Disable Ok and Cancel Buttons, Enable Add and Delete
set(handles.OkWaypointButton,'Enable','off');
set(handles.CancelWaypointButton,'Enable','off');
set(handles.AddWaypointButton,'Enable','on');
set(handles.DeleteWaypointButton,'Enable','on');
set(handles.EditWaypointButton,'Enable','on');
set(handles.WaypointList,'Enable','on');

% --- Executes on button press in OkWaypointButton.
function OkWaypointButton_Callback(hObject, eventdata, handles)
% hObject    handle to OkWaypointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get Values from user data
wpGUI = get(handles.WaypointList,'UserData');

% Get list data
idx = get(handles.WaypointList,'Value');

% Get edit boxes values
wpGUI(idx).x =get(handles.WaypointEditEast,'String');
wpGUI(idx).y =get(handles.WaypointEditNorth,'String');
wpGUI(idx).h =get(handles.HeadingEdit,'String');
wpGUI(idx).k =get(handles.CurvatureEdit,'String');
wpGUI(idx).d =get(handles.DirectionToggle,'Value');

wpList = wpListCreation(wpGUI);
set(handles.WaypointList,'String',wpList);
set(handles.WaypointList,'UserData',wpGUI);

% Disable Ok and Cancel Buttons, Enable Add and Delete
set(handles.OkWaypointButton,'Enable','off');
set(handles.CancelWaypointButton,'Enable','off');
set(handles.AddWaypointButton,'Enable','on');
set(handles.DeleteWaypointButton,'Enable','on');
set(handles.EditWaypointButton,'Enable','on');
set(handles.WaypointList,'Enable','on');

% % --- Executes on button press in InsertWaypointButton.
% function InsertWaypointButton_Callback(hObject, eventdata, handles)
% % hObject    handle to InsertWaypointButton (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EditWaypointButton.
function EditWaypointButton_Callback(hObject, eventdata, handles)
% hObject    handle to EditWaypointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.WaypointList,'Value');

% Get values from the waypoint list
wpList = get(handles.WaypointList,'String');

if ~isempty(wpList)
    % Get Values from user data
    wpGUI = get(handles.WaypointList,'UserData');

    % Set values in respective boxes
    wpIdx = wpGUI(idx);
    set(handles.WaypointEditEast,'String',wpIdx.x);
    set(handles.WaypointEditNorth,'String',wpIdx.y);
    set(handles.HeadingEdit,'String',wpIdx.h);
    set(handles.CurvatureEdit,'String',wpIdx.k);
    set(handles.DirectionToggle,'Value',wpIdx.d)
    
    % Enable Ok and Cancel Buttons, Disable Add and Delete
    set(handles.OkWaypointButton,'Enable','on');
    set(handles.CancelWaypointButton,'Enable','on');
    set(handles.AddWaypointButton,'Enable','off');
    set(handles.DeleteWaypointButton,'Enable','off');
    set(handles.EditWaypointButton,'Enable','off');
    set(handles.WaypointList,'Enable','off');    
else
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:wpEditListError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
end

function NoFlyEditEast_Callback(hObject, eventdata, handles)
% hObject    handle to NoFlyEditEast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoFlyEditEast as text
%        str2double(get(hObject,'String')) returns contents of NoFlyEditEast as a double


% --- Executes during object creation, after setting all properties.
function NoFlyEditEast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoFlyEditEast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function NoFlyEditNorth_Callback(hObject, eventdata, handles)
% hObject    handle to NoFlyEditNorth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoFlyEditNorth as text
%        str2double(get(hObject,'String')) returns contents of NoFlyEditNorth as a double


% --- Executes during object creation, after setting all properties.
function NoFlyEditNorth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoFlyEditNorth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function MarginEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MarginEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MarginEdit as text
%        str2double(get(hObject,'String')) returns contents of MarginEdit as a double


% --- Executes during object creation, after setting all properties.
function MarginEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarginEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in AddNoFlyButton.
function AddNoFlyButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddNoFlyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get values from edit boxes
idx = get(handles.NoFlyList,'Value');

% Get values from edit boxes
nfzAdd.x =get(handles.NoFlyEditEast,'String');
nfzAdd.y =get(handles.NoFlyEditNorth,'String');
nfzAdd.r =get(handles.RadiusEdit,'String');
nfzAdd.m =get(handles.MarginEdit,'String');

% Get values from User data
nfzGUI = get(handles.NoFlyList,'UserData');
nfzList = get(handles.NoFlyList,'String');

if idx == 1
    if isempty(nfzList)
        nfzGUI(1) = nfzAdd;
        set(handles.NoFlyList,'Value',1);
    else
        nfzGUI = [nfzGUI(1) nfzAdd nfzGUI(2:end)];
        set(handles.NoFlyList,'Value',2);
    end
else
    nfzGUI = [nfzGUI(1:idx) nfzAdd nfzGUI(idx+1:end)];
    if idx == length(nfzGUI)
        set(handles.NoFlyList,'Value',idx);
    else
        set(handles.NoFlyList,'Value',idx+1);
    end
end
nfzList = nfzListCreation(nfzGUI);
set(handles.NoFlyList,'String',nfzList);
set(handles.NoFlyList,'UserData',nfzGUI);

% --- Executes on button press in DeleteNoFlyButton.
function DeleteNoFlyButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteNoFlyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.NoFlyList,'Value');

% Get values from User data
nfzGUI = get(handles.NoFlyList,'UserData');
sizeNFZ = length(nfzGUI);

% Get values from User data
nfzGUI = get(handles.NoFlyList,'UserData');

if ~isempty(nfzGUI)
    if idx == 1
        nfzGUI = nfzGUI(2:end);
        set(handles.NoFlyList,'Value',1);
    elseif idx==sizeNFZ
        nfzGUI = nfzGUI(1:end-1);
        set(handles.NoFlyList,'Value',idx-1);
    else
        nfzGUI = [nfzGUI(1:idx-1) nfzGUI(idx+1:end)];
        set(handles.NoFlyList,'Value',idx-1);
    end
    nfzList = nfzListCreation(nfzGUI);
    set(handles.NoFlyList,'String',nfzList);
    set(handles.NoFlyList,'UserData',nfzGUI);
else
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:nfzListError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
end

% --- Executes on button press in CancelNoFlyButton.
function CancelNoFlyButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelNoFlyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Disable Ok and Cancel Buttons, Enable Add and Delete
set(handles.OkNoFlyButton,'Enable','off');
set(handles.CancelNoFlyButton,'Enable','off');
set(handles.AddNoFlyButton,'Enable','on');
set(handles.DeleteNoFlyButton,'Enable','on');
set(handles.EditNoFlyButton,'Enable','on');
set(handles.NoFlyList,'Enable','on');

% --- Executes on button press in OkNoFlyButton.
function OkNoFlyButton_Callback(hObject, eventdata, handles)
% hObject    handle to OkNoFlyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get Values from user data
nfzGUI = get(handles.NoFlyList,'UserData');

% Get list data
idx = get(handles.NoFlyList,'Value');

% Get edit boxes values
nfzGUI(idx).x =get(handles.NoFlyEditEast,'String');
nfzGUI(idx).y =get(handles.NoFlyEditNorth,'String');
nfzGUI(idx).r =get(handles.RadiusEdit,'String');
nfzGUI(idx).m =get(handles.MarginEdit,'String');

nfzList = nfzListCreation(nfzGUI);
set(handles.NoFlyList,'String',nfzList);
set(handles.NoFlyList,'UserData',nfzGUI);


% Disable Ok and Cancel Buttons, Enable Add and Delete
set(handles.OkNoFlyButton,'Enable','off');
set(handles.CancelNoFlyButton,'Enable','off');
set(handles.AddNoFlyButton,'Enable','on');
set(handles.DeleteNoFlyButton,'Enable','on');
set(handles.EditNoFlyButton,'Enable','on');
set(handles.NoFlyList,'Enable','on');

% --- Executes on button press in EditNoFlyButton.
function EditNoFlyButton_Callback(hObject, eventdata, handles)
% hObject    handle to EditNoFlyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.NoFlyList,'Value');

% Get values from No-fly zone list
nfzList = get(handles.NoFlyList,'String');

if ~isempty(nfzList)
    % Get Values from user data
    nfzGUI =  get(handles.NoFlyList,'UserData');
    % Set values in respective boxes
    nfzIdx = nfzGUI(idx);
    set(handles.NoFlyEditEast,'String',nfzIdx.x);
    set(handles.NoFlyEditNorth,'String',nfzIdx.y);
    set(handles.RadiusEdit,'String',nfzIdx.r);
    set(handles.MarginEdit,'String',nfzIdx.m);
    
    % Enable Ok and Cancel Buttons, Disable Add and Delete
    set(handles.OkNoFlyButton,'Enable','on');
    set(handles.CancelNoFlyButton,'Enable','on');
    set(handles.AddNoFlyButton,'Enable','off');
    set(handles.DeleteNoFlyButton,'Enable','off');
    set(handles.EditNoFlyButton,'Enable','off');
    set(handles.NoFlyList,'Enable','off');
    
else
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:nfzEditListError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
end

% --- Executes on selection change in NoFlyList.
function NoFlyList_Callback(hObject, eventdata, handles)
% hObject    handle to NoFlyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns NoFlyList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NoFlyList


% --- Executes during object creation, after setting all properties.
function NoFlyList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoFlyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','');

function RadiusEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RadiusEdit as text
%        str2double(get(hObject,'String')) returns contents of RadiusEdit as a double


% --- Executes during object creation, after setting all properties.
function RadiusEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RadiusEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GenerateTrajectoryButton.
function GenerateTrajectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateTrajectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get data from user data
wpGUI =  get(handles.WaypointList,'UserData');
nfzGUI = get(handles.NoFlyList,'UserData');

% Verify that there are at least 2 waypoints
if length(wpGUI)<2
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:wpNumError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
else    
    % Prepare data before passing it to the dubin trajectory generator
    % Waypoints
    p = zeros(length(wpGUI),3);
    t = zeros(length(wpGUI),1);
    d = zeros(length(wpGUI),1);
    kk = zeros(length(wpGUI),1);
    
    % The dubin path tool uses X and Y in its usual representation, since
    % Y=North and X=East for display convenience, the values are exchanged. In
    % a similar way for the heading (in degrees from North) needs to be updated
    % so they represent the same orientation measured positively from the X
    % axis.
    for k=1:length(wpGUI)
        p(k,:) = [str2double(wpGUI(k).x) str2double(wpGUI(k).y) 0];
        t(k) = str2double(wpGUI(k).h);
        if wpGUI(k).d==2
            d(k)=-1;
        else
            d(k)=1;
        end
        kk(k) = str2double(wpGUI(k).k);
    end
    
    % No Fly zones
    if isempty(nfzGUI(1).x) && isempty(nfzGUI(1).y) && isempty(nfzGUI(1).r)...
            && isempty(nfzGUI(1).m)
        noflyc = [];
        noflyr=[];
        dr = [];
    else
        noflyc = zeros(length(nfzGUI),3);
        noflyr = zeros(length(nfzGUI),1);
        dr = zeros(length(nfzGUI),1);
        
        for k=1:length(nfzGUI)
            noflyc(k,:) = [str2double(nfzGUI(k).x) str2double(nfzGUI(k).y) 0];
            noflyr(k) = str2double(nfzGUI(k).r);
            dr(k) = str2double(nfzGUI(k).m);
        end
        
        validateattributes(noflyc,{'numeric'},{'real','finite','nonnan'});
        validateattributes(noflyr,{'numeric'},{'real','finite','nonnan','>',0});
        validateattributes(dr,{'numeric'},{'real','finite','nonnan','>',0});
    end
    % Adjust heading
    t = mod(90-t+360,360);
    
    % Verify values before calculating the trajectory
    validateattributes(p,{'numeric'},{'ncols',3,'real','finite','nonnan'});
    validateattributes(t,{'numeric'},{'real','finite','nonnan'});
    validateattributes(d,{'numeric'},{'real','finite','nonnan'});
    validateattributes(kk,{'numeric'},{'real','finite','nonnan'});
    
    % Call Dubin's path generator
    wp = dubinPathGeneration(p,t,d,kk,noflyc,noflyr,dr);
    
    % Plot trajectory
    plotMWSchematic(handles.MappedTrajectoryAxes);
    tr = plotWaypoint(handles.MappedTrajectoryAxes,wp,noflyc,noflyr);
    
    %Update trajectory world
    if getfield(vr.appdependent, 'fullinstall') && ...
            builtin('license','test','Virtual_Reality_Toolbox')  %#ok<GFLD>
        % Assemble trajectory data for SL3D world
        alt = 16.15;
        trWorld = [ tr(1,2) 0 tr(1,1);...
            tr(:,2) alt*ones(length(tr),1) tr(:,1);...
            tr(end,2) 0 tr(end,1)];
        trIdxWorld = 0:1:length(trWorld);
        trIdxWorld(end) = -1;
        
        % Open Trajectory world
        worldTrajectory = vrworld('asbQuadcopterTrajectory.wrl','new');
        open(worldTrajectory);
        
        % Set the world values for the trajectory
        worldTrajectory.LineCoordinates.point = trWorld;
        worldTrajectory.LineIndexedList.coordIndex = int32(trIdxWorld');
        
        % Add markers for the waypoints
        markerFile = 'asbWaypointMarker.wrl';
        try
            addexternproto(worldTrajectory, markerFile, 'MarkerProto');
        catch ME
            if ~strcmpi(ME.identifier, 'sl3d:interface:protoexists')
                throwAsCaller(ME);
            end
        end
        
        % Remove previously created nodes
        nodesWorld= nodes(worldTrajectory);
        for k=1:length(nodesWorld)
            nodeName = get(nodesWorld(k),'Name');
            if strcmp(nodeName(1:7),'Marker_')
                delete(nodesWorld(k));
            end
        end
        
        % Add current markers
        Marker_Start = vrnode(worldTrajectory, 'Marker_Start', 'MarkerProto');
        Marker_Start.Translation = [wp(1,2) 0 wp(1,1)];
        Marker_End = vrnode(worldTrajectory, 'Marker_End', 'MarkerProto');
        Marker_End.Translation = [wp(end,2) 0 wp(end,1)];
        for k=1:size(wp,1)
            newMarker = vrnode(worldTrajectory, sprintf('%s_%d', 'Marker', k), 'MarkerProto');
            % set marker translation
            newMarker.Translation = [wp(k,2) alt wp(k,1)];
        end
        
        % Save and close SL3D trajectory world
        p = slproject.getCurrentProject;
        projectRoot = p.RootFolder;
        save(worldTrajectory,fullfile(projectRoot,'support','asbQuadcopterTrajectory.wrl'));
        close(worldTrajectory);
        delete(worldTrajectory);
    end
    
    % Save data in user data:
    ud.wp = wp;
    ud.tr = tr;
    set(handles.MappedTrajectoryAxes,'UserData',ud);
end

% --- Executes on button press in DefaultButton.
function DefaultButton_Callback(hObject, eventdata, handles)
% hObject    handle to DefaultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

buttonDlg = questdlg(getString(message('aeroblks_demos_quad:asbquadcopter:defaultData')),...
    getString(message('aeroblks_demos_quad:asbquadcopter:defaultDataTitle')));

if strcmp(buttonDlg,'Yes')
    % Load pre-recorded values (loads wp and nfz)
    load('wpData.mat')
    
    %Assign values to the user data
    set(handles.WaypointList,'UserData',wp);
    set(handles.NoFlyList,'UserData',nfz);
    
    % Update Lists
    wpList = wpListCreation(wp);
    set(handles.WaypointList,'String',wpList,'Value',1);
    nfzList = nfzListCreation(nfz);
    set(handles.NoFlyList,'String',nfzList,'Value',1);
    
    %Update edit boxes
    set(handles.WaypointEditEast,'String',wp(1).x);
    set(handles.WaypointEditNorth,'String',wp(1).y);
    set(handles.HeadingEdit,'String',wp(1).h);
    set(handles.CurvatureEdit,'String',wp(1).k);
    set(handles.NoFlyEditEast,'String',nfz(1).x);
    set(handles.NoFlyEditNorth,'String',nfz(1).y);
    set(handles.RadiusEdit,'String',nfz(1).r);
    set(handles.MarginEdit,'String',nfz(1).m);

end

% --- Executes on selection change in DirectionToggle.
function DirectionToggle_Callback(hObject, eventdata, handles)
% hObject    handle to DirectionToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DirectionToggle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DirectionToggle


% --- Executes during object creation, after setting all properties.
function DirectionToggle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DirectionToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ClearListButton.
function ClearListButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClearListButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wpGUI = struct('x','','y','','h','','k','','d',[]);
nfzGUI = struct('x','','y','','r','','m','');

set(handles.WaypointList,'UserData',wpGUI,'String','','Value',1);
set(handles.NoFlyList,'UserData',nfzGUI,'String','','Value',1);
plotMWSchematic(handles.MappedTrajectoryAxes);

% --- Executes on button press in SaveTrajectoryButton.
function SaveTrajectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveTrajectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ud = get(handles.MappedTrajectoryAxes,'UserData');
if isfield(ud,'wp')
    wp = ud.wp;
else
    wp =[];
end
wpGUI = get(handles.WaypointList,'UserData'); %#ok<NASGU>
nfzGUI = get(handles.NoFlyList,'UserData'); %#ok<NASGU>
p = slproject.getCurrentProject;
projectRoot = p.RootFolder;

if ~isempty(wp)
    save(fullfile(projectRoot,'tasks','private','wpTrajectory'),'wp','wpGUI',...
        'nfzGUI');
else
    errordlg(getString(message('aeroblks_demos_quad:asbquadcopter:saveWpError')),...
        getString(message('aeroblks_demos_quad:asbquadcopter:ListErrorTitle')));
    save(fullfile(projectRoot,'tasks','private','wpTrajectory'),'wpGUI',...
        'nfzGUI')
end

% --- Executes on button press in LoadTrajectoryButton.
function LoadTrajectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTrajectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


buttonDlg = questdlg(getString(message('aeroblks_demos_quad:asbquadcopter:savedData')),...
    getString(message('aeroblks_demos_quad:asbquadcopter:defaultDataTitle')));

if strcmp(buttonDlg,'Yes')
    % Load pre-recorded values (loads wp and nfz)
    load('wpTrajectory.mat')
    
    %Assign values to the user data
    set(handles.WaypointList,'UserData',wpGUI);
    set(handles.NoFlyList,'UserData',nfzGUI);
    
    % Update Lists
    wpList = wpListCreation(wpGUI);
    set(handles.WaypointList,'String',wpList,'Value',1);
    nfzList = nfzListCreation(nfzGUI);
    set(handles.NoFlyList,'String',nfzList,'Value',1);
    
    %Update edit boxes
    set(handles.WaypointEditEast,'String',wpGUI(1).x);
    set(handles.WaypointEditNorth,'String',wpGUI(1).y);
    set(handles.HeadingEdit,'String',wpGUI(1).h);
    set(handles.CurvatureEdit,'String',wpGUI(1).k);
    set(handles.NoFlyEditEast,'String',nfzGUI(1).x);
    set(handles.NoFlyEditNorth,'String',nfzGUI(1).y);
    set(handles.RadiusEdit,'String',nfzGUI(1).r);
    set(handles.MarginEdit,'String',nfzGUI(1).m);

end
