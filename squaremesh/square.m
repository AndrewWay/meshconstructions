function [ v1,v2,v3,v4 ] = square(x0,y0,d)
%Given a center and a dimension
%Calculate the positions of a square's vertices
%vertices are as follows:
%    2 ----- 1
%    -       -
%    -       -
%    3 ----- 4

halfd=d/2; %Calculate half of the square dimension

%Calculate vertex vectors
    
    v1x=x0+halfd;
    v1y=y0+halfd;
    
    v2x=x0-halfd;
    v2y=y0+halfd;
    
    v3x=x0-halfd;
    v3y=y0-halfd;
    
    v4x=x0+halfd;
    v4y=y0-halfd;
    
    v1=[v1x,v1y];
    v2=[v2x,v2y];
    v3=[v3x,v3y];
    v4=[v4x,v4y];
    

end

