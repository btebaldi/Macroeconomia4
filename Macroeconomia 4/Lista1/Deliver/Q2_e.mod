/*
 * Exercicio 2 da lista 1 de Macro 4
 * Bruna Mirelle J. Silva
 * Bruno Tebaldi Q. Barbosa
 * Matheus A. Melo 
 */


//Declarando as variáveis endógenas do modelo
var c   //consumo
    k   //capital
    y   // produto
    i   // investimento
    z; //produtividade
    
varexo ez;

parameters alpha  //participação do capital na renda
           beta   //taxa de desconto intertemporal
           delta  // taxa de depreciacao do capita
           sigma  //elasticidade de substituicao interntemporal
           phi_1  //coeficiente autoregressivo de ordem 1 do choque
           phi_2  //coeficiente autoregressivo de ordem 2 do choque
        ; 
   
//Letra b) 
//A ideia desta questao é mostrar que o Dynare pode encontrar o steady state
//pra voce. Mesmo variando as condicoes iniciais o ss encontrado sera o mesmo
//Aqui e a calibracao
alpha=0.3; 
beta=0.95; 
delta=0.05; 
sigma=1; 
phi_1=0.94; 
phi_2=0;
 

//Agora vamos colocar as FOCs que calculamos no item a

model;
//Estamos usando o comando model. Precisamos log linearizar o modelo e para 
//isso vamos colocar a variável em exp (pois o dynare só lineariza)

//equacao 3 Eq. de Euller
exp(c)^(-sigma)=beta*( exp(c(+1))^(-sigma) )*(alpha*exp(z(+1))*( exp(k)^(alpha-1) )+(1-delta));

//equacao 4  Eq. de Movimentacao do Capital
exp(k)=exp(z)*( exp(k(-1))^(alpha) )-exp(c)+(1-delta)*exp(k(-1));

// FUncao de Producao
exp(y) = exp(z)*( exp(k(-1))^(alpha) );

// Investimento
exp(i) = exp(y) - exp(c);

//equacaco do AR(2)
//log(z)=phi_1*log(z(-1))+phi_2*log(z(-2))+ez;
z=phi_1*z(-1)+phi_2*z(-2)+ez;

end; //sempre colocar end para terminar o modelo

initval; //vamos chutar os valores para o chute inicial

k=3;
c=0.75;
z=0;
y = 0.5;
i = 1;
ez=0;

end;
steady;
check;

shocks;
var ez=0.01^2;
end;

stoch_simul(order=1, irf=30);




