                   
Patrones = [-1 -1 -1 -1 1;-1 -1 -1 1 1;-1 -1 1 -1 1; -1 -1 1 1 1; 
    -1 1 -1 -1 1;-1 1 -1 1 1;-1 1 1 -1 1;-1 1 1 1 1;1 -1 -1 -1 1;1 -1 -1 1 1;
    1 -1 1 -1 1;1 -1 1 1 1;1 1 -1 -1  1;1 1 -1 1 1; 1 1 1 -1 1;1 1 1 1 1];
%[ -1 -1 -1 -1 1; -1 -1 -1 1 1; -1 -1 1 -1 1; -1 -1 1 1 1; -1 1 -1 -1 1; -1 1 -1 1 1; -1 1 1 -1 1];
nPatrones= size(Patrones,1);
Salidas = [-1,1,1,-1,1,-1,-1,1,1,-1,-1,1,-1,1,1,-1];
SalidasActuales = zeros(1,16);
numeroCapas =2;
w1 = rand(10,5);
%puede ser negativo y funcionaria
w2 = rand(1,11);
%w3 = rand(1,11);
error = 10;
count = 0;
while(error > 0.001  && count<20000)
    listRandonPos = randperm(nPatrones);
    v = zeros(2, 11);
    h = zeros(2,11);
    % adelante
for i = listRandonPos%1: nPatrones
    entrada = Patrones(i,:);
    wPeso = w1;
    v = zeros(2, 11);
    h = zeros(2,11);
    for capas = 1: numeroCapas        
        [hSalida,vSalida] = calculateHEjercicio2(wPeso, entrada, size(v,2),capas); 
        v(capas,:) = vSalida;
        h(capas,:) = hSalida;
        entrada = [v(capas,:) 1];
        % no se si matlab maneja listas asi que esto es una limitacion
        % no me gusta el codigo  pero es la unica forma que encontre
        if capas == 1
            wPeso = w2;
        end
    end

    salidaDeseada = Salidas(i);
    n = 0.5;
    [deltaW, delta] = calculateDeltaPesoUltimaCapa(h(2,:), [v(1,:) 1], salidaDeseada, v(2,:),n);
    w2 = w2 + deltaW;

    [deltaW2, delta2] = calculateDeltaPesoCapaIntermedia(w2, w1, delta, h(1,:), Patrones(i,:),n);
    w1 = w1 + deltaW2;
   
    v = zeros(2, 11);
    h = zeros(2,11);
    entrada = Patrones(i,:);
    wPeso = w1;
    for capas = 1: numeroCapas
        
        [hSalida,vSalida] = calculateHEjercicio2(wPeso, entrada, size(v,2),capas);
        v(capas,:) = vSalida;
        h(capas,:) = hSalida;
        entrada = [v(capas,:) 1];
        
        if capas == 1
            wPeso = w2;
        end
    end
     vFinal = v(2,:);
     vFinal = vFinal(vFinal~=0);
     SalidasActuales(i) = vFinal;
end

count = count + 1;

x = 0;
for np = 1: nPatrones
    x = x + ((Salidas(np) - SalidasActuales(np))^2);
end
error = 0.5 * x;
% subplot(2,2,1);
% hold on;
% axis([0 8000 0 15]);
% drawnow; 
% plot(count,error,'ob', 'MarkerFaceColor', 'g');
%plot(1, 1, 'ob', 'MarkerFaceColor', 'g');
end

drawnow;
subplot(2,1,2);
grid on;
axis([0 16 -1 1]);
bar([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],SalidasActuales);

subplot(2,1,1);
grid on;
axis([0 16 -1 1]);
bar([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],Salidas);
