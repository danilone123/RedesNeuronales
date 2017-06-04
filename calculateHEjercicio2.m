function[h,v] = calculateHEjercicio2(w, entrada, sizeV, capa)

entrada = entrada(entrada~=0);
v = zeros(1,sizeV); 
h = zeros(1,sizeV); 
for i = 1:size(w,1)
    h(1,i) = dot(w(i,:), entrada);
%     if capa == 2
    v(1,i) = gTangenteh(h(1,i));%CalculateSSalidaEjercicio2(h(1,i));
     
%     else
%         v(1,i) = gExph(h(1,i));
%      end
end
end