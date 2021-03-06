import java.util.LinkedList;

%PARAMETERS
n=300; % number of points
d=0.002; % Dimension of square
maxstds=1;
x=zeros(n,1);
y=zeros(n,1);
radius=1;

%CIRCLE DATA
angle_inc=2*3.145678/n
for i=1:n
    angle=(i-1)*angle_inc;
    x(i)=cos(angle)*radius;
    y(i)=sin(angle)*radius;
end

%RANDOM DATA
%x = randn(n,1);
%y = randn(n,1);


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


%PLOT THE RESULT
scatter(x,y)
hold on
for i=1:grid_hunits
    for j=1:grid_wunits
        if(grid(i,j) == 1)
           xbox=d*((j-1)+1/2);
           ybox=-d*((i-1)+1/2);
           [v1,v2,v3,v4]=square(xbox,ybox,d);
           xpoints=[v1(1),v2(1),v3(1),v4(1),v1(1)];
           ypoints=[v1(2),v2(2),v3(2),v4(2),v1(2)];
           plot(xpoints,ypoints);
        end
    end
end
%plot(w,z,'.-');

hold off