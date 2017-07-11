function [ std ] = stdsep( minsep,ave_sep )
%STDSEP Summary of this function goes here
%   Detailed explanation goes here
n=size(minsep,1);
sum=0;
for i=1:n %For the data set
    sum=sum+(minsep(i)-ave_sep)^2;
end
std=sqrt(sum/n);
end

