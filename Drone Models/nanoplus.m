function params = nanoplus()
% NANOPLUS basic parameters for nanoplus quadrotor
%   nanoplus outputs the basic parameters (mass, gravity and inertia) of
%   the quadrotor nanoplus

m = 0.176; %kg: nanoplus without gumstix and camera
g = 9.81;
I = [0.00025,   0,          2.55e-6;
     0,         0.000232,   0;
     2.55e-6,   0,          0.0003738]; %see mathematica calculation

params.mass = m;
params.I    = I;
params.invI = inv(I);
params.grav = g;
params.arm_length = 0.086;

% Ixx = I(1,1);
% Iyy = I(2,2);
% Izz = I(3,3);

params.maxangle = 40*pi/180; %you can specify the maximum commanded angle here
params.maxF = 2.5*m*g;
params.minF = 0.05*m*g;

% You can add any fiels you want in params
% for example you can add your controller gains by
% params.k = 0, and they will be passed into controller.m

params.kp = [1;   % x       % Best: 1
             1;   % y       % Best: 1
             25;  % z       % Best: 25
             .5;  % roll    % Best: .5
             .5;  % pitch   % Best: .5
             .5]; % yaw     % Best: .5

params.kd = [100; % x       % Best: 100
             100; % y       % Best: 100
             100; % z       % Best: 100
             1;   % roll    % Best: 1
             1;   % pitch   % Best: 1
             1];  % yaw     % Best: 1
end
