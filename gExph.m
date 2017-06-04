function[gResult] = gExph(h)
b=0.5;
gResult = 1 / (1+exp(-2*h*b));
end