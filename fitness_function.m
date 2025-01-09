function fitness = fitness_function(population, t, a, c, B, penalty_factor)
    % population: Πίνακας πληθυσμού (κάθε γραμμή είναι λύση)
    % t: Πίνακας σταθερών χρόνων
    % a: Πίνακας συντελεστών
    % c: Πίνακας μέγιστων δυνατοτήτων
    
    [pop_size, num_edges] = size(population);
    fitness = zeros(pop_size, 1);

    for i = 1:pop_size
        x = population(i, :);

        % Υπολογισμός χρόνου Tᵢ(xᵢ) = tᵢ + (aᵢ * xᵢ) / [1 - (xᵢ / cᵢ)]
        T = t + (a .* x) ./ (1 - (x ./ c));

        % Στόχος: Σ(xᵢ * Tᵢ)
        cost_value = sum( x .* T );

        % Υπολογισμός αν δεν ικανούνται οι ροές κόμβων
        flow_imbalance = B * x';  % μέγεθος = N κόμβοι
        % Ποινή: πχ sum(abs(flow_imbalance))
        penalty_term = penalty_factor * sum(abs(flow_imbalance));

        % Τελικό fitness = κόστος + ποινή
        fitness(i) = cost_value + penalty_term;
    end
end