%sen x + cos y + z
xmin=0;
xmax=2*pi;
n=10;
kAprendizaje = 0.1;
x=linspace(0,2*pi,n);%xmin+rand(1,n)*(xmax-xmin);
y= linspace(0,2*pi,n);%xmin+rand(1,n)*(xmax-xmin);                 
z =linspace(-1,1,n);%-1 + rand(1,n)*(1+1); 
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
for i = listRandonPos
    entrada = Patrones(i,:);
    [hSalida1,vSalida1] = calculateHEjercicio3(w1, entrada);
    
    entradaCapaIntermedia  = [vSalida1 1];
    [hSalida2,vSalida2] = calculateHEjercicio3(w2,entradaCapaIntermedia);
    
    vFinal = vSalida2;
     SalidasActuales(i) = vFinal;
       salidaDeseada = Salidas(i);
     errorAcumulado = errorAcumulado + (salidaDeseada-vFinal)^2;
    
    nuevaEntradas = [vSalida1 1];
    [deltaW, delta] = calculateDeltaPesoUltimaCapaEjercicio3(hSalida2, nuevaEntradas, salidaDeseada, vSalida2,kAprendizaje);
    w2 = w2 + deltaW;

    [deltaW2, delta2] = calculateDeltaPesoCapaIntermediaEjercicio3(w2, w1, delta, hSalida1, Patrones(i,:),kAprendizaje);
    w1 = w1 + deltaW2;
   
%   vFinal =  gTangenteh(w2*[gTangenteh(w1* Patrones(i,:)'); 1]);
%      SalidasActuales(i) = vFinal;
%      %salidaDeseada = Salidas(i);
%      errorAcumulado = errorAcumulado + (salidaDeseada-vFinal)^2;
end
count = count + 1;
error = 0.5 * errorAcumulado;
end

figure(1);
indices =find(Patrones(:,2) == 0  & Patrones(:,3) == -1);
[xsorted, I] = sort(Patrones(indices,1));
t =SalidasActuales(indices);
ysorted = t(I);
% plot(Patrones(indices,1),Salidas(indices),'--go',Patrones(indices,1),SalidasActuales(indices),'--r');
plot(xsorted,ysorted);
hold all;
t = Salidas(indices);
ysorted = t(I);
plot(xsorted,ysorted);
legend('Salida red','Set entrenamiento', 'Location', 'Best')
ylabel('f(x,0,0), x $\in$ [0,2$\pi$]', 'Interpreter', 'LaTeX')
xlabel('x')

figure(2);
indices =find(Patrones(:,1) == 0  & Patrones(:,3) == -1);
[xsorted, I] = sort(Patrones(indices,2));
t =SalidasActuales(indices);
ysorted = t(I);
% plot(Patrones(indices,1),Salidas(indices),'--go',Patrones(indices,1),SalidasActuales(indices),'--r');
plot(xsorted,ysorted);
hold all;
t = Salidas(indices);
ysorted = t(I);
plot(xsorted,ysorted);
legend('Salida red','Set entrenamiento', 'Location', 'Best')
ylabel('f(0,y,0), x $\in$ [0,2$\pi$]', 'Interpreter', 'LaTeX')
xlabel('y')

figure(3);
indices =find(Patrones(:,1) == 0  & Patrones(:,2) == 0);
[xsorted, I] = sort(Patrones(indices,3));
t =SalidasActuales(indices);
ysorted = t(I);
% plot(Patrones(indices,1),Salidas(indices),'--go',Patrones(indices,1),SalidasActuales(indices),'--r');
plot(xsorted,ysorted);
hold all;
t = Salidas(indices);
ysorted = t(I);
plot(xsorted,ysorted);
legend('Salida red','Set entrenamiento', 'Location', 'Best')
ylabel('f(0,0,z), z $\in$ [-1,1]', 'Interpreter', 'LaTeX')
xlabel('z')

figure(4);
plot(1:length(SalidasActuales),SalidasActuales);
hold all;
plot(1:length(SalidasActuales),Salidas);
legend('Salida red','Set entrenamiento', 'Location', 'Best')
ylabel('f(x,y,z), y $\in$ [0,2$\pi$], z $\in$ [-1,1]', 'Interpreter', 'LaTeX')
xlabel('Muestra')



n= 20; 
x=linspace(0,2*pi,n);
y= linspace(0,2*pi,n);                 
z =linspace(-1,1,n);
PatronesAprender = zeros(n^3,4);
SalidasDeseadas = zeros(1,n^3);
SalidasAprendidas = zeros(1,n^3);
amount = 1;
for iX  = 1 : n
    for jY = 1:n
        for zZ = 1:n
            PatronesAprender(amount,:) = [x(iX) y(jY) z(zZ) 1];
            SalidasDeseadas(amount) = (sin(PatronesAprender(amount,1)) + cos(PatronesAprender(amount,2)) + PatronesAprender(amount,3))/3;
            SalidasAprendidas(amount) = gTangenteh(w2 * [gTangenteh(w1 * PatronesAprender(amount,:)'); 1]);
            amount = amount + 1;
        end
    end
end
%SalidasDeseadas = (sin(PatronesAprender(:,1)) + cos(PatronesAprender(:,2)) + PatronesAprender(:,3))/3;

%SalidasAprendidas = gTangenteh(w2 * [gTangenteh(w1 * PatronesAprender'); ones(1,size(PatronesAprender,1))]);

figure(5)
plot(1:length(SalidasAprendidas),SalidasAprendidas,'*');
hold all;
plot(1:length(SalidasAprendidas),SalidasDeseadas, '*');
legend('Salida red','Set deseado', 'Location', 'Best')
ylabel('f(x,y,z), y $\in$ [0,2$\pi$], z $\in$ [-1,1]', 'Interpreter', 'LaTeX')
xlabel('Muestra')
