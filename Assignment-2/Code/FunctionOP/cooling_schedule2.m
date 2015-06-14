function [ T ] = cooling_schedule2( T0, alpha, t )
%COOLING_SCHEDULE Summary of this function goes here
%   Detailed explanation goes here
T = T0 * cos(t)^2 * exp(-alpha * t);
end