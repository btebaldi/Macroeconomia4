function out = RMSE(y, y_hat)
if size(y)~=size(y_hat)
    error('y e y_hat devem ter as mesmas dimensoes');
end

% inicializa variavel de soma
soma=0;
T=numel(y);
for i=1:T
    soma = soma + ((y(i)-y_hat(i))^2)/T;
end

out = soma^0.5;
end % end of function RMSE