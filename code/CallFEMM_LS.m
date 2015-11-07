function Y = CallFEMM_LS(X)

%% enter your local path here
global outpath;
femmpath = 'C:\Arquiv~1\femm42\bin\femm.exe';  % Path for the FEMM 4.2 executable
modelpath = 'C:\Docume~1\fcampelo\Meusdo~1\Academia\Models\loudspeaker\loudspeaker.lua'; % path for the loudspeaker LUA script
inpath = 'C:\Docume~1\fcampelo\Meusdo~1\Academia\Models\loudspeaker\loudspeaker.in';     % path for input file
outpath = 'C:\Docume~1\fcampelo\Meusdo~1\Academia\Models\loudspeaker\loudspeaker.out';   % path for output file


%% Define command line argument
%runstr = strcat(femmpath,' -lua-script=',modelpath); % This is the command that will be passed to the system
runstr = strcat(femmpath,' -lua-script=',modelpath,' -windowhide'); % alternative version, hides FEMM window


%% Assemble input file for FEMM
[nvars,npop] = size(X);             % Each configuration should be a 16x1 column vector. Multiple solutions can be assembled in matrix form.
fid=fopen(inpath,'w');    % input file
fprintf(fid,'%d\n',npop);           % number of configurations being evaluated

for i=1:npop                        % For each configuration...
    for j=1:nvars                   % ... enter the variables sequentially
        fprintf(fid,'%f\n',X(j,i));
    end
end
fclose(fid);


%% call FEMM 4.2 and evaluate solutions
system(runstr);

%%	load results from the FEMM analysis run into matlab
load(outpath,'ascii')

%%	return the results. Y is a [(3 npop) x 1] vector containing the magnetic
%	field density in the air gap (in Tesla), the iron volume and the magnet volume (in m^3) for
%	each candidate solution evaluated:
%   Y = [B1, B2, ..., B{npop}, VolIron1, VolIron2, ..., VolIron{npop}, VolMag1, VolMag2, ..., VolMag{npop}]'
Y=loudspeaker;

