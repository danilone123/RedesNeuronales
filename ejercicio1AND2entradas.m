%contains the patterns and Sd(salida deseada)
M = [ 1 1 1; 1 -1 -1; -1 1 -1; -1 -1 -1];
%adding 1 to the column
M = [ones(4, 1), M];
%w puede tener valores negativos 2*rand(1,3)-1???
w = randn(1,3);
%constante de aprendizaje
nPatrones =4;
k = 1;

count = 0;
while (0 == count)
listRandonPos = randperm(4);
lastW = w;
    for j = 1:4
        p = M(listRandonPos(j),:);
        sD = p(4);
        width = size(p,2);
        p(width) = [];
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

x = -5:1:5;
y = -(w(1)/w(3)) - ((w(2)/w(3))*x);
plot(x,y);
hold on;
plot(1, 1, 'ob', 'MarkerFaceColor', 'g');
plot([-1 1 -1], [1 -1 -1], 'og', 'MarkerFaceColor', 'b');
%diferente
% if sD == sR
%     w(1) = CalculateDeltaW(sD,sR,p(1),w,1
% end


