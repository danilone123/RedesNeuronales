function[deltaW, deltaCapaFinal] = calculateDeltaPesoCapaIntermediaEjercicio3(wForward,wBack,deltaJ,hi, entrada,n)
 deltaCapaFinal = calculateDeltaPrecedingLayer(wForward,deltaJ, hi);
 deltaW = wBack;
 for i = 1 : size(deltaCapaFinal,2)-1
     deltaW(i,:) = n * deltaCapaFinal(i) * entrada;
 end
end