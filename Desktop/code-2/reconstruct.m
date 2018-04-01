function [Z1, Z2] = reconstruct(M, D1, D2)
    D = [D1, D2];
    Z = ALM(D, M);
    N1 = size(D1, 2);
    Z1 = Z(1: N1);
    Z2 = Z(N1 + 1: end);
end