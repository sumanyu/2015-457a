T_init = 1.0;
alphas = linspace(0.05, 0.95, 10);
data = zeros(length(alphas), 3);

for i = 1:length(alphas)
    alpha = alphas(i);
    [m_iterations, m_obj] = SA(T_init, alpha, 10);
    data(i, :) = [T_init, m_iterations, m_obj];
end

data