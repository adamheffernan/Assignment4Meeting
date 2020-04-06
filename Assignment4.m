clear 
clc

%% MNA Circuit Modeling 
%%% Adam Heffernan 100977570
% This assignment uses the modified nodal analysis method for circuit
% analysis. This is the underlying framework behind P-Spice or LT-Spice,
% i.e circuit simulators. All circuit simulators use this basic frameworek
% in order to analyze a circuit, big or small. This method really cuts down
% on processing time for a computer as if the computer needed to solve
% circuits with hundreds of nodes the non-matrix method would be extremely
% time consuming and costly on the program and taxing on computer resources
% in order to combat this, we use stamps for each element in our circuit
% and put them into a matrix, by doing matrix division with a column vector
% for the current at each node in the circuit we are able to solve for
% voltage, as shown in the following experiments.
%% Part1
% Basic sweep was done using the simulation from part 3, a resistance value
% of approximately 50 Ohms was found using this method. The rest of the
% simulation then proceeded. In the MNA PA we learned how to stamp different
% components into a matrix in order to complete the modified nodal analysis
% technique. This is a low pass filter circuit. We would expect a frequency
% response that declines at 40dB/decade as this circuit is a second order
% filter. 
Part1;
%% Part2
% Different inputs with no noise were modeled. A gaussian input a sinusodal input
% and a step input. The frequency content of the signal was plotted using
% the FFT command. 
Part2;
%% Part 3
% Different inputs with  noise were modeled. A gaussian input a sinusodal input
% and a step input. The frequency content of the signal was plotted using
% the FFT command. We also varied the capacitance which effects the
% bandwidth of the signal, and the time step was also varied which alows us
% to get a higher resolution for the output voltage. Bandwidth decreases as
% the capacitance of the noise signal is varied. The higher resolution that
% is created by varrying the time step allows us to get a more accurate
% representation of the output signal. As the capacitance is varied the
% signal overshoots and then levels off before finally reaching a steady
% state, this is because the circuit is transient in nature with
% energy-storage components like inductors and capacitors. The overshoots
% increase as the value of the capacitor increases. This makes sense as the
% time constant for the circuit will also be increasing at the same time. 
Part3;
%% Part 4
% Modeling equation would change the equations by adding another vector. A
% column vector would be added with a non-linear expression for the
% conductance of the device in question. The updated matrix equation would
% look like $C*(dV/dt) + GV + B = F(\omega)$ in order to implement this
% equation we would need to use an iterative approach to solve for the
% current $I_3$ and then use this updated value to forward into our system
% of equations, getting closer and closer to the final solution and finally,
% depending on the error of convergence the final solution is attained for
% all practical Engineering purposes. 

Part4;
