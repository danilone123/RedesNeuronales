Patrones = [-1 -1 -1 -1 1;-1 -1 -1 1 1;-1 -1 1 -1 1; -1 -1 1 1 1; 
    -1 1 -1 -1 1;-1 1 -1 1 1;-1 1 1 -1 1;-1 1 1 1 1;1 -1 -1 -1 1;1 -1 -1 1 1;
    1 -1 1 -1 1;1 -1 1 1 1;1 1 -1 -1  1;1 1 -1 1 1; 1 1 1 -1 1;1 1 1 1 1];
nPatrones =size(Patrones,1);
Salidas = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1];
SalidasActuales = zeros(1,nPatrones);

%w puede tener valores negativos 2*rand(1,3)-1???
w = randn(1,5);
%constante de aprendizaje

k = 1;

count = 1;
limit = 0;
while (0 == limit)
listRandonPos = randperm(nPatrones);
lastW = w;
    for j = listRandonPos
        p = Patrones(j,:);
        sD = Salidas(j);
        sR = CalculateSr(w,p);
        SalidasActuales(j) = sR;
            if sR ~= sD
                deltaW =  CalculateDeltaW(sD,sR,p);%CalculateDeltaW(sD,sR,p(i),w,i);
            w = w + deltaW;
            end
    end
    drawnow;
%subplot(2,1,2);
grid on;
axis([0 16 -1 1]);
bar([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],SalidasActuales);
    if lastW == w
        limit = 1;
    end
    count = count + 1;
end



