function [ ave_sep, minsep ] = avesep( x,y,n )
%AVESEP Summary of this function goes here
%   Detailed explanation goes here
sum=0;
minsep=zeros(n,1);
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

end

