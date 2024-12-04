function velocity_delta = rocket_velocity(t)
if (t <= 0) 
    error("invalid parameter"); 
end
M = 750; % [m/s]
m0=150000;
u=2000;
q=2700;
g = 1.622;

velocity = u * log(m0/(m0 - q*t)) - g*t;
velocity_delta = velocity - M;

end