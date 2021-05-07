function [c, y] = Consumption(k, k_1, h, econom_param, z)
    % checa se os vetores h e k tem o mesmo tamanho.
    y = Production(k, h, econom_param, z);
    c = y + (1-econom_param.delta).*k - k_1;
end % end of function consumption