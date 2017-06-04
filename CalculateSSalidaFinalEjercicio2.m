function[fDerivable] = CalculateSSalidaFinalEjercicio2(w,P)

sr =  dot(w, P);
b= 0.5;
fDerivable = tanh(b*sr);

end