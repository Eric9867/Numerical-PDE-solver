% PARAMETERS
a = 1;
Cn = 2;
M = 50;
dx = 1 / M;
dt = Cn * dx ./ a;
N = round(1/dt);
x = dx:dx:1;

A = -a ./ dx * MAT_DIFF_OPERATOR2(M);
f = @(t, u) (A * u);

% INITIAL CONDITION
ic = @(x) exp(-0.5 * ((x-0.5) ./ 0.08) .^ 2);


% TIME MARCHING
% T1 = 'RK4';
% u1 = RUNGEKUTTA4(M, N, f, ic(x), dt);
% T2 = 'MILNE';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 1/6, -1/2, -1/6);


% T1 = 'EXPLICIT EULER';
% u1 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 0, 0, 0);
% T2 = 'MOST ACCURATE EXPLICIT1';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 0, 5/6, -1/3);
% T2 = 'LEAP FROG';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 0, -1/2, 0);
% T2 = 'AM3';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 5/12, 0, 1/12);
% T2 = 'A-CONTRACTIVE';
% u2 = TWO_STEP_LINEAR_METHOD(M, N, ic(x), dt, A, 0, 5/9, -1/6, -2/9);

% T = dt:dt:1;
% u1 =zeros(M,N);
% 
% for i=1:N
%     u1(:, i) = exp(-0.5 * (((mod(x - a.*T(i), 1))-0.5) ./ 0.08) .^ 2);
% end


% PLOT ANIMATION
clf
plot(x, ic(x));
hold on
ylim([-0.5 1.5])
p = plot(x, u1(:, 1));
% q = plot(x, u2(:, 1));
% r = plot(x, u3(:, 1));
hold off
% legend('Initial Condition', T1, T2);
% legend('Initial Condition', T1, T2, T3);
pause(2)

for i = 1:N
    % Updating the line
    p.YData = u1(:, i);
%     q.YData = u2(:, i);
%     r.YData = u3(:, i);
%     exportgraphics(gcf, ['ExactSol/exactSol' num2str(i) '.png']); %,'Append',true);
    exportgraphics(gcf, ['Inflow/exactSol' num2str(i) '.png']);
    % Delay
    pause(0.005)
end