function F = LS_fun(X)
% F = LS_fun(X) -   Evaluates the (penalized) objective function for the 
%                   Loudspeaker optimisation problem:
%
% Minimize f = Volume
% Subject to: B >= 0.5T
%
% X is an [nvars x npop] matrix in which each column represents a candidate
% solution. The current implementation supports two different problems:
%
% a) 7-variable problem: optimisation of the upper iron section and magnet
% dimensions. Design variables: [x2, x6, x9, x10, x11, x14, x15]
%
% b) 16-variable problem: optimisation of the full model
%
% The suggested limits for the variables are as follows:
%
% Loudspeaker parameter limits:
% varlims = [...
%     3.0000   12.0000;   %x1 
%     1.0000    4.0000;   %x2 
%     1.0000    4.0000;   %x3 
%     0.0000    3.0000;   %x4 
%     5.0000   15.0000;   %x5 
%     2.0000    5.0000;   %x6 
%     1.0000   10.0000;   %x7 
%     1.0000    3.0000;   %x8 
%     0.5000    2.0000;   %x9 
%     0.0000    3.0000;   %x10 
%     1.0000    5.0000;   %x11 
%     2.0000    5.0000;   %x12 
%     0.5000    2.0000;   %x13 
%     5.0000   12.0000;   %x14 
%     2.0000    5.0000;   %x15 
%     1.0000   5.0000];   %x16 
%
% Feel free to use this model in any of your works, but please acknowledge 
% the source as:
% F. Campelo, "Loudspeaker design model - a test benchmark for 
% electromagnetic optimisation." [online]. Available from: 
% http://www.cpdee.ufmg.br/~fcampelo/files/loudspeaker/.
%--------------------------------------------------------------------------
X=X';
[nvars,npop] = size(X);
Bref = 0.5;

%% Check number of variables and insert fixed values when necessary
switch nvars
    case 7, % [x2 x6 x9 x10 x11 x14 x15]

        a = repmat([5.0]',1,npop);          %x1
        b = repmat([2.0 1.5 7.0]',1,npop);  % x3 x4 x5
        c = repmat([2.0 2.0]',1,npop);      % x7 x8
        d = repmat([2.0 1.0]',1,npop);      % x12 x13
        e = repmat(2.0,1,npop);             % x16

        X = [a;X(1,:);b;X(2,:);c;X(3:5,:);d;X(5:6,:);e];
    case 16
        % Just leave it as it is. No command needed here
    otherwise
        error('Error: Invalid Dimension for X');
end

%% Calls the finite element model
Y = CallFEMM_LS(X);

%% Calculates objective function
B = Y(1:npop);                      % Magnetic field density [T]
Viron = 1e6*Y(npop+1:2*npop);       % Iron volume [cm^3]
Vmag  = 1e6*Y(2*npop+1:3*npop);     % Magnet volume [cm^3]

F = -((Viron + Vmag) + 100*max(0,Bref-B));