Fsim = 200e6; % number of samples/second
Tsym = 1e-6; % seconds per one symbol
%xl is the number of samples
xl = length (x);
%to get the number of samples: xl / Fsim / Tsym
nos = round ((xl/ Fsim)/ Tsym, 0);
%the number of samples per symbol = xl / nos
sps = round (xl/ nos, 0);
%From here we reshape to make a matrix of 500 by 200 (symbols by samples)
%Note that reshape fills down by column first not by row
y= reshape (x, [sps, nos]);
fc = 20e6; %carrier frequency is 20 MHz
%symbols are each 1e-6 secs so,
tmax = 1e-6 * nos;
%length of x is how many samples we have and also how many times we want to
%sample at
t = linspace (0, tmax, xl);
tl = length (t);
basis1 = zeros (tl, 1);
basis2 = zeros (tl, 1);
for t = 1: tl
    basis1 (t) = sin (pi * fc * t);
    basis2 (t) = cos (pi * fc * t);
end 
basis1 = reshape (basis1, [sps, nos]);
basis2 = reshape (basis2, [sps, nos]);
datax = zeros (nos, 1);
datay = zeros (nos, 1);
for i = 1 : nos
    datax (i) = dot (y(:, i), basis2 (:, i));
    datay (i) = dot (y(:, i), basis1 (:, i));
end
scatter(datax, datay)
xlabel('cosine dot product')
ylabel('sine dot product')