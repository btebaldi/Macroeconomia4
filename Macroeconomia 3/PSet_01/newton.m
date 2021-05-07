function [y] = newton(f, Df, x0, param, Dparam, eps, maxInt)
% EXecuta o processo de Newton Rapson com derivada deterministica
% f: funcao que se quer saber a raiz
% Df: funcao Derivada
% x0: ponto de saida inicial
% param: parametros adicionais a serem passados para a funcao
% Dparam: Parametros adicionais a serem passado para a funcao Derivada
% eps: valor critico de arredondamento
% maxInt: maior numero de interacoes

% Check number of inputs.
narginchk(3,7)

% Fill in unset optional values.
switch nargin
    case {4,5}
        eps = 1e-7;
        maxInt = 100;
    case 6
        maxInt = 100;
end

% executa processo interativo de Newton
for i=1:maxInt
    % verifica se a derivada da funcao no ponto e diferente de zero
    if Df(x0,Dparam) == 0
        error('Derivada em ponto critico encontrado.')
    end
    
    % calcula novo ponto
    x=x0-f(x0,param)/Df(x0,Dparam);
    
    if abs(f(x,param))<eps;
        break % comando de saida do looping
    end
    x0=x;
end
y=x;
end % end of function