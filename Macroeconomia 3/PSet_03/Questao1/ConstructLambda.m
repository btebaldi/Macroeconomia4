function out = ConstructLambda(Policy, Asset, Income)
% Calcula matrix de distribuicao lambda a partir de uma politica e dos
% estados.

% Inicia uma matri de zeros
lambda = zeros(Income.Grid.N*Asset.Grid.N);

for nShockState = 1:Income.Grid.N
    
    % inicializo a matrix de Transicao gerada pela politica
    M = zeros(Asset.Grid.N);

    % constroi a matrix de Transicao Politica
    for nLinha = 1:Asset.Grid.N
       M(nLinha, Policy.AssetPrime.Index(nLinha, nShockState)) =  1;
    end
   
    % seleciona as linhas da matrix lambda que serao alteradas
    lines =(1:Asset.Grid.N)+ (Asset.Grid.N*(nShockState -1));
    
    % altera a matrix lambda
    lambda(lines,:) = kron(Income.PI(nShockState,:),M);
end
    
    out = CalculaLongoPrazo(lambda);
    out = reshape(out, Asset.Grid.N, Income.Grid.N);
end % end of function