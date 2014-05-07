% GAUSSIAN & LoG KERNELS - 1D comparsion
clear all;
close all;

sigma = 4;

x = -1*sigma:0.01:5*sigma;
G = zeros(size(x));
LoG = zeros(size(x));
for i = 1:length(x)
    G(i) = exp(-(x(i)^2)/(2*sigma^2));
    LoG(i) = -((x(i)^2 - 2*sigma^2)/(sigma^4))*exp(-(x(i)^2)/(2*sigma^2));
end

G = G/max(G);
LoG = LoG/max(LoG);

factor = 0.01;
% ind_G e ind_LoG por amplitud:
% ind_G = find(abs(G)>factor*max(G),1,'last');
% ind_LoG = find(abs(LoG)>factor*max(LoG),1,'last');

area_G = cumtrapz(x,abs(G)); area_G = area_G/max(area_G);
area_LoG = cumtrapz(x,abs(LoG)); area_LoG = area_LoG/max(area_LoG);
% ind_G e ind_LoG por area:
ind_G = find(area_G>=(1-factor),1,'first');
ind_LoG = find(area_LoG>=(1-factor),1,'first');

h = figure('Name','Kernels comparsion','Color','white','Position',[100 100 800 500]);
plot(x,G,'-r','Linewidth',2); hold on; 
plot(x,LoG,'-b','Linewidth',2); axis tight;
title('Comparison of Gaussian and LoG functions');
plot(x(ind_G),G(ind_G),'*r','Linewidth',5);
plot(x(ind_LoG),LoG(ind_LoG),'*b','Linewidth',5);
% Líneas:
line([0 0],[min(LoG) max(LoG)],'Color','k');
line([-1*sigma 5*sigma],[0 0],'Color','k');
line([x(ind_G) x(ind_G)],[min(LoG) max(LoG)],'Color','r','LineStyle','--');
line([x(ind_LoG) x(ind_LoG)],[min(LoG) max(LoG)],'Color','b','LineStyle','--');
h2 = get(h,'Children');
set(h2,'XTick',[]); set(h2,'YTick',[]);
line([-1*sigma 5*sigma],[factor*max(LoG) factor*max(LoG)],'Color','k','LineStyle',':');
line([-1*sigma 5*sigma],[-factor*max(LoG) -factor*max(LoG)],'Color','k','LineStyle',':');
line([0 x(ind_G)],[0.6*max(G) 0.6*max(G)],'Color','k','Linewidth',2);
line([0 x(ind_LoG)],[0.3*max(G) 0.3*max(G)],'Color','k','Linewidth',2);
% Referencias
hleg = legend('Gaussian function','LoG function');
set(hleg,'box','Off');
% Texto:
text(-0.95*sigma,(factor+0.03)*max(LoG),'\pm3% of maximum absolute value','BackgroundColor','white');
text(sigma,0.6*max(G),[sprintf('~%1.2f',x(ind_G)/sigma) '\sigma'],'FontSize',12,'BackgroundColor','white');
text(1.2*sigma,0.3*max(G),[sprintf('~%1.2f',x(ind_LoG)/sigma) '\sigma'],'FontSize',12,'BackgroundColor','white');
% Save
% print(h,'-depsc','kernels.eps');