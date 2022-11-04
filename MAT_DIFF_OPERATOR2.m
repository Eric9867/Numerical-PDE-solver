function [A] = MAT_DIFF_OPERATOR2(size)
%mat_diff_op Summary of this function goes here
%   Detailed explanation goes here

A = zeros(size);

for i = 1:size
    % SECOND-ORDER
    a = mod(i - 2, size) + 1;
    b = mod(i, size) + 1;
        
    A(i,a) = -1/2;
    A(i,b) =  1/2;
  
end

% % Order of magnitude slower
% m=5000;
% A = diag(ones(1, m-1), 1) + diag(-ones(1,m-1), -1);
% A(1,m) = -1;
% A(m,1) = 1;

end

