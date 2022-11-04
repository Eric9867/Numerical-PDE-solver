function [A] = MAT_DIFF_OPERATOR4(size)
%mat_diff_op Summary of this function goes here
%   Detailed explanation goes here

A = zeros(size);

for i = 1:size
    % FOURTH-ORDER
    i1 = mod(i - 3, size) + 1;
    i2 = mod(i - 2, size) + 1;
    i3 = mod(i - 1, size) + 1;
    i4 = mod(i    , size) + 1;
    i5 = mod(i + 1, size) + 1;

    [A(i, i1),   A(i, i2),    A(i, i3),    A(i, i4),    A(i, i5)] = ...
        deal(1/12,	-2/3,	0,	2/3,	-1/12);
    
end

end

