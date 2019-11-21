function [A] = findandcheckA(alphas,alpha_2,alpha_1,alpha_0,accuracy)
t1=clock;
if nargin < 5
    accuracy=.1e-8;
end
qz=0; %=0, use AIM algorithm (version obtained from G. Anderson 2004-01-15); =1, use qz decomposition

[nrow,ncol]=size(alphas);
r=(ncol/nrow)-1;
if round(r) ~= r
    error('fatal (feedback) dimension of alphas not right')
end

if qz == 1
    ne=[]; 
    [A,isp]  =   solveaa(alphas,ne);
    if isp ~= 1
        error('fatal (findancheckA) failed to find A')
    end
    
end

if qz == 0 | isp == 1
    
    hmat            =   [alpha_2 alpha_1 alpha_0];
    
    new_AIM = 1; % =1, use new AIM code (as of january 2004); =0 use previous version of anderson and moore
    
    if new_AIM == 0
        [zb,hb,zf,hf]   =   numericBiDirectionalAR(hmat);
        tm              =   numericTransitionMatrix(hf);
        theq            =   numericAsymptoticConstraint(zf,zb,hf,1);
        theb            =   numericAsymptoticAR(theq);
        A               =   theb;
    else
        nlag  =  1; %Number of lags
        nlead =  1; %Number of leads
        condn = 1e-8; %Zero tolerance used as a condition number test by numeric_shift and reduced_form
        uprbnd = 1; %Inclusive upper bound for the modulus of roots allowed in the reduced form
        tic
        [A,rts,ia,nexact,nnumeric,lgroots,aimcode] =  SPAmalg(hmat,size(hmat,1),nlag,nlead,condn,uprbnd);
        toc
        
        if aimcode ~= 1; % See SPAimerr.m for how the variable aimcode is defined
            error('(findandcheckA) anderson-moore algorithm returned aimcode ~= 1')
        end;
    end
    
    [n1,n2]         =   size(A);
    if n1 ~= n2
        error('fatal (findandcheckA) anderson-moore algorithm failed')
    end
end

%Verify that A is a root of the matrix polynomial and that its eigenvalues are stable
%Q=alpha_0*A*A+alpha_1*A+alpha_2;
Q = alphas(:,1:nrow);
for i=1:r
    Q = Q*A+alphas(:,[i*nrow+1:i*nrow+nrow]);
end

qq=max(max(abs(Q)));
qz=max(abs(eig(A)));

if qq > accuracy | qz > 1
    disp('accuracy');disp(qq);
    error('fatal (findandcheckA) solution for A is inaccurate' )
end

if max(max(abs(imag(A)))) > .1e-9
    error('fatal (findandcheckA) A complex')
end

improve =0;
if improve ==1
    if max(max(abs(Q))) > .1e-10
        [n,j] = size(alphas);
        r = j/n-1;
        
        Q = alphas(:,1:n);
        for i=1:r
            Q = Q*A+alphas(:,[i*n+1:i*n+n]); 
        end
        A1=A;
        [A] = chroot(Q,alphas,n,A1,r);
        
        Q1 = alphas(:,1:n);
        for i=1:r
            Q1 = Q1*A+alphas(:,[i*n+1:i*n+n]); 
        end
        
        if max(max(abs(Q1))) > .1e-10
            error('fatal (solvea) matrix root not accurate, even after improvement');
        end               
        
    end    
end

A=real(A);

t2=clock;
fprintf('%g seconds used to compute A\n',etime(t2,t1))