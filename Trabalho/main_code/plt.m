function plt(kkap,ff,I,I1,f3,f1,f4,phi1,phi2,rhoR,rho,kap,bet,gam,N,g,k,l,Ghat,sig,p,rl,tt)

subplot(221)
plot(kkap(I),ff(I),kkap(I1),ff(I1),'*')
text(kkap(I(2)),ff(I(2)),['dY/dG at baseline: ',num2str(ff(I1))])
title('dY/dG')
xlabel(tt)
axis tight
subplot(222)
plot(kkap(I),100*f3(I),kkap(I1),100*f3(I1),'*')
title('Yhatl')
ylabel('% deviation from ss')
xlabel(tt)
axis tight
subplot(223)
plot(kkap(I),f1(I),kkap(I1),f1(I1),'*')
title('Zl')
xlabel(tt)
axis tight
subplot(224)
plot(kkap(I),400*f4(I),kkap(I1),400*f4(I1),'*')
title('inflation')
ylabel('APR')
xlabel(tt)
axis tight

str=['benchmark parameter values: \phi_{1} = ',num2str(phi1),', \phi_{2} = ',num2str(phi2),', \rho_{R} = ',num2str(rhoR) ...
    ,', \rho = ',num2str(rho),', \kappa = ',num2str(kap),', \beta = ',num2str(bet) ...
    ,', \gamma = ',num2str(gam),', N = ',num2str(N),', g = ',num2str(g) ...
    ,', k = ',num2str(k),', l = ',num2str(l),', Ghat = ',num2str(Ghat),', sig = ',num2str(sig), ...
    ', p = ',num2str(p),', r^l (APR) = ',num2str(400*rl)];
hout=suptitle(str);
