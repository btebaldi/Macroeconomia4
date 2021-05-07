function [piel,Yhatl,dYdG,Zl,pielCEE,YhatlCEE,multCEE,ZlCEE] = ...
    EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,phi1,phi2,rho,gam1)


pk=1;
if k == 1
    pk=p;
end

pl=1;
if l == 1
    pl=p;
end

R=1/bet-1;

if abs(rhoR) < .1e-10
    
    num=kap*(1/(1-g)+N/(1-N))*(g*(gam*(sig-1)+1)*Ghat ...
        +(1-g)*bet*rl/(1-p))-(g/(1-g))*kap*Ghat;
    den=1-bet*p-kap*((1/(1-g))+N/(1-N))*p*(1-g)/(1-p);
    piel=num/den;
    Yhatl=g*(gam*(sig-1)+1)*Ghat+((1-g)/(1-p))*(bet*rl+p*piel);
    cc=(1-bet*p)*(1-p)/p;
    dd=(1+N*(1-g)/(1-N));
    rat=kap*(dd*(gam*(sig-1)+1)-1)/(cc-kap*dd);
    dYdG=gam*(sig-1)+1+rat;
    err(1)=-(Yhatl-g*(gam*(sig-1)+1)*Ghat)+(1-g)*(bet*rl+p*piel)+p*Yhatl- ...
        g*(gam*(sig-1)+1)*p*Ghat;
    err(2)=-piel+bet*p*piel+kap*((1/(1-g))+N/(1-N))*Yhatl-(g/(1-g))*kap*Ghat;
    Zl = R + ((phi1/bet)*pk*piel+(phi2/bet)*pl*Yhatl);
    drl=rl-(1/bet-1);
    if Zl > 0
        num=(1-g)*bet/(1-p);
        den=1+((1-g)/(1-p))*(phi2+(kap*(phi1-p)/(1-bet*p))*(1/(1-g)+N/(1-N)));
        YYhatl=(num/den)*drl;
        ppiel=(kap/(1-bet*p))*(1/(1-g)+N/(1-N))*Yhatl;
        dRl=(phi1/bet)*piel+(phi2/bet)*Yhatl;
        errr(1)=-Yhatl-(1-g)*(bet*(dRl-drl)-p*piel)+p*Yhatl;
        errr(2)=-piel+bet*p*piel+kap*(1/(1-g)+N/(1-N))*Yhatl;
        ZZ = R + ((phi1/bet)*pk*ppiel+(phi2/bet)*pl*YYhatl);
        if ZZ < 0
            warning('fatal (EW) interest rate negative, when zero bound appeared not to be binding')
        end
    end
    if nargin == 16
        
        pielCEE=kap*((gam1*(1-g)/sig+1)*bet*rl+gam1*g*(1-p)*Ghat)/((1-bet*p)*(1-p)-kap*(gam1*(1-g)/sig+1)*p);
        YhatlCEE=((1-g)*(bet*rl+p*pielCEE)/sig + g*(1-p)*Ghat)/(1-p);
        piemult=kap*gam1*g*(1-p)/((1-p)*(1-bet*p)-kap*(gam1*(1-g)/sig+1)*p);
        multCEE=(1-g)*p*piemult/(sig*g*(1-p))+1;
        ZlCEE = R + ((phi1/bet)*pk*pielCEE+(phi2/bet)*pl*YhatlCEE);
        erz(1)=-(YhatlCEE-g*Ghat)+((1-g)/sig)*(bet*rl+p*pielCEE)+p*(YhatlCEE-g*Ghat);
        erz(2)=-pielCEE + kap*( (gam1+sig/(1-g))*YhatlCEE - (sig*g/(1-g))*Ghat ) + bet*p*pielCEE;
        if max(abs(erz)) > .1e-10
            warning('fatal (EW) CEE utility function equations not satisfied')
        end
        
    else
        
        YhatlCEE=[];pielCEE=[];multCEE=[];ZlCEE=[];
        
    end
else

    [A,B,P,ind] = solutionKPR(g,bet,rhoR,kap,N,phi1,phi2,k,l,gam,sig,rho);
    if ind ~= 1
        error('fatal (EW) failed to find a unique solution')
    end
    if max(max(abs(A(:,[1:2])))) > .1e-10
        error('fatal (EW) solution incomprehensible')
    end
    a=A(:,3);
    Yhat1=-a(1)*R;
    pie1=-a(2)*R;
    csnt=(1/(1-g))+N/(1-N);
    num=bet*(1-p)*pie1+kap*csnt*(((1-g)*bet*rl/(1-p))+(1-g)*pie1+Yhat1 ...
        +g*(gam*(sig-1)+1)*Ghat)-g*kap*Ghat/(1-g);
    den=1-bet*p-kap*csnt*(1-g)*p/(1-p);
    piel=num/den;
    Yhatl=(1-g)*(bet*rl+p*piel)/(1-p)+(1-g)*pie1+Yhat1+g*(gam*(sig-1)+1)*Ghat;
    err(1)=-(Yhatl-g*(gam*(sig-1)+1)*Ghat)+(1-g)*(bet*rl+p*piel+(1-p)*pie1)+p*Yhatl ...
        +(1-p)*Yhat1-g*(gam*(sig-1)+1)*p*Ghat;
    err(2)=-piel+bet*p*piel+bet*(1-p)*pie1 ...
        +kap*((1/(1-g))+N/(1-N))*Yhatl-(g/(1-g))*Ghat*kap;
    aa=((1/(1-g))+N/(1-N));
    bb=gam*(sig-1)+1;
    rt=(kap*aa*bb-kap/(1-g))/(1-bet*p-kap*aa*(1-g)*p/(1-p));
    dYdG=bb+(p*(1-g)/(1-p))*rt;

end


if max(abs(err)) > .1e-10
    error('fatal(EW) failed to compute lower bound equilibrium')
end


Zl = R + (1-rhoR)*((phi1/bet)*pk*piel+(phi2/bet)*pl*Yhatl);