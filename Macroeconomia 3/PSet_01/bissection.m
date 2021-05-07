function [y,fy] = bissection(f,a,b,r,eps)

% Check number of inputs.
if nargin < 3
    error('requires at least 3 inputs');
end

% Fill in unset optional values.
switch nargin
    case 3
        r = 0;
        eps = 1e-7;
    case 4
        eps = 1e-7;
end

% verifica se os valores das funcoes
if f(a)*f(b) > 0
    error('Pontos a e b inconsistentes');
end


% calcula o ponto medio
c = (a+b)/2;

% enquanto a funcao for diferente do valor.
nCount=0;
while (abs(f(c)-r) > eps)
    if f(a)*f(c) < 0
        b=c;
    else
        a=c;
    end
    
    % Calculo novo ponto medio
    c = (a+b)/2;
    nCount=nCount+1;
end

y=c;
fy=f(c);
end
