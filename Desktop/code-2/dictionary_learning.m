function [D1, D2] = dictionary_learning(sig1, sig2, k1, k2, step, iter)
    if ~exist('step', 'var')
        step = 0.001;
    end
    if ~exist('iter', 'var')
        iter = 10;
    end
    M = size(sig1, 1);
    N = size(sig1, 2);
    D1 = rand(N, k1);
    D2 = rand(N, k2);
    err = [];
    
    disp('learning process start')
    for i = 1: iter
        perm = randperm(M);
        for j = 1: M
            idx = perm(j);
            s1 = sig1(idx, :)';
            s2 = sig2(idx, :)';
            mixed = s1 + s2;

            [Z1, Z2] = reconstruct(mixed, D1, D2);
            for k = 1: 50
                D1  = D1 - step * ((s1 - D1 * Z1) * Z1');
                D2  = D2 - step * ((s2 - D2 * Z2) * Z2');
                err = [err, norm(s1 - D1 * Z1) + norm(s2 - D2 * Z2)];
            end
        end
    end
    figure()
    plot(err);
end