function[deltaW, deltaCapaFinal] = calculateDeltaPesoUltimaCapa(hiLast, entrada, salidaDeseada, sFinal,n)
 hiLast = hiLast(hiLast~=0);
 entrada = entrada(entrada~=0);
 sFinal = sFinal(sFinal~=0);
 
 deltaCapaFinal = gDerivadaTanh(hiLast) * (salidaDeseada - sFinal);%calculateDeltaLastLayer(salidaDeseada, sFinal, hiLast);
 deltaW = n * deltaCapaFinal * entrada;
 
end