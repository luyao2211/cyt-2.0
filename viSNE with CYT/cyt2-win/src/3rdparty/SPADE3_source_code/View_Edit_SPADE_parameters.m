function varargout = View_Edit_SPADE_parameters(varargin)
% VIEW_EDIT_SPADE_PARAMETERS M-file for View_Edit_SPADE_parameters.fig
%      VIEW_EDIT_SPADE_PARAMETERS, by itself, creates a new VIEW_EDIT_SPADE_PARAMETERS or raises the existing
%      singleton*.
%
%      H = VIEW_EDIT_SPADE_PARAMETERS returns the handle to a new VIEW_EDIT_SPADE_PARAMETERS or the handle to
%      the existing singleton*.
%
%      VIEW_EDIT_SPADE_PARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEW_EDIT_SPADE_PARAMETERS.M with the given input arguments.
%
%      VIEW_EDIT_SPADE_PARAMETERS('Property','Value',...) creates a new VIEW_EDIT_SPADE_PARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before View_Edit_SPADE_parameters_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to View_Edit_SPADE_parameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help View_Edit_SPADE_parameters

% Last Modified by GUIDE v2.5 09-May-2016 21:50:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @View_Edit_SPADE_parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @View_Edit_SPADE_parameters_OutputFcn, ...
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


% --- Executes just before View_Edit_SPADE_parameters is made visible.
function View_Edit_SPADE_parameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to View_Edit_SPADE_parameters (see VARARGIN)

% Choose default command line output for View_Edit_SPADE_parameters
handles.output = hObject;
handles.mother_window_handles = varargin{1};
guidata(hObject, handles);
% initialize the listbox of used and not-used markers
used_markers_str = handles.mother_window_handles.used_markers;
[C,I] = setdiff(handles.mother_window_handles.all_overlapping_markers, used_markers_str);
not_used_markers_str = handles.mother_window_handles.all_overlapping_markers(sort(I));
set(handles.listbox_overlapping_markers_not_used,'string',not_used_markers_str);
set(handles.listbox_overlapping_markers_used,'string',used_markers_str);
% initialize the part about compensation
if ~isfield(handles.mother_window_handles,'apply_compensation')
    handles.mother_window_handles.apply_compensation=0;
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
end
if handles.mother_window_handles.apply_compensation==0 % no compensation
    set(handles.radiobutton_compensation_ignore,'value',1)
    set(handles.radiobutton_compensation_apply,'value',0)
else % yes compensation
    set(handles.radiobutton_compensation_ignore,'value',0)
    set(handles.radiobutton_compensation_apply,'value',1)
end
% initialize the transformation options
set(handles.edit_arcsinh_cofactor,'value',handles.mother_window_handles.arcsinh_cofactor,'string',num2str(handles.mother_window_handles.arcsinh_cofactor));
switch handles.mother_window_handles.transformation_option
    case 0    
        set(handles.radiobutton_0_no_transformation,'value',1);
    case 1    
        set(handles.radiobutton_1_arcsinh,'value',1);
    case 2    
        set(handles.radiobutton_2_arcsinh_norm,'value',1);
    otherwise
        set(handles.radiobutton_1_arcsinh,'value',1);
end
% density estimation parameters
set(handles.edit_kernel_width_factor,'string', num2str(handles.mother_window_handles.kernel_width_factor));
set(handles.edit_density_estimation_optimization_factor,'string', num2str(handles.mother_window_handles.density_estimation_optimization_factor));
% downsampling OD and TD
set(handles.edit_outlier_density,'string',num2str(handles.mother_window_handles.outlier_density));
set(handles.edit_target_density,'string',num2str(handles.mother_window_handles.target_density));
set(handles.edit_target_cell_number, 'string', num2str(handles.mother_window_handles.target_cell_number));
switch handles.mother_window_handles.target_density_mode
    case 1    
        set(handles.radiobutton_1_TD_percentile,'value',1);
    case 2    
        set(handles.radiobutton_2_TD_cell_number,'value',1);
    otherwise
        set(handles.radiobutton_2_TD_cell_number,'value',1);
end
% number of desired clusters
set(handles.edit_desired_number_of_clusters,'string',num2str(handles.mother_window_handles.number_of_desired_clusters));
set(handles.edit_max_allowable_events,'string',num2str(handles.mother_window_handles.max_allowable_events));
% clustering algorithm
switch handles.mother_window_handles.clustering_algorithm
    case 'kmeans'    
        set(handles.radiobutton_4_kmeans,'value',1);
        set(handles.radiobutton_5_agglomerative,'value',0);
    case 'agglomerative'    
        set(handles.radiobutton_4_kmeans,'value',0);
        set(handles.radiobutton_5_agglomerative,'value',1);
    otherwise
        set(handles.radiobutton_4_kmeans,'value',1);
        set(handles.radiobutton_5_agglomerative,'value',0);
        handles.mother_window_handles.clustering_algorithm = 'kmeans';
        guidata(hObject,handles); 
        guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
end
% files used or not used to build the SPADE tree
files_used = handles.mother_window_handles.file_used_to_build_SPADE_tree;
[C,I] = setdiff(handles.mother_window_handles.file_annot, files_used);
files_not_used = handles.mother_window_handles.file_annot(sort(I));
set(handles.listbox_files_not_used,'string',files_not_used);
set(handles.listbox_files_used,'string',files_used);
uiwait(handles.figure1);

% UIWAIT makes View_Edit_SPADE_parameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = View_Edit_SPADE_parameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.mother_window_handles.Result;




% --- Executes on selection change in listbox_overlapping_markers_not_used.
function listbox_overlapping_markers_not_used_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlapping_markers_not_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_overlapping_markers_not_used contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlapping_markers_not_used


% --- Executes during object creation, after setting all properties.
function listbox_overlapping_markers_not_used_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlapping_markers_not_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlapping_markers_used.
function listbox_overlapping_markers_used_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlapping_markers_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_overlapping_markers_used contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlapping_markers_used


% --- Executes during object creation, after setting all properties.
function listbox_overlapping_markers_used_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlapping_markers_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in button_add_marker.
function button_add_marker_Callback(hObject, eventdata, handles)

not_used_markers_str = get(handles.listbox_overlapping_markers_not_used,'String');
used_markers_str = get(handles.listbox_overlapping_markers_used,'String');
ind = get(handles.listbox_overlapping_markers_not_used,'value');
if length(not_used_markers_str)==0 || length(not_used_markers_str)<ind
    return
end 
if ind == length(not_used_markers_str)
    set(handles.listbox_overlapping_markers_not_used,'value',ind-1);
end
tmp = not_used_markers_str(ind);  % this is the marker to be moved over
not_used_markers_str = not_used_markers_str(setdiff(1:end,ind)); 
[C,IA,IB] = intersect(handles.mother_window_handles.all_overlapping_markers, [used_markers_str(:);tmp]);
used_markers_str = handles.mother_window_handles.all_overlapping_markers(sort(IA));

set(handles.listbox_overlapping_markers_not_used,'String',not_used_markers_str);
if get(handles.listbox_overlapping_markers_used,'value')==0
    set(handles.listbox_overlapping_markers_used,'value',1);
end
set(handles.listbox_overlapping_markers_used,'String',used_markers_str);
handles.mother_window_handles.used_markers = used_markers_str;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
used_markers = handles.mother_window_handles.used_markers;
save(parameter_filename,'used_markers','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)



% --- Executes on button press in button_remove_marker.
function button_remove_marker_Callback(hObject, eventdata, handles)
not_used_markers_str = get(handles.listbox_overlapping_markers_not_used,'String');
used_markers_str = get(handles.listbox_overlapping_markers_used,'String');
ind = get(handles.listbox_overlapping_markers_used,'value');
if length(used_markers_str)==0 || length(used_markers_str)<ind
    return
end 
if ind == length(used_markers_str)
    set(handles.listbox_overlapping_markers_used,'value',ind-1);
end
tmp = used_markers_str(ind);  % this is the marker to be moved over
used_markers_str = used_markers_str(setdiff(1:end,ind)); 
[C,IA,IB] = intersect(handles.mother_window_handles.all_overlapping_markers, [not_used_markers_str(:);tmp]);
not_used_markers_str = handles.mother_window_handles.all_overlapping_markers(sort(IA));

set(handles.listbox_overlapping_markers_used,'String',used_markers_str);
if get(handles.listbox_overlapping_markers_not_used,'value')==0
    set(handles.listbox_overlapping_markers_not_used,'value',1);
end
set(handles.listbox_overlapping_markers_not_used,'String',not_used_markers_str);
handles.mother_window_handles.used_markers = used_markers_str;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
used_markers = handles.mother_window_handles.used_markers;
save(parameter_filename,'used_markers','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)





function edit_arcsinh_cofactor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_arcsinh_cofactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp = get(handles.edit_arcsinh_cofactor,'string');
new_cofactor = str2num(tmp);
if isempty(str2num(tmp)) || new_cofactor<=0
	set(handles.edit_arcsinh_cofactor,'value',handles.mother_window_handles.arcsinh_cofactor,'string',num2str(handles.mother_window_handles.arcsinh_cofactor));
else
	handles.mother_window_handles.arcsinh_cofactor = new_cofactor;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    arcsinh_cofactor = handles.mother_window_handles.arcsinh_cofactor;
    save(parameter_filename,'arcsinh_cofactor','-append');
    % update the .mat files
    delete_LD_PooledData_Result_mat_files(handles)
end


% --- Executes during object creation, after setting all properties.
function edit_arcsinh_cofactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_arcsinh_cofactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in radiobutton_0_no_transformation.
function radiobutton_0_no_transformation_Callback(hObject, eventdata, handles)
% set(handles.radiobutton_0_no_transformation,'value',1);
if handles.mother_window_handles.transformation_option==0
    set(handles.radiobutton_0_no_transformation,'value',1);
    return
end
handles.mother_window_handles.transformation_option=0;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
transformation_option = handles.mother_window_handles.transformation_option;
save(parameter_filename,'transformation_option','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)



% --- Executes on button press in radiobutton_1_arcsinh.
function radiobutton_1_arcsinh_Callback(hObject, eventdata, handles)
% set(handles.radiobutton_1_arcsinh,'value',1);
if handles.mother_window_handles.transformation_option==1
    set(handles.radiobutton_1_arcsinh,'value',1);
    return
end
handles.mother_window_handles.transformation_option=1;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
transformation_option = handles.mother_window_handles.transformation_option;
save(parameter_filename,'transformation_option','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)




% --- Executes on button press in radiobutton_2_arcsinh_norm.
function radiobutton_2_arcsinh_norm_Callback(hObject, eventdata, handles)
% set(handles.radiobutton_2_arcsinh_norm,'value',1);
if handles.mother_window_handles.transformation_option==2
    set(handles.radiobutton_2_arcsinh_norm,'value',1);
    return
end
handles.mother_window_handles.transformation_option=2;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
transformation_option = handles.mother_window_handles.transformation_option;
save(parameter_filename,'transformation_option','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)




function edit_kernel_width_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kernel_width_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp = get(handles.edit_kernel_width_factor,'string');
new_factor = str2num(tmp);
if isempty(str2num(tmp)) || new_factor<=0 
	set(handles.edit_kernel_width_factor,'string',num2str(handles.mother_window_handles.kernel_width_factor));
else
	handles.mother_window_handles.kernel_width_factor = new_factor;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    kernel_width_factor = handles.mother_window_handles.kernel_width_factor;
    save(parameter_filename,'kernel_width_factor','-append');
    % update the .mat files
    delete_LD_PooledData_Result_mat_files(handles)
end


% --- Executes during object creation, after setting all properties.
function edit_kernel_width_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kernel_width_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_density_estimation_optimization_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_density_estimation_optimization_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp = get(handles.edit_density_estimation_optimization_factor,'string');
new_factor = str2num(tmp);
if isempty(str2num(tmp)) || new_factor<=0 
	set(handles.edit_density_estimation_optimization_factor,'string',num2str(handles.mother_window_handles.density_estimation_optimization_factor));
else
	handles.mother_window_handles.density_estimation_optimization_factor = new_factor;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    density_estimation_optimization_factor = handles.mother_window_handles.density_estimation_optimization_factor;
    save(parameter_filename,'density_estimation_optimization_factor','-append');
    % update the .mat files
    delete_LD_PooledData_Result_mat_files(handles)
end

% --- Executes during object creation, after setting all properties.
function edit_density_estimation_optimization_factor_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit_outlier_density_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_outlier_density_Callback(hObject, eventdata, handles)
tmp = get(handles.edit_outlier_density,'string');
new_outlier_density = str2num(tmp);
if isempty(str2num(tmp)) || new_outlier_density<0 || new_outlier_density>100
	set(handles.edit_outlier_density,'string',num2str(handles.mother_window_handles.outlier_density));
else
	handles.mother_window_handles.outlier_density = new_outlier_density;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    outlier_density = handles.mother_window_handles.outlier_density;
    save(parameter_filename,'outlier_density','-append');
    % updae .mat files
    delete_PooledData_Result_mat_files(handles)
end




% --- Executes during object creation, after setting all properties.
function edit_target_density_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_density_Callback(hObject, eventdata, handles)
tmp = get(handles.edit_target_density,'string');
new_target_density = str2num(tmp);
if isempty(str2num(tmp)) || new_target_density<=0 || new_target_density>100
	set(handles.edit_target_density,'string',num2str(handles.mother_window_handles.target_density));
else
	handles.mother_window_handles.target_density = new_target_density;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    target_density = handles.mother_window_handles.target_density;
    save(parameter_filename,'target_density','-append');
    % updae .mat files
    delete_PooledData_Result_mat_files(handles)
end



% --- Executes during object creation, after setting all properties.
function edit_target_cell_number_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_target_cell_number_Callback(hObject, eventdata, handles)
tmp = get(handles.edit_target_cell_number,'string');
new_target_cell_number = str2num(tmp);
if isempty(str2num(tmp)) || new_target_cell_number<=0 || new_target_cell_number~=round(new_target_cell_number)
	set(handles.edit_target_cell_number,'string',num2str(handles.mother_window_handles.target_cell_number));
else
	handles.mother_window_handles.target_cell_number = new_target_cell_number;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    target_cell_number = handles.mother_window_handles.target_cell_number;
    save(parameter_filename,'target_cell_number','-append');
    % updae .mat files
    delete_PooledData_Result_mat_files(handles)
end


% --- Executes on button press in radiobutton_1_TD_percentile.
function radiobutton_1_TD_percentile_Callback(hObject, eventdata, handles)
if handles.mother_window_handles.target_density_mode==1
    set(handles.radiobutton_1_TD_percentile,'value',1);
    return
end
handles.mother_window_handles.target_density_mode=1;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
target_density_mode = handles.mother_window_handles.target_density_mode;
save(parameter_filename,'target_density_mode','-append');
% updae .mat files
delete_PooledData_Result_mat_files(handles)




% --- Executes on button press in radiobutton_2_TD_cell_number.
function radiobutton_2_TD_cell_number_Callback(hObject, eventdata, handles)
if handles.mother_window_handles.target_density_mode==2
    set(handles.radiobutton_2_TD_cell_number,'value',1);
    return
end
handles.mother_window_handles.target_density_mode=2;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
target_density_mode = handles.mother_window_handles.target_density_mode;
save(parameter_filename,'target_density_mode','-append');
% updae .mat files
delete_PooledData_Result_mat_files(handles)




% --- Executes during object creation, after setting all properties.
function edit_desired_number_of_clusters_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_desired_number_of_clusters_Callback(hObject, eventdata, handles)
tmp = get(handles.edit_desired_number_of_clusters,'string');
new_desired_number_of_clusters = str2num(tmp);
if isempty(str2num(tmp)) || new_desired_number_of_clusters<=0 || new_desired_number_of_clusters~=round(new_desired_number_of_clusters)
	set(handles.edit_desired_number_of_clusters,'string',num2str(handles.mother_window_handles.number_of_desired_clusters));
else
	handles.mother_window_handles.number_of_desired_clusters = new_desired_number_of_clusters;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    number_of_desired_clusters = handles.mother_window_handles.number_of_desired_clusters;
    save(parameter_filename,'number_of_desired_clusters','-append');
    % updae .mat files
    delete_Result_mat_files(handles)
end



% --- Executes on selection change in listbox_files_not_used.
function listbox_files_not_used_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files_not_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_files_not_used contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files_not_used


% --- Executes during object creation, after setting all properties.
function listbox_files_not_used_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files_not_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_files_used.
function listbox_files_used_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_files_used contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files_used


% --- Executes during object creation, after setting all properties.
function listbox_files_used_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files_used (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_add_file.
function button_add_file_Callback(hObject, eventdata, handles)

not_used_files_str = get(handles.listbox_files_not_used,'String');
used_files_str = get(handles.listbox_files_used,'String');
ind = get(handles.listbox_files_not_used,'value');
if length(not_used_files_str)==0 || length(not_used_files_str)<ind
    return
end 
if ind == length(not_used_files_str)
    set(handles.listbox_files_not_used,'value',ind-1);
end
tmp = not_used_files_str(ind);  % this is the flie to be moved over
not_used_files_str = not_used_files_str(setdiff(1:end,ind)); 
[C,IA,IB] = intersect(handles.mother_window_handles.file_annot, [used_files_str(:);tmp]);
used_files_str = handles.mother_window_handles.file_annot(sort(IA));

set(handles.listbox_files_not_used,'String',not_used_files_str);
if get(handles.listbox_files_used,'value')==0
    set(handles.listbox_files_used,'value',1);
end
set(handles.listbox_files_used,'String',used_files_str);
handles.mother_window_handles.file_used_to_build_SPADE_tree = used_files_str;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
file_used_to_build_SPADE_tree = handles.mother_window_handles.file_used_to_build_SPADE_tree;
save(parameter_filename,'file_used_to_build_SPADE_tree','-append');
% updae .mat files
delete_PooledData_Result_mat_files(handles)


% --- Executes on button press in button_remove_file.
function button_remove_file_Callback(hObject, eventdata, handles)
used_files_str = get(handles.listbox_files_used,'String');
not_used_files_str = get(handles.listbox_files_not_used,'String');
ind = get(handles.listbox_files_used,'value');
if length(used_files_str)==0 || length(used_files_str)<ind
    return
end 
if ind == length(used_files_str)
    set(handles.listbox_files_used,'value',ind-1);
end
tmp = used_files_str(ind);  % this is the flie to be moved over
used_files_str = used_files_str(setdiff(1:end,ind)); 
[C,IA,IB] = intersect(handles.mother_window_handles.file_annot, [not_used_files_str(:);tmp]);
not_used_files_str = handles.mother_window_handles.file_annot(sort(IA));

set(handles.listbox_files_used,'String',used_files_str);
if get(handles.listbox_files_not_used,'value')==0
    set(handles.listbox_files_not_used,'value',1);
end
set(handles.listbox_files_not_used,'String',not_used_files_str);
handles.mother_window_handles.file_used_to_build_SPADE_tree = used_files_str;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
file_used_to_build_SPADE_tree = handles.mother_window_handles.file_used_to_build_SPADE_tree;
save(parameter_filename,'file_used_to_build_SPADE_tree','-append');
% updae .mat files
delete_PooledData_Result_mat_files(handles)





function edit_max_allowable_events_Callback(hObject, eventdata, handles)
tmp = get(handles.edit_max_allowable_events,'string');
new_max_allowable_events = str2num(tmp);
if isempty(str2num(tmp)) || new_max_allowable_events<=0 || new_max_allowable_events~=round(new_max_allowable_events)
	set(handles.edit_max_allowable_events,'string',num2str(handles.mother_window_handles.max_allowable_events));
else
	handles.mother_window_handles.max_allowable_events = new_max_allowable_events;
    guidata(hObject,handles); 
    guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
    % update the parameter file 
    parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
    max_allowable_events = handles.mother_window_handles.max_allowable_events;
    save(parameter_filename,'max_allowable_events','-append');
    % updae .mat files
    delete_PooledData_Result_mat_files(handles)
end


% --- Executes during object creation, after setting all properties.
function edit_max_allowable_events_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% edit_arcsinh_cofactor_Callback(handles.edit_arcsinh_cofactor, [], handles);
% edit_kernel_width_factor_Callback(handles.edit_kernel_width_factor, [], handles);
% edit_density_estimation_optimization_factor_Callback(handles.edit_density_estimation_optimization_factor, [], handles);
% edit_outlier_density_Callback(handles.edit_outlier_density, [], handles);
% edit_target_density_Callback(handles.edit_target_density, [], handles);
% edit_target_cell_number_Callback(handles.edit_target_cell_number, [], handles);
% edit_desired_number_of_clusters_Callback(handles.edit_desired_number_of_clusters, [], handles);
% edit_max_allowable_events_Callback(handles.edit_max_allowable_events, [], handles);
% delete(hObject);


% --- Executes on button press in button_close_parameter_window.
function button_close_parameter_window_Callback(hObject, eventdata, handles)
uiresume(handles.figure1);
delete(handles.figure1);
% figure1_CloseRequestFcn(handles.figure1, [], handles);




% parameter update induced change of files. 
function delete_LD_PooledData_Result_mat_files(handles)
for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.all_fcs_filenames{i});
    mat_filename = [fcs_filename(1:end-3),'mat'];
    if exist(mat_filename)==2 % if the .mat file that stores the downsampling info already exist
        delete(mat_filename);
    end
end
pooled_downsampled_filename = fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.pooled_downsampled_filename);
if exist(pooled_downsampled_filename)==2
    delete(pooled_downsampled_filename);
end
cluster_mst_upsample_filename = fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename);
if exist(cluster_mst_upsample_filename)==2
    delete(cluster_mst_upsample_filename);
end



% parameter update induced change of files. 
function delete_PooledData_Result_mat_files(handles)
pooled_downsampled_filename = fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.pooled_downsampled_filename);
if exist(pooled_downsampled_filename)==2
    delete(pooled_downsampled_filename);
end
cluster_mst_upsample_filename = fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename);
if exist(cluster_mst_upsample_filename)==2
    delete(cluster_mst_upsample_filename);
end


% parameter update induced change of files. 
function delete_Result_mat_files(handles)
cluster_mst_upsample_filename = fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename);
if exist(cluster_mst_upsample_filename)==2
    delete(cluster_mst_upsample_filename);
end


% --- Executes on button press in radiobutton_4_kmeans.
function radiobutton_4_kmeans_Callback(hObject, eventdata, handles)
if isequal(handles.mother_window_handles.clustering_algorithm,'kmeans')
    set(handles.radiobutton_4_kmeans,'value',1);
    set(handles.radiobutton_5_agglomerative,'value',0);
    return
end
set(handles.radiobutton_4_kmeans,'value',1);
set(handles.radiobutton_5_agglomerative,'value',0);
handles.mother_window_handles.clustering_algorithm='kmeans';
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
clustering_algorithm = handles.mother_window_handles.clustering_algorithm;
save(parameter_filename,'clustering_algorithm','-append');
% updae .mat files
delete_Result_mat_files(handles)


% --- Executes on button press in radiobutton_5_agglomerative.
function radiobutton_5_agglomerative_Callback(hObject, eventdata, handles)
if isequal(handles.mother_window_handles.clustering_algorithm,'agglomerative')
    set(handles.radiobutton_4_kmeans,'value',0);
    set(handles.radiobutton_5_agglomerative,'value',1);
    return
end
set(handles.radiobutton_4_kmeans,'value',0);
set(handles.radiobutton_5_agglomerative,'value',1);
handles.mother_window_handles.clustering_algorithm='agglomerative';
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
clustering_algorithm = handles.mother_window_handles.clustering_algorithm;
save(parameter_filename,'clustering_algorithm','-append');
% updae .mat files
delete_Result_mat_files(handles)


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton_compensation_ignore,'value')==1 && get(handles.radiobutton_compensation_apply,'value')==0
    apply_compensation = 0; % no compensation is applied
elseif get(handles.radiobutton_compensation_ignore,'value')==0 && get(handles.radiobutton_compensation_apply,'value')==1
    apply_compensation = 1; % use compensated data
else
    error('these two radiobuttons cannot be of the same status')
end
if handles.mother_window_handles.apply_compensation==apply_compensation  % if the selection is the same as that in the mother window, do nothing
    return
end
handles.mother_window_handles.apply_compensation = apply_compensation;
guidata(hObject,handles); 
guidata(handles.mother_window_handles.cmiSPADE,handles.mother_window_handles);
% update the parameter file 
parameter_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.parameter_filename);
apply_compensation = handles.mother_window_handles.apply_compensation;
save(parameter_filename,'apply_compensation','-append');
% update the .mat files
delete_LD_PooledData_Result_mat_files(handles)
if exist(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data'),'dir')
    delete(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data','*.*'));
    rmdir(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data'));
end


% --- Executes on button press in button_Start_SPADE.
function button_Start_SPADE_Callback(hObject, eventdata, handles)
% hObject    handle to button_Start_SPADE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_1_compute_local_density_Callback(handles.button_1_compute_local_density, [], handles)
button_2_pool_selected_files_Callback(handles.button_2_pool_selected_files, [], handles)
button_3_clustering_Callback(handles.button_3_clustering, [], handles)


% --- Executes on button press in button_1_compute_local_density.
function button_1_compute_local_density_Callback(hObject, eventdata, handles)
% hObject    handle to button_1_compute_local_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
local_density_available = 0;
for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,[handles.mother_window_handles.all_fcs_filenames{i},'.fcs']);
    mat_filename = [fcs_filename(1:end-3),'mat'];
    if exist(mat_filename)==2 % if the .mat file that stores the downsampling info already exist
        local_density_available = local_density_available + 1;
    end
end
fprintf('There are %d fcs files in this directory, %d with local density computed already.\n\nStart to work on the remaining %d files ...\n', length(handles.mother_window_handles.all_fcs_filenames), local_density_available, length(handles.mother_window_handles.all_fcs_filenames)-local_density_available);


for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,[handles.mother_window_handles.all_fcs_filenames{i},'.fcs']);
    mat_filename = [fcs_filename(1:end-3),'mat'];
    
    if exist(mat_filename)==2 % if the .mat file that stores the downsampling info already exist
        continue;
    end

    fprintf('Read fcs file %d/%d ... ',i,length(handles.mother_window_handles.all_fcs_filenames));
    fprintf('%s\n',handles.mother_window_handles.all_fcs_filenames{i});
%     [fcsdat, fcshdr, fcsdatscaled] = fca_readfcs(fcs_filename);
%     clear('fcsdatscaled');
%     for i=1:length(fcshdr.par), 
%         marker_names{i,1} = fcshdr.par(i).name2;  
%         if isequal(unique(fcshdr.par(i).name2),' ')
%             marker_names{i,1} = fcshdr.par(i).name;  
%         end
%     end
    if isequal(handles.mother_window_handles.apply_compensation,0) || ~isequal(handles.mother_window_handles.apply_compensation,1)
        %[data, marker_names] = readfcs_v2(fcs_filename);
        data = handles.mother_window_handles.session_data(:,handles.mother_window_handles.gates{i,1});
        marker_names = handles.mother_window_handles.marker_names;
    else
        %[data, marker_names, channel_names, scaled_data, compensated_data, fcshdr] = readfcs_v2(fcs_filename);
        %data = compensated_data;
        data = handles.mother_window_handles.session_data(:,handles.mother_window_handles.gates{i,1});
        marker_names = handles.mother_window_handles.marker_names;
    end
    if ~exist(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data'),'dir')
        mkdir(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data'));
    end
    write_to_txt_v2(fullfile(handles.mother_window_handles.directoryname,'check_loaded_data',[handles.mother_window_handles.all_fcs_filenames{i},'.txt']), marker_names(:)', [], data(:,1:10)', char(9));
    fprintf('Number of events in this file %d\n', size(data,2));
    
    fprintf('Data transformation options in SPADE parameters ... ');
    switch handles.mother_window_handles.transformation_option
        case 0, 
            fprintf('No transofrmation performed\n');
%             data = fcsdat'; 
%             clear('fcsdat');
        case 1, 
            fprintf(['arcsinh transformation with cofactor ',num2str(handles.mother_window_handles.arcsinh_cofactor),'\n']);
            data = flow_arcsinh(data,handles.mother_window_handles.arcsinh_cofactor); 
%             data = flow_arcsinh(fcsdat',handles.arcsinh_cofactor); 
%             clear('fcsdat');
        case 2, display('2');
            fprintf(['arcsinh transformation with cofactor ',num2str(handles.mother_window_handles.arcsinh_cofactor),', followed by 0-mean-1-var normalization \n']);
            data = SPADE_per_gene_normalization(flow_arcsinh(data,handles.mother_window_handles.arcsinh_cofactor)); 
%             data = SPADE_per_gene_normalization(flow_arcsinh(fcsdat',handles.arcsinh_cofactor)); 
%             clear('fcsdat');
        otherwise, 1;
    end
    % data = data(:,1:min(end,500000)); %%NOTE: we don't want one single file to be super super huge, a single file normally does not get this big
        
    [C,IA,IB] = intersect(marker_names, handles.mother_window_handles.used_markers);
    used_markers = handles.mother_window_handles.used_markers;

    fprintf('Compute local density for each cell in this file\n')
    new_data = data(:,1:min(size(data,2),2000));  %% NOTE: this should be 2000, need to alter back later
    fprintf('  calculate median min dist ...')
    tic; [min_dist,NN_ind] = compute_min_dist_downsample(new_data(IA,:),data(IA,1:min(size(data,2),500000)));toc  % since new_data is part of data, this function does not compute min L1 dist. It computes the min non-zero distance, because there will be one 0. However, this creates a problem, what if the data simply contains a lot of identical entries, and result in multiple 0's? This code ignores them all, because this being zero does no good to the subsequent definination of neighborhood 
    median_min_dist = median(min_dist);
    kernel_width = median_min_dist*handles.mother_window_handles.kernel_width_factor;
    optimizaiton_para = median_min_dist*handles.mother_window_handles.density_estimation_optimization_factor;
    fprintf('  calculate local densities ...')
    tic; [local_density] = compute_local_density(data(IA,:), kernel_width, optimizaiton_para); toc

    save(mat_filename, 'data', 'marker_names', 'used_markers', 'local_density', 'kernel_width');

    clear( 'data', 'marker_names', 'used_markers', 'local_density', 'kernel_width');
end
fprintf('Done computing local density!\n\n');


% --- Executes on button press in button_2_pool_selected_files.
function button_2_pool_selected_files_Callback(hObject, eventdata, handles)
% hObject    handle to button_2_pool_selected_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    % get file name
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.all_fcs_filenames{i});
    mat_filename = [fcs_filename,'.mat'];
    if exist(mat_filename)~=2 % if the .mat file that stores the downsampling info already exist
        fprintf('Not all fcs files have local density calculated yet!!\nPlease click the Compute local densities button, and wait for it to finish before clicking this step.\n\n');
        return
    end
end

% gather the list of files used in  building SPADE tree
[c,used_file_ind,IB] = intersect(handles.mother_window_handles.file_annot,handles.mother_window_handles.file_used_to_build_SPADE_tree);
used_file_ind = sort(used_file_ind); 
% define variable for all pooled data
all_data=[];
tube_channel=[];
all_local_density=[];
for i=1:length(used_file_ind)
    % get file name
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.all_fcs_filenames{used_file_ind(i)});
    mat_filename = [fcs_filename,'.mat'];
    % load file
    display(['downsampling and pooling fcs file: ',num2str(i),'/',num2str(length(used_file_ind))]);
    display(handles.mother_window_handles.all_fcs_filenames{used_file_ind(i)});
    load(mat_filename);
    % used to normalize the local densities for the other files 
    if i==1
        RefDataSize = size(data,2); % used to normalize the local densities for the other files 
        all_marker_names = marker_names;
        used_marker_names = used_markers;
    end
    % remove outliers
    if handles.mother_window_handles.outlier_density>0
        outlier_density = prctile(local_density,handles.mother_window_handles.outlier_density);
        data(:,local_density<=outlier_density)=[];
        local_density(local_density<=outlier_density)=[];
    end
    % compute target density
    switch handles.mother_window_handles.target_density_mode
        case 1
            target_density = prctile(local_density,handles.mother_window_handles.target_density);
        case 2
            num_desired_cells = handles.mother_window_handles.target_cell_number;
            target_density = downsample_to_certain_num_cells(data, local_density, num_desired_cells);
        otherwise
            1;
    end
    % % downsample
    % keep_prob = min(1,(target_density./local_density));
    % is_keep = rand(1,length(local_density))<keep_prob;  
    % is_keep(find(sum(isnan(data))~=0))=0;
    tic;
    is_keep = logical(deterministic_downsample_to_target_density(data(ismember(marker_names, used_markers),:), local_density, target_density));
    toc
    display([num2str(sum(is_keep)),' cells keeped in this fcs file'])
    display(' ');
    data = data(:,is_keep);
    local_density = local_density(is_keep)/length(is_keep)*RefDataSize;
    % pool data
    if isequal(marker_names,all_marker_names)
        all_data = [all_data,data];
    else
        new_marker_names = setdiff(marker_names,all_marker_names);
        all_marker_names = [all_marker_names;new_marker_names];
        all_data = [all_data;repmat(NaN,length(new_marker_names),size(all_data,2))];
        data_tmp = zeros(size(all_data,1),size(data,2))+NaN;
        [C,IA,IB] = intersect(marker_names,all_marker_names);
        data_tmp(IB,:) = data(IA,:);
        all_data = [all_data, data_tmp];
    end
    all_local_density = [all_local_density,local_density];
    tube_channel = [tube_channel,repmat(used_file_ind(i),1,size(data,2))];
end
all_data = [all_data;tube_channel];
all_marker_names{end+1} = 'FileInd';

data = all_data; 
marker_names = all_marker_names;
local_density = all_local_density;
display(['PooledDownsampledData has ', num2str(size(data,2)), ' cells from ', num2str(length(used_file_ind)), ' files']);
if size(data,2)>handles.mother_window_handles.max_allowable_events
    display(['Since the number of cells exceeds the max number of allowable events ', num2str(handles.mother_window_handles.max_allowable_events),', further deterministic downsampling is performed']);
    % % the following three lines are for uniform downsampling, which is from the implementation before
    % keep_ind = sort(randsample(1:size(data,2),handles.max_allowable_events));
    % data = data(:,keep_ind);
    % local_density = local_density(keep_ind);
    
    % for each file used to build the tree, compute NN distance
    possible_file_ind = unique(data(end,:));
    file_ind = data(end,:);
    IA = find(ismember(marker_names, used_markers));
    all_medians = [];
    fprintf('  calculate nearest neighbor dist for kernel width ... %4d / %4d',0,length(possible_file_ind));
    for i=possible_file_ind
        tmp = data(IA,file_ind==i);
        ns = createns(tmp','Distance','cityblock');
        [idx,dist] = knnsearch(ns,tmp','k',2);
        all_medians = [all_medians, median(dist(:,2))];
        fprintf('\b\b\b\b\b\b\b\b\b\b\b%4d / %4d',length(all_medians),length(possible_file_ind));
    end
    fprintf('\n');
    
    kernel_width = median(all_medians);
    optimizaiton_para = 0.01*kernel_width; 
    fprintf('  calculate local densities ...')
    tic; [local_density_tmp] = compute_local_density(data(IA,:), kernel_width, optimizaiton_para); toc

    num_desired_cells = handles.mother_window_handles.max_allowable_events;
    target_density = downsample_to_certain_num_cells(data, local_density_tmp, num_desired_cells);
    
    fprintf('  ');
    tic; 
    is_keep = logical(deterministic_downsample_to_target_density(data(IA,:), local_density_tmp, target_density));
    toc
    
    data = data(:,is_keep);
    local_density = local_density(:,is_keep);
    
    display(['Now, PooledDownsampledData has ', num2str(size(data,2)), ' cells from ', num2str(length(used_file_ind)), ' files']);
    display(' ');
end
save(fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.pooled_downsampled_filename), 'all_data', 'all_local_density', 'data', 'local_density', 'marker_names', 'used_markers');
fprintf('Done!\n\n');
guidata(hObject, handles);

function target_density = downsample_to_certain_num_cells(data, local_density, desired_num)
% keep_prob = x./local_density
% need to find the value of "x", such that if we downsample according to
% "keep_prob", we end up with about "desired_num" cells
% therefore, need to solve the following
%      sum(min(x/local_density(i),1)) = desired_num
% which is equivalent to
%      x = (desired_num-i) / sum(1/local_density(i+1:end)) && local_density(i)<=x<=local_density(i+1) 

if desired_num>=length(local_density)
    target_density = max(local_density)+1;
    return
end
ld = [sort(local_density,'ascend')];
if desired_num/sum(1./local_density) <= ld(1)
    target_density = desired_num/sum(1./local_density);
    return
end
for i=1:length(ld)-1
    x = (desired_num-i) / sum(1./ld(i+1:end));
    if ld(i)<=x && x<=ld(i+1) 
        break;
    end
end
target_density = x;
return


% --- Executes on button press in button_3_clustering.
function button_3_clustering_Callback(hObject, eventdata, handles)
% hObject    handle to button_3_clustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% do the actual work here
load(fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.pooled_downsampled_filename));
[C,IA,IB] = intersect(marker_names,used_markers); IA = sort(IA);
% % clustering and mst
switch handles.mother_window_handles.clustering_algorithm
    case 'kmeans'    
        % clustering and mst using kmeans
        fprintf('Working on clustering step...\n');
        if handles.mother_window_handles.number_of_desired_clusters==size(data(IA,:),2)
            centers = data(IA,:); idx = 1:size(data(IA,:),2); centers_ind = idx;
        else
            [idx,centers,centers_ind]=deterministic_kmeans_for_SPADE(data(IA,:)',handles.mother_window_handles.number_of_desired_clusters,local_density);
            % [idx, centers] = kmeans_phase1(data(IA,:)', handles.number_of_desired_clusters); 
            centers = centers'; idx = idx';
        end
        
%         center_dist_scaled = SPADE_center_pairwise_dist(idx,centers,centers_ind, data(IA,:), local_density);
%         [mst_tree,adj2] = mst_from_dist_matrix(center_dist_scaled);

        % [mst_tree,adj2] = SPADE_mst_from_contact_weights(idx,data(IA,:),local_density, data(end,:));
        [mst_tree,adj2] = SPADE_mst_from_contact_weights(idx,data(IA,:),local_density, ones(size(data(end,:))));
        fprintf('Done\n\n');
    case 'agglomerative'    
        % clustering and mst using agglomerative
        [mst_tree, idx, centers] = SPADE_cluster_cells(data(IA,:), handles.mother_window_handles.number_of_desired_clusters);
        data(:,idx==0)=[];
        local_density(idx==0)=[];
        idx(idx==0)=[];
    otherwise
        error('this should not happen!!')
end

% layout
disp('Working on visualization of the tree structure ... ');

% % node_positions = arch_layout(mst_tree);

% % A = mst_tree;
% % [X,spring,distance]=kamada_kawai_spring_layout_mex(...
% %     A, 1e-30, 20000, 1, ...  % adj, tolerance, max iteration, spring_constant
% %     [], 1, 0, 'matrix');     % progressive_opt, options.edge_length, edge_weights, edge_weight_opt;
% % node_positions = X';         % use spring embedding to determine node positoin

node_positions = radio_layout(mst_tree,centers);


% normalize node positions
node_positions = node_positions - repmat((max(node_positions,[],2)+min(node_positions,[],2))/2,1,size(node_positions,2));
node_positions = node_positions/max(abs(node_positions(:)))*50;
% rotate so that the highest density point is in the west
node_local_density = accumarray(idx', local_density')';
% weight_center = sum(node_positions.*repmat(node_local_density,2,1),2)/sum(node_local_density);
weight_center = find_highest_density_position(node_positions, node_local_density);
tmp_score = zeros(1,360) + Inf;
for i=1:360
    tmp_angle = i/180*pi;
    tmp = [cos(tmp_angle), sin(tmp_angle); -sin(tmp_angle), cos(tmp_angle)]*weight_center(:);
    if tmp(1)<0 
        tmp_score(i)=abs(tmp(2));
    end
end
[~,i] = min(tmp_score);
tmp_angle = i/180*pi;
node_positions = [cos(tmp_angle), sin(tmp_angle); -sin(tmp_angle), cos(tmp_angle)]*node_positions;
% flipup to make sure that more density is in the north half
if sum(node_local_density(node_positions(1,:)>0 & node_positions(2,:)>0)) < sum(node_local_density(node_positions(1,:)>0 & node_positions(2,:)<0))
    node_positions(2,:)=-node_positions(2,:);
end
fprintf('Done\n\n');
% [mst_tree,adj2] = mst(node_positions');


% determine initial node_size
node_size = zeros(1,size(node_positions,2));
for i=1:length(node_size), node_size(i) = sum(local_density(idx==i)); end
node_size = flow_arcsinh(node_size, median(node_size)/2);
node_size = ceil(node_size/max(node_size)*10);
node_size(node_size<5)=5;
node_size = node_size * 1.2;
% initialize annotations
tree_annotations = [];
tree_bubble_contour = [];
save(fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename), 'data', 'local_density', 'marker_names', 'used_markers','idx','mst_tree','node_positions','node_size','tree_annotations','tree_bubble_contour');

% upsample
all_clustered_data = data;
all_clustered_data_idx = idx;
[C,IA1,IB] = intersect(marker_names,used_markers);
handles.mother_window_handles.Result = [];
for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    indicator_of_this_file = all_clustered_data(end,:)==i;
    if sum(indicator_of_this_file)~=0
        clustered_data = all_clustered_data(:,indicator_of_this_file);
        clustered_data_idx = all_clustered_data_idx(indicator_of_this_file);
    else
        clustered_data = all_clustered_data;
        clustered_data_idx = all_clustered_data_idx;
    end
    
    % get file name
    fprintf('upsampling %d of %d files\n',i, length(handles.mother_window_handles.all_fcs_filenames));
    fcs_filename = fullfile(handles.mother_window_handles.directoryname,handles.mother_window_handles.all_fcs_filenames{i});
    mat_filename = [fcs_filename,'.mat'];
    load(mat_filename,'data','marker_names');
    [C,IA2,IB] = intersect(marker_names,used_markers);

    %  tic;[min_dist,NN_index] = compute_min_dist_upsample(data(IA2,:),clustered_data(IA1,:));toc
    % % the following block replaces the above commented line, at least three times faster
    tic;
    NN_index = zeros(1,size(data,2));
    block_size = 1000;
    ns = createns(clustered_data(IA1,:)','nsmethod','kdtree','Distance','cityblock');
    fprintf('%3d%%',0);
    for k=1:block_size:size(data,2)
        ind_tmp = k:min([k+block_size-1,size(data,2)]);
        [a] = knnsearch(ns,data(IA2,ind_tmp)','k',1);
        NN_index(ind_tmp) = a';
        fprintf('\b\b\b\b%3d%%',round(max(ind_tmp)/size(data,2)*100));
    end    
    toc
    
    all_assign{i} = clustered_data_idx(NN_index);
    handles.mother_window_handles.Result = [handles.mother_window_handles.Result, all_assign{i}];
end

all_fcs_filenames = handles.mother_window_handles.all_fcs_filenames;
file_annot = handles.mother_window_handles.file_annot;
handles.mother_window_handles.all_assign = all_assign;
handles.mother_window_handles.Result = handles.mother_window_handles.Result';

% build the cell arrary that stores the average protein expression per node per marker per file
fprintf('\nComputing average protein expression per cluster per marker per file for %d files ... %5d',length(handles.mother_window_handles.all_fcs_filenames)+1,1);
marker_node_average=cell(0); counter = 1;
% get the average from the pooled data
load(fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename),'data','marker_names');
for j=1:length(marker_names)
    marker_node_average{counter,1} = 'POOLED';
    marker_node_average{counter,2} = marker_names{j};
    [group_avg, counts, group_idx_values] = SPADE_compute_one_marker_group_mean(data(j,:), idx);
    group_avg(group_idx_values==0)=[];
    counts(group_idx_values==0)=[];
    group_idx_values(group_idx_values==0)=[];
    tmp = zeros(1,max(idx))+NaN;
    tmp(group_idx_values) = group_avg;
    marker_node_average{counter,3} = tmp;
    counter = counter + 1;
end
marker_node_average{counter,1} = 'POOLED';
marker_node_average{counter,2} = 'CellFreq';
[dummy, tmp] = SPADE_compute_one_marker_group_mean(ones(1,length(idx)),idx);    
marker_node_average{counter,3} = tmp(:)';
counter = counter + 1;
% get the average from individual files
for i=1:length(handles.mother_window_handles.all_fcs_filenames)
    fprintf('\b\b\b\b\b%5d',i+1);
    load(fullfile(handles.mother_window_handles.directoryname, [handles.mother_window_handles.all_fcs_filenames{i},'.mat']),'data','marker_names');
    for j=1:length(marker_names)
        marker_node_average{counter,1} = handles.mother_window_handles.file_annot{i};
        marker_node_average{counter,2} = marker_names{j};
        [group_avg, counts, group_idx_values] = SPADE_compute_one_marker_group_mean(data(j,:), all_assign{i}); % the following few lines are for the purpose that: some file may not have any cell belong to one particular node, and therefore, the "group_avg" does not have information for every node
        group_avg(group_idx_values==0)=[];
        counts(group_idx_values==0)=[];
        group_idx_values(group_idx_values==0)=[];
        tmp = zeros(1,max(idx))+NaN;
        tmp(group_idx_values) = group_avg;
        marker_node_average{counter,3} = tmp;
        counter = counter + 1;
    end    
    marker_node_average{counter,1} = handles.mother_window_handles.file_annot{i};
    marker_node_average{counter,2} = 'CellFreq';
    [group_avg, counts, group_idx_values] = SPADE_compute_one_marker_group_mean(ones(1,length(handles.mother_window_handles.all_assign{i})),handles.mother_window_handles.all_assign{i}); 
    marker_node_average{counter,3} = zeros(1,max(idx));
    marker_node_average{counter,3}(group_idx_values)=counts;
    counter = counter + 1;
end
save(fullfile(handles.mother_window_handles.directoryname, handles.mother_window_handles.cluster_mst_upsample_filename), 'all_assign','all_fcs_filenames','file_annot', 'marker_node_average', '-append');
fprintf('\nDone\n\n')
guidata(hObject, handles);
uiresume(handles.figure1);