function [R,ind1] = solver(tau,rho,Ve)
%Solver:  Solve for the matrix R used to compute the matrix, B, in the case
%where there is partial information.
%
%R is a (n1*mth+m1+m2+...+mn1)Xm*n1 matrix where m = 2*mth. R is defined by
%
%  vec_bar(F_tilde') = R*vec(F')
%
%where vec_bar removes the zero restrictions from F_tilde'.
%
%ind1 indexes the non-zero restrictions in vec(B'). It also
%indexes these non-zeros in vec(F_tilde') due to the requirement
%that the ordering of z1(t) corresponds to the ordering of the equations.
%
%Inputs:
%
%tau:  a mthXn1 matrix containing 1s or 0s indicating whether a variable in
%th(t) is included in the info sets for equations, i = 1,2,...,n1.
%
% (rho, Ve) are mthXmth matrices given by
%
%  th(t) = rho*th(t-1) + e(t)
%
%  Ve = E(e(t)*e(t)')
%
%mth: no. of variables in th(t)
%mi:  no. of 1's in tau(i) where i = 1,2,...,n1
%n1:  no. of endogenous equations or variables in z1(t)
%m:   no. of variables in s(t);

%Determine mth,n1,m
[mth,n1] = size(tau);  m = 2*mth;
taulev	= tau(1,:);
R=eye(m*n1);
taucounter=0;
drops=[];
for i=1:n1;
   if taulev(i)==0
      taucounter=taucounter+1;
      taulev2(taucounter)=(2*(i-1)+1);
      R((2*i-1)*mth+1:2*i*mth,(2*i-2)*mth+1:(2*i-1)*mth)=rho';
   end
end
for i=1:length(taulev2);
   drops=union(drops,[(taulev2(i)-1)*mth+1:taulev2(i)*mth]);
end

nondrops=setdiff([1:length(R)],drops);
R=R(nondrops,:);
      
ind1=nondrops;
