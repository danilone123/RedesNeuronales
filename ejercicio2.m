M = [ 1 1 -1; 1 -1 1; -1 1 1; -1 -1 -1];
Patrones = [ 1 1 1; 1 -1 1; -1 1 1; -1 -1 1];
nPatrones= size(Patrones,1);
Salidas = [-1,1,1,-1];
SalidasActuales = [0, 0 , 0 ,0];

w1 = rand(2,3);
%puede ser negativo y funcionaria
w2 = rand(1,3);

error = 10;
count = 0;
while(error > 0.001 && count<300000)
    listRandonPos = randperm(nPatrones);
for i = listRandonPos%1: nPatrones
    entrada = Patrones(i,:);
    h1 = dot(w1(1,:), entrada);
    h2 = dot(w1(2,:), entrada);
    %CalculateSSalidaEjercicio2(w1(:,1),p);
    v1 = CalculateSSalidaEjercicio2(h1);
    v2 = CalculateSSalidaEjercicio2(h2); 
    entradaFinal  = [v1 v2 1];
    
    sFinal = CalculateSSalidaFinalEjercicio2(w2,entradaFinal);
    salidaDeseada = Salidas(i);
   %if sFinal ~= salidaDeseada
        %capa final
        hiLast = dot(w2,entradaFinal);
        deltaCapaFinal = calculateDeltaLastLayer(salidaDeseada, sFinal, hiLast);
        n = 1; 
        deltaW2 = n * deltaCapaFinal * entradaFinal;
        w2 = w2 + deltaW2;
        %capa medias
        deltaCapaIntermedia = calculateDeltaPrecedingLayer(w2,deltaCapaFinal,[h1 h2]);
        deltaW11 = n * deltaCapaIntermedia(1)* (entrada);
        deltaW12 = n * deltaCapaIntermedia(2)* (entrada);
        
        w1(1,:) = deltaW11 + w1(1,:);
        w1(2,:) = deltaW12 + w1(2,:);
        
    %end
    h1 = dot(w1(1,:), entrada);
    h2 = dot(w1(2,:), entrada);
    v1 = CalculateSSalidaEjercicio2(h1);
    v2 = CalculateSSalidaEjercicio2(h2); 
    entradaFinal  = [v1 v2 1];
    SalidasActuales(i) = CalculateSSalidaFinalEjercicio2(w2,entradaFinal);

end
x = 0;
for np = 1: nPatrones
    x = x + ((Salidas(np) - SalidasActuales(np))^2);
end
error = 0.5 * x;
%disp('At line 50' + error);
count = count +1;
end

x = -4:1:4;
y1 = -(w1(1,3)/w1(1,2)) - ((w1(1,1)/w1(1,2))*x);
y2 = -(w1(2,3)/w1(2,2)) - ((w1(2,1)/w1(2,2))*x);
y3 = -(w2(1,3)/w2(1,2)) - ((w2(1,1)/w2(1,2))*x);
plot(x,y1);
grid on;
hold on;
plot(x,y2);
hold on;
%plot(x,y3);
%hold on;
plot(1, 1, 'ob', 'MarkerFaceColor', 'r');
plot(-1, -1, 'ob', 'MarkerFaceColor', 'r');
plot(-1, 1, 'ob', 'MarkerFaceColor', 'b');
plot(1, -1, 'ob', 'MarkerFaceColor', 'b');
%plot([-1 1 1], [1 -1 1], 'og', 'MarkerFaceColor', 'b');
%plot(1, 1, 'ob', 'MarkerFaceColor', 'r');
