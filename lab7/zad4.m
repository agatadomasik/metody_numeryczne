[integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4();

function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    %   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %       integration_result, błąd jest definiowany jako:
    %       integration_error(1,i) = abs(integration_result - reference_value),
    %       gdzie reference_value to wartość referencyjna całki.
    %
    %   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %       wektor błędów całkowania integration_error.
    %
    %   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    %   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %       do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    %   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów

    reference_value = 0.0473612919396179; % wartość referencyjna całki
    ft_5 = f(5);
    yrmax = ft_5 + 0.001;

    Nt = 5:50:10^4;
    integration_error = [];

    for i = 1:length(Nt)
        [integration_result, xr{i}, yr{i}] = integration(@f, Nt(i), yrmax);
        integration_error(i) = abs(integration_result - reference_value);
    end

    loglog(Nt, integration_error);
    xlabel('intervals');
    ylabel('Integration Error');
    title('Integration Error for the Monte Carlo method');
    grid on;
    print -dpng zadanie3.png

end

function [integral, xr, yr] = integration(fun, N, yrmax)
    xr = zeros(1, N);
    yr = zeros(1, N);
    N1 = 0;
    for i=1:N
        xr(1,i) = rand() * 5;
        yr(1,i) = rand() * yrmax;
        if yr(1,i) <= f(xr(1,i))
            N1 = N1 + 1;
        end
    end
    integral = N1 / N * yrmax * 5;
end





function [ft] = f(t)
    sigma = 3;
    my = 10;
    ft = 1 / (sigma*sqrt(2*pi)) * exp(-(t-my)^2/(2*sigma^2));
end