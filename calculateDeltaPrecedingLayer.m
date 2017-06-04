function[delta] = calculateDeltaPrecedingLayer(w,deltaJ, h)
%w salida x entrada
delta = zeros(1,size(w,2));
if size(deltaJ,2)~= 1
deltaJ(size(deltaJ,2)) = [];
end
for i = 1: size(w,2)
    delta(1,i) = dot(w(:,i),deltaJ');
end

for j = 1:size(h,2)
    delta (1,j)= delta(1,j) * gDerivadaTanh(h(1,j));%gDerivadaExp(h(1,j));
end

end