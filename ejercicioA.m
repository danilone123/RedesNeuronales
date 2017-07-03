

%numero de muestras
n = 100000;
alpha = 3;
sigma = 100/3;
eta = 0.9;
e = rand(1,n).^(1/(alpha+1)); %muestras reales
neuronas = 100;
w = (rand(1,neuronas));
count = 0;
for i =1:n
    [minimo,ganadorW]=min(abs(w - e(i)));
    if i<=100000 %modificar todos los pesos
    vecindadF = exp(-((linspace(1,neuronas,neuronas)-ganadorW).^2)/(2*sigma^2));
    deltaW = eta * vecindadF' .* (e(i)-w)';
    w = w+ deltaW';
    end
%     if i>50000 && i<99000 
%         rango = 5;
%         limite1= max(1, ganadorW - rango);
%         limite2 = min(neuronas,ganadorW + rango);
%         numeroPos = limite2-limite1 + 1;
%         posiciones = linspace(limite1,limite2,numeroPos);
%         vecindadF = exp(-((posiciones-ganadorW).^2)/(2*sigma^2));        
%         deltaW = eta * vecindadF'.*(e(i)-w(posiciones))';
%         w(posiciones) = w(posiciones) + deltaW';
%     end
%     if i>=99000%update solamente la ganadora funcion vecindad es 1
%         vecindadF = exp(-((ganadorW-ganadorW).^2)/(2*sigma^2)); 
%         deltaW = eta * vecindadF.*(e(i)-w(ganadorW));
%         w(ganadorW) = w(ganadorW) + deltaW;
%     end
    count = count + 1;
    if rem(count,80)==0
       sigma = sigma*0.99;
    end
end

beta = 1/(1+((2/3)*alpha));
plot(linspace(0,1,neuronas), w, 'xr',...
    linspace(0,1,neuronas), linspace(0,1,neuronas).^beta);
grid on;
