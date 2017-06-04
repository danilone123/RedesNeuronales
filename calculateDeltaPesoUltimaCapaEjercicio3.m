function[deltaW, deltaCapaFinal] = calculateDeltaPesoUltimaCapaEjercicio3(hiLast, entrada, salidaDeseada, sFinal,n)
 deltaCapaFinal = gDerivadaTanh(hiLast) * (salidaDeseada - sFinal);%calculateDeltaLastLayer(salidaDeseada, sFinal, hiLast);
 deltaW = n * deltaCapaFinal * entrada;
 
end