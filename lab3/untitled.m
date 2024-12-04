load("filtr_dielektryczny.mat");

N = 20000;

[x,time,iterations,index_number] = solve_direct(A, b, N);
[M,bm,x,err_norm, err_norms, time,iterations,index_number] = solve_Jacobi(A, b, N);
err_norm
iterations
plot(err_norms);
title("err_norms Jacobi");
ylabel("err_norms");
xlabel("iterations");

%{
[M, bm, x,err_norm, err_norms, time,iterations,index_number] = solve_Gauss_Seidel(A, b, N);
err_norm
iterations

plot(err_norms);
title("err_norms Gauss_Seidel");
ylabel("err_norms");
xlabel("iterations");
%}

function [M,bm,x,err_norm, err_norms, time,iterations,index_number] = solve_Jacobi(A, b, N)

index_number = 193577;
L1 = 7;

x = ones(N, 1);
accuracy_rate = 1e-12;
err_norm = 1;
err_norms = ones(1000);
iterations = 0;

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
M = -D^-1*(L + U);
bm = D^-1*b;

tic
while true
    x = M*x + bm;
    iterations = iterations + 1;
    err_norm = norm(A*x - b);
    err_norms(iterations) = err_norm;
    if (err_norm <= accuracy_rate || iterations == 1000)
    break
    end
end
time = toc;
end


function [M,bm,x,err_norm, err_norms, time,iterations,index_number] = solve_Gauss_Seidel(A, b, N)
index_number = 193577;
L1 = 7;

x = ones(N, 1);
accuracy_rate = 1e-12;
err_norm = 1;
err_norms = ones(1000);
iterations = 0;

L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
M = -(D+L)\U;
bm = (D+L)\b;

tic
while true

    x = M*x + bm;
    iterations = iterations + 1;
    err_norm = norm(A*x - b);
    err_norms(iterations) = err_norm;
    if (err_norm <= accuracy_rate || iterations == 1000)
    break
    end
end
time = toc;
end

function [x,time_direct,err_norm,index_number] = solve_direct(A, b, N)
    index_number = 193577;
    L1 = 7;
    tic;
    x = A\b;
    time_direct = toc;
    err_norm = norm(A*x-b);
end

