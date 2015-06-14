T_inits = logspace(-2,2, 10);
alphas = linspace(0.05, 0.95, 5);
data = zeros(length(alphas), 4);

% For plotting alpha vs. iterations
for j = 1:length(T_inits)
    T_init = T_inits(j);
    for i = 1:length(alphas)
        alpha = alphas(i);
        [m_iterations, m_obj] = SA(T_init, alpha, 1);
        k = i + (j-1)*length(alphas);
        data(k, :) = [T_init, alpha, m_iterations, m_obj];
    end
end

% For plotting temperature vs. iterations
% for i = 1:length(alphas)
%     alpha = alphas(i);
%     for j = 1:length(T_inits)
%         T_init = T_inits(j);
%         [m_iterations, m_obj] = SA(T_init, alpha, 5);
%         k = j + (i-1)*length(T_inits);
%         data(k, :) = [T_init, alpha, m_iterations, m_obj];
%     end
% end

data