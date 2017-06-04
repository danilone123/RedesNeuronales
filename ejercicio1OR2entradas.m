%contains the patterns and Sd(salida deseada)
Patrones = [ 1 1 1; 1 -1 1; -1 1 1; -1 -1 1];
%nPatrones =size(Patrones(4));
Salidas = [1 1 1 -1];
SalidasDeseadas = zeros(1,4);

%w puede tener valores negativos 2*rand(1,3)-1???
w = randn(1,3);
%constante de aprendizaje

k = 1;

count = 0;
while (0 == count)
listRandonPos = randperm(4);
lastW = w;
    for j = listRandonPos
        p = Patrones(j,:);
        sD = Salidas(j);
        
        %p = [1, p]; 
        sR = CalculateSr(w,p);
            if sR ~= sD
                deltaW =  CalculateDeltaW(sD,sR,p);%CalculateDeltaW(sD,sR,p(i),w,i);
                w = w + deltaW;
            end
    end
    if lastW == w
        count = 1;
    end
end
%-(w1(1,3)/w1(1,2)) - ((w1(1,1)/w1(1,2))*x);
x = -5:1:5;
y = -(w(1,3)/w(1,2)) - ((w(1,1)/w(1,2))*x);
plot(x,y);
hold on;
plot(1, 1, 'ob', 'MarkerFaceColor', 'b');
plot(-1, -1, 'ob', 'MarkerFaceColor', 'r');
plot(-1, 1, 'ob', 'MarkerFaceColor', 'b');
plot(1, -1, 'ob', 'MarkerFaceColor', 'b');
%diferente
% if sD == sR
%     w(1) = CalculateDeltaW(sD,sR,p(1),w,1
% end


