function [V0, U_Cube, Policy] = SolveConsumerProblem(Asset, Labor, WageShocks, wage, eco_param, displayInfo, displayIter)
    
    % Fill in unset optional values.
    switch nargin
        case {5}
            displayInfo = 0;
            displayIter = 0;
        case 6
            displayIter = 0;
    end
    
    
    if displayInfo == 1
        fprintf('Beging solving Consumer Problem.\n');
    end
    
    U_Cube_1 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(1), eco_param);
    U_Cube_2 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(2), eco_param);
    U_Cube_3 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(3), eco_param);
    U_Cube_4 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(4), eco_param);
    U_Cube_5 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(5), eco_param);
    U_Cube_6 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(6), eco_param);
    U_Cube_7 = UtilityCube(Asset.Values, Labor.Values, wage*WageShocks.Values(7), eco_param);
    
    % define vetor inicial de chutes (lin:asset col:income)
    V_star_1 = zeros(Asset.Grid.N, 1);
    V_star_2 = zeros(Asset.Grid.N, 1);
    V_star_3 = zeros(Asset.Grid.N, 1);
    V_star_4 = zeros(Asset.Grid.N, 1);
    V_star_5 = zeros(Asset.Grid.N, 1);
    V_star_6 = zeros(Asset.Grid.N, 1);
    V_star_7 = zeros(Asset.Grid.N, 1);
    
    % Initializa a condicao de parada das interacoes (um para cada estado)
    check=ones(1, 7);
    
    % inicializa os vetores de politica (K x z)
    policyIndex_L = nan(Asset.Grid.N, 7);
    policyIndex_A = nan(Asset.Grid.N, 7);
    
    Test_param.tolerance = 0.0001;
    Test_param.error = 1;
    nIter = 0;
    if displayIter==1
        fprintf('_______________________________________\n');
        fprintf('Interação      | eps (%f)\n', Test_param.tolerance);
        fprintf('---------------------------------------\n');
    end
    while Test_param.error > Test_param.tolerance
        % Incrementa o contador de interacoes
        nIter = nIter + 1;
        
        % CALCULA AS MATRIZES DE MEDIA DO TVi
        TV1_average = WageShocks.PI(1,1)*V_star_1 + ...
            WageShocks.PI(1,2)*V_star_2 + ...
            WageShocks.PI(1,3)*V_star_3 + ...
            WageShocks.PI(1,4)*V_star_4 + ...
            WageShocks.PI(1,5)*V_star_5 + ...
            WageShocks.PI(1,6)*V_star_6 + ...
            WageShocks.PI(1,7)*V_star_7;
        
        TV2_average = WageShocks.PI(2,1)*V_star_1 + ...
            WageShocks.PI(2,2)*V_star_2 + ...
            WageShocks.PI(2,3)*V_star_3 + ...
            WageShocks.PI(2,4)*V_star_4 + ...
            WageShocks.PI(2,5)*V_star_5 + ...
            WageShocks.PI(2,6)*V_star_6 + ...
            WageShocks.PI(2,7)*V_star_7;
        
        TV3_average = WageShocks.PI(3,1)*V_star_1 + ...
            WageShocks.PI(3,2)*V_star_2 + ...
            WageShocks.PI(3,3)*V_star_3 + ...
            WageShocks.PI(3,4)*V_star_4 + ...
            WageShocks.PI(3,5)*V_star_5 + ...
            WageShocks.PI(3,6)*V_star_6 + ...
            WageShocks.PI(3,7)*V_star_7;
        
        TV4_average = WageShocks.PI(4,1)*V_star_1 + ...
            WageShocks.PI(4,2)*V_star_2 + ...
            WageShocks.PI(4,3)*V_star_3 + ...
            WageShocks.PI(4,4)*V_star_4 + ...
            WageShocks.PI(4,5)*V_star_5 + ...
            WageShocks.PI(4,6)*V_star_6 + ...
            WageShocks.PI(4,7)*V_star_7;
        
        TV5_average = WageShocks.PI(5,1)*V_star_1 + ...
            WageShocks.PI(5,2)*V_star_2 + ...
            WageShocks.PI(5,3)*V_star_3 + ...
            WageShocks.PI(5,4)*V_star_4 + ...
            WageShocks.PI(5,5)*V_star_5 + ...
            WageShocks.PI(5,6)*V_star_6 + ...
            WageShocks.PI(5,7)*V_star_7;
        
        TV6_average = WageShocks.PI(6,1)*V_star_1 + ...
            WageShocks.PI(6,2)*V_star_2 + ...
            WageShocks.PI(6,3)*V_star_3 + ...
            WageShocks.PI(6,4)*V_star_4 + ...
            WageShocks.PI(6,5)*V_star_5 + ...
            WageShocks.PI(6,6)*V_star_6 + ...
            WageShocks.PI(6,7)*V_star_7;
        
        TV7_average = WageShocks.PI(7,1)*V_star_1 + ...
            WageShocks.PI(7,2)*V_star_2 + ...
            WageShocks.PI(7,3)*V_star_3 + ...
            WageShocks.PI(7,4)*V_star_4 + ...
            WageShocks.PI(7,5)*V_star_5 + ...
            WageShocks.PI(7,6)*V_star_6 + ...
            WageShocks.PI(7,7)*V_star_7;
        
        % Dimensionaliza as matrizes
        % Atencao, inverto TV1_average pois ele eh funcao de k
        V_cube_1 = repmat(TV1_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_2 = repmat(TV2_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_3 = repmat(TV3_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_4 = repmat(TV4_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_5 = repmat(TV5_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_6 = repmat(TV6_average', Labor.Grid.N, 1, Asset.Grid.N);
        V_cube_7 = repmat(TV7_average', Labor.Grid.N, 1, Asset.Grid.N);
        
        
        % Finds the new TV1
        [TV_1, policyIndex_L(:,1), policyIndex_A(:,1)] = TV_op(U_Cube_1.Values, eco_param, V_cube_1);
        [TV_2, policyIndex_L(:,2), policyIndex_A(:,2)] = TV_op(U_Cube_2.Values, eco_param, V_cube_2);
        [TV_3, policyIndex_L(:,3), policyIndex_A(:,3)] = TV_op(U_Cube_3.Values, eco_param, V_cube_3);
        [TV_4, policyIndex_L(:,4), policyIndex_A(:,4)] = TV_op(U_Cube_4.Values, eco_param, V_cube_4);
        [TV_5, policyIndex_L(:,5), policyIndex_A(:,5)] = TV_op(U_Cube_5.Values, eco_param, V_cube_5);
        [TV_6, policyIndex_L(:,6), policyIndex_A(:,6)] = TV_op(U_Cube_6.Values, eco_param, V_cube_6);
        [TV_7, policyIndex_L(:,7), policyIndex_A(:,7)] = TV_op(U_Cube_7.Values, eco_param, V_cube_7);
        
        % Sets the new numerical value for the stopping rule
        check(1) = norm(TV_1 - V_star_1)/norm(V_star_1);
        check(2) = norm(TV_2 - V_star_2)/norm(V_star_2);
        check(3) = norm(TV_3 - V_star_3)/norm(V_star_3);
        check(4) = norm(TV_4 - V_star_4)/norm(V_star_4);
        check(5) = norm(TV_5 - V_star_5)/norm(V_star_5);
        check(6) = norm(TV_6 - V_star_6)/norm(V_star_6);
        check(7) = norm(TV_7 - V_star_7)/norm(V_star_7);
        
        Test_param.error = max(check);
        
        % Sets V to be the last TV we found
        V_star_1 = TV_1;
        V_star_2 = TV_2;
        V_star_3 = TV_3;
        V_star_4 = TV_4;
        V_star_5 = TV_5;
        V_star_6 = TV_6;
        V_star_7 = TV_7;
        
        if (displayIter==1) & (mod(nIter, 25) == 0)
            fprintf('  %13d| %12.10f \n', nIter, max(check));
        end
    end
    if displayIter==1
        fprintf('_______________________________________\n');
        fprintf('Total   %7d| %12.10f\n', nIter, max(check));
        fprintf('---------------------------------------\n');
    end
    
    V0=[V_star_1 V_star_2 V_star_3 V_star_4 V_star_5 V_star_6 V_star_7];
    
    U_Cube=[U_Cube_1 U_Cube_2 U_Cube_3 U_Cube_4 U_Cube_5 U_Cube_6 U_Cube_7];
    
    % DEFINICAO DAS POLITICAS
    Policy.AssetDomain = Asset.Values;
    Policy.LaborDomain = Labor.Values;
    
    Policy.AssetPrime.Index = policyIndex_A;
    Policy.Labor.Index = policyIndex_L;
    
    Policy.AssetPrime.Values = Policy.AssetDomain(Policy.AssetPrime.Index );
    Policy.Labor.Values = Policy.LaborDomain(Policy.Labor.Index);
    
    Policy.Wealth.Values = Asset.Values'*ones(1,7).*(1 + eco_param.r) ...
        + Policy.Labor.Values * diag(wage*WageShocks.Values);
    
    Policy.Consumption.Values = Asset.Values'*ones(1,7).*(1 + eco_param.r) ...
        + Policy.Labor.Values * diag(wage*WageShocks.Values) ...
        - Policy.AssetPrime.Values;
    
    Policy.Wages.Values = Policy.Labor.Values * diag(wage*WageShocks.Values);
    
    Policy.Asset.Values = Asset.Values'*ones(1,7);
    
    if displayInfo == 1
        fprintf('\nEnd of Consumer Problem.\n');
    end
end % end of fucntion