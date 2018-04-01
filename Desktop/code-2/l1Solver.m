function X = l1Solver(y, A, lambda)
    N = size(A, 2);
    B = [A, -A];
    f = [lambda, lambda];
    lb = zeros(2 * N, 1);
    
    options = optimoptions('linprog');
    options.Display = 'off';
    
    z = linprog(f, [], [], B, y, lb, [], options);
    X = z(1: N) - z(N + 1: end);
end