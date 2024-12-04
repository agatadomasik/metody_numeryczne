load('energy.mat');

[country, source, degrees, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy);


function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
% Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
%   - nmax = length(y_yearly)-1
%   - y_approximation{1,i} stanowi aproksymację stopnia i
%   - y_approximation{1,i} stanowi wartości funkcji aproksymującej w punktach x_fine
% mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
%   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
% msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
%   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
%   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine

country = 'Poland';
source = 'Coal';
degrees = 1:4;
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = [];
mse = [];
msek = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    N = length(y_yearly);
    P = (N-1)*10+1;
    x_coarse = linspace(-1, 1, N)';
    x_fine = linspace(-1, 1, P)';

    mse = zeros(N-1, 1);
    msek = zeros(N-2, 1);

    % Pętla po wielomianach różnych stopni
    for i = 1:N-1
        p = my_polyfit(x_coarse, y_yearly, i);
        
        y_coarse_approx = polyval(p, x_coarse);
        y_fine_approx = polyval(p, x_fine);
        
        y_approximation{i} = y_fine_approx;
        mse(i) = mean((y_yearly - y_coarse_approx).^2);
        
        if i < N-1
            p_next = my_polyfit(x_coarse, y_yearly, i+1);
            y_fine_approx_next = polyval(p_next, x_fine);
            msek(i) = mean((y_fine_approx - y_fine_approx_next).^2);
        end
    end
    

    figure;
    subplot(3, 1, 1);
    plot(x_coarse, y_yearly, 'k', 'DisplayName', 'dane wejściowe');
    hold on;
    colors = ['r', 'g', 'b', 'm'];
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{degrees(i)}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
    end
    hold off;
    xlabel('x');
    ylabel('y');
    title('Aproksymacja produkcji energii');
    legend('Location', 'northeastoutside');
    grid on;
    
    subplot(3, 1, 2);
    semilogy(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('MSE');
    title('Błąd średniokwadratowy dla różnych stopni aproksymacji');
    grid on;
    
    subplot(3, 1, 3);
    semilogy(msek);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('MSE');
    title('Błąd średniokwadratowy dla różnych stopni aproksymacji');
    grid on;
        print -dpng zadanie4.png


else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end

function p = my_polyfit(x, y, deg)
    X = zeros(length(x), deg+1);
    for i = 1:length(x)
        for j=1:(deg+1)
            X(i,j) = x(i)^(deg+1-j);
        end
    end
    p = (X' * X) \ (X' * y);
end