[C,G] = modelGenerator(1,2,55,0.1,1000,0.25,0,0.2,100);
C
G
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

figure(1)
hold on;
plot(Nodal_Voltage(1,:),Nodal_Voltage(2,:),'Color','black');
plot(Nodal_Voltage(1,:),Nodal_Voltage(3,:),'Color','red');
hold off;
legend('V_O','V_3');
title('Output voltage and V3 as functions of Input voltage');
ylabel('Voltage');
xlabel('V_i');

voltage_step=2000;
Nodal_VoltageAC=zeros(2,voltage_step);
Nodal_VoltageAC(1,:)=linspace(0,500,voltage_step);
Vin=1;
for ii=1:voltage_step
    omega=Nodal_VoltageAC(1,ii);
    F=[Vin; 0; 0; 0; 0; 0];
    V=(G+1j*omega*C)\F;
    Nodal_VoltageAC(2,ii)=V(5);
end

figure(2)
plot(Nodal_VoltageAC(1,:),real(Nodal_VoltageAC(2,:)),'Color','black');
title('Output Voltage as a Function of Angular Frequency');
legend('V_O')
ylabel('V_O');
xlabel('\omega');

figure(3)
semilogx(Nodal_VoltageAC(1,:),20*log10(real(Nodal_VoltageAC(2,:))./Vin),'Color','black');
title('Gain as a Function of Angular Frequency');
axis([0 700 -8 6])
legend('dB(V_O/V_i)');
ylabel('Gain')
xlabel('\omega');

Vin=1;
omega=pi;
counter=10000;
Nodal_Voltage_VarryingC=zeros(1,counter);
for ii=1:counter
    C2=0.25+randn()*0.05;
    C(2,:)=[-C2 +C2 0 0 0 0];
    F=[Vin; 0; 0; 0; 0; 0];
    V=(G+1j*omega*C)\F;
    Nodal_Voltage_VarryingC(1,ii)=V(5);
end
figure(4);
histogram(real(Nodal_Voltage_VarryingC),20,'FaceColor','red');
title('Histogram of Gain for variations in Capacitance');
ylabel('Count')
xlabel('Gain');


