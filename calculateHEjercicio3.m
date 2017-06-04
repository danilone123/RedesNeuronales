function[h,v] = calculateHEjercicio3(w, entrada)
h = (w *entrada')';
v = (gTangenteh(h));
% for i = 1:size(w,1)
%     h(1,i) = dot(w(i,:), entrada);
%     v(1,i) = gTangenteh(h(1,i));
% end
end