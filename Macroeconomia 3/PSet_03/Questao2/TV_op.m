function [TV_1, pol_L, pol_A] = TV_op(U, eco_param, V0)
    % Calcula a Utilidade em um "cubo" de grid de variaveis.
    % (1)-axis: k1
    % (2)-axis: h
    % (3)-axis: k
    
    % quantidade de elementos na dimensao k
    T = size(U, 2);
    
    % Inicializacao de variaveis
    TV_1 = nan(T,1);
    pol_L = nan(size(U,1),1);
    pol_A = nan(size(U,2),1);
    
    for i=1:T
        % Finds the new TV1
        ChoiceMatrix = U(:,:,i) + eco_param.beta .* V0(:,:,i);
        [maxValue, index] = max(ChoiceMatrix(:));
        
        TV_1(i) = maxValue;
        
        [lin,col] = ind2sub(size(ChoiceMatrix), index);
        pol_L(i) = lin;
        pol_A(i) = col;
    end
end % end of function
