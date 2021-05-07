function out=mu(Ui,Ua, param)
gamma = param(1);
eta =param(2);
beta=param(3);
if gamma~=1
    out = (Ui/Ua)^(1/(1-gamma)) -1;
else
    out = exp((1-eta*beta)*(Ui-Ua)) -1;
end

end % end of function