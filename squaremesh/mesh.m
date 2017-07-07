%PARAMETERS
n=10; % number of points
d=0.5; % Dimension of square
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


%FIND MIN SEPARATION DISTANCE OF ALL POINTS

for i=1:n %For the data set
    p=[x(i),y(i)]; %pick each point
    dist=realmax;%Set the separation distance to largest float
    for j=1:n %compare with every point in the set
        if (i ~= j)%Exclude comparing a point with itself
          newp=[x(j),y(j)];
          newdist=abs(norm(p-newp));%calculate the seperation distance
          if(newdist < dist)%If the current point is closer
              dist=newdist; %Set the minimum separation distance to distance
          end
        end    
    end
    minsep(i)=dist;
    sum=sum+dist;
end
ave_sep=sum/n;
fprintf('Average minimum separation distance is %d\n',ave_sep);

%Calculate the standard deviation of seperation distance
sum=0;
for i=1:n %For the data set
    sum=sum+(minsep(i)-ave_sep)^2;
end

std_sep=sqrt(sum/n);
fprintf('Standrad deviation of separation distance is %d\n',std_sep);

boxed=zeros(n,1);
%BOX IN THE POINTS
for i=1:n %For every point
    fprintf('%d\n',i);
    p=[x(i),y(i)]; %pick each point
    disp(p);
    %Calculate its grid position TODO
    gridpos=[abs(floor(p(1)/d)+1),abs(floor(p(2)/d)+1)];
    disp(gridpos);
    %Search the surrounding for neighbouring points within the region
    pointfound=0;
    for s=0:maxstds
        queryradius=ave_sep+s*std_sep;%TODO Prevent searching same areas
        for j=1:n
            fprintf('j: %d\n',j);
             newp=[x(j),y(j)];
             sepdistance=abs(norm(newp-p));
             if (sepdistance <= queryradius)
                s=maxstds+1;%Terminate any further searches
                %Connect the two points with boxes
                disp(newp);
             end
        end
        
        %Connect all the nearest neighbors with boxes
        enclosed=0;
        center=p;
     %   while ( enclosed == 0)
            vec=newp-center;
            [th,rh]=cart2pol(vec(1),vec(2));
            th=th*180/3.145678;
            if(th>315)
                th=th-360;
            end
            if(th > -45 && th <= 45)
                center(1)=center(1)+d;%Shift the box right
                gridpos(1)=round(gridpos(1)+1);
            elseif(th > 45 && th <= 135)
                center(2)=center(2)+d;%Shift the box up
                gridpos(2)=round(gridpos(2)+1);
            elseif(th > 135 && th <= 225)
                center(1)=center(1)-d;%Shift the box left
                gridpos(1)=round(gridpos(1)-1);
            elseif(th > 225 && th <= 315)
                center(2)=center(2)-d;%Shift the box down
                gridpos(2)=round(gridpos(2)-1);
            else
                fprintf('ERROR IN THETA\n');
            end
            grid(uint16(gridpos(1)),uint16(gridpos(2)))=1;
            [v1,v2,v3,v4] = gridvertices(gridpos(1),gridpos(2),d);
            if(newp(1) <= v2(1) && newp(1) >= v1(1) && newp(2) >= v3(2) && newp(2) <= v1(2))
                fprintf('point enclosed\n');
                enclosed=1;
            end
    %    end        
    end
end






%PLOT THE RESULT

scatter(x,y)
%hold on
w = [-1,-0.5,-0.5,0,1.5,-0.5,-1];
z = [-1,-1,-0.5,0,0.5,0.9,-1];
%plot(w,z,'.-');

%hold off