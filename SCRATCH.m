a = 1;
inflow = @(t) sin(10*pi * t);
Q = [100 200 400];
Cn = 1;
g = @(dudx) - a .* dudx;

% INITIAL CONDITION
ic = @(x) 0; % @(x) exp(-0.5 * ((x-0.5) ./ 0.08) .^ 2);

M = Q(2);
dx = 1 / M;
dt = Cn * dx ./ a;
N = 2 * round(1/dt);
x = dx:dx:1;


% SETTING UP INFLOW BOUNDARY CONDITION
% (FROM PERIODIC MATRIX)

A = MAT_DIFF_OPERATOR2(M);
A(M, 1) = 0; 
A(1, M) = 0;
A(M,[M-1 M]) = [-1 1];

q = zeros(M, 1); q(1) = -1/2;
inflow_diff_component = @(t) inflow(t) * q * -a ./ dx ;


% A = MAT_DIFF_OPERATOR4(M);
% A(M-1:M, 1:2) = 0; 
% A(1:2, M-1:M) = 0;
% A(1, 1:4) = [-5/6 3/2 -1/2 1/12];
% A(M-1, [M-3:M]) = [1/6 -1 1/2 1/3];
% A(M, [M-3:M]) = [-1/3 3/2 -3 11/6];
% q = zeros(M, 1); q(1:2) = [-1/4 1/12];
% inflow_diff_component = @(t) inflow(t) * q * -a./dx;

A = -a./dx * A;

f = @(t, u) ( A*u + inflow_diff_component(t));

% TIME MARCHING
T1 = 'RK4';
u1 = RUNGEKUTTA4(M, N, f, ic(x), dt);
% P1 = plot(x, u1(:, N), x, ic(x), ':');
% title(T1)

T2 = 'IMPLICIT EULER';
u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, inflow_diff_component, 1, 0, 0);
% P2 = plot(x, u2(:, N), x, ic(x), ':');
% title(T2)

% T2 = 'Trapezoidal';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, inflow_diff_component, 0, -1/2, 0);


ylim([-0.5 1.5])
er(1) = sqrt(sum((ic(x)' - u1(:, N)).^2) ./ M);

% title(T1);
hold off
p = plot(x, u1(:, 1));
hold on
q = plot(x, u2(:, 1));
% r = plot(x, u3(:, 1));
legend(T1,T2);
ylim([-1.5 1.5])

pause(2)

for i = 1:N
    % Updating the line
    p.YData = u1(:, i);
    q.YData = u2(:, i);
%     r.YData = u3(:, i);
    ylim([-1.5 1.5])
%     % Delay
    if ~mod(i,8)
        exportgraphics(gcf, ['Inflow/exactSol' int2str(floor(i/8)) '.png']);
    end
    pause(0.001)
end
