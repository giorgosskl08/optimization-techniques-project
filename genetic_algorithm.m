function genetic_algorithm()
    rng(42); % Ορισμός σταθερού seed
    % Παράμετροι
    pop_size = 50;              % Μέγεθος πληθυσμού
    num_edges = 17;             % Αριθμός ακμών
    V = 100;                    % Ρυθμός εισερχομένων οχημάτων
    c = [54.13, 21.56, 34.08, 49.19, ...
        33.03, 21.84, 29.96, 24.87, ...
        47.24, 33.97, 26.89, 32.76, ... 
        39.98, 37.12, 53.83, 61.65, 59.73]; % Μέγιστες δυνατότητες
    t = ones(1, num_edges);     % Σταθεροί χρόνοι
    a = [1.25*ones(1,5), 1.5*ones(1,5), ones(1,7)]; % Συντελεστές βαρύτητας
    max_generations = 100;      % Μέγιστος αριθμός γενεών
    crossover_rate = 0.8;       % Ποσοστό διασταύρωσης
    mutation_rate = 0.1;        % Ποσοστό μετάλλαξης

    B = zeros(9, num_edges);    % Πίνακας ροών
    penalty_factor = 1e5;       % Συντελεστής ποινής

    % Αρχικοποίηση πληθυσμού
    population = initialize_population(pop_size, num_edges, V, c);
    fitness_history = zeros(max_generations, 1); % Αποθήκευση ιστορικού fitness

    for gen = 1:max_generations
        % Υπολογισμός fitness
        fitness = fitness_function(population, t, a, c, B, penalty_factor);
        fitness_history(gen) = min(fitness); % Αποθήκευση καλύτερης τιμής fitness

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

    fprintf("Καλύτερη λύση: \n");
    disp(best_solution);
    fprintf("Καλύτερο fitness (Σxᵢ Tᵢ(xᵢ) + ποινή): %f\n", best_fitness);
    fprintf("Συνολικός ρυθμός: %.2f (πρέπει να είναι κοντά στο %d)\n", sum(best_solution), V);
    fprintf("Παραβίαση δυνατοτήτων: %d\n", any(best_solution > c));
    flow_balance = B * best_solution';
    disp("Έλεγχος ισορροπίας ροών ανά κόμβο (πρέπει να είναι ~0):");
    disp(flow_balance);

    % Οπτικοποίηση Αποτελεσμάτων
    visualize_results(best_solution, fitness_history, num_edges);
end

function visualize_results(best_solution, fitness_history, num_edges)
    % Ραβδόγραμμα Κατανομής Ροών
    figure;
    bar(1:num_edges, best_solution, 'FaceColor', [0.2, 0.6, 0.8]);
    xlabel('Ακμές');
    ylabel('Ροές (x_i)');
    title('Κατανομή Ροών στις Ακμές');
    grid on;

    % Γραφική Παράσταση Fitness
    figure;
    plot(1:length(fitness_history), fitness_history, 'LineWidth', 2, 'Color', [0.8, 0.2, 0.2]);
    xlabel('Γενιά');
    ylabel('Fitness');
    title('Μεταβολή Fitness ανά Γενιά');
    grid on;
end
