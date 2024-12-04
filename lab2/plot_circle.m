
plot_circles();


function plot_circle1(R, X, Y)
    % R - promień okręgu
    % X - współrzędna x środka okręgu
    % Y - współrzędna y środka okręgu
    theta = linspace(0,2*pi);
    x = R*cos(theta) + X;
    y = R*sin(theta) + Y;
    plot(x,y)
end

function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 193577;
    L1 = 7;
    circles = zeros(3, n_max);
    circle_areas = zeros(n_max, 1);
    circle_area = zeros(n_max, 1);

    rand_counts = zeros(n_max, 1);
    count_mean = zeros(n_max, 1);
    for i = 1:n_max
        count = 0;
        collision = true;
        while collision
            count = count + 1;

            R = rand() * r_max;
            X = rand() * (a - 2 * R) + R;
            Y = rand() * (a - 2 * R) + R;
            collision = false;
            for j = 1:i-1
                distance = sqrt((X - circles(2, j))^2 + (Y - circles(3, j))^2);
                if distance < R + circles(1, j)
                    collision = true;
                    break;
                end
            end
            if ~collision
                circles(:, i) = [R; X; Y];
            end
        end
        rand_counts(i) = count;
        counts_mean(i,1) = sum(rand_counts)/i;

        circle_area(i,1) = pi * circles(1, i)^2;
        circle_areas = cumsum(circle_area);
    end
    
end




function plot_circles()
    clear all
    close all
    format compact
    
    n_max = 200;
    a = 10;
    r_max = a/2;
    
    [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
    axis equal;
    axis([0 a 0 a]);
    hold on;
    for i = 1:n_max
        plot_circle1(circles(1,i), circles(2,i), circles(3,i));
    end
    hold off;

    plot_circle_areas(circle_areas);
    plot_counts_mean(counts_mean);

end

function plot_counts_mean(counts_mean)
    figure;
    hold on;
    plot(counts_mean);
    title("means of circles areas");
    xlabel("circles");
    ylabel("means");
    hold off;
end

function plot_circle_areas(circle_areas)
    figure;
    hold on;
    plot(circle_areas);
    title("circle areas");
    xlabel("circles");
    ylabel("areas");
    hold off;
end