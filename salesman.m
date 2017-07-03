clear;
sigma = 15/3;
eta = 0.5;
numeroCiudades = 500;
numeroNeuronas = numeroCiudades*2;


ciudades = rand(2,numeroCiudades)';

figure(1)
sc =scatter(ciudades(:,1)*150,ciudades(:,2)*150, 60) ;

theta = linspace(0,2*pi,numeroNeuronas);%2*pi*rand(1,n);
vecindadF = zeros(1,numeroNeuronas);
posCiudades = [(cos(theta))' (sin(theta))'];
w = [rand(1,numeroNeuronas)' rand(1,numeroNeuronas)'];
count = 1;
while (count<5000)
for i = 1:numeroCiudades
 
    [col,m]=min(((w(:,1)-ciudades(i,1)).^2 + (w(:,2)-ciudades(i,2)).^2));
    posGanadora= [m,m];
    %for j = 1:neuronas
        for z = 1:numeroNeuronas
            d1 = (posCiudades(z,1) - posCiudades(m,1))^2;
            d2 = (posCiudades(z,2) - posCiudades(m,2))^2;
            dfinal = sqrt(d1+d2);
            vecindadF(1,z) = exp(-(dfinal*dfinal)/(2*sigma^2));
        end
    %end
    deltaX = eta * vecindadF' .* (ciudades(i,1)-w(:,1));
    deltaY = eta * vecindadF' .* (ciudades(i,2)-w(:,2));
    %deltaW = eta * vecindadF' .* (e(i)-w)';
    w(:,1) = w(:,1) + deltaX;
    w(:,2) = w(:,2) + deltaY;
     if rem(i,500)==0
       sigma = sigma*0.99;
     end
    if rem(i,300)==0
     clf
        sc =scatter(ciudades(:,1)*150,ciudades(:,2)*150, 60) ;
        %hold on;
        %figure(1)
         grid minor
       %ylim([-15 150]);
       %xlim([-15 150]);
        for j = 1:numeroNeuronas-1
            
        line([w(j,1)*150 w(j+1,1)*150],[w(j,2)*150 w(j+1,2)*150], 'LineWidth', 2);
        end
        pause(0.001);
    end
end
count = count + 1;
    if rem(count,1)==0
        
       
    end
end



%     mind = 1000;
%     menorIndice = -1;
%     for ll = 1:numeroNeuronas
%        distanciaminima = (((w(ll,1)-ciudades(i,1)).^2 + (w(ll,2)-ciudades(i,2)).^2));
%        if distanciaminima<mind
%            mind = distanciaminima;
%            menorIndice = ll;
%        end
%     end