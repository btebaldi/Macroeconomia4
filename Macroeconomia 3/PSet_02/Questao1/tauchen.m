function [Z,Zprob] = tauchen(N,mu,rho,sigma,m)
%Function TAUCHEN
%
%Purpose:    Finds a Markov chain whose sample paths
%            approximate those of the AR(1) process
%                z(t+1) = (1-rho)*mu + rho * z(t) + eps(t+1)
%            where eps are normal with stddev sigma
%
%Format:     {Z, Zprob} = Tauchen(N,mu,rho,sigma,m)
%
%Input:      N       scalar, number of nodes for Z
%            mu      scalar, unconditional mean of process
%            rho     scalar
%            sigma   scalar, std. dev. of epsilons
%            m       max +- std. devs.
%
%Output:     Z       N*1 vector, nodes for Z
%            Zprob   N*N matrix, transition probabilities
%
%  
%
%    This procedure is an implementation of George Tauchen's algorithm
%    described in Ec. Letters 20 (1986) 177-181.
%


Z     = zeros(N,1);
Zprob = zeros(N,N);
a     = (1-rho)*mu;

% Defino dois intervalos Z1 e ZN
Z(N)  = mu + m * sqrt(sigma^2 / (1 - rho^2));
Z(1)  = mu - m * sqrt(sigma^2 / (1 - rho^2));

% Então Z2 ... ZN-1 são definidos por uma grid equidistante de [z1; zN]:
d = (Z(N) - Z(1)) / (N - 1);
for i=2:(N-1)
    Z(i) = Z(1) + d * (i - 1);
end 

% Z = Z + a / (1-rho);

% Create the borders of each interval [zi; zi+1]
mi = zi +d/2;

for j = 1:N
    for k = 1:N
        if k == 1
%             Zprob(j,k) = cdf_normal((Z(1) - a - rho * Z(j) + zstep / 2) / sigma);
            Zprob(j,k) = cdf_normal((Z(1) - a - rho * mi) / sigma);
        elseif k == N
            Zprob(j,k) = 1 - cdf_normal((Z(N) - a - rho * Z(j) - zstep / 2) / sigma);
        else
            Zprob(j,k) = cdf_normal((Z(k) - a - rho * Z(j) + zstep / 2) / sigma) - ...
                         cdf_normal((Z(k) - a - rho * Z(j) - zstep / 2) / sigma);
        end
    end
end


function c = cdf_normal(x)
    c = 0.5 * erfc(-x/sqrt(2));

