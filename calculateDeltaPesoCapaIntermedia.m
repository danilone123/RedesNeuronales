function[deltaW, deltaCapaFinal] = calculateDeltaPesoCapaIntermedia(wForward,wBack,deltaJ,hi, entrada,n)
 hi = hi(hi~=0);
 entrada = entrada(entrada~=0);
 deltaCapaFinal = calculateDeltaPrecedingLayer(wForward,deltaJ, hi);
 deltaW = wBack;
 for i = 1 : size(deltaCapaFinal,2)-1
     deltaW(i,:) = n * deltaCapaFinal(i) * entrada;
 end
end