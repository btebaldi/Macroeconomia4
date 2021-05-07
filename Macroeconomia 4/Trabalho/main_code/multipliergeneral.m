function [DYDG,DWDG,ind,Ghat,z] = ...
    multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k,imp)

%KPR preferences

if nargin < 13
    imp=[];
end

[A,B,P,ind] = solutionKPR(g,bet,rhoR,kap,N,phi1,phi2,k,l,gam,sig,rho);

if ind ~= 1
    DYDG=[];
    DWDG=[];
    return
end

Ay=B(1);

Api=B(2);

DYDG=Ay/g;
DWDG=((1/(1-g))+N/(1-N))*Ay-g/(1-g);

if isempty(imp) ~= 1
    Ghat(1)=.04/g;
    z(:,1)=B*Ghat(1);
    for ii = 2:imp
        Ghat(ii)=rho*Ghat(ii-1);
        z(:,ii)=A*z(:,ii-1)+B*Ghat(ii);
    end
else
    z=[];
    Ghat=[];
end