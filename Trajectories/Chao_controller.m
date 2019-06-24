function [F, M, trpy, drpy] = Chao_controller(qd, t, qn, params)
% CONTROLLER quadrotor controller
% The current states are:
% qd{qn}.pos, qd{qn}.vel, qd{qn}.euler = [roll;pitch;yaw], qd{qn}.omega
% The desired states(trajectory handle ouputs) are:
% qd{qn}.pos_des, qd{qn}.vel_des, qd{qn}.acc_des, qd{qn}.yaw_des, qd{qn}.yawdot_des
% Using these current and desired states, you have to compute the desired controls
% anuglar vel of robot in boday frame omega = [p,q,r]
% =================== Your code goes here ===================

m  = params.mass;
g  = params.grav;
kd = params.kd;
kp = params.kp;

kp_pos = kp(1:3);
kd_pos = kd(1:3);

kp_att = kp(4:6);
kd_att = kd(4:6);

% using equation 11
rdotdot_des = qd{qn}.acc_des + kd_pos.* (qd{qn}.vel_des - qd{qn}.vel) ...
                             + kp_pos.* (qd{qn}.pos_des - qd{qn}.pos);

r1dotdot_des = rdotdot_des(1);
r2dotdot_des = rdotdot_des(2);
r3dotdot_des = rdotdot_des(3);

% using equation 14 get theta_des and phi_des
psi_T = qd{qn}.yaw_des;
phi_des = 1/g * (r1dotdot_des * sin(psi_T) - r2dotdot_des * cos(psi_T));
theta_des= 1/g * (r1dotdot_des * cos(psi_T) + r2dotdot_des * sin(psi_T));
% using equation 16 got psi_des, r_des
psi_des = psi_T;
r_des = qd{qn}.yawdot_des;


% desired p,q are taken to be zero
p_des = 0; %
q_des = 0; %

% Thurst/ u1= F using Eq(13)
F = m*g + m * r3dotdot_des;

% error between desired angles and current angles
err_angle = [phi_des,theta_des,psi_des]' - qd{qn}.euler;

% error between desired omega and current omega (in body frame)
err_omega = [p_des,q_des,r_des]' - qd{qn}.omega;


% Moment (u2 = M) using 10 dimension is 3X1 in quadEOM_readonly
M = kp_att.* err_angle + kd_att.* err_omega;

% =================== Your code ends here ===================

% Output trpy and drpy as in hardware
trpy = [F, phi_des, theta_des, psi_des];
drpy = [0, 0,       0,         0];

end