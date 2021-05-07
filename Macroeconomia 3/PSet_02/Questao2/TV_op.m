function [TV_1, pol_h, pol_k] = TV_op(U, econom_param, V0)
    % Calcula a Utilidade em um "cubo" de grid de variaveis.
    % (1)-axis: k1
    % (2)-axis: h
    % (3)-axis: k
    
    % quantidade de elementos na dimensao k
    T = size(U, 2);
    
    % Inicializacao de variaveis
    TV_1 = nan(size(U,3),1);
    pol_h = nan(size(U,2),1);
    pol_k = nan(size(U,1),1);
    
    for i=1:T
        % Finds the new TV1
        ChoiceMatrix = U(:,:,i) + econom_param.beta .* V0(:,:,i);
        [maxValue, index] = max(ChoiceMatrix(:));
        
        TV_1(i) = maxValue;
        
        [h,k] = ind2sub(size(ChoiceMatrix), index);
        pol_k(i) = k;
        pol_h(i) = h;
    end
end % end of function
