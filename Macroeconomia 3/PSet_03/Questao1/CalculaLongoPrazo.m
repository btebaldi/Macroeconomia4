function out = CalculaLongoPrazo(PI)

N = size(PI,1);
prob_0 = (1/N)*ones(N,1);
error = 1;
while error > 1e-8
    % Calcula a probabilidade do proximo estado
    prob_1 = PI'*prob_0;
    
    % determina a variacao entre as duas probabilidades
    error = max(abs(prob_1 - prob_0));
    prob_0 = prob_1;
end

out = prob_0;

end % end of function