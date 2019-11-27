%by default (ip=3 below), this program generates results that correspond to
%figure 3 in the JPE paper, 'When is the Multiplier on Government Spending
%Large?', Christiano-Eichebaum-Rebelo

dbstop if error
clear all
close all
addpath ../AIM
addpath ../code
% addpath ../june2006
% addpath ../capital

%&&&&&&&&&&&&&&&&&& block of parameters to be set by the user &&&&&&&&&&&
%following is the set of parameter values used in the JPE:
bet=.99;                    % Temporal discount factor
phi1=1.5;                   %<<<<
phi2=0.0;                   %<<<<
N=1/3;                      % Total working hours
g=.2;                       % G/Y Gov consumption of the GDP<<<<
gam=1/((1-N)/(N*(1-g))+1);  %
sig=2;                      % CES factor
%sig=1.0000001;%this is the log case
rho=.8;                     % serial correlation of governament spending
p=.8;                       % Propabilitiy of non zero bind
kap=.03;                    % Price flexibility
rhoR=0;                   % Stickness of monetary autority (0=no stick) / Interest rate smothing
rl=-.01/4;                  % stocartic discount factor lower (<0)
Ghat=0.0;                   % Gt/G
gam1=1;                     % gamma for when EW utility function is used (EW utility, standard separable utility function in DSGE literature)
ip=1;%ip=1, behavior of the economy in zlb for a range of parameter values (figure 2 in JPE paper)
     %ip=5, same as ip=1, except results are displayed for KPR preferences and EW preferences (the code is now set up to only vary the value of
     %      one parameter and must be adjusted to vary others)
     %ip=2, impulse responses of the system to a G shock outside the zlb. 
     %ip=3, optimal government consumption in the zlb (figure 3 in JPE paper)
     %ip=0, properties (as a function of different parameter values) of model outside zlb
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

%the following calculates the value of thet, the calvo price stickiness
%parameter, that is implicit in our setting of bet and kap:
c=[bet -(1+bet+kap) 1];
cc=roots(c);
thet=cc(2);
if abs(thet)>1
    thet=cc(1);
end

KPR=1;%if 0, use EW parameterization
%these have to do with whether it's the actual (k,l=0) or forecasted (k,l=1) values
%of inflation/output gap in Taylor rule. Not sure if k,l=1 works.
k=0;
l=0;
if ip == 2
    KPR = 0;
end
if KPR == 0
    ip=2;
end

%JPE code with bug, N^((1-gam)*(1-sig)) should have been (1-N)^((1-gam)*(1-sig))
psig=gam*((N*(1-g))^(gam*(1-sig)-1))*(N^((1-gam)*(1-sig)))*(N*g)^sig;
MUG=psig*(N*g)^(-sig);
MUC=gam*(N*(1-g))^(gam*(1-sig)-1)*N^((1-gam)*(1-sig));
%LJC correction, May 17 2013 (error pointed out by Florin Bilbii May 16):
psig=gam*((N*(1-g))^(gam*(1-sig)-1))*((1-N)^((1-gam)*(1-sig)))*(N*g)^sig;
MUG=psig*(N*g)^(-sig);
MUC=gam*(N*(1-g))^(gam*(1-sig)-1)*(1-N)^((1-gam)*(1-sig));

if abs(MUG-MUC) > .1e-10
   error('fatal (stickyprice) psig not calibrated correctly')
end
%if you want utility of government consumption to be zero, comment out the following line:
%psig=0;

%set the range of perturbations:
ssig=.9:.001:3;
kkap=0.015:.001:2;
pphi1=1.001:.001:1.9;
pphi2=0:.001:.5;
rrhoR=0:.001:.99;
rrho=0:.001:.99;
pp=.01:.001:.99;
n1=3;
n2=3;

[piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,phi1,phi2,rho);
[DYDG,DWDG,ind,Ghatt,z] = multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k);

if ip == 1

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(pp)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,pp(ii),bet,k,l,rhoR,phi1,phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(pp-p));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    tt='p';
    figure('name','probability');
    plt(pp,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(pphi1)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,pphi1(ii),phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(pphi1-phi1));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end
    if isempty(I)
        error('fatal (stickyprice) zlb never binding, try lower value of r^l')
    end
    figure('name','phi1');
    tt='\phi_{1}';
    plt(pphi1,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(pphi2)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,phi1,pphi2(ii),rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(pphi2-phi2));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    tt='\phi_{2}';
    figure('name','phi2');
    plt(pphi2,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(rrhoR)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rrhoR(ii),phi1,phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(rrhoR-rhoR));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    tt='\rho_{R}';
    figure('name','rhoR');
    plt(rrhoR,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(kkap)
        [piel,Yhatl,dYdG,Zl]=EW(kkap(ii),g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,phi1,phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(kkap-kap));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    tt='\kappa';
    figure('name','kappa');
    plt(kkap,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

elseif ip == 2

    imp=20;
    [DYDG,DWDG,ind,Ghat,z] = ...
        multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k,imp);
    if KPR == 1
        pltt(imp,z,Ghat,g);
        str=['parameter values: \phi_{1} = ',num2str(phi1),', \phi_{2} = ',num2str(phi2),', \rho_{R} = ',num2str(rhoR) ...
            ,', \rho = ',num2str(rho),', \kappa = ',num2str(kap),', \beta = ',num2str(bet) ...
            ,', \gamma = ',num2str(gam),', N = ',num2str(N),', g = ',num2str(g) ...
            ,', k = ',num2str(k),', l = ',num2str(l),', sig = ',num2str(sig),', r^l (APR) = ',num2str(400*rl)];
        hout=suptitle(str);
    else
        [DYDG1,DWDG1,ind1,Ghat1,z1] = ...
            multipliergeneral1(kap,bet,g,N,sig,gam1,phi1,phi2,rho,rhoR,l,k,imp)
        pltt1(imp,z,z1,Ghat,g);
    end

elseif ip == 0

    ff=zeros(1,length(pphi1));
    for ii = 1:length(pphi1)
        [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,sig,gam,pphi1(ii),phi2,rho,rhoR,l,k);
        if ind == 1
            ff(ii)=DYDG;
        else
            ff(ii)=0;
        end
    end

    n1=2;
    n2=3;

    [Y,I]=min(abs(pphi1-phi1));
    subplot(n1,n2,3)
    plot(pphi1,ff,pphi1(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\phi_{1}')
    axis tight

    ff=zeros(1,length(ssig));
    for ii = 1:length(ssig)
        [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,ssig(ii),gam,phi1,phi2,rho,rhoR,l,k);
        ff(ii)=DYDG;
    end

    [Y,I]=min(abs(ssig-sig));
    subplot(n1,n2,1)
    plot(ssig,ff,ssig(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\sigma')
    axis tight

    ff=zeros(1,length(kkap));
    for ii = 1:length(kkap)
        [DYDG,DWDG,ind] = multipliergeneral(kkap(ii),bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k);
        ff(ii)=DYDG;
    end

    [Y,I]=min(abs(kkap-kap));
    subplot(n1,n2,2)
    plot(kkap,ff,kkap(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\kappa')
    axis tight

    ff=zeros(1,length(pphi2));
    for ii = 1:length(pphi2)
        [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,sig,gam,phi1,pphi2(ii),rho,rhoR,l,k);
        ff(ii)=DYDG;
    end

    [Y,I]=min(abs(pphi2-phi2));
    subplot(n1,n2,4)
    plot(pphi2,ff,pphi2(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\phi_{2}')
    axis tight

    ff=zeros(1,length(rrhoR));
    for ii = 1:length(rrhoR)
        [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rho,rrhoR(ii),l,k);
        ff(ii)=DYDG;
    end

    [Y,I]=min(abs(rrhoR-rhoR));
    subplot(n1,n2,5)
    plot(rrhoR,ff,rrhoR(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\rho_{R}')
    axis tight

    ff=zeros(1,length(rrho));
    for ii = 1:length(rrho)
        [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rrho(ii),rhoR,l,k);
        ff(ii)=DYDG;
    end

    [Y,I]=min(abs(rrho-rho));
    subplot(n1,n2,6)
    plot(rrho,ff,rrho(I),ff(I),'*')
    ylabel('dY/dG')
    xlabel('\rho')
    axis tight

    %     ff=zeros(1,length(kkap));
    %     for ii = 1:length(kkap)
    %         [DYDG,DWDG,ind] = multipliergeneral(kkap(ii),bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k);
    %         ff(ii)=DWDG;
    %     end
    %
    %     [Y,I]=min(abs(kkap-kap));
    %     subplot(n1,n2,7)
    %     plot(kkap,ff,kkap(I),ff(I),'*')
    %     ylabel('dW/dG')
    %     xlabel('\kappa')
    %     axis tight
    %
    %     ff=zeros(1,length(rrho));
    %     for ii = 1:length(rrho)
    %         [DYDG,DWDG,ind] = multipliergeneral(kap,bet,g,N,sig,gam,phi1,phi2,rrho(ii),rhoR,l,k);
    %         ff(ii)=DWDG;
    %     end
    %
    %     [Y,I]=min(abs(rrho-rho));
    %     subplot(n1,n2,8)
    %     plot(rrho,ff,rrho(I),ff(I),'*')
    %     ylabel('dW/dG')
    %     xlabel('\rho')
    %     axis tight

    str=[' \phi_{1} = ',num2str(phi1),', \phi_{2} = ',num2str(phi2),', \rho_{R} = ',num2str(rhoR) ...
        ,', \rho = ',num2str(rho),', \kappa = ',num2str(kap),', \beta = ',num2str(bet) ...
        ,', \gamma = ',num2str(gam),', N = ',num2str(N),', g = ',num2str(g) ...
        ,', k = ',num2str(k),', l = ',num2str(l),', \sigma = ',num2str(sig)];
    hout=suptitle(str);

elseif ip == 3

    GGhat=0:.001:.5;
    GGhat=0:.0001:.15;
    for ii = 1:length(GGhat)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,GGhat(ii),rl,p,bet,k,l,rhoR,phi1,phi2,rho);
        Rl=0;
        if Zl > 0
            A=[1-p -(1-g)*p (1-g)*bet
                -kap*(1/(1-g)+N/(1-N)) 1-bet*p 0
                -phi2/bet -phi1/bet 1];
            d=[g*(gam*(sig-1)+1)*(1-p)*GGhat(ii)-(1-g)*bet*(1/bet-1-rl)
                -kap*(g/(1-g))*GGhat(ii)
                0];
            ck = 0;
            if ck==1
                AA=A;
                AA(3,1)=0;
                AA(3,2)=0;
                dd=d;
                dd(3)=-(1/bet-1);
                zzz=inv(AA)*dd;
                if abs(Yhatl-zzz(1)) > .1e-10 | abs(piel-zzz(2)) > .1e-10 | abs(-(1/bet-1)-zzz(3)) > .1e-10
                    error('fatal (stickyprice) failed to compute zero bound equilibrium correctly')
                end
            end
            zz=inv(A)*d;
            Yhatl=zz(1);
            piel=zz(2);
            dRl=zz(3);
            Rl=dRl+(1/bet-1);
            err(1)=-Yhatl+g*(gam*(sig-1)+1)*GGhat(ii)-(1-g)*(bet*(dRl+1/bet-1-rl)-p*piel)+p*Yhatl-g*(gam*(sig-1)+1)*p*GGhat(ii);
            err(2)=-piel+bet*p*piel+kap*((1/(1-g)+N/(1-N))*Yhatl-(g/(1-g))*GGhat(ii));
            err(3)=-dRl+(phi1/bet)*piel+(phi2/bet)*Yhatl;
            if max(abs(err)) > .1e-10
                error('fatal (stickyprice) error in computing high discount rate equilibrium')
            end
        end
        U(ii)=(((N*(Yhatl+1)-N*g*(GGhat(ii)+1))^gam  ...
            * (1-N*(Yhatl+1))^(1-gam))^(1-sig)-1)/(1-sig) + ...
            psig*(N*g*(GGhat(ii)+1))^(1-sig)/(1-sig);
        Yhat(ii)=Yhatl;
        ffq(ii)=Zl;
        pie(ii)=piel;
        RR(ii)=Rl;
    end
    I=find(ffq>0);
    if isempty(I)
        I1=length(U);
    else
        I1=I(1);
    end
    [Y,I]=max(U);
    subplot(231)
    plot(GGhat(I1),U(I1),'o',GGhat(I),U(I),'*',GGhat,U)
    legend('zero bound','optimal')
    xlabel('Ghat','FontSize',18)
    ylabel('Utility','FontSize',18)
    axis([GGhat(1) GGhat(end) min(U) (max(U)+(max(U)-min(U))*.1)])
    subplot(232)
    plot(GGhat,Yhat+1,GGhat(I),Yhat(I)+1,'*',GGhat(I1),Yhat(I1)+1,'o',GGhat,ones(1,length(GGhat)))    
    xlabel('Ghat','FontSize',18)
    ylabel('Y over Y steady state','FontSize',18)
    axis tight
    subplot(233)
    plot(GGhat,ffq,GGhat(I),ffq(I),'*',GGhat(I1),ffq(I1),'o',GGhat,zeros(1,length(GGhat)))
    xlabel('Ghat','FontSize',18)
    ylabel('{Z}^l','FontSize',18)
    axis tight
    C=N*(1-g);
    subplot(234)
    plot(GGhat,(N*(Yhat+1)-N*g*(GGhat+1))/(N*(1-g)),GGhat(I),(N*(Yhat(I)+1)-N*g*(GGhat(I)+1))/(N*(1-g)),'*',GGhat(I1),(N*(Yhat(I1)+1)-N*g*(GGhat(I1)+1))/(N*(1-g)),'o')
    xlabel('Ghat','FontSize',18)
    ylabel('C over C steady state','FontSize',18)
    axis tight
    subplot(235)
    plot(GGhat,400*RR,GGhat(I),400*RR(I),'*',GGhat(I1),400*RR(I1),'o')
    xlabel('Ghat','FontSize',18)
    ylabel('nominal rate of interest (APR)','FontSize',18)
    axis([GGhat(1) GGhat(end) -.1 400*max(RR)])
    subplot(236)
    plot(GGhat,400*pie,GGhat(I),400*pie(I),'*',GGhat(I1),400*pie(I1),'o')
    xlabel('Ghat','FontSize',18)
    ylabel('inflation (APR)','FontSize',18)
    axis tight
    str=[' \phi_{1} = ',num2str(phi1),', \phi_{2} = ',num2str(phi2),', \rho_{R} = ',num2str(rhoR) ...
        ,', \rho = ',num2str(rho),', \kappa = ',num2str(kap),', \beta = ',num2str(bet) ...
        ,', \gamma = ',num2str(gam),', {N} = ',num2str(N),', {g} = ',num2str(g) ...
        ,', k = ',num2str(k),', l = ',num2str(l),', Ghat = ',num2str(Ghat),', \sigma = ',num2str(sig),', \psi_{g} = ', ...
        num2str(psig),', r^l (APR) = ',num2str(400*rl)];
    hout=suptitle(str);

elseif ip == 4

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(pp)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,pp(ii),bet,k,l,rhoR,phi1,phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(pp-p));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    tt='p';
    figure('name','probability');
    plt(pp,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

    ff=[];f1=[];f2=[];f3=[];f4=[];
    for ii = 1:length(pphi1)
        [piel,Yhatl,dYdG,Zl]=EW(kap,g,N,gam,sig,Ghat,rl,p,bet,k,l,rhoR,pphi1(ii),phi2,rho);
        ff(ii)=dYdG;
        f1(ii)=Zl;
        f2(ii)=ind;
        f3(ii)=Yhatl;
        f4(ii)=piel;
    end

    [Y1,I1]=min(abs(pphi1-phi1));
    I=find(f1<=0);
    if isempty(find(f2(I)~=1))~=1
        error('fatal(stickyprice) multiple equilibria encountered')
    end

    figure('name','phi1');
    tt='\phi_{1}';
    plt(pphi1,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt);

elseif ip == 5    
    
    ff=[];f1=[];f2=[];f3=[];f4=[];
    kkap=[.023:.0001:.038];
    pp=.01:.001:.99;
    for ii = 1:length(pp)
        [piel,Yhatl,dYdG,Zl,pielCEE,YhatlCEE,multCEE,ZlCEE] ...
            =EW(kap,g,N,gam,sig,Ghat,rl,pp(ii),bet,k,l,rhoR,phi1,phi2,rho,gam1);
        ff(ii,[1:2])=[dYdG multCEE];
        f1(ii,[1:2])=[Zl ZlCEE];
        f3(ii,[1:2])=[Yhatl YhatlCEE];
        f4(ii,[1:2])=[piel pielCEE];
    end

    [Y1,I1]=min(abs(kkap-kap));
    [Y1,I1]=min(abs(pp-p));
    I=find(f1(:,1)<=0&ff(:,1)<20);
    ICEE=find(f1(:,2)<=0&ff(:,2)<20);

%    tt='\kappa';
%    figure('name','kappa');
    tt=' p ';
    figure('name','p')
    pltcompare(pp,ff,I,I1,ICEE,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt,gam1);
end