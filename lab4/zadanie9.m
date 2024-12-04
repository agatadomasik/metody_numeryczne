% Ustaw opcje
options = optimset('Display', 'iter');
[x1, fval1, exitflag1, output1] = fzero(@tan, 6, options);
[x2, fval2, exitflag2, output2] = fzero(@tan, 4.5, options);

% Wyświetl wyniki
disp('Starting point:');
disp(['Zero point: ', num2str(x1)]);
disp(['Value: ', num2str(fval1)]);
disp(['Exit flag: ', num2str(exitflag1)]);
disp(['Informations:']);
disp(output1);

disp('Starting point: 4.5');
disp(['Zero point: ', num2str(x2)]);
disp(['Value: ', num2str(fval2)]);
disp(['Exit flag: ', num2str(exitflag2)]);
disp(['Informtions:']);
disp(output2);
