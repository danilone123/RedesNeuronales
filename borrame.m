M = [-1 -1 -1 -1 -1; -1 -1 -1 1 1; -1 -1 1 -1 1; -1 -1 1 1 -1; -1 1 -1 -1 1; -1 1 -1 1 -1; -1 1 1 -1 -1];
                          
                          
                        
                          
                     
                         
              
      Patrones = [ 1 1 1; 1 -1 1; -1 1 1; -1 -1 1];       
% Patrones = [-1 -1 -1 -1 1;-1 -1 -1 1 1;-1 -1 1 -1 1; -1 -1 1 1 1; 
%     -1 1 -1 -1 1;-1 1 -1 1 1;-1 1 1 -1 1;-1 1 1 1 1;1 -1 -1 -1 1;1 -1 -1 1 1;
%     1 -1 1 -1 1;1 -1 1 1 1;1 1 -1 -1  1;1 1 -1 1 1; 1 1 1 -1 1;1 1 1 1 1
%     ];
%[ -1 -1 -1 -1 1; -1 -1 -1 1 1; -1 -1 1 -1 1; -1 -1 1 1 1; -1 1 -1 -1 1; -1 1 -1 1 1; -1 1 1 -1 1];
nPatrones= size(Patrones,1);
% Salidas = [-1,1,1,-1,1,-1,-1,1,1,-1,-1,1,-1,1,1,-1];
% SalidasActuales = zeros(1,16);
Salidas = [-1,1,1,-1];
SalidasActuales = [0, 0 , 0 ,0];
numeroCapas =3;


% w1 = rand(4,5);
% %puede ser negativo y funcionaria
% w2 = rand(2,5);
% w3 = rand(1,3);

w1 = rand(2,3);
w2 = rand(2,3);
%puede ser negativo y funcionaria
w3 = rand(1,3);

error = 10;
count = 0;
while(error > 0.001 && count<20000)
    listRandonPos = randperm(nPatrones);
    v = zeros(3, 4);
    h = zeros(3,4);
    % adelante
for i = listRandonPos%1: nPatrones
    entrada = Patrones(i,:);
    wPeso = w1;
    
    for capas = 1: numeroCapas
        
        [hSalida,vSalida] = calculateHEjercicio2(wPeso, entrada, size(v,2));
        v(capas,:) = vSalida;
        h(capas,:) = hSalida;
        entrada = [v(capas,:) 1];
        % no se si matlab maneja listas asi que esto es una limitacion
        % no me gusta el codigo  pero es la unica forma que encontre
        if capas == 1
            wPeso = w2;
        end
        if capas == 2
            wPeso = w3;
        end
    end
%     [hSalida1,vSalida1] = calculateHEjercicio2(w1, entrada, size(v,2));
%     v(1,:) = vSalida1;
%     h(1,:) = hSalida1;
%     
%     entradaCapaIntermedia  = [v(1,:) 1];
%     [hSalida2,vSalida2] = calculateHEjercicio2(w2,entradaCapaIntermedia, size(v,2));
%     v(2,:) = vSalida2;
%     h(2,:) = hSalida2;
%     
%     entradaCapaIntermedia  = [v(2,:) 1];
%     [hSalida3,vSalida3] = calculateHEjercicio2(w3,entradaCapaIntermedia, size(v,2));
%     v(3,:) = vSalida3;
%     h(3,:) = hSalida3;
    salidaDeseada = Salidas(i);
    n = 1;
%     [deltaW, delta] = calculateDeltaPesoUltimaCapa(h(2,:), [v(1,:) 1], salidaDeseada, v(2,:),n);
%   w2 = w2 + deltaW;
%    
%     [deltaW2, delta2] = calculateDeltaPesoCapaIntermedia(w2, w1, delta, h(1,:), Patrones(i,:),n);
%     w1 = w1 + deltaW2;
    [deltaW, delta] = calculateDeltaPesoUltimaCapa(h(3,:), [v(2,:) 1], salidaDeseada, v(3,:),n);
    w3 = w3 + deltaW;
    [deltaW1, delta1] = calculateDeltaPesoCapaIntermedia(w3, w2, delta, h(2,:), [v(1,:) 1],n);
    w2 = w2 + deltaW1;
    [deltaW2, delta2] = calculateDeltaPesoCapaIntermedia(w2, w1, delta1, h(1,:), Patrones(i,:),n);
    w1 = w1 + deltaW2;
   
    v = zeros(3, 4);
    h = zeros(3,4);
    entrada = Patrones(i,:);
    wPeso = w1;
    for capas = 1: numeroCapas
        
        [hSalida,vSalida] = calculateHEjercicio2(wPeso, entrada, size(v,2));
        v(capas,:) = vSalida;
        h(capas,:) = hSalida;
        entrada = [v(capas,:) 1];
        
        if capas == 1
            wPeso = w2;
        end
        if capas == 2
            wPeso = w3;
        end
    end
     vFinal = v(3,:);
     vFinal = vFinal(vFinal~=0);
     SalidasActuales(i) = vFinal;
 %calculateDeltaPesoCapaIntermedia(w,deltaJ,hi, entradaFinal,n)
end

count = count + 1;

x = 0;
for np = 1: nPatrones
    x = x + ((Salidas(np) - SalidasActuales(np))^2);
end
error = 0.5 * x;

end