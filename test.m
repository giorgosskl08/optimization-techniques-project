% Δεδομένα
x = [6.4984, 3.1558, 7.0960, 3.7467, 7.4661, 3.5246, 8.7955, 0.2558, ...
     6.0197, 1.3308, 9.5251, 0.2805, 0.6567, 5.3735, 9.6228, 16.1292, 10.5228];
t = ones(1, 17);
a = [1.25*ones(1,5), 1.5*ones(1,5), ones(1,7)];
c = [54.13, 21.56, 34.08, 49.19, 33.03, 21.84, 29.96, 24.87, ...
     47.24, 33.97, 26.89, 32.76, 39.98, 37.12, 53.83, 61.65, 59.73];
penalty_factor = 1e5;
B = zeros(9, num_edges);  % Προσαρμόστε κατάλληλα για το δικό σας δίκτυο

% Υπολογισμός χρόνου
T = t + (a .* x) ./ (1 - (x ./ c));

% Fitness
flow_imbalance = B * x';
penalty_term = penalty_factor * sum(abs(flow_imbalance));
fitness = sum(x .* T) + penalty_term;

% Έλεγχος
fprintf("Fitness: %f\n", fitness);
disp("Ισορροπία Ροών:");
disp(flow_imbalance);
