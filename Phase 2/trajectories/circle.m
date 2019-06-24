function [desired_state] = circle(t, qn, r, z_max, T, rot)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
if nargin < 6, rot = 1; end
if nargin < 5, T=10; end
if nargin < 4, z_max = 5; end
if nargin < 3, r = 5; end

if t >= T
    % position is constant, velocity and acceleration are zero
    x = cos(2*pi*rot)*r;
    y = sin(2*pi*rot)*r;
    pos = [x; y; z_max];
    vel = zeros(3,1);
    acc = zeros(3,1);
else

    b1 = [0 ; 0 ; 0 ; z_max ; 0 ; 0 ];
    b2 = [0 ; 0 ; 0 ; 2*pi*rot ; 0 ; 0 ];
    b = [b1 b2];
    c = timeScale(b,T);
    
    % calculates position and derivatives output from time scaling
    s = c(1,:) + c(2,:)*t + c(3,:)*t^2 +c(4,:)*t^3 + c(5,:)*t^4 + c(6,:)*t^5;
    sd = c(2,:) + 2*c(3,:)*t + 3*c(4,:)*t^2 + 4*c(5,:)*t^3 + 5*c(6,:)*t^4;
    sdd = 2*c(3,:) + 6*c(4,:)*t + 12*c(5,:)*t^2 + 20*c(6,:)*t^3;
    
    ang = s(2);
    dang = sd (2);
    ddang = sdd(2);
    
    x = r*cos(ang);
    dx = -r*sin(ang)*dang;
    ddx = -r*cos(ang)*dang-r*sin(ang)*ddang;
    
    y = r*sin(ang);
    dy = r*cos(ang)*dang;
    ddy = -r*sin(ang)*dang+r*cos(ang)*ddang;
    
    z = s(1);
    dz = sd(1);
    ddz = sd(1);
    
    pos = [x; y; z];
    vel = [dx; dy; dz];
    acc = [ddx; ddy; ddz];
    
end

yaw = 0;
yawdot = 0;

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
