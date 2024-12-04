%{
% zadanie 1
N = 100;
[A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_direct(N);
%}


% zadanie 2
N = 1000:1000:8000;
n = length(N);
vtime_direct = ones(1,n); 
for i=1:n
    [A,b,x,time_direct,err_norm,index_number] = solve_direct(N(i));
    vtime_direct(i) = time_direct;
end
plot_direct(N, vtime_direct);


%{
% zadanie 3
N = 100;
[A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N);
%}

% zadanie 5
%{
N = 1000:1000:8000;
n = length(N);
time_Jacobi = ones(1,n);
time_Gauss_Seidel = ones(1,n);
iterations_Jacobi = 40*ones(1,n);
iterations_Gauss_Seidel = 40*ones(1,n);

for i=1:n
    [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N(i));
    time_Jacobi(i) = time
    iterations_Jacobi(i) = iterations

    [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N(i));
    time_Gauss_Seidel(i) = time;
    iterations_Gauss_Seidel(i) = iterations;
end


%plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel);
%

function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
subplot(2,1,1);
hold on;
plot(N,time_Jacobi);
plot(N,time_Gauss_Seidel);
hold off;
xlabel("size");
ylabel("time");
title("time using Jacobi's and Gauss-Seidel method");
legend("Jacobi", "Gauss-Seidel", 'Location', 'eastoutside');
subplot(2,1,2);
bar_data = [iterations_Jacobi(:), iterations_Gauss_Seidel(:)];
bar(N,bar_data);
xlabel("size");
ylabel("iterations");
title("iterations using Jacobi's and Gauss-Seidel method");
legend("Jacobi", "Gauss-Seidel", 'Location', 'eastoutside');

end



function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)

index_number = 193577;
L1 = 7;

[A,b] = generate_matrix(N, L1);
x = ones(N, 1);
accuracy_rate = 1e-12;
err_norm = 1;
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

    if (err_norm <= accuracy_rate || iterations == 1000)
    break
    end
end
time = toc;
end


function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)

index_number = 193577;
L1 = 7;

[A,b] = generate_matrix(N, L1);
x = ones(N, 1);
accuracy_rate = 1e-12;
err_norm = 1;
iterations = 0;


L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
M = (D+L)\-U;
bm = (D+L)\b;


tic
while true

    x = M*x + bm;
    iterations = iterations + 1;
    err_norm = norm(A*x - b);

    if (err_norm <= accuracy_rate || iterations == 1000)
    break
    end
end
time = toc;
end


function plot_direct(N,vtime_direct)

    plot(vtime_direct);
    xlabel("matrix size");
    ylabel("calculation time");
    title('direct solving');

end

function [A,b,x,time_direct,err_norm,index_number] = solve_direct(N)
    index_number = 193577;
    L1 = 7;
    [A,b] = generate_matrix(N, L1);
    tic;
    x = A\b;
    time_direct = toc;
    err_norm = norm(A*x-b);
end

function [A,b] = generate_matrix(N, convergence_factor)
    % A - macierz o rozmiarze NxN
    % b - wektor o rozmiarze Nx1
    % convergense_factor - regulacja elementów diagonalnych macierzy A, które wpływają
    %       na zbieżność algorytmów iteracyjnego rozwiązywania równania macierzowego

    if(convergence_factor<0 || convergence_factor>9)
        error('Wartość convergence_factor powinna być zawarta w przedziale [1,9]');
    end

    seed = 0; % seed - kontrola losowości elementów niezerowych macierzy A
    rng(seed); % ustawienie generatora liczb losowych

    A = rand(N, N);
    A = A - diag(diag(A)); % wyzerowanie głównej diagonalnej

    convergence_factor_2 = 1.2 + convergence_factor/10;
    diag_values = sum(abs(A),2) * convergence_factor_2;
    A = A + diag(diag_values); % nadanie nowych wartości na głównej diagonalnej

    % regulacja normy macierzy
    norm_Frobenius = norm(A,'fro');
    A = A/norm_Frobenius;

    b = rand(N,1);
end

