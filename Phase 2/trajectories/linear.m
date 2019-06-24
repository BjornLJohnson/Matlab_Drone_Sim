function [desired_state] = linear(t, qn)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

pos = [0; t^2/5; t/10];
vel = [0; .4*t; .1];
acc = [0; .4; 0];
yaw = 0;
yawdot = 0;


% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
