function [hss, kss, yss, css] = ComputeSteadyState(hss, p, z)
    
    % Check number of inputs.
    %     narginchk(3,7)
    
    % Fill in unset optional values.
    switch nargin
        case {2}
            z=1;
    end
    
    kss = ((p.beta .* z .* p.alpha .* hss.^(1-p.alpha)) / (1 -p.beta.*(1-p.delta))).^(1/(1-p.alpha));
    [css, yss]= Consumption(kss, kss, hss, p, z);
    
end %end of function ComputeSteadyState