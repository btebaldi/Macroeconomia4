function out = PlotStuff(Data, Legenda, x_lim)
ncol = 3;
% ceil : arredonda para o inteiro acima. ceil(0.1) = 1
nrow = ceil(numel(Legenda)/ncol); 
f1 = figure;
for i=1:numel(Legenda)
    subplot(nrow,ncol,i)
    plot(Data(:,i))
    title(Legenda(i));
    xlim([0,x_lim]);
%     ylim([0 inf]);
end

out = f1;
end % end of function