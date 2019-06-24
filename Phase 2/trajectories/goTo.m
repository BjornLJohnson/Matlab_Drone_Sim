function [desired_state] = rise(t, qn)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

goal = [5; 5; 10];
pos = [goal(1)/10*t; goal(2)/10*t; goal(3)/10*t];
vel = [goal(1)/10; goal(2)/10; goal(3)/10];
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;


% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
