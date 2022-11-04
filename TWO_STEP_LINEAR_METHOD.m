function [u] = TWO_STEP_LINEAR_METHOD(M, N, ic, h, A, f, theta, xi, phi)
if ic==0
    ic = zeros(M, 1);
else
    ic = ic';
end
u = zeros(M, N);
t = 0;
dx = 1 / M;
if(~isa(f, 'function_handle'))
    f = @(x) 0;
end
g = @(t,u) (A*u + f(t));

k1 = g(t, ic);
k2 = g(t + h/2, ic + k1 * h / 2);
k3 = g(t + h/2, ic + k2 * h / 2);
k4 = g(t + h, ic + k3 * h);
u(:, 1) = ic + h/6 * (k1 + 2*k2 + 2*k3 + k4);
clear k1 k2 k3 k4
%use RK4 for nonzero phi

for i = 1:N-1
    t = t + h;
    if(i==1)
        u(:, i+1) = ( (1+xi) * eye(M) - h * theta * A ) \ ...
            ( (1+2*xi)*u(:,i) - xi*ic + h*((1-theta+phi)*g(t, u(:,i)) - phi*(g(t-h, ic))) + h*theta * f(t));

        continue
    end
    
    u(:, i+1) = ( (1+xi) * eye(M) - h * theta * A ) \ ...
        ( (1+2*xi)*u(:,i) - xi*u(:,i-1) + h*((1-theta+phi)*g(t, u(:,i)) - phi*(g(t-h, u(:,i-1)))) + h*theta * f(t));
    
end

end













% %%%%%%%%%%%%%%%%
% function [u] = TWO_STEP_LINEAR_METHOD(M, N, ic, h, A, f, theta, xi, phi)
% ic = ic';
% u = zeros(M, N);
% u(:, 1) = ic + h * f(ic);
% u(:, 1) = ic + h / 2 * (f(ic) + f(u(:, 1)));
% %use RK4 for nonzero phi
% 
% for i = 1:N-1
%     if(i==1)
%         u(:, i+1) = u(:, i) + h * f(u(:, i));
%         u(:, i+1) = 1/(1 + xi) * ( ...
%             (1 + 2*xi) * u(:, i) - xi * ic + ...
%             h * (theta * f(u(:, i+1)) + (1 - theta + phi) * f(u(:, i)) - phi * f(ic)) ...
%         );
%         continue
%     end
%     
%     u(:, i+1) = u(:, i) + h * f(u(:, i));
%     u(:, i+1) = 1/(1 + xi) * ( ...
%         (1 + 2*xi) * u(:, i) - xi * u(:, i-1) + ...
%         h * (theta * f(u(:, i+1)) + (1 - theta + phi) * f(u(:, i)) - phi * f(u(:, i-1))) ...
%     );
% end
% 
% end
% 
