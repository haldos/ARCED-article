% GAUSSIAN & LoG KERNELS
clear all;
close all;

n1 = 25;
n2 = 31;
sigma = 4;

x1 = zeros(n1,n1); y1 = zeros(n1,n1);
x2 = zeros(n2,n2); y2 = zeros(n2,n2);

for i = 1:n1
    x1(:,i) = i-floor(n1/2)-1;
    y1(i,:) = i-floor(n1/2)-1;
end
for i = 1:n2
    x2(:,i) = i-floor(n2/2)-1;
    y2(i,:) = i-floor(n2/2)-1;
end

G = zeros(n1,n1);
LoG = zeros(n2,n2);

for i = 1:n1
    for j = 1:n1
        G(i,j) = exp(-(x1(i,j)^2 + y1(i,j)^2)/(2*sigma^2));
    end
end
for i = 1:n2
    for j = 1:n2
        LoG(i,j) = -((x2(i,j)^2 + y2(i,j)^2 - 2*sigma^2)/(sigma^4))*exp(-(x2(i,j)^2 + y2(i,j)^2)/(2*sigma^2));
    end
end


%xmin = -floor(n/2)-3;
%xmax = floor(n/2)+3;

a = figure('Name','Gaussian Kernel','Color','white');
h1 = subplot(2,3,[1 2 4 5]); surf(x1,y1,G); grid off; axis tight; axis off;
    hold on; plot3(zeros(n1,1),y1(:,1),G(ceil(n1/2),:),'-k','LineWidth',3); 
    text(0,0,1.1,'Gaussian kernel, 3D view','HorizontalAlignment','center'); hold off;
    p = get(h1, 'pos'); 
    p(1) = p(1) - 0.1; p(2) = p(2) + 0.05;
    p(3) = p(3) + 0.1; p(4) = p(4) + 0.1;
    set(h1, 'pos', p);
h2 = subplot(2,3,3); pcolor(x1,y1,G); axis square; axis off;
    p = get(h2, 'pos'); 
    p(1) = p(1) - 0.05; p(2) = p(2) - 0.05;
    p(3) = p(3) + 0.1; p(4) = p(4) + 0.1;
    set(h2, 'pos', p);
subplot(2,3,6); plot(x1(1,:),G(ceil(n1/2),:),'-k','LineWidth',2); 
    title('Gaussian kernel, 2D view','Position',[0 -0.2]);
    hold on; annotation('arrow',[0.65 0.95],[0.11 0.11],'LineWidth',1);
    annotation('arrow',[0.798 0.798],[0.1 0.5],'LineWidth',1);
    %annotation('arrow',[0.45 0.72],[0.30 0.20],'Color','red');
    axis tight; axis off; hold off;
print(a,'-depsc','kernel_gaussian.eps');

b = figure('Name','LoG Kernel','Color','white');
h3 = subplot(2,3,[1 2 4 5]); surf(x2,y2,LoG); grid off; axis tight; axis off;
    hold on; plot3(zeros(n2,1),y2(:,1),LoG(ceil(n2/2),:),'-k','LineWidth',3); 
    text(0,0,0.14,'LoG kernel, 3D view','HorizontalAlignment','center');hold off;
    p = get(h3, 'pos'); 
    p(1) = p(1) - 0.1; p(2) = p(2) + 0.05;
    p(3) = p(3) + 0.1; p(4) = p(4) + 0.1;
    set(h3, 'pos', p);
h4 = subplot(2,3,3); pcolor(x2,y2,LoG); axis square; axis off;
    p = get(h4, 'pos'); 
    p(1) = p(1) - 0.05; p(2) = p(2) - 0.05;
    p(3) = p(3) + 0.1; p(4) = p(4) + 0.1;
    set(h4, 'pos', p);
subplot(2,3,6); plot(x2(1,:),LoG(ceil(n2/2),:),'-k','LineWidth',2);
    title('LoG kernel, 2D view','Position',[0 -0.04]);
    hold on; annotation('arrow',[0.65 0.95],[0.149 0.149],'LineWidth',1);
    annotation('arrow',[0.798 0.798],[0.1 0.5],'LineWidth',1);
    %annotation('arrow',[0.4 0.72],[0.40 0.20],'Color','red');
    axis tight; axis off; hold off;
print(b,'-depsc','kernel_log.eps');