function x_normalized = normalize(x, V)
    sum_x = sum(x);
    if sum_x < 1e-9
        x_normalized = zeros(size(x));
    else
        x_normalized = x * (V / sum_x);
    end
end