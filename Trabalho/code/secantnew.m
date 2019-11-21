function x = secant(func,x0,param,crit,maxit)
%SECANT   Finds the fixed point of a system of equations.
%         x=secant(func,x0,param,crit,maxit)  uses the secant method
%         to find the zeros of the following system:
%
%                        f1(z1,z2,...zn)=0
%                        f2(z1,z2,...zn)=0                (*)
%                          :           :
%                        fn(z1,z2,...zn)=0
%
%         where x=[z1,z2,...,zn]' are those values of zi that solve (*).
%         To use secant, you must specify "func" which is a string giving
%         the name of an m-file.  Do not use "f.m","x.m","x0.m".
%         This m-file takes inputs x and param and returns f, where
%         f = [f1(x,param),f2(x,param),...fn(x,param)]'.  The arguments
%         x0, crit, and maxit are the initial guess for the fixed point,
%         the convergence criterion, and the iteration limit.
%
%
[n1,n2]=size(x0);
if n2>n1
   x0=x0';
end

if isempty(maxit) == 1;maxit=100;end
if isempty(crit) == 1;crit = .1e-10;end
n   = length(x0);
del = diag(max(abs(x0)*1e-8,1e-8));
eval(['f        =',func,'(x0,param);']);
f0=f;
for i=1:maxit;
  
  for j=1:n;
    eval(['fj(:,j)  = (f-',func,'(x0-del(:,j),param))/del(j,j);']);
  end;
  zip=min(abs(eig(fj)));
  if zip < .1e-10
    disp(' (secant) singularity')
    zip
    n
    keyboard
 end
 
  x=x0-fj\f0;
  eval(['f        =',func,'(x,param);']);
  lam=1;
  
  while max(abs(f)) > max(abs(f0))
     lam=lam/2;
     
     x=x0-lam*(fj\f0)
     eval(['f       =',func,'(x,param);'])
     fprintf('*lam = %6.3f*\n',lam)
     if lam < .000001
        error(' (secant) having a tough time finding an improvement')
     end     
  end
  
     
  if max( abs(x-x0)./(1+abs(x0)) ) < crit | max(abs(f)) < crit;
    break;
  end;
  x0=x;
  f0=f;
  fprintf('.')
end;
if i>=maxit;
  sprintf('WARNING: iteration limit of %g exceeded for Secant',maxit)
end;
