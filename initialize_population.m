function population = initialize_population(pop_size, num_edges, V, c)
    % pop_size: Μέγεθος πληθυσμού
    % num_edges: Αριθμός ακμών στο δίκτυο
    % V: Ρυθμός εισερχομένων οχημάτων
    % c: Πίνακας μέγιστων δυνατοτήτων ακμών

    population = zeros(pop_size, num_edges);
    for i = 1:pop_size
        % Τυχαίο άθροισμα ροής = V με όριο c(i)
        x = rand(1, num_edges) .* c;
        if sum(x) > V
            x = x * (V / sum(x));
        end
        % Τελικό normalize ώστε sum(x)=V
        population(i, :) = normalize(x, V);
    end
end