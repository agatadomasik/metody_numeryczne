function impedance_delta = impedance_magnitude(omega)
if (omega <= 0) 
    error("invalid parameter"); 
end
R = 525;
C = 7*10^(-5);
L = 3;
M = 75; % docelowa wartość modułu impedancji
Z = 1/sqrt(1/(R*R) + (omega*C - 1/(omega*L))^2);
impedance_delta = Z - M;
end


