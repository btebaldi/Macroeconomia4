clear all

sigma = 1.5;
beta = 0.96;
betta = beta^(1/6);
eh = 1.00;
el = 0.1;

prob = [ .925 .075; .5 .5];

probst = (1/2)*ones(1,2);

test = 1;
while test > 10^(-8);
    probst1 = probst*prob;
    test=max(abs(probst1-probst));
    probst = probst1;
end

finaldist=probst1


income=[eh,el];
avg_income=finaldist*income'

yearly_avg_income=avg_income*6;

b=-yearly_avg_income

minast = b;
maxast = 3*avg_income;
N=5;
a_grid=linspace(minast,maxast,N);
r=(1+0.034)^(1/6)-1

u = @(c) (c^(1-sigma)-1)/(1-sigma);
Ut = zeros(N,N,2);
for kk = 1:2 % Loop Over Nature States
    for ii = 1:N % Loop Over Assets Today
        for jj = 1:N % Loop Over Assets Tomorrow
            z = income(kk); % Income level Today
            a = a_grid(ii); % Assets Today
            ap = a_grid(jj); % Assets Tomorrow
            % Solve for Consumption at Each Point
            c = z + a*(1+r) -ap;
            if (ap < b)||(c < 0)
                % If Tomorrow's Capital Stock or Today's Consumption is Negative we assign a very %to ensure this never happens
                Ut(ii,jj,kk) = -inf;
            else
                Ut(ii,jj,kk) = u(c);
            end
        end
    end
end

V0 = kron(income,ones(N,1));

for kk = 1:2
    EVF(:,kk) = V0*prob(kk,:)';
end

tol = 0.0001;
err = 2;
iter = 0;
while err > tol
    for kk = 1:2 % Loop over Today's Income Levels
        % Here have used Kronecker product to save a loop over assets
        % today and tomorrow
        Objgrid = Ut(:,:,kk) + betta*kron(ones(N,1),EVF(:,kk)');
        for ii = 1:N
            % Loop Over Today's assets to find max of Value Function
            [V1(ii,kk),PF(ii,kk)] = max(Objgrid(ii,:));
        end
    end
    for kk = 1:2
        % Loop over Today's Income to Solve for Expected Value Function
        EVF(:,kk) = V1*prob(kk,:)';
        % To be used as the next guess for the value function
    end
    iter = iter + 1;
    err = norm(V1(:) - V0(:));
    iter10 = mod(iter,10);
    V0 = V1;
    % disp(iter)
end

AF = zeros(size(PF));
CF = zeros(size(PF));
for kk = 1:2
    for ii = 1:N
        a = a_grid(ii);
        ap = a_grid(PF(ii,kk));
        z= income(kk);
        AF(ii,kk) = ap;
        CF(ii,kk) = z + a*(1+r) -ap;
    end
end