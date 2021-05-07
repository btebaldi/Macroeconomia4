function out=h(x) 
% Inicializa variavel de saida
out = nan(size(x));

for i=1:numel(x)
    if (0 <=x(i)) && (x(i)<=2)
        out(i)=(x(i)-0.5)^2;
    elseif (-2 <=x(i)) && (x(i)<0)
        out(i)=(x(i)+0.5)^2;
    else
        error('x fora do intervalo permitido')
    end
end

end % end of function
