load energy;
[country, source, degrees, y_original, y_approximation, mse] = zadanie2(energy);

function [country, source, degrees, y_original, y_movmean, y_approximation, mse] = zadanie2(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji wygładzonych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wygładzenie danych wykonane jest poprzez wywołanie funkcji movmean.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_movmean - średnia 12-miesięczna danych wejściowych, y_movmean = movmean(y_original,[11,0]);
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej wygładzone dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

country = 'Poland';
source = 'Coal';
degrees = [1, 5, 12, 27];
y_original = [];
y_approximation= [];
mse = [];


% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;
    y_movmean = movmean(y_original,[11,0]);

    x = linspace(-1,1,length(y_original))';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        degree = degrees(i);
        p = polyfit(x, y_movmean, degree);
        z = polyval(p, x);
        y_approximation{i} = z;
        mse(i) = 0;
        for j = 1:length(y_movmean)
            mse(i) = mse(i) + (y_movmean(j) - z(j))^2;
        end
        mse(i) = mse(i) * 1/length(y_movmean);
    end

    figure;
    subplot(2, 1, 1);
    hold on;
    plot(y_original, 'DisplayName', 'dane wejściowe', 'LineWidth', 0.7);
    plot(y_movmean, 'DisplayName', 'dane wygładzone', 'LineWidth', 0.7);
    colors = ['r', 'g', 'b', 'm'];
    
    for i = 1:length(degrees)
        plot(y_approximation{i}, 'DisplayName', ['stopien ' num2str(degrees(i))], 'Color', colors(i), 'LineWidth', 0.7);
    end
    
    xlabel('Indeks');
    ylabel('Produkcja energii');
    title(['Aproksymacja produkcji energii: ' country ' - ' source]);
    legend('show', 'Location', 'eastoutside');

    hold off;
    
    subplot(2, 1, 2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('MSE');
    title('Błąd średniokwadratowy dla różnych stopni aproksymacji');
        print -dpng zadanie2.png

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end