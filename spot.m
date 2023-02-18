function varargout = spot(varargin)


global data 
load spotdata;

if nargin == 0  % LAUNCH GUI

	fig = openfig("spot.fig",'reuse');
   
	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);
    

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = pushbutton1_Callback(h, eventdata, handles, varargin)
global data
flag=get(handles.popupmenu2,'value')

blink(data.mask,data.IM{flag});


% --------------------------------------------------------------------
function varargout = pushbutton2_Callback(h, eventdata, handles, varargin)
global data
flag=get(handles.popupmenu2,'value');
D=data.IM{flag} ;
[Xall,Yall]=getpixelvalues(D,data.mask);
PERM=randperm(44); 
for i=1:8
    Y(i)=Yall(PERM(i));
end

str=strcat(' Y =  ' , num2str(Y))
set(handles.edit2,'string',str);

%Now for starting W ranksum test
alpha=str2num(get(handles.edit1,'string'))

Xall=sort(Xall);

'WORKING ON RANK SUM TEST'
Hyp=0; i=1;
while(Hyp==0 & i<31)
    
    X=Xall(i:i+7)
    
    str=strcat(' X =  ' , num2str(X)); pause(2);
    set (handles.edit2,'string',str);
    
    [P,Hyp]=ranksum(X,Y,alpha)
    i=i+1;
end


if i==31
    set(handles.edit2,'string','CHANGE SIGNIFICANCE TO A HIGHER VALUE');
else
    MX=min(X);
    
    set(handles.edit2,'string',strcat('THRESHOLD=',num2str(MX))); 
    mask=(double(data.mask)).*(double(rgb2gray(D))>MX);
    blink(mask,D);
    
    D=double(D);
    BRed=median(nonzeros((1-mask).*D(:,:,1)));%background
    Red=median(nonzeros(mask.*D(:,:,1)));%foreground
    
    BGreen=median(nonzeros((1-mask).*D(:,:,2)));
    Green=median(nonzeros(mask.*D(:,:,2)));
    
    T=(Red-BRed)/(Green-BGreen);
    
    str=strcat(' Ratio T= ',num2str(T) ); 
    
    set(handles.edit2,'string',str);
end

% --------------------------------------------------------------------
function varargout = edit1_Callback(h, eventdata, handles, varargin)

% --------------------------------------------------------------------
function varargout = edit2_Callback(h, eventdata, handles, varargin)










% --------------------------------------------------------------------
function[]=blink(M,D);

M=M*200;
for i=1:3
Dhat(:,:,i)=uint8(M+double(D(:,:,i)));
end

for i=1:3
    image(Dhat);axis off; pause(1);
    image(D);axis off;  pause(1);
   
end

image(D);axis off;


function[X,Y]=getpixelvalues(D,mask)
D=double(rgb2gray(D));
X=[];Y=[];
for i=1:9
    for j=1:9
        if mask(i,j)==0
            Y=[Y,D(i,j)];
        else
            X=[X,D(i,j)];
        end
    end
end


% --------------------------------------------------------------------
function varargout = popupmenu2_Callback(h, eventdata, handles, varargin)
global data
flag= get(handles.popupmenu2,'value')
image(data.IM{flag}); axis off;
