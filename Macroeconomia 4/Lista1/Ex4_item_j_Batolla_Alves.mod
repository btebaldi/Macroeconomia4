//Problem set 1,ex 4 macro 4 item j

//Fernanda Batolla

//Renan Alves


var
y
c
r   //juros real
w
n
m
i    //juros nominal
pi
a
nu
;

varexo ea em;

parameters sigma rho varphi alpha beta eta phi_pi rho_m rho_a sigma_a sigma_m;

// Calibration
alpha   = 0.25;
beta    = 0.99;
sigma   = 1;
varphi  = 5;
eta     = 3.77;
phi_pi  = 1.5;
rho_m   = 0.5;
rho_a   = 0.9;
sigma_a = 0.01;
sigma_m =  0.01;



//First Order Conditions

model(linear);
//Eq de Euller #1
c = c(+1) - (1/sigma)*(r);

//Eq de Fisher   #2
r = i -pi(+1);

//Oferta de trabalho  #3
w = sigma*c + varphi*n;

//Restricao de Recursos #4
y = c;

//Funcao de Producao  #5
y = a + (1-alpha)*n;

//Demanda por trabalho  #6
w = a - alpha*n;

//Demanda por moeda  #7
m = y - eta*i;

//Regra de Politica Monetaria #8
i = phi_pi*pi + nu;

//Choque de tecnologia #9
a = rho_a*a(-1) - ea;

//Choque de Politica Monetaria  #10
nu = rho_m*nu(-1) + em;

end;

// define shock variances
shocks;
var ea = sigma_a^2;
var em = sigma_m^2;
end;

steady;
check;

stoch_simul(order = 1,irf=40, nograph);

//For shocks in ea
figure(1)
subplot(3,3,1)
plot(y_ea)
title('y')
hold on

subplot(3,3,2)
plot(c_ea)
title('c')
hold on

subplot(3,3,3)
plot(n_ea)
title('n')
hold on

subplot(3,3,4)
plot(w_ea)
title('w')
hold on

subplot(3,3,5)
plot(r_ea)
title('r')
hold on

subplot(3,3,6)
plot(i_ea)
title('i')
hold on

subplot(3,3,7)
plot(pi_ea)
title('pi')
hold on

subplot(3,3,8)
plot(m_ea)
title('m')
hold on

subplot(3,3,9)
plot(a_ea)
title('a')
hold on

//For shocks in em
figure(2)
subplot(2,2,1)
plot(i_em)
title('i')
hold on

subplot(2,2,2)
plot(pi_em)
title('pi')
hold on

subplot(2,2,3)
plot(m_em)
title('m')
hold on

subplot(2,2,4)
plot(nu_em)
title('nu')
hold on














