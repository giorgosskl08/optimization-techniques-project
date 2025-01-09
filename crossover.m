function offspring = crossover(parents, crossover_rate)
    [pop_size, num_edges] = size(parents);
    offspring = zeros(size(parents));
    
    for i = 1:2:pop_size
        if rand() < crossover_rate
            % Δύο γονείς
            p1 = parents(i, :);
            p2 = parents(i+1, :);
            % Σημείο διασταύρωσης
            point = randi([1, num_edges-1]);
            offspring(i, :) = [p1(1:point), p2(point+1:end)];
            offspring(i+1, :) = [p2(1:point), p1(point+1:end)];
        else
            % Χωρίς διασταύρωση
            offspring(i, :) = parents(i, :);
            offspring(i+1, :) = parents(i+1, :);
        end
    end
end
