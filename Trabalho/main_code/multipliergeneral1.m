function [DYDG,DWDG,ind,Ghat,z] = ...
    multipliergeneral1(kap,bet,g,N,sig,gam,phi1,phi2,rho,rhoR,l,k,imp)

%this works with the 'standard' preferences.

if nargin < 13
    imp=[];
end

if l~=1 & l~=0
    error('fatal (multipliergeneral) wrong value for l')
end

if k~=1 & k~=0
    error('fatal (multipliergeneral) wrong value for k')
end

al0=[1 (1-g)/sig 0
   0 bet 0
   l*(1-rhoR)*phi2/bet k*(1-rhoR)*phi1/bet 0];

al1=[-1 0 -bet*(1-g)/sig
    kap*(gam+sig/(1-g)) -1 0
    (1-l)*(1-rhoR)*phi2/bet (1-k)*(1-rhoR)*phi1/bet -1];

al2=[0 0 0
   0 0 0
   0 0 rhoR];

bet0=[-g
      0
      0];
  
bet1=[g
      -sig*kap*g/(1-g)
      0];

alphas=[al0, al1, al2];

ne=[];

[ind,dropm,A] = SOLVEA(alphas,0,ne);
if ind ~= 1
    DYDG=[];
    DWDG=[];
    Ghat=[];
    z=[];
    return
end

Q=al0*A^2+al1*A+al2;

if max(max(abs(Q))) > .1e-7
    error('fatal(stickyprice) failed to solve model')
end

betas=[bet0 bet1];

tau=ones(1,3);

PP=rho;

[B,P] = SOLVEB(A,alphas,betas,PP,tau);

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
end