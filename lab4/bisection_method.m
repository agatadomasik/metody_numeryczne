function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
xtab = []
xdif = []
for iterations = 1:max_iterations
        xsolution = (a+b)/2;
        ysolution = fun(xsolution);
        xtab = [xtab; xsolution];
        if(iterations>1)
            xdif = [xdif; abs(xtab(iterations) - xtab(iterations - 1))];
        end
        if (abs(ysolution) < ytolerance)
            break
        elseif (fun(a) * ysolution < 0)
            b = xsolution;
        else
            a = xsolution;
        end
    end
end
