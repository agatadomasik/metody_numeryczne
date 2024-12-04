format long
a=1;
b=50;
ytolerance=1e-12;
max_iterations=100;

[omega_bisection,ysolution_bisection,iterations_bisection,xtab_bisection,xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude);
[omega_secant,ysolution_secant,iterations_secant,xtab_secant,xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude);
omega_bisection
omega_secant

subplot(2,1,1);
hold on;
plot(xtab_bisection);
plot(xtab_secant);
title('x vector for bisection and secant method');
xlabel("iterations");
ylabel("omega");
legend("bisection", "secant", 'Location', 'eastoutside');

hold off;

subplot(2,1,2)
semilogy(xdif_bisection);
hold on;
semilogy(xdif_secant);
hold off;
title("x difference for bisection and secant method");
xlabel('iterations');
ylabel('difference');
legend("bisection", "secant", 'Location', 'eastoutside');
