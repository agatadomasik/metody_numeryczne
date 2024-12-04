function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    % nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
    % V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
    % V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
    % interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
    %       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N);
    V2 = vandermonde_matrix2(N, nodes_Chebyshev);
    original_Runge = 1./(1+25*x_fine.^2);

    x_interp =  linspace(-1,1,N);
    c_runge = V \ (1 ./ (1 + 25 * x_interp.^2))'; % współczynniki wielomianu interpolującego
    interpolated_Runge = polyval(flipud(c_runge), x_fine); % interpolacja

    c_runge_Chebyshev = V2 \ (1 ./ (1 + 25 * nodes_Chebyshev.^2))'; % współczynniki wielomianu interpolującego
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine); % interpolacja

subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Runge');
    xlabel("x");
    ylabel("Runge(x)")
    title("Runge interpolation")
    hold on;
    plot(x_interp, 1./(1+25*x_interp.^2), 'o', 'DisplayName', 'Interpolation nodes');
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolated');
    legend('Location','northwest');
    hold off;

    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Runge');
    xlabel("x");
    ylabel("Runge(x)")
    title("Runge interpolation - Chebyshev nodes")
    hold on;
    plot(x_interp, 1./(1+25*x_interp.^2), 'o', 'DisplayName', 'Interpolation nodes');
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolated (Chebyshev)');
    legend('Location','northwest');
    hold off;
end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    nodes = zeros(1, N);
    for k=0:(N-1)
        nodes(k+1) = cos(k*pi/(N-1));
    end
end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_interp = linspace(-1,1,N);
    V = ones(N, N);
    for i=1:N
        x = x_interp(i);
        for j=2:N
            V(i, j) = x^(j-1);
        end
    end
end

function V = vandermonde_matrix2(N, nodes)
    % Generuje macierz Vandermonde dla N węzłów interpolacji
    V = ones(N, N);
    for i=1:N
        x = nodes(i);
        for j=2:N
            V(i, j) = x^(j-1);
        end
    end
end
