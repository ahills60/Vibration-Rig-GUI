function varargout = VibrationPlayer(varargin)
% VIBRATIONPLAYER MATLAB code for VibrationPlayer.fig
%      VIBRATIONPLAYER, by itself, creates a new VIBRATIONPLAYER or raises the existing
%      singleton*.
%
%      H = VIBRATIONPLAYER returns the handle to a new VIBRATIONPLAYER or the handle to
%      the existing singleton*.
%
%      VIBRATIONPLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONPLAYER.M with the given input arguments.
%
%      VIBRATIONPLAYER('Property','Value',...) creates a new VIBRATIONPLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VibrationPlayer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VibrationPlayer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VibrationPlayer

% Last Modified by GUIDE v2.5 14-Jan-2015 18:35:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VibrationPlayer_OpeningFcn, ...
                   'gui_OutputFcn',  @VibrationPlayer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before VibrationPlayer is made visible.
function VibrationPlayer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VibrationPlayer (see VARARGIN)

% Choose default command line output for VibrationPlayer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VibrationPlayer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VibrationPlayer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in closeButton.
function closeButton_Callback(hObject, eventdata, handles)
% hObject    handle to closeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)

% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function pathEditBox_Callback(hObject, eventdata, handles)
% hObject    handle to pathEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathEditBox as text
%        str2double(get(hObject,'String')) returns contents of pathEditBox as a double


% --- Executes during object creation, after setting all properties.
function pathEditBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathEditBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browseButton.
function browseButton_Callback(hObject, eventdata, handles)
% hObject    handle to browseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, filepath] = uigetfile({'*.mat', 'MATLAB save file'}, 'Browse signature files to load');

% Make sure the filename is not empty (i.e. cancel)
if ~isequal(filename, 0) && ~isequal(filepath, 0)
    set(handles.pathEditBox, 'String', [filepath filename]);
end


% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% hObject    handle to openButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Extract the path in the edit box
filepath = get(handles.pathEditBox, 'String');

% Ensure that the file exists before trying to open it.
if exist(filepath, 'file') ~= 2
    set(handles.varListBox, 'Enable', 'off');
    set(handles.loadVarButton, 'Enable', 'off');
    errordlg('Unable to locate the selected file. Please select a valid file.');
    return
end

% Get a cell list of objects within the given file.
varList = who('-file', filepath);

% Upload the file contents to the variable list box.
set(handles.varListBox, 'String', varList);
% Reset index
set(handles.varListBox, 'Value', 1.0);

% Before finally enabling again
if length(varList) > 0
    set(handles.varListBox, 'Enable', 'on');
    set(handles.loadVarButton, 'Enable', 'on');
end

% --- Executes on key press with focus on closeButton and none of its controls.
function closeButton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to closeButton (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in varListBox.
function varListBox_Callback(hObject, eventdata, handles)
% hObject    handle to varListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns varListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from varListBox


% --- Executes during object creation, after setting all properties.
function varListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadVarButton.
function loadVarButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadVarButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    % Firstly, obtain all the variables from the UI elements
    filepath = get(handles.pathEditBox, 'String');
    varIdx = get(handles.varListBox, 'Value');
    varNames = get(handles.varListBox, 'String');
    
    % Then extract what we want from them
    varName = varNames{varIdx};
    
    % ... to load the data...
    variable = load(filepath, varName);
    variable = variable.(varName);
    
    if min(size(variable)) > 1
        errordlg('Selected variable is not a vector. Please select a valid variable.');
        return
    end
    
    % Normalise wrt the largest min or max value
    variable = variable - mean(variable);
    variable = variable ./ max(variable, -min(variable));
    
    % Before plotting in the axis
    plot(handles.timeAxis, 1:length(variable), variable, 'y');
    set(handles.timeAxis, 'Color', [0 0 0]);
    ylim(-1,1);
    xlim(0, length(variable) + 1);
catch
    return
end
