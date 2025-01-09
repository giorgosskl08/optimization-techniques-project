function genetic_algorithm_with_variable_V()
    % Παράμετροι
    pop_size = 50;              % Μέγεθος πληθυσμού
    num_edges = 17;             % Αριθμός ακμών
    V_base = 100;               % Βασικός ρυθμός εισερχομένων οχημάτων
    c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, 47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73]; % Μέγιστες δυνατότητες
    t = ones(1, num_edges);     % Σταθεροί χρόνοι
    a = [1.25*ones(1,5), 1.5*ones(1,5), ones(1,7)]; % Συντελεστές βαρύτητας
    max_generations = 100;      % Μέγιστος αριθμός γενεών
    crossover_rate = 0.8;       % Ποσοστό διασταύρωσης
    mutation_rate = 0.1;        % Ποσοστό μετάλλαξης
    B = zeros(9, num_edges);
    penalty_factor = 1e5;

    % Δημιουργία εύρους για V
    V_values = [0.85, 1.0, 1.15] * V_base;

    % Αποθήκευση αποτελεσμάτων
    results = struct();

    % Επανάληψη για κάθε τιμή του V
    for v_idx = 1:length(V_values)
        rng(42); % Ορισμός σταθερού seed
        V = V_values(v_idx); % Τρέχουσα τιμή του V

        % Αρχικοποίηση πληθυσμού
        population = initialize_population(pop_size, num_edges, V, c);

        for gen = 1:max_generations
            % Υπολογισμός fitness
            fitness = fitness_function(population, t, a, c, B, penalty_factor);

            % Επιλογή γονέων
            parents = selection(population, fitness);

            % Διασταύρωση
            offspring = crossover(parents, crossover_rate);

            % Μετάλλαξη
            offspring = mutation(offspring, mutation_rate, c, V);

            % Ενημέρωση πληθυσμού
            population = offspring;
        end

        % Τελική λύση
        fitness = fitness_function(population, t, a, c, B, penalty_factor);
        [best_fitness, idx] = min(fitness);
        best_solution = population(idx, :);

        % Αποθήκευση αποτελεσμάτων
        results(v_idx).V = V;
        results(v_idx).best_fitness = best_fitness;
        results(v_idx).best_solution = best_solution;
        results(v_idx).total_flow = sum(best_solution);
    end

    % Εμφάνιση αποτελεσμάτων
    for v_idx = 1:length(V_values)
        fprintf("Για V = %.2f:\n", results(v_idx).V);
        fprintf("  Καλύτερη λύση: ");
        disp(results(v_idx).best_solution);
        fprintf("  Καλύτερο fitness: %.2f\n", results(v_idx).best_fitness);
        fprintf("  Συνολικός ρυθμός: %.2f\n\n", results(v_idx).total_flow);
    end

    % Πλοκή Κατανομής Ροών
    figure;
    for v_idx = 1:length(V_values)
        subplot(1, length(V_values), v_idx);
        bar(results(v_idx).best_solution, 'FaceColor', [0.2, 0.6, 0.8]);
        title(sprintf('Κατανομή Ροών (V = %.2f)', results(v_idx).V));
        xlabel('Ακμές');
        ylabel('Ροές (xᵢ)');
        ylim([0, max(c) * 1.1]);
    end
    sgtitle('Κατανομή Ροών για Διάφορες Τιμές του V');

    % Πλοκή Fitness σε σχέση με V
    figure;
    plot(V_values, [results.best_fitness], '-o', 'LineWidth', 2, 'Color', [0.8, 0.2, 0.2]);
    title('Μεταβολή Fitness σε σχέση με V');
    xlabel('V');
    ylabel('Fitness');
    grid on;
end
