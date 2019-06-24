function c = timeScale(b,T)
% implementation of quintic time scaling

% x(t) = c1 + c2*t + c3*t^2 +c4*t^3 + c5*t^4 + c6*t^5
% x(0) = xi  x'(0) = 0  x''(0) = 0
% x(T) = xf  x'(T) = 0  x''(T) = 0
% need to solve system Ax = b where x is the coefficient vector, and b
% is the desired outputs at time 0 and T
    
    
    % row 1 of A corresponds to the position at time 0 
    A1 = [1 0 0 0 0 0];
    % row 2 of A corresponds to the velocity at time 0 
    A2 = [0 1 0 0 0 0];
    % row 3 of A corresponds to the acceleration at time 0 
    A3 = [0 0 2 0 0 0];
    % row 4 of A corresponds to the position at time T
    A4 = [1 T T^2 T^3 T^4 T^5];
    % row 5 of A corresponds to the velocity at time T
    A5 = [0 1 2*T 3*T^2 4*T^3 5*T^4];
    % row 6 of A corresponds to the acceleration at time T
    A6 = [0 0 2 6*T 12*T^2 20*T^3];
    
    A = [A1 ; A2 ; A3 ; A4 ; A5 ; A6];
    
    %solves system Ac = b for c, aka coefficients
    c = A\b;
end
