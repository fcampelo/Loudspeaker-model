function B = LS_B(X)
% F = LS_B(X) -   Returns the magnetic flux density (B) for the Loudspeaker 
%                   optimisation problem:
%
% Minimize f = Volume
% Subject to: B >= 0.5T
%
% IMPORTANT: in order to function properly, this routine must be called 
% *AFTER* either LS_vol.m or LS_fun.m
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
global outpath;

Bref = 0.5;
xtmp = X;
load(outpath, 'ascii');

if sum(sum(X-xtmp))
    warning('Inconsistent X entered in LS_B.m; Using the value of X entered in the last LS_vol.m call.');
end

npop = size(X,2);
Y = loudspeaker;

B = 0.5 - Y(1:npop);