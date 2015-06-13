function [ T ] = cooling_schedule1( T0, alpha, t )
%COOLING_SCHEDULE Summary of this function goes here
%   Detailed explanation goes here
T0
alpha
t
T = T0/(1.0 + alpha * t);
end

