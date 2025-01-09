function mutated = mutation(offspring, mutation_rate, c, V)
    [pop_size, num_edges] = size(offspring);
    mutated = offspring;

    for i = 1:pop_size
        for j = 1:num_edges
            if rand() < mutation_rate
                mutated(i, j) = rand() * c(j); % Τυχαία τιμή εντός [0, c_j]
            end
        end
        % Κανονικοποίηση για να διατηρείται ο περιορισμός sum(x) = V
        mutated(i, :) = normalize(mutated(i, :), V);
    end
end
