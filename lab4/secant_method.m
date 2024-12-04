function [xsolution, ysolution, iterations, xtab, xdif] = secant_method(a, b, max_iterations, ytolerance, fun)
    xtab = [];
    xdif = [];
    xtab = [xtab; a];
    xtab = [xtab; b];
    
    for iterations = 3:max_iterations
        xk = xtab(iterations - 1);
        xkp = xtab(iterations - 2);
        
        fk = fun(xk);
        fkp = fun(xkp);
        
        xsolution = xk - fk * (xk - xkp) / (fk - fkp);
        ysolution = fun(xsolution);
        
        xtab = [xtab; xsolution];
        
        if (iterations > 3)
            xdif = [xdif; abs(xtab(iterations) - xtab(iterations - 1))];
        end
        if abs(ysolution) < ytolerance
            break;
        end
    end
    iterations = iterations - 2;
    xtab = xtab(3:end);
end
