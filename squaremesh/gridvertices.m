function [ v1,v2,v3,v4 ] = gridvertices( i,j,d)
%GRIDVERTICES Summary of this function goes here
%vertices are as follows:
%    1 ----- 2
%    -       -
%    -       -
%    3 ----- 4

%   Detailed explanation goes here
    v1x=-(i-1)*d;
    v1y=-(j-1)*d;
    
    v2x=-(i)*d;
    v2y=-(j-1)*d;
    
    v3x=-(i-1)*d;
    v3y=-(j)*d;
    
    v4x=-(i)*d;
    v4y=-(j)*d;
    

end

