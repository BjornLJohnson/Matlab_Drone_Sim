function [F, M, trpy, drpy] = controller(qd, t, qn, params)
% CONTROLLER quadrotor controller
% The current states are:
% qd{qn}.pos, qd{qn}.vel, qd{qn}.euler = [roll;pitch;yaw], qd{qn}.omega
% The desired states are:
% qd{qn}.pos_des, qd{qn}.vel_des, qd{qn}.acc_des, qd{qn}.yaw_des, qd{qn}.yawdot_des
% Using these current and desired states, you have to compute the desired controls

% =================== Your code goes here ===================

% Retrieve useful parameters
phi = qd{qn}.euler(1);
theta = qd{qn}.euler(2);
psi = qd{qn}.euler(3);
g=params.grav;
m=params.mass;
kp = params.kp;
kd = params.kd;


% Calculate desired acceleration in world frame w/ gravity
a = [0;0;g] + qd{qn}.acc_des;
R = RPYtoRot_ZXY(phi, theta, psi);
Rinv = R';
a_des = Rinv*a;


% Calculate position and velocity errors
ep = qd{qn}.pos_des-qd{qn}.pos;
ev = qd{qn}.vel_des-qd{qn}.vel;


% Factor errors and gains into desired acceleration
a_des = a_des+kp(1:3).*ep+kd(1:3).*ev;

% Calculate thrust based on desired acceleration and mass
F = m*a_des(3);


% Calculate desired roll, pitch and yaw
psi_des = qd{qn}.yaw_des;
phi_des = (a_des(1)*sin(psi_des)-a_des(2)*cos(psi_des))/g;
theta_des = (a_des(1)*cos(psi_des)+a_des(2)*sin(psi_des))/g;


% Retrieve current angular velocities
p = qd{qn}.omega(1);
q = qd{qn}.omega(2);
r = qd{qn}.omega(3);


% Calculate desired angular velocities
p_des = 0;
q_des = 0;
r_des = qd{qn}.yawdot_des;


% Calculate angular position and derivative errors
ep = [phi_des-phi; theta_des-theta; psi_des-psi];
ed = [p_des-p; q_des-q; r_des-r];


% Calculate moments based on errors and gains
M    = ep.*kp(4:6)+ed.*kd(4:6);
    
% =================== Your code ends here ===================

% Output trpy and drpy as in hardware
trpy = [F, phi_des, theta_des, psi_des];
drpy = [0, 0,       0,         0];

end
