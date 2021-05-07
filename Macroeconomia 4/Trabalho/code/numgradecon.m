function Df=numgradecon(func,x,param,h,err);

%unmgradecon returns numerical gradient of function func.
%The function numgradecon is designed to deal with higher order problems, when the evaluation of the function is costly.
%func returns M-dimensional vector as a function of parameteres param, and variables x. As the dimension of M
%increases, evaluating Df(i,j) for each i separately becomes infeasible. numgradecon avoids this problem by using 
%function evaluations for all i simultaneously, given j. (i is dimension of output,j is dimension of x)

NTAB	=	10;
CON	=	1.4;
CON2	=	CON*CON;
BIG	=	1.0e30;
SAFE	=	2.0;
f0=feval(func,param,x);

a		=	zeros(length(f0),NTAB, NTAB);
derivative	=	zeros(length(f0),1);
ans			=	derivative;
hh 	=	h;
up		=	x;
dn		=	x;

up(wrt) = up(wrt) + hh;
dn(wrt) = dn(wrt) - hh;
a(:,1,1) = ( feval(func,pars, up) - feval(func, pars, dn) ) / (2.0*hh);
perr = BIG;
for i=2:NTAB
   hh = hh/CON;
   up=x;
   dn=x;
   up(wrt) = up(wrt) + hh;
   dn(wrt) = dn(wrt) - hh;
   
   a(:,1,i) = ( feval(func, pars, up) - feval(func, pars, dn) ) /(2.0*hh);
   fac = CON2;
   for j=2:i
      a(:,j,i) = ( a(:,j-1,i)*fac - a(:,j-1,i-1) ) / (fac-1.0) ;
      fac = CON2 * fac;
      dum = [ abs(a(:,j,i) - a(:,j-1,i)),abs(a(:,j,i) - a(:,j-1,i-1)) ];
      errt = max(dum);
      for k=1:length(f0)
         
      if errt(k) <= perr(k)
         perr(k) = errt(k);
         ans(k) = a(k,j,i);
      end
      end
   end
   if min(abs(a(:,i,i) - a(:,i-1,i-1))- SAFE*(perr))>0
      break
      
   end
end
derivative= ans;
