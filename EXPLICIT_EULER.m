% Explicit Euler's
function u = EXPLICIT_EULER(M, N, f, ic, h)

u = zeros(M, N);
u(:, 1) = ic;
for i = 1:N-1
    u(:, i+1) = u(:, i) + f(u(:, i)) * h ;
end

end