function [A,B,P,ind] = solutionKPR(g,bet,rhoR,kap,N,phi1,phi2,k,l,gam,sig,rho)

if l~=1 & l~=0
    error('fatal (solutionKPR) wrong value for l')
end

if k~=1 & k~=0
    error('fatal (solutionKPR) wrong value for k')
end

al0=[-1/(1-g) -1 0
   0 bet 0
   l*(1-rhoR)*phi2/bet k*(1-rhoR)*phi1/bet 0];

al1=[1/(1-g) 0 bet
    kap*((1/(1-g))+N/(1-N)) -1 0
    (1-l)*(1-rhoR)*phi2/bet (1-k)*(1-rhoR)*phi1/bet -1];

al2=[0 0 0
   0 0 0
   0 0 rhoR];

bet0=[g*(gam*(sig-1)+1)/(1-g)
      0
      0];
  
bet1=[-g*(gam*(sig-1)+1)/(1-g)
      -kap*g/(1-g)
      0];

alphas=[al0, al1, al2];

ne=[];

[ind,dropm,A] = SOLVEA(alphas,0,ne);

if ind ~= 1
    A=[];B=[];P=[];
    return
end

Q=al0*A^2+al1*A+al2;

if max(max(abs(Q))) > .1e-7
    error('fatal(solutionKPR) failed to solve model')
end

betas=[bet0 bet1];

tau=ones(1,3);

PP=rho;

[B,P] = SOLVEB(A,alphas,betas,PP,tau);