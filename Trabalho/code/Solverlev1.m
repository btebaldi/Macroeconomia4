function [del_bar,ind1] = solverlev1(tau,rho,d,q)
%Solver:  Solve for the matrix R used to compute the matrix, B, in the case
%where there is partial information.
%
%R is a (n1*mth+m1+m2+...+mn1)Xm*n1 matrix where m = 2*mth. R is defined by
%  vec_bar(F_tilde') = R*vec(F')
%where vec_bar removes the zero restrictions from F_tilde'.
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
%mth: no. of variables in th(t)
%mi:  no. of 1's in tau(i) where i = 1,2,...,n1
%n1:  no. of endogenous equations or variables in z1(t)
%m:   no. of variables in s(t);

%Determine mth,n1,m
[mth,n1] = size(tau);  m = 2*mth;
taulev	= tau(1,:);
R=eye(m*n1);
taucounter=0;
taulev3=zeros(2*n1);
drops=[];
smalldrops=[];
for i=1:n1;
   if taulev(i)==0
      taucounter=taucounter+1;
      taulev2(taucounter)=(2*(i-1)+1);
      taulev3(2*i,2*i-1)=1;
   end
end
Radd=kron(taulev3,rho');
smallR=taulev3+2*eye(size(taulev3));
R=R+Radd;
for i=1:length(taulev2);
   drops=union(drops,[(taulev2(i)-1)*mth+1:taulev2(i)*mth]);
   smalldrops=union(smalldrops,taulev2(i));
end

nondrops=setdiff([1:length(R)],drops);
smallnondrops=setdiff(1:2*n1,smalldrops);
R=R(nondrops,:);
smallR=smallR(smallnondrops,:);      
ind1=nondrops;
smallind1=smallnondrops;
[rn,rm]=size(smallR);
dtilde=zeros(mth*rn,1);
for i=1:rn
   R_dtemp=zeros(mth,1);
   for j=1:rm
      if smallR(i,j)==1
         R_dtemp =rho'    * d(mth*(j-1)+1:mth*j)+R_dtemp;
      elseif smallR(i,j)==2
         R_dtemp =eye(mth)* d(mth*(j-1)+1:mth*j)+R_dtemp;
      end
   end
   dtilde(mth*(i-1)+1:mth*i)=R_dtemp;
end
qtilde=zeros(mth*rn,mth*rm);
for k=1:rm
   for i=1:rn
      R_qtemp=zeros(mth,mth);
      for j=1:rm
         if smallR(i,j)==1
            R_qtemp=rho'*q(mth*(j-1)+1:mth*j,mth*(k-1)+1:mth*k)+R_qtemp;
         elseif smallR(i,j)==2
            R_qtemp=     q(mth*(j-1)+1:mth*j,mth*(k-1)+1:mth*k)+R_qtemp;
         end
      end
      qtilde(mth*(i-1)+1:mth*i,mth*(k-1)+1:mth*k)=R_qtemp;
   end
end  
del_bar = -(qtilde(:,ind1)\dtilde);
