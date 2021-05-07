function y = Production(k, h, econom_param, z)
    % Check number of inputs.
    narginchk(4,4)
    
    % checa se os vetores h e k tem o mesmo tamanho.
    y = z .* k.^econom_param.alpha .* h.^(1-econom_param.alpha);
    
end % end of function consumption