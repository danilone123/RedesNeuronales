%sen x + cos y + z
xmin=0;
xmax=2*pi;
n=10;

x=xmin+rand(1,n)*(xmax-xmin);
y= xmin+rand(1,n)*(xmax-xmin);                 
z =-1 + rand(1,n)*(1+1); 
Patrones = zeros(1000,4);
amount = 1;
for iX  = 1 : 10
    for jY = 1:10
        for zZ = 1:10
            Patrones(amount,:) = [x(iX) y(jY) z(zZ) 1];
            amount = amount + 1;
        end
    end
end

Salidas = (sin(Patrones(:,1)) + cos(Patrones(:,2)) + Patrones(:,3))/3;
Salidas = Salidas';
nPatrones= size(Patrones,1);
SalidasActuales = zeros(1,1000);
numeroCapas =2;
w1 = rand(10,4);
w2 = rand(1,11);
error = 10;
count = 0;
while(error > 0.8  && count<5000)
    listRandonPos = randperm(nPatrones);
    errorAcumulado = 0;
    % adelante
for i = listRandonPos%1: nPatrones
    entrada = Patrones(i,:);
    v = zeros(numeroCapas, 15);
    h = zeros(numeroCapas,15);

    [hSalida1,vSalida1] = calculateHEjercicio2(w1, entrada, size(v,2), 2);
    v(1,:) = vSalida1;
    h(1,:) = hSalida1;
    
    entradaCapaIntermedia  = [v(1,:) 1];
    [hSalida2,vSalida2] = calculateHEjercicio2(w2,entradaCapaIntermedia, size(v,2), 2);
    v(2,:) = vSalida2;
    h(2,:) = hSalida2;
    
    vFinal = v(numeroCapas,:);
    vFinal = vFinal(vFinal~=0);
     SalidasActuales(i) = vFinal;
     salidaDeseada = Salidas(i);
     errorAcumulado = errorAcumulado + (salidaDeseada-vFinal)^2;
    
    n = 0.1;
    nuevaEntradas = [v(1,:) 1];
    [deltaW, delta] = calculateDeltaPesoUltimaCapa(h(2,:), nuevaEntradas, salidaDeseada, v(2,:),n);
    w2 = w2 + deltaW;

    [deltaW2, delta2] = calculateDeltaPesoCapaIntermedia(w2, w1, delta, h(1,:), Patrones(i,:),n);
    w1 = w1 + deltaW2;
 
end
count = count + 1;
error = 0.5 * errorAcumulado;
%     if rem(count,10) == 0
%     hold on;
%     axis([0 2000 0 200]);
%     drawnow; 
%     plot(count,error,'ob', 'MarkerFaceColor', 'g');
% 
%     end
end

figure(2);
indices =find(Patrones(:,2) == 0  & Patrones(:,3) == Patrones(100,3));
plot(Patrones(indices,1),SalidasActuales(indices));
hold all;
plot(Patrones(indices,1),Salidas(indices));
legend('Salida red','Set entrenamiento', 'Location', 'Best')
ylabel('f(x,0,0), x $\in$ [0,2$\pi$]', 'Interpreter', 'LaTeX')
xlabel('x')
