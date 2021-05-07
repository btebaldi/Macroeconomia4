function [TV_1, pol_k] = TV_op(U_cube, Econom_param, V0_cube)
    % Calcula a Utilidade em um "cubo" de grid de variaveis.
    % (1)-axis: k1
    % (2)-axis: h
    % (3)-axis: k
    
    % quantidade de elementos na dimensao de income
    T = size(V0_cube, 3);
    
    % Inicializacao de variaveis
    TV_1 = nan(size(U_cube,1), T);
    pol_k = nan(size(U_cube,1),T);
    
    for i=1:T
        % Finds the new TV1
        ChoiceMatrix = U_cube(:,:,i) + Econom_param.Beta .* V0_cube(:,:,i);
        [maxValue, index] = max(ChoiceMatrix);
        
        TV_1(:,i) = maxValue';
        
        pol_k(:,i) = index';
    end
end % end of function
