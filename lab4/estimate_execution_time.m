function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych
if (N <= 0) 
    error("invalid parameter"); 
end
M = 5000; % [s]
time = (N^(16/11) + N^(pi*pi/8))/1000;
time_delta = time - M;

end