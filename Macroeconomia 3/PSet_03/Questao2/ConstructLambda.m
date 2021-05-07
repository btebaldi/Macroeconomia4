function out = ConstructLambda(Policy, Asset, WageShocks)
% Calcula matrix de distribuicao lambda a partir de uma politica e dos
% estados.

% Inicia uma matri de zeros
lambda = zeros(Asset.Grid.N*WageShocks.Grid.N);

for nShockState = 1:WageShocks.Grid.N
    
    % inicializo a matrix de Transicao gerada pela politica
    M = zeros(Asset.Grid.N);

    % constroi a matrix de Transicao Politica
    for nLinha = 1:Asset.Grid.N
       M(nLinha, Policy.AssetPrime.Index(nLinha, nShockState)) =  1;
    end
   
    % seleciona as linhas da matrix lambda que serao alteradas
    lines =(1:Asset.Grid.N)+ (Asset.Grid.N*(nShockState -1));
    
    % altera a matrix lambda
    lambda(lines,:) = kron(WageShocks.PI(nShockState,:),M);
end
    
    out = CalculaLongoPrazo(lambda);
    out = reshape(out, Asset.Grid.N, WageShocks.Grid.N);
end % end of function