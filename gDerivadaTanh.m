function[fDerivable] = gDerivadaTanh(h)
b= 0.5;
g = gTangenteh(h);
fDerivable = b *(1-(g^2));
end