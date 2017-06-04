
nPatrones = 4;
%M1 = [ 1 1 1 1; 1 -1 -1; -1 1 1; -1 -1 -1];
%second layer
M = [ 1 1 -1; 1 -1 1; -1 1 1; -1 -1 -1];
mPatrones = M;
salidas = M(:,3);

mPatrones(:,3) = [];
mPatrones = [ mPatrones,ones(nPatrones, 1)];

%matrix 'pesos' 1
w1 = randn(3,2);
w2 = rand(3,1);


%usa un margen al momento de saber si la diff es 0.999 por ejemplo???
error = 1;
while(error< 10)
    listRandonPos = randperm(nPatrones);
for i = 1:nPatrones
    p = mPatrones(listRandonPos(i),:);
    v1 = CalculateSSalidaEjercicio2(w1(:,1),p);
    v2 = CalculateSSalidaEjercicio2(w1(:,2),p); 
    sFinal = CalculateSSalidaFinalEjercicio2(w2,[v1,v2, 1]);
    hiu = dot(w2,[v1,v2, 1]);
    hju1 = dot(w1(:,1),p);
    hju2 = dot(w2(:,1),p);
    sDeseada = salidas(listRandonPos(i));
    if sFinal ~= sDeseada
        %backtracking!
        %finalLayer
        gDerivadaCapaFinal = gDerivadaTanh(hiu);
        diu = gDerivadaCapaFinal *(sDeseada - sFinal);
        n =1;
        deltaWCapaFinal = n*(diu * [v1,v2, 1])';
        w2 = w2 + deltaWCapaFinal;
        %first layer
        g = gDerivadaExp(hju1);
        dju = g *(diu*w2);
        dW = n * (dju.*p');
         w1(:,1) = w1(:,1) + dW;
        dju = gDerivadaExp(hju2) *(diu*w2);
        dW = n * (dju.*p');
        w1(:,2) = w1(:,2) + dW;    
    end
end
error = error + 1;
end

