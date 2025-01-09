function parents = selection(population, fitness)
    % Εφαρμογή roulette wheel selection
    prob = 1 ./ fitness;           % Αντίστροφο fitness (μικρότερο = καλύτερο)
    prob = prob / sum(prob);       % Κανονικοποίηση πιθανοτήτων
    cum_prob = cumsum(prob);       % Σωρευτικές πιθανότητες
    
    [pop_size, ~] = size(population);
    parents = zeros(size(population));
    for i = 1:pop_size
        r = rand();
        selected_idx = find(cum_prob >= r, 1);
        parents(i, :) = population(selected_idx, :);
    end
end
