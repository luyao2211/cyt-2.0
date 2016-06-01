function varargout = density_subsample_params(varargin)
% DENSITY_SUBSAMPLE_PARAMS MATLAB code for density_subsample_params.fig
%      DENSITY_SUBSAMPLE_PARAMS, by itself, creates a new DENSITY_SUBSAMPLE_PARAMS or raises the existing
%      singleton*.
%
%      H = DENSITY_SUBSAMPLE_PARAMS returns the handle to a new DENSITY_SUBSAMPLE_PARAMS or the handle to
%      the existing singleton*.
%
%      DENSITY_SUBSAMPLE_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DENSITY_SUBSAMPLE_PARAMS.M with the given input arguments.
%
%      DENSITY_SUBSAMPLE_PARAMS('Property','Value',...) creates a new DENSITY_SUBSAMPLE_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before density_subsample_params_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to density_subsample_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help density_subsample_params

% Last Modified by GUIDE v2.5 10-May-2016 16:35:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @density_subsample_params_OpeningFcn, ...
                   'gui_OutputFcn',  @density_subsample_params_OutputFcn, ...
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
end

% --- Executes just before density_subsample_params is made visible.
function density_subsample_params_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to density_subsample_params (see VARARGIN)

% Choose default command line output for density_subsample_params
handles.output = hObject;
%set default params
    set(handles.od, 'String', '1');
    set(handles.td, 'String', '3');
    set(handles.number, 'String', '20000');
    set(handles.neighsize, 'String', '1.5');
    set(handles.approfac, 'String', '5');
    set(handles.ifTD, 'value',1);
    set(handles.ifnumber, 'value',0);
    set(handles.trans_option_1, 'value',0);
    set(handles.trans_option_2, 'value',1);
    set(handles.trans_option_3, 'value',0);
    set(handles.arcsinh_factor, 'String', '5');
%     set(handles.neighsize, 'String', '1.5');
%     set(handles.approfac, 'String', '5');
%      ifTD
%     td
%     number
%     neighsize
%     approfac
%     trans_option_1
%     trans_option_2
%     trans_option_3
%     arcsinh_factor
% Update handles structure
guidata(hObject, handles);
% guidata(hObject, handles);
setappdata(0,'hwand',gcf);
% UIWAIT makes density_subsample_params wait for user response (see UIRESUME)
uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = density_subsample_params_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
    delete(handles.figure1);
end

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = {};

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
end

function W = getParams
    hgui=getappdata(0,'hwand');
    handles=guihandles(hgui);
    
    W.outlier_density = str2double(get(handles.od, 'String'));
%     W.ifTD = get(handles.ifTD, 'Value');
     W.target_cell_number = 0;
     W.target_density = 3;
    if get(handles.ifTD, 'Value')
        W.target_density_mode = 1;% target density
        W.target_density = str2double(get(handles.td, 'String')); 
    else
       W.target_density_mode = 2;% number
       W.target_cell_number = str2double(get(handles.number, 'String'));  
    end   
    W.od = str2double(get(handles.od, 'String')); 
    W.kernel_width_factor = str2double(get(handles.approfac, 'String'));
    W.density_estimation_optimization_factor = str2double(get(handles.neighsize, 'String'));
    
    if get(handles.trans_option_1,'Value')
        W.transformation_option = 1;
    else
        if get(handles.trans_option_2,'Value')
            W.transformation_option = 2;
            W.arcsinh_factor = str2double(get(handles.arcsinh_factor, 'String'));
        else
            if get(handles.trans_option_3,'Value')
                W.transformation_option = 3;
                W.arcsinh_factor = str2double(get(handles.arcsinh_factor, 'String'));
            end
        end
    end
        
    
end

% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    W = getParams;
    handles.output = W;
    
    % Update handles structure
    guidata(hObject, handles);

    % Use UIRESUME instead of delete because the OutputFcn needs
    % to get the updated handles structure.
    uiresume(handles.figure1);
    
end



function figure1_KeyPressFcn(hObject, eventdata, handles)

    % Check for "enter" or "escape"
    if isequal(get(hObject,'CurrentKey'),'escape')
        % User said no by hitting escape
        handles.output = [];

        % Update handles structure
        guidata(hObject, handles);

        uiresume(handles.figure1);
    end    

    if isequal(get(hObject,'CurrentKey'),'return')
        uiresume(handles.figure1);
    end   
end


















function neighsize_Callback(hObject, eventdata, handles)
% hObject    handle to neighsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neighsize as text
%        str2double(get(hObject,'String')) returns contents of neighsize as a double
end

% --- Executes during object creation, after setting all properties.
function neighsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neighsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end



function approfac_Callback(hObject, eventdata, handles)
% hObject    handle to approfac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of approfac as text
%        str2double(get(hObject,'String')) returns contents of approfac as a double
end

% --- Executes during object creation, after setting all properties.
function approfac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to approfac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end



function td_Callback(hObject, eventdata, handles)
% hObject    handle to td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of td as text
%        str2double(get(hObject,'String')) returns contents of td as a double
end

% --- Executes during object creation, after setting all properties.
function td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end



function od_Callback(hObject, eventdata, handles)
% hObject    handle to od (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of od as text
%        str2double(get(hObject,'String')) returns contents of od as a double
    str2double(get(hObject,'String'));
    tmp = get(handles.od,'string');
    new_outlier_density = str2num(tmp);
	handles.mother_window_handles.outlier_density = new_outlier_density;
    guidata(hObject,handles); 
%     guidata(handles.mother_window_handles.button_browse_directory,handles.mother_window_handles);
end

% --- Executes during object creation, after setting all properties.
function od_CreateFcn(hObject, eventdata, handles)
% hObject    handle to od (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function number_Callback(hObject, eventdata, handles)
% hObject    handle to number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number as text
%        str2double(get(hObject,'String')) returns contents of number as a double
end

% --- Executes during object creation, after setting all properties.
function number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end



function arcsinh_factor_Callback(hObject, eventdata, handles)
% hObject    handle to arcsinh_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arcsinh_factor as text
%        str2double(get(hObject,'String')) returns contents of arcsinh_factor as a double
end

% --- Executes during object creation, after setting all properties.
function arcsinh_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arcsinh_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
