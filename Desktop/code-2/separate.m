function [A, E] = separate(S, lambda)
    mag = abs(S);
    P = S./mag;
    [A, E, ~] = inexact_alm_rpca(mag, lambda);
    A = A.* P;
    E = E.* P;
end