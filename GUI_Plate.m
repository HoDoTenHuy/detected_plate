function varargout = GUI_Plate(varargin)
% GUI_PLATE MATLAB code for GUI_Plate.fig
%      GUI_PLATE, by itself, creates a new GUI_PLATE or raises the existing
%      singleton*.
%
%      H = GUI_PLATE returns the handle to a new GUI_PLATE or the handle to
%      the existing singleton*.
%
%      GUI_PLATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLATE.M with the given input arguments.
%
%      GUI_PLATE('Property','Value',...) creates a new GUI_PLATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Plate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Plate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to btn_run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Plate

% Last Modified by GUIDE v2.5 01-Jul-2020 21:13:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Plate_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Plate_OutputFcn, ...
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


% --- Executes just before GUI_Plate is made visible.
function GUI_Plate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Plate (see VARARGIN)

% Choose default command line output for GUI_Plate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Plate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Plate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in input_image.
function input_image_Callback(hObject, eventdata, handles)
% hObject    handle to input_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'D:\DoAnNhanDangBS_Xe\Image\hog_matlab-master\ImageTest';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.jpg');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);
I = imread(fullFileName);

axes(handles.axes1);
imshow(I);

% --- Executes on button press in btn_load_hog.
function btn_load_hog_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_hog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'D:\DoAnNhanDangBS_Xe\Image\hog_matlab-master';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.mat');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);
% hog_model_plate = load(fullFileName);
set(handles.btn_load_hog, 'String', fullFileName);

% --- Executes on button press in btn_run.

warning off
clc;
clear all;
function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
IM = getimage(handles.axes1);
imshow(IM);
[h, w, ~] = size(IM);

step = get(handles.edt_step, 'string');
load(get(handles.btn_load_hog, 'string'));
load(get(handles.btn_scale, 'string'));
step = str2num(step);

hog.numBins = 9;
hog.numHorizCells = 9;
hog.numVertCells = 8;
hog.cellSize = 8;
hog.winSize = [(hog.numVertCells * hog.cellSize + 2), ...
               (hog.numHorizCells * hog.cellSize + 2)];
           
threshold = str2double(get(handles.edt_threshold, 'string'));

if isempty(step) == 1
    msgbox('Please enter step sliding window');
elseif isempty(IM) == 1
    msgbox('Please select a image');
else
    result_plate = [];
    plate = [];
    for k = 1 : length(scaleRange)
        scale = scaleRange(k);
        
        winWidth = floor(hog.winSize(2) * scale);
        winHeight = floor(hog.winSize(1) * scale);
        
        for i = 1:step:h
            for j =1:step:w        
                if (i + winHeight-1) < (h - 1) && (j + winWidth-1) < (w - 1)
                    width = winWidth-1;
                    height = winHeight-1;
                    imshow(IM);
                    rectangle('Position', [j, i, width, height],...
                    'linewidth',2,...
                    'linestyle','-',...
                    'EdgeColor','r');
                    drawnow;
                    hold off;
                    im = IM(i:i+height,j:j+width);
                    im = imresize(im, [66, 74]);
                    H = getHOGDescriptor(hog, im);
                    p = H' * hog.theta;
                    
                    if (p > threshold)
                        result_plate = [result_plate; j, i, width, height];
                        plate = [plate; p, j, i, height, width];
                    end
                end
            end
        end
    end
end
hold off;
axes(handles.axes2);
imshow(IM);

[m, ~] = size(result_plate);
for i = 1 : m
    rectangle('Position', result_plate(i, :),...
    'linewidth',2,...
    'linestyle','-',...
    'EdgeColor','b');
end
axes(handles.axes3);
[m, ~] = size(plate);
max_rs = max(plate(:, 1));
for i = 1:m
    if plate(i, 1) == max_rs
        image_plate = IM(plate(i, 3):plate(i, 3)+plate(i, 4), plate(i, 2):plate(i, 2)+plate(i, 5));
        imshow(image_plate);
    end
end
if isempty(result_plate) == 1
    msgbox('This image does not contain a plate!');
else
    msgbox('This image contains a plate!');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes during object deletion, before destroying properties.
function btn_run_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object deletion, before destroying properties.
function btn_run_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_scale.
function btn_scale_Callback(hObject, eventdata, handles)
% hObject    handle to btn_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'D:\DoAnNhanDangBS_Xe\Image\hog_matlab-master';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.mat');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);
set(handles.btn_scale, 'String', fullFileName);


function edt_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edt_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
axis off

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off



function edt_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to edt_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_threshold as text
%        str2double(get(hObject,'String')) returns contents of edt_threshold as a double


% --- Executes during object creation, after setting all properties.
function edt_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
axis off
