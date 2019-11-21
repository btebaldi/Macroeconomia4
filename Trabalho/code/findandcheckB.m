function [B,B1,B2,P,rho,betas] = findandcheckB(A,alphas,rho,taushock,taumat,betas)

[B,P]   =   solveb(A,alphas,betas,rho,taumat);
if max(max(abs(imag(B)))) > 2e-12
    error('fatal (findandcheckB) B complex')
end

if size(P,1) ==  size(rho,1)
    P = [rho, zeros(size(rho,1),size(rho,1)); eye(size(rho,1)), zeros(size(rho,1),size(rho,1))];
    B1 = real(B);
    B2 = zeros(size(A,1),size(rho,1));
    B  = [B1 B2];
else
    B1 = real(B(:,1:size(rho,1)));
    B2 = real(B(:,size(rho,1)+1:end));
end;

%checkB