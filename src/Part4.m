[C,G] = modifiedModelGenerator(1,2,55,0.1,1000,0.25,0.00001,0.2,1000,100000,600000);
C
G
%%%%create out AC and DC voltage matrices
%%%%define our F matrix.
voltage_step=20;
Nodal_Voltage=zeros(3,voltage_step);
Nodal_Voltage(1,:)=linspace(-10,10,voltage_step);
for ii=1:voltage_step
    %Solving for voltage at each 1V increment
    F=[Nodal_Voltage(1,ii); 0; 0; 0; 0; 0];
    V=G\F;
    Nodal_Voltage(2,ii)=V(5);
    Nodal_Voltage(3,ii)=V(3);
end

figure(15)
hold on;
plot(Nodal_Voltage(1,:),Nodal_Voltage(2,:));
plot(Nodal_Voltage(1,:),Nodal_Voltage(3,:));
hold off;
legend('V_O','V_3');
title('Figure 16: Output voltage and V3 as functions of Input voltage');
ylabel('Voltage (V)');
xlabel('V_i (V)');

