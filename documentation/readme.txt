Instructions of use: Loudspeaker design model

1) Software required:

- Finite Element Method Magnetics v.4.2 (http://www.femm.info/wiki/Download)
- Matlab


2) Files needed:

- loudspeaker.lua 	(script file for the evaluation of the loudspeaker)
- CallFEMM_LS.m	(Matlab routine for calling the FEMM solver)
- LS_fun.m		(penalized objective function for the optimisation problem)


3) Problem definitions: 

- 16-variable problem	(full design)
- 6-variable problem	(partial design, upper iron section + magnet)


4) How to use the model

a) Download all files available at http://www.cpdee.ufmg.br/~fcampelo/files/loudspeaker/ to a local folder in your computer (e.g., "C:/Loudspeaker/")
b) Using any text editor, edit the following files:

b.1) loudspeaker.lua: 
In lines 29-31, insert the correct path of your local folder. Attention to the double backslashes.
After adjusting the path, open FEMM 4.2 and select File -> Open LUA Script -> loudspeaker.lua. 
If your path is correct, the FEMM should run a dummy simulation of the device and close itself afterwards.

b.2) CallFEMM_LS.m:
In lines 4-5, insert the correct path of your local folder. Attention to the old-windows style of treating long names or names with spaces.
After adjusting the path, type the following commands in the Matlab command window:

>> X = [5.0,3.0,1.0,0.0,7.0,6.0,2.0,5.0,0.5,0.0,1.0,0.5,1.0,7.0,4.0,1.0]';
>> Y = CallFEMM_LS(X)

If your path is correct, the FEMM 4.2 window should pop up in your screen, run the dummy simulation, and return the result:

Y =

    0.5272
    0.0000
    0.0000

The following call:

>> F = LS_fun(X)

should then yield the penalized objective function value:

F =

  159.5294
