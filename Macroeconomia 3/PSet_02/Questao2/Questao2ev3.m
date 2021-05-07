% ATENCAO ESSE SCRITPT ESTA SEM AS ULTIMAS ALTERACOES.
% FAVOR OLHAR O CODIGO NO REPORT PARA VERIFICAR AS ALTERACOES FEITAS.


%% SECTION I: Parameters

% limpeza de variaveis antigas
clear all
clc

% Inicia o Cronometro
tic

econom_param.beta=0.987;
econom_param.mu=2;
econom_param.alpha = 1/3;
econom_param.delta = 0.012;
econom_param.gamma = 0.386810;

test_param.T = 101;
test_param.epsilon = 1e-6;
test_param.mkv.rho = 0.95;
test_param.mkv.sigma = 0.007;
test_param.mkv.r = 3;
test_param.mkv.N = 7;
test_param.mkv.mu = 0;

% Calcula os choques do estado de Mkv
mkv = MarkovProcess(test_param.mkv.rho, test_param.mkv.sigma, test_param.mkv.r, test_param.mkv.N, test_param.mkv.mu);
z.values = exp(mkv.StateVector);
z.TransitionMatrix = mkv.TransitionMatrix;

h_ss =1/3;
[h_ss, k_ss, y_ss, c_ss] = ComputeSteadyState(h_ss, econom_param);

fprintf('Time (Parameters): %.2f [secs]\n', toc);
%% SECTION II: Bellman Function


% Calcula a Utilidade em um "cubo" de grid de variaveis.
% (1)-axis: k1
% (2)-axis: h
% (3)-axis: k
U_1 = Utility(k_ss, econom_param, test_param, z.values(1));
U_2 = Utility(k_ss, econom_param, test_param, z.values(2));
U_3 = Utility(k_ss, econom_param, test_param, z.values(3));
U_4 = Utility(k_ss, econom_param, test_param, z.values(4));
U_5 = Utility(k_ss, econom_param, test_param, z.values(5));
U_6 = Utility(k_ss, econom_param, test_param, z.values(6));
U_7 = Utility(k_ss, econom_param, test_param, z.values(7));
fprintf('Time (Utility Determination): %.2f [secs]\n', toc);

% Inicializacao dos sete vetores da value function
V_star_1 = zeros(test_param.T, 1);
V_star_2 = zeros(test_param.T, 1);
V_star_3 = zeros(test_param.T, 1);
V_star_4 = zeros(test_param.T, 1);
V_star_5 = zeros(test_param.T, 1);
V_star_6 = zeros(test_param.T, 1);
V_star_7 = zeros(test_param.T, 1);

% Initializa a condicao de parada das interacoes (um para cada estado)
check=ones(1,test_param.mkv.N);

% Initializa o contador de interacoes
nContador=0;

fprintf('_______________________________________\n');
fprintf('Interação      | Time   | eps (%f)\n', test_param.epsilon);
fprintf('---------------------------------------\n');

% inicializa os vetores de politica (k x z)
policyIndex_h = nan(size(U_1.k_domain, 2), mkv.QtdStates);
policyIndex_k = nan(size(U_1.h_domain, 2), mkv.QtdStates);


while min(check) > test_param.epsilon
    % Incrementa o numero de interacoes
    nContador = nContador + 1;
    
    
    % CALCULA AS MATRIZES DE MEDIA DO TVi
    TV1_average = z.TransitionMatrix(1,1)*V_star_1 + ...
        z.TransitionMatrix(1,2)*V_star_2 + ...
        z.TransitionMatrix(1,3)*V_star_3 + ...
        z.TransitionMatrix(1,4)*V_star_4 + ...
        z.TransitionMatrix(1,5)*V_star_5 + ...
        z.TransitionMatrix(1,6)*V_star_6 + ...
        z.TransitionMatrix(1,7)*V_star_7;
    
    TV2_average = z.TransitionMatrix(2,1)*V_star_1 + ...
        z.TransitionMatrix(2,2)*V_star_2 + ...
        z.TransitionMatrix(2,3)*V_star_3 + ...
        z.TransitionMatrix(2,4)*V_star_4 + ...
        z.TransitionMatrix(2,5)*V_star_5 + ...
        z.TransitionMatrix(2,6)*V_star_6 + ...
        z.TransitionMatrix(2,7)*V_star_7;
    
    TV3_average = z.TransitionMatrix(3,1)*V_star_1 + ...
        z.TransitionMatrix(3,2)*V_star_2 + ...
        z.TransitionMatrix(3,3)*V_star_3 + ...
        z.TransitionMatrix(3,4)*V_star_4 + ...
        z.TransitionMatrix(3,5)*V_star_5 + ...
        z.TransitionMatrix(3,6)*V_star_6 + ...
        z.TransitionMatrix(3,7)*V_star_7;
    
    TV4_average = z.TransitionMatrix(4,1)*V_star_1 + ...
        z.TransitionMatrix(4,2)*V_star_2 + ...
        z.TransitionMatrix(4,3)*V_star_3 + ...
        z.TransitionMatrix(4,4)*V_star_4 + ...
        z.TransitionMatrix(4,5)*V_star_5 + ...
        z.TransitionMatrix(4,6)*V_star_6 + ...
        z.TransitionMatrix(4,7)*V_star_7;
    
    TV5_average = z.TransitionMatrix(5,1)*V_star_1 + ...
        z.TransitionMatrix(5,2)*V_star_2 + ...
        z.TransitionMatrix(5,3)*V_star_3 + ...
        z.TransitionMatrix(5,4)*V_star_4 + ...
        z.TransitionMatrix(5,5)*V_star_5 + ...
        z.TransitionMatrix(5,6)*V_star_6 + ...
        z.TransitionMatrix(5,7)*V_star_7;
    
    TV6_average = z.TransitionMatrix(6,1)*V_star_1 + ...
        z.TransitionMatrix(6,2)*V_star_2 + ...
        z.TransitionMatrix(6,3)*V_star_3 + ...
        z.TransitionMatrix(6,4)*V_star_4 + ...
        z.TransitionMatrix(6,5)*V_star_5 + ...
        z.TransitionMatrix(6,6)*V_star_6 + ...
        z.TransitionMatrix(6,7)*V_star_7;
    
    TV7_average = z.TransitionMatrix(7,1)*V_star_1 + ...
        z.TransitionMatrix(7,2)*V_star_2 + ...
        z.TransitionMatrix(7,3)*V_star_3 + ...
        z.TransitionMatrix(7,4)*V_star_4 + ...
        z.TransitionMatrix(7,5)*V_star_5 + ...
        z.TransitionMatrix(7,6)*V_star_6 + ...
        z.TransitionMatrix(7,7)*V_star_7;
    
    
    % Dimensionaliza as matrizes
    % Atencao, inverto TV1_average pois ele eh funcao de k
    V_cube_1 = repmat(TV1_average', test_param.T, 1, test_param.T);
    V_cube_2 = repmat(TV2_average', test_param.T, 1, test_param.T);
    V_cube_3 = repmat(TV3_average', test_param.T, 1, test_param.T);
    V_cube_4 = repmat(TV4_average', test_param.T, 1, test_param.T);
    V_cube_5 = repmat(TV5_average', test_param.T, 1, test_param.T);
    V_cube_6 = repmat(TV6_average', test_param.T, 1, test_param.T);
    V_cube_7 = repmat(TV7_average', test_param.T, 1, test_param.T);
    
    
    % Finds the new TV1
    [TV_1, policyIndex_h(:,1), policyIndex_k(:,1)] = TV_op(U_1.Value, econom_param, V_cube_1);
    [TV_2, policyIndex_h(:,2), policyIndex_k(:,2)] = TV_op(U_2.Value, econom_param, V_cube_2);
    [TV_3, policyIndex_h(:,3), policyIndex_k(:,3)] = TV_op(U_3.Value, econom_param, V_cube_3);
    [TV_4, policyIndex_h(:,4), policyIndex_k(:,4)] = TV_op(U_4.Value, econom_param, V_cube_4);
    [TV_5, policyIndex_h(:,5), policyIndex_k(:,5)] = TV_op(U_5.Value, econom_param, V_cube_5);
    [TV_6, policyIndex_h(:,6), policyIndex_k(:,6)] = TV_op(U_6.Value, econom_param, V_cube_6);
    [TV_7, policyIndex_h(:,7), policyIndex_k(:,7)] = TV_op(U_7.Value, econom_param, V_cube_7);
    
    %     test_param.Howard
    if 1==1
        TVh_1 = TV_1;
        TVh_2 = TV_2;
        TVh_3 = TV_3;
        TVh_4 = TV_4;
        TVh_5 = TV_5;
        TVh_6 = TV_6;
        TVh_7 = TV_7;
        
        for i=1:20
            
            % Calcula o consumo para cada ponto do grid
            Uh.Consumption1 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,1)), U_1.h_domain(policyIndex_h(:,1)), econom_param, z.values(1));
            Uh.Consumption2 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,2)), U_1.h_domain(policyIndex_h(:,2)), econom_param, z.values(2));
            Uh.Consumption3 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,3)), U_1.h_domain(policyIndex_h(:,3)), econom_param, z.values(3));
            Uh.Consumption4 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,4)), U_1.h_domain(policyIndex_h(:,4)), econom_param, z.values(4));
            Uh.Consumption5 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,5)), U_1.h_domain(policyIndex_h(:,5)), econom_param, z.values(5));
            Uh.Consumption6 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,6)), U_1.h_domain(policyIndex_h(:,6)), econom_param, z.values(6));
            Uh.Consumption7 = Consumption(U_1.k_domain, U_1.k_domain(policyIndex_k(:,7)), U_1.h_domain(policyIndex_h(:,7)), econom_param, z.values(7));
            
            % caso o consumo seja negativo imponho consumo zero.
            Uh.Consumption1(Uh.Consumption1<0) = 0;
            Uh.Consumption2(Uh.Consumption2<0) = 0;
            Uh.Consumption3(Uh.Consumption3<0) = 0;
            Uh.Consumption4(Uh.Consumption4<0) = 0;
            Uh.Consumption5(Uh.Consumption5<0) = 0;
            Uh.Consumption6(Uh.Consumption6<0) = 0;
            Uh.Consumption7(Uh.Consumption7<0) = 0;
            
            g = econom_param.gamma;
            u = econom_param.mu;
            
            % Calcula a utilidade associada
            Uh.Value1 = (Uh.Consumption1.^g.*(1- U_1.h_domain(policyIndex_h(:,1))).^(1-g)).^(1-u)/(1-u);
            Uh.Value2 = (Uh.Consumption2.^g.*(1- U_1.h_domain(policyIndex_h(:,2))).^(1-g)).^(1-u)/(1-u);
            Uh.Value3 = (Uh.Consumption3.^g.*(1- U_1.h_domain(policyIndex_h(:,3))).^(1-g)).^(1-u)/(1-u);
            Uh.Value4 = (Uh.Consumption4.^g.*(1- U_1.h_domain(policyIndex_h(:,4))).^(1-g)).^(1-u)/(1-u);
            Uh.Value5 = (Uh.Consumption5.^g.*(1- U_1.h_domain(policyIndex_h(:,5))).^(1-g)).^(1-u)/(1-u);
            Uh.Value6 = (Uh.Consumption6.^g.*(1- U_1.h_domain(policyIndex_h(:,6))).^(1-g)).^(1-u)/(1-u);
            Uh.Value7 = (Uh.Consumption7.^g.*(1- U_1.h_domain(policyIndex_h(:,7))).^(1-g)).^(1-u)/(1-u);
            
            TVh_1 = Uh.Value1' + econom_param.beta .* TVh_1(policyIndex_k(:,1));
            TVh_2 = Uh.Value2' + econom_param.beta .* TVh_2(policyIndex_k(:,2));
            TVh_3 = Uh.Value3' + econom_param.beta .* TVh_3(policyIndex_k(:,3));
            TVh_4 = Uh.Value4' + econom_param.beta .* TVh_4(policyIndex_k(:,4));
            TVh_5 = Uh.Value5' + econom_param.beta .* TVh_5(policyIndex_k(:,5));
            TVh_6 = Uh.Value6' + econom_param.beta .* TVh_6(policyIndex_k(:,6));
            TVh_7 = Uh.Value7' + econom_param.beta .* TVh_7(policyIndex_k(:,7));
        end
        % Sets the new numerical value for the stopping rule
        check(1) = norm(TVh_1 - V_star_1)/norm(V_star_1);
        check(2) = norm(TVh_2 - V_star_2)/norm(V_star_2);
        check(3) = norm(TVh_3 - V_star_3)/norm(V_star_3);
        check(4) = norm(TVh_4 - V_star_4)/norm(V_star_4);
        check(5) = norm(TVh_5 - V_star_5)/norm(V_star_5);
        check(6) = norm(TVh_6 - V_star_6)/norm(V_star_6);
        check(7) = norm(TVh_7 - V_star_7)/norm(V_star_7);
        
        if  min(check) < test_param.epsilon
            break;
        end
        
    end
    
    % Sets the new numerical value for the stopping rule
    check(1) = norm(TV_1 - V_star_1)/norm(V_star_1);
    check(2) = norm(TV_2 - V_star_2)/norm(V_star_2);
    check(3) = norm(TV_3 - V_star_3)/norm(V_star_3);
    check(4) = norm(TV_4 - V_star_4)/norm(V_star_4);
    check(5) = norm(TV_5 - V_star_5)/norm(V_star_5);
    check(6) = norm(TV_6 - V_star_6)/norm(V_star_6);
    check(7) = norm(TV_7 - V_star_7)/norm(V_star_7);
    
    % Sets V to be the last TV we found
    V_star_1 = TV_1;
    V_star_2 = TV_2;
    V_star_3 = TV_3;
    V_star_4 = TV_4;
    V_star_5 = TV_5;
    V_star_6 = TV_6;
    V_star_7 = TV_7;
    
    if mod(nContador, 2) == 0
        fprintf('  %13d| %6.2f | %12.10f\n', nContador, toc, max(check));
    elseif nContador > 1000
        error('Howard''s Method failed to converge')
    end
end

fprintf('_______________________________________\n');
fprintf('Total   %7d| %6.2f | %12.10f\n', nContador, toc, max(check));
fprintf('---------------------------------------\n');

fprintf('Time (Bellman function): %.2f [secs]\n', toc);

%% Determinação das policy functions

% policy_h(k_index, z_index) = h_index
% policy_k(k_index, z_index) = k_index
PolicyFunction.h_domain = U_1.h_domain;
PolicyFunction.k_domain = U_1.k_domain;

PolicyFunction.k = PolicyFunction.k_domain([1:test_param.T]'*ones(1,test_param.mkv.N));

PolicyFunction.k1 = U_1.k_domain(policyIndex_k)
PolicyFunction.h = U_1.h_domain(policyIndex_h)

PolicyFunction.y = PolicyFunction.k.^econom_param.alpha .* PolicyFunction.h.^(1-econom_param.alpha)*diag(z.values);
PolicyFunction.c = PolicyFunction.y  ...
    + (1-econom_param.delta)*PolicyFunction.k + ...
    - PolicyFunction.k1;

PolicyFunction.i = PolicyFunction.y - PolicyFunction.c;

figure
plot(PolicyFunction.k_domain, PolicyFunction.h);

figure
plot(PolicyFunction.k_domain, PolicyFunction.k1);

figure
plot(PolicyFunction.k_domain, PolicyFunction.i);

figure
plot(PolicyFunction.k_domain, PolicyFunction.c);

figure
plot(PolicyFunction.k_domain, PolicyFunction.y);

figure
plot3(U_1.k_domain(policyIndex_k), U_1.h_domain(policyIndex_h), U_1.k_domain);
xlabel('k')
ylabel('h')
zlabel('k_prime')

plot( U_1.k_domain, policyIndex_h(:,[1 5 7]))

fprintf('Time (Policy function plot): %.2f [secs]\n',toc);

%% CALCULO DOS ERROS DE EULER


% Funcao de retorno efetivo
% R(kt,zt) = zg(zt)*F_Prime_k(kt,ht) + 1-econom_param.delta
% R = diag(z.values)* econom_param.alpha .* k1_f^
% Define a derivada da funcao de producao com relacao a k.
Matrix_F_1=econom_param.alpha.*PolicyFunction.k.^(econom_param.alpha-1).*PolicyFunction.h.^(1-econom_param.alpha)*diag(z.values);
ER = Matrix_F_1*z.TransitionMatrix';

U_prime = (PolicyFunction.c.^econom_param.gamma .* (1.-PolicyFunction.h).^(1-econom_param.gamma)).^(-econom_param.mu).*econom_param.gamma.*(1-PolicyFunction.h).^(1-econom_param.gamma).*PolicyFunction.c .^(econom_param.gamma -1);
EUprime = U_prime*z.TransitionMatrix';


% Estamos assumindo que U
Euler = log10(abs(1-(econom_param.beta.*ER.*EUprime).^(-1).*PolicyFunction.c.^(-1)));

EEE = mean(Euler);
fprintf('The average E.E.E. is:\n');
for i=1:test_param.mkv.N
    fprintf('Z(%d)\t%f\n',i,EEE(i));
end

