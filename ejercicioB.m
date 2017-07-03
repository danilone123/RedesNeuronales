%numero de muestras
n = 30000;
neuronas = 20;
sigma = 20/3;
%matriz pesos
eta = 0.5;

circ = linspace(0,2*pi,n);

%radio
R = 1;
r = R*sqrt(rand(1,n));
%angulo
theta = 2*pi*rand(1,n);
%entradas
e = [(r.*cos(theta))' (r.*sin(theta))'];
hold on;
 %plot(e(:,1),e(:,2),'g.')
 %axis([-1.1*R 1.1*R -1.1*R 1.1*R])
axis square
title('Right')
%2 entradas
w = (rand(neuronas,neuronas,2)*2-1);

line(w(:,:,1),w(:,:,2), 'LineWidth', 2);
line(w(:,:,1).',w(:,:,2).', 'LineWidth', 2');

pause(0.6);
grid on;
%r1(n)*cos(theta1(n));
%//rand(2,n).^(1/(alpha+1));
vecindadF = zeros(neuronas,neuronas);
count = 0;
for i = 1:n
    
    [col,m]=min(sqrt((w(:,:,1)-e(i,1)).^2 + (w(:,:,2)-e(i,2)).^2));
    [~,columnGanadora] = min(col);
    posGanadora= [m(columnGanadora),columnGanadora];
    for j = 1:neuronas
        for z = 1:neuronas
            vecindadF(j,z) = exp(-( (j-posGanadora(1)).^2 + (z-posGanadora(2)).^2 )/(2*sigma^2));
        end
    end
    deltaX = eta * vecindadF .* (e(i,1)-w(:,:,1));
    deltaY = eta * vecindadF .* (e(i,2)-w(:,:,2));
    %deltaW = eta * vecindadF' .* (e(i)-w)';
    w(:,:,1) = w(:,:,1) + deltaX;
    w(:,:,2) = w(:,:,2) + deltaY;
    
   
    
    count = count + 1;
    if rem(count,150)==0
       sigma = sigma*0.99;
    end
    if i<300
        %figure(1)

        clf
         hold on
        line(w(:,:,1),w(:,:,2), 'LineWidth', 2);
        line(w(:,:,1).',w(:,:,2).', 'LineWidth', 2);
     
        grid minor
       ylim([-1.1 1.1])
       xlim([-1.1 1.1])
     
        plot(e(1:i,1),e(1:i,2),'g.')
        pause(0.001);
    end
    if rem(count,600)==0
        %figure(1)

        clf
         hold on
        line(w(:,:,1),w(:,:,2), 'LineWidth', 2);
        line(w(:,:,1).',w(:,:,2).', 'LineWidth', 2);
        grid minor
        ylim([-1.1 1.1])
        xlim([-1.1 1.1])
     
        plot(e(1:i,1),e(1:i,2),'g.')
        pause(0.001);
    end
end


