[integration_error, Nt, ft_5, integral_1000] = zadanie3();

function [integration_error, Nt, ft_5, integral_1000] = zadanie3()
    % Numeryczne całkowanie metodą prostokątów.
    % Nt - wektor zawierający liczby podprzedziałów całkowania
    % integration_error - integration_error(1,i) zawiera błąd całkowania wyznaczony
    %   dla liczby podprzedziałów równej Nt(i). Zakładając, że obliczona wartość całki
    %   dla Nt(i) liczby podprzedziałów całkowania wyniosła integration_result,
    %   to integration_error(1,i) = abs(integration_result - reference_value),
    %   gdzie reference_value jest wartością referencyjną całki.
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    % integral_1000 - całka od 0 do 5 funkcji gęstości prawdopodobieństwa
    %   dla 1000 podprzedziałów całkowania

    reference_value = 0.0473612919396179; % wartość referencyjna całki
    
    Nt = 5:50:10^4;
    integration_error = [];

    ft_5 = f(5);
    integral_1000 = integration(@f, 1000);

    for i=1:length(Nt)
        N = Nt(i);
        integration_result = integration(@f, N);
        integration_error(i)=abs(integration_result-reference_value);
    end
    loglog(Nt, integration_error);
    xlabel('intervals');
    ylabel('Integration Error');
    title('Integration Error for the Simpsons rule');
    grid on;
    print -dpng zadanie3.png
end

function[integral] = integration(f, N)
    a = 0;
    b = 5;
    integral = 0;
    delta_x = (b-a)/N;
    x1 = a+0*delta_x;

    x1 = a + 0 * delta_x ;
    for i = 2:N+1
        x2 = a + (i-1) * delta_x;
        integral = integral + ( f(x1) + 4*f((x2+x1)/2) + f(x2) );
        x1 = x2;
    end

    integral = integral * delta_x/6
end




function [ft] = f(t)
    sigma = 3;
    my = 10;
    ft = 1 / (sigma*sqrt(2*pi)) * exp(-(t-my)^2/(2*sigma^2));
end