import java.util.LinkedList;

%PARAMETERS
n=10; % number of points
d=0.2; % Dimension of square
maxstds=1;
%DATASET
x = randn(n,1);
y = randn(n,1);
minsep=zeros(n,1);
sum=0;

%SETUP GRID
x_max=max(x);
y_max=max(y);
x_min=min(x);
y_min=min(y);

%Shift all the data 
y=y-y_max;
x=x-x_min;
disp(x);
disp(y);
%Set the grid width and height
grid_width=abs(x_max-x_min);
grid_height=abs(y_max-y_min);

grid_wunits=ceil(grid_width/d);
grid_hunits=ceil(grid_height/d);
fprintf('The grid is %d wide by %d high\n',grid_wunits,grid_hunits);
grid=zeros(grid_hunits,grid_wunits);


[ave_sep,minsep]=avesep(x,y,n);%Find average minimum seperation distance
fprintf('Average minimum separation distance is %d\n',ave_sep);

std_sep=stdsep(minsep,ave_sep);%Calculate the standard deviation of min seperation distance
fprintf('Standard deviation of separation distance is %d\n',std_sep);

boxed=zeros(n,1);
%BOX IN THE POINTS
for i=1:n %For every point
    p=[x(i),y(i)]; %pick each point
    %Search the surrounding for neighbouring points within the region
    pair_queue=LinkedList();
    for s=0:maxstds
        queryradius=ave_sep+s*std_sep;%TODO Prevent searching same areas
        pair_queue=pairsearch(p,x,y,queryradius);
        if(pair_queue.size()>0)
            s=maxstds+1;
        end
    end
    
    while (pair_queue.size() > 0) %While there are points to connect
        index=pair_queue.remove();%Grab an unconnected point
        neighbor=[x(index),y(index)];
        grid=connectpoints(grid,p,neighbor,d);%Connect the points
    end     
end


disp(grid);



%PLOT THE RESULT

scatter(x,y)
%hold on
w = [-1,-0.5,-0.5,0,1.5,-0.5,-1];
z = [-1,-1,-0.5,0,0.5,0.9,-1];
%plot(w,z,'.-');

%hold off