[C,G] = modelGenerator(1,2,55,0.1,1000,0.25,0,0.2,100);

timesteps=1000;
real_time=1;
stepsize=real_time/timesteps;
step=1/stepsize;
elements=timesteps+1;
finite_difference=(-(elements-1)/2:(elements-1)/2)*(step/elements);
% initial
Nodal_Step_Transient=zeros(3,3,timesteps+1);
Vold=[0; 0; 0; 0; 0; 0];
input_Q2=zeros(3,timesteps+1);
f_B=1/0.03;
for inputtype=1:3
    for ii=1:timesteps
        if(inputtype==1)
            if(ii*stepsize<0.03)
                input_Q2(inputtype,ii)=0;
            else
                input_Q2(inputtype,ii)=1;
            end
        elseif(inputtype==2)
            input_Q2(inputtype,ii)=sin(2*pi*f_B*ii*stepsize);
        else
            input_Q2(inputtype,ii)=exp(-(ii*stepsize-0.1)^2/(2*0.03^2));
        end
    end
end

for inputtype=1:3
    Vold=[0; 0; 0; 0; 0; 0];
    for ii=1:timesteps
 
        Vin=input_Q2(inputtype,ii);
        F=[Vin; 0; 0; 0; 0; 0];
        Nodal_Step_Transient(inputtype,1,ii+1)=ii*stepsize;
        Nodal_Step_Transient(inputtype,2,ii+1)=Vin; 
        A=C/stepsize+G;
        V=(A)\(C*Vold/stepsize+F);
        Nodal_Step_Transient(inputtype,3,ii+1)=V(5);
        Vold=V;
    end 
end
row=1;
Step=zeros(3,timesteps+1);
Step(:,:)=Nodal_Step_Transient(row,:,:);
figure(5)
hold on;
plot(Step(1,:),Step(2,:),'Color','black');
plot(Step(1,:),Step(3,:),'Color','red');
hold off;
legend('V_i','V_O');
title('Steps for Step Input');
ylabel('Voltage Step');
xlabel('Time');

row=2;
Sine=zeros(3,timesteps+1);
Sine(:,:)=Nodal_Step_Transient(row,:,:);
figure(6)
hold on;
plot(Sine(1,:),Sine(2,:),'Color','black');
plot(Sine(1,:),Sine(3,:),'Color','red');
hold off;
legend('V_i','V_O');
title('Steps for Sinusoidal Input with f=33.3Hz');
ylabel('Voltage Step');
xlabel('Time');

row=3;
Guass=zeros(3,timesteps+1);
Guass(:,:)=Nodal_Step_Transient(row,:,:);
figure(7)
hold on;
plot(Guass(1,:),Guass(2,:),'Color','black');
plot(Guass(1,:),Guass(3,:),'Color','red');
hold off;
legend('V_i','V_O');
title('Steps for Gaussian Pulse Input');
ylabel('Voltage Step');
xlabel('time (s)');

figure(8)
X=fft(Step(2,:));
Y=fft(Step(3,:));
hold on;
plot(finite_difference,fftshift(abs(X)),'Color','black');
plot(finite_difference,fftshift(abs(Y)),'Color','red');
hold off;
legend('V_i','V_O');
axis([-100 100 0 1400])
title('Frequency Domain for Step Input');
ylabel('Magnitude');
xlabel('Frequency');

figure(9)
X=fft(Sine(2,:));
Y=fft(Sine(3,:));
hold on;
plot(finite_difference,fftshift(abs(X)),'Color','black');
plot(finite_difference,fftshift(abs(Y)),'Color','red');
hold off;
axis([-200 200 0 600])
legend('V_i','V_O');
title('Frequency Domain for Sinusoidal Input with f=33.3Hz');
ylabel('Magnitude');
xlabel('Frequency');

figure(10)
X=fft(Guass(2,:));
Y=fft(Guass(3,:));
hold on;
plot(finite_difference,fftshift(abs(X)),'Color','black');
plot(finite_difference,fftshift(abs(Y)),'Color','red');
hold off;
axis([-100 100 0 130])
legend('V_i','V_O');
title('Frequency Domain for Gaussian Pulse Input');
ylabel('Magnitude');
xlabel('Frequency');
