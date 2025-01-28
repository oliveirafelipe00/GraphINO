function varargout = GraphINO_V2(varargin)
% GRAPHINO_V2 M-file for GraphINO_V2.fig
%      GRAPHINO_V2, by itself, creates a new GRAPHINO_V2 or raises the existing
%      singleton*.
%
%      H = GRAPHINO_V2 returns the handle to a new GRAPHINO_V2 or the handle to
%      the existing singleton*.
%
%      GRAPHINO_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHINO_V2.M with the given input arguments.
%
%      GRAPHINO_V2('Property','Value',...) creates a new GRAPHINO_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphINO_V2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphINO_V2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphINO_V2

% Last Modified by GUIDE v2.5 27-Jan-2025 19:50:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphINO_V2_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphINO_V2_OutputFcn, ...
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


% --- Executes just before GraphINO_V2 is made visible.
function GraphINO_V2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphINO_V2 (see VARARGIN)

% Choose default command line output for GraphINO_V2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GraphINO_V2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GraphINO_V2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function com_Callback(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of com as text
%        str2double(get(hObject,'String')) returns contents of com as a double


% --- Executes during object creation, after setting all properties.
function com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in conect.
function conect_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
fclose('all');
delete(instrfind);
set(handles.meas,'Userdata',0);
set(handles.parar,'Userdata',0);
set(handles.status,'String','Aguarde...','BackgroundColor','Red');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%aduirir o nome do arquivo de dados
file = get(handles.filename,'String');
if isempty(file)
   errordlg('Arquivo Inválido');
   set(handles.status,'String','OFF');
   return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nsens = round(str2double(get(handles.Nsens,'String')));
if isnan(Nsens) || Nsens <= 0;
    errordlg('Set the number of sensors!');
    set(handles.status,'String','OFF','BackgroundColor','Red');
    return
elseif Nsens > 16;
    errordlg('GraphINO supports up to 16 sensors!');
    set(handles.status,'String','OFF','BackgroundColor','Red');
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
intervalo = (str2double(get(handles.interval,'String')));
if isnan(intervalo) || intervalo < 0;
    errordlg('Set the time delay in seconds!');
    set(handles.status,'String','OFF','BackgroundColor','Red');
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    a = arduino(get(handles.com,'String'));
    set(handles.status,'String','Conected','BackgroundColor','Green');
catch
    errordlg('Check COM port and adiosrv Arduino file','Error!');
    set(handles.status,'String','OFF','BackgroundColor','Red');
    return
end
MS = 16;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = get(handles.filename,'String');
%arquivo
if isempty(file)
    errordlg('Invalid data file!','Error');
    return
end
fid = fopen(file,'w');
switch Nsens;  
    case 1
       fprintf(fid,'%15s %5s %5s\n',...
            't','PWM','s0'); 
    case 2
        fprintf(fid,'%15s %5s %5s %5s\n',...
            't','PWM','s0','s1');
    case 3
        fprintf(fid,'%15s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2');
    case 4
        fprintf(fid,'%15s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3');
    case 5
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4');
    case 6
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5');
    case 7
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6');
    case 8
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7');
    case 9
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8');
    case 10
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s9');
    case 11
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10');
    case 12
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10','s11');
    case 13
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10','s11','s12');
    case 14
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10','s11','s12','s13');
    case 15
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10','s11','s12','s13','s14');
    case 16
        fprintf(fid,'%15s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n',...
            't','PWM','s0','s1','s2','s3','s4','s5','s6','s7','s8','s8','s9','s10','s11','s12','s13','s14','s15');
end
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while get(handles.meas,'Userdata') == 0
    if get(handles.parar,'Userdata') == 1
        break
    end
    pause(1e-3);
end
set(handles.conect,'Enable','Off');
set(handles.com,'Enable','Off');
set(handles.Nsens,'Enable','Off');
set(handles.file,'Enable','Off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if get(handles.meas,'Userdata') == 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(handles.status,'String','Running...');
    t0 = clock;
    figure;
    set(handles.meas,'Enable','Off');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while get(handles.meas,'Userdata') == 1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pause(1e-3);
        intervalo = (str2double(get(handles.interval,'String')));
        if isnan(intervalo) || intervalo <= 0;
            intervalo = 0;
            set(handles.interval,'String','0');
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pause(intervalo);
        t = abs(etime(clock,t0));
        s = zeros(1,Nsens);
        PWM = round(str2double(get(handles.powerPWM,'String'))*(255/100));
        set(handles.powerPWM,'String',num2str(PWM));
    if isnan(PWM) || PWM <= 0;
        PWM = 0;
        set(handles.powerPWM,'String','0');
    end
        a.analogWrite(10,PWM);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        switch Nsens;
            case 1
                s(1) = a.analogRead(0);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d\n',...
                    t,PWM,s(1));
                fclose(fid);
            case 2
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,1,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,1,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d\n',...
                    t,PWM,s(1),s(2));
                fclose(fid);
            case 3
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,1,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,1,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,1,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3));
                fclose(fid);
            case 4
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,2,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,2,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,2,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,2,4);
                plot(t,s(4),'.k'); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4));
                fclose(fid);
            case 5
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,3,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,3,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,3,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,3,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(2,3,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5));
                fclose(fid);
            case 6
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,3,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,3,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,3,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,3,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(2,3,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(2,3,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6));
                fclose(fid);
        case 7
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,4,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,4,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,4,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,4,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(2,4,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(2,4,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(2,4,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7));
                fclose(fid);
        case 8
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,4,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,4,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,4,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,4,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(2,4,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(2,4,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(2,4,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(2,4,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8));
                fclose(fid);
        case 9
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,3,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,3,2);
                plot(t,s(2),'.k'); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,3,3);
                plot(t,s(3),'.k'); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,3,4);
                plot(t,s(4),'.k'); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,3,5);
                plot(t,s(5),'.k'); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,3,6);
                plot(t,s(6),'.k'); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,3,7);
                plot(t,s(7),'.k'); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,3,8);
                plot(t,s(8),'.k'); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,3,9);
                plot(t,s(9),'.k'); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9));
                fclose(fid);

        case 10
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(2,5,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(2,5,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(2,5,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(2,5,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(2,5,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(2,5,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(2,5,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(2,5,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(2,5,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(2,5,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10));
                fclose(fid);
        case 11
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,4,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,4,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,4,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,4,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,4,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,4,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,4,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,4,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,4,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(3,4,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(3,4,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11));
                fclose(fid);
        case 12
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                s(12) = a.analogRead(11);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,4,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,4,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,4,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,4,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,4,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,4,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,4,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,4,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,4,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(3,4,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(3,4,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                subplot(3,4,12);
                plot(t,s(12),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A11'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11),s(12));
                fclose(fid);
        case 13
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                s(12) = a.analogRead(11);
                s(13) = a.analogRead(12);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,5,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,5,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,5,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,5,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,5,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,5,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,5,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,5,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,5,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(3,5,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(3,5,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                subplot(3,5,12);
                plot(t,s(12),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A11'); grid on; hold on;
                subplot(3,5,13);
                plot(t,s(13),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A12'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11),s(12),s(13));
                fclose(fid);
        case 14
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                s(12) = a.analogRead(11);
                s(13) = a.analogRead(12);
                s(14) = a.analogRead(13);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,5,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,5,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,5,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,5,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,5,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,5,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,5,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,5,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,5,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(3,5,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(3,5,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                subplot(3,5,12);
                plot(t,s(12),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A11'); grid on; hold on;
                subplot(3,5,13);
                plot(t,s(13),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A12'); grid on; hold on;
                subplot(3,5,14);
                plot(t,s(14),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A13'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11),s(12),s(13),s(14));
                fclose(fid);
        case 15
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                s(12) = a.analogRead(11);
                s(13) = a.analogRead(12);
                s(14) = a.analogRead(13);
                s(15) = a.analogRead(14);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(3,5,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(3,5,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(3,5,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(3,5,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(3,5,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(3,5,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(3,5,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(3,5,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(3,5,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(3,5,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(3,5,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                subplot(3,5,12);
                plot(t,s(12),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A11'); grid on; hold on;
                subplot(3,5,13);
                plot(t,s(13),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A12'); grid on; hold on;
                subplot(3,5,14);
                plot(t,s(14),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A13'); grid on; hold on;
                subplot(3,5,15);
                plot(t,s(15),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A14'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11),s(12),s(13),s(14),s(15));
                fclose(fid);
        case 16
                s(1) = a.analogRead(0);
                s(2) = a.analogRead(1);
                s(3) = a.analogRead(2);
                s(4) = a.analogRead(3);
                s(5) = a.analogRead(4);
                s(6) = a.analogRead(5);
                s(7) = a.analogRead(6);
                s(8) = a.analogRead(7);
                s(9) = a.analogRead(8);
                s(10) = a.analogRead(9);
                s(11) = a.analogRead(10);
                s(12) = a.analogRead(11);
                s(13) = a.analogRead(12);
                s(14) = a.analogRead(13);
                s(15) = a.analogRead(14);
                s(16) = a.analogRead(15);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                subplot(4,4,1);
                plot(t,s(1),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A0'); grid on; hold on;
                subplot(4,4,2);
                plot(t,s(2),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A1'); grid on; hold on;
                subplot(4,4,3);
                plot(t,s(3),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A2'); grid on; hold on;
                subplot(4,4,4);
                plot(t,s(4),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A3'); grid on; hold on;
                subplot(4,4,5);
                plot(t,s(5),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A4'); grid on; hold on;
                subplot(4,4,6);
                plot(t,s(6),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A5'); grid on; hold on;
                subplot(4,4,7);
                plot(t,s(7),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A6'); grid on; hold on; 
                subplot(4,4,8);
                plot(t,s(8),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A7'); grid on; hold on;   
                subplot(4,4,9);
                plot(t,s(9),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A8'); grid on; hold on; 
                subplot(4,4,10);
                plot(t,s(10),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A9'); grid on; hold on; 
                subplot(4,4,11);
                plot(t,s(11),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A10'); grid on; hold on;
                subplot(4,4,12);
                plot(t,s(12),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A11'); grid on; hold on;
                subplot(4,4,13);
                plot(t,s(13),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A12'); grid on; hold on;
                subplot(4,4,14);
                plot(t,s(14),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A13'); grid on; hold on;
                subplot(4,4,15);
                plot(t,s(15),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A14'); grid on; hold on;
                subplot(4,4,16);
                plot(t,s(16),'.k','MarkerSize',MS); xlabel('t (s)'); ylabel('S - A15'); grid on; hold on;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fid = fopen(file,'a');
                fprintf(fid,'%15e %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d %5d\n',...
                    t,PWM,s(1),s(2),s(3),s(4),s(5),s(6),s(7),s(8),s(9),s(10),s(11),s(12),s(13),s(14),s(15),s(16));
                fclose(fid);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if get(handles.parar,'Userdata') == 1
            break
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.meas,'Userdata',0);
set(handles.parar,'Userdata',0);
set(handles.status,'String','OFF','BackgroundColor','Red');
set(handles.conect,'Enable','On');
set(handles.com,'Enable','On');
set(handles.Nsens,'Enable','On');
set(handles.meas,'Enable','On');
set(handles.file,'Enable','On');
fclose('all');
delete(instrfind);

% --- Executes on button press in meas.
function meas_Callback(hObject, eventdata, handles)
if strmatch(get(handles.status,'String'),'OFF')
    errordlg('Connect Arduino');
    return
end
set(handles.meas,'Userdata',1);
% hObject    handle to meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in parar.
function parar_Callback(hObject, eventdata, handles)
set(handles.parar,'Userdata',1);
% hObject    handle to parar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ajuda_Callback(hObject, eventdata, handles)
% hObject    handle to ajuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
msgbox(sprintf('%s\n%s\n%s','GraphINO 2.0','Developed by Felipe Oliveira','oliveira.felipe00@gmail.com'),'GraphINO 2.0');
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in novaFig.
function novaFig_Callback(hObject, eventdata, handles)
figure;
% hObject    handle to novaFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Nsens_Callback(hObject, eventdata, handles)
% hObject    handle to Nsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nsens as text
%        str2double(get(hObject,'String')) returns contents of Nsens as a double

% --- Executes during object creation, after setting all properties.
function Nsens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function interval_Callback(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval as text
%        str2double(get(hObject,'String')) returns contents of interval as a double


% --- Executes during object creation, after setting all properties.
function interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function powerPWM_Callback(hObject, eventdata, handles)
% hObject    handle to powerPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of powerPWM as text
%        str2double(get(hObject,'String')) returns contents of powerPWM as a double


% --- Executes during object creation, after setting all properties.
function powerPWM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to powerPWM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in file.
function file_Callback(hObject, eventdata, handles)
[name,path] = uiputfile('.dat','Data file','Data');
if name == 0
    name = '';
    path = '';
end
set(handles.filename,'String',strcat(path,name));

% --------------------------------------------------------------------
function hlp_Callback(hObject, eventdata, handles)
% hObject    handle to hlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
