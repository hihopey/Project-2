clear all
fprintf (1, 'Types of filter: \n')
fprintf (1, '1: Butterworth \n')
fprintf (1, '2: Chebyshev \n')
%ask users type
type = input ('What type of filter will you be using? (1 or 2) \n');
%ask users order
n = input ('What maximum order would you like to see? \n');
%ask for ripple 
if type == 2
    fprintf (1, '1: Equi-ripple return loss \n')
    fprintf (1, '2: Passband ripple \n')
    R = input ('Which value do you have?  (1 or 2) \n');
    if R == 1
        rl = input ('What is the value? \n'); %FIGURE OUT HOW TO USE THIS
        %find epsilon
        epsilon = sqrt((1/(1-(10^(rl/-10))))-1);
    else
        r = input ('What is the value? \n'); 
        %find epsilon
        epsilon = sqrt(10^(r/10)-1);
    end
else
end
for N = 1 : n
    %find gs
    if type == 1 %Butterworth
        for i = 1 : N
            g(N, i) = 2*sin((((2*i)-1)*pi)/(2*N));
        end
        g(N, N+1) = 1;
    elseif mod(N, 2) == 1 %odd Chebyshev
        %find eta
        eta = sinh((1/N)*asinh(1/epsilon));
        g(N, 1) = (2/eta)*sin(pi/(2*N));
        g(N, N+1) = 1;
            for i = 1 : N - 1
                g(N, i + 1) = ((4*sin(((2*i-1)*pi)/(2*N))*sin(((2*i+1)*pi)/(2*N)))/((eta^2)+(sin((i*pi)/N)^2)))/(g(N, i)); %WHAT'S WRONG
            end
    else %even Chebyshev
        %find eta
        eta = sinh((1/N)*asinh(1/epsilon));
        g(N, 1) = (2/eta)*sin(pi/(2*N));
        g(N, N+1) = (epsilon + sqrt(1 + (epsilon^2)))^2;
            for i = 1 : N - 1
                g(N, i + 1) = ((4*sin(((2*i-1)*pi)/(2*N))*sin(((2*i+1)*pi)/(2*N)))/((eta^2)+(sin((i*pi)/N)^2)))/(g(N, i)); %DITTO
            end 
    end
end
RowNames = 1 : n;
RowNames = num2cell(RowNames);
array2table (g, 'RowNames', RowNames)
%table (g(1,:),g(2,:), g(3:n), g(4:n), 'RowNames', [1 : n])