% RK4
function u = RUNGEKUTTA4(M, N, f, ic, h)
if ic==0
    ic = zeros(M, 1);
else
    ic = ic';
end

t = 0;
u = zeros(M, N);

k1 = f(t, ic);
k2 = f(t + h/2, ic + k1 * h / 2);
k3 = f(t + h/2, ic + k2 * h / 2);
k4 = f(t + h, ic + k3 * h);

u(:, 1) = ic + (k1 + 2*k2 + 2*k3 + k4) .* h ./ 6;

for i = 1:N-1
    t = t + h;
    k1 = f(t, u(:, i));
    k2 = f(t + h/2, u(:, i) + k1 * h / 2);
    k3 = f(t + h/2, u(:, i) + k2 * h / 2);
    k4 = f(t + h, u(:, i) + k3 * h);
    
    u(:, i+1) = u(:, i) + (k1 + 2*k2 + 2*k3 + k4) .* h ./ 6;
end

end