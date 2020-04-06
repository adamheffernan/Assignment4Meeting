[C,G] = modelGenerator(1,2,55,0.1,1000,0.25,0.00001,0.2,100);
C
G
iter = 1;
for timesteps = 1000:9000:10000
C_n = 0.00001; 
real_time=1;
stepsize=real_time/timesteps;
step=1/stepsize;
elements=timesteps+1;
finite=(-(elements-1)/2:(elements-1)/2)*(step/elements);
% initial
Nodal_Voltage_withNoise=zeros(3,3,timesteps+1);
waveform=zeros(3,timesteps+1);

for source=1:3
    for i=1:timesteps
        waveform(source,i)=exp(-(i*stepsize-0.1)^2/(2*0.03^2));
    end
end

for source=1:3
    if(source==1)
        Cn_mod=C_n;
    elseif(source==2)
        Cn_mod=C_n*100;
    else
        Cn_mod=C_n*1000;
    end
    C(3,:)=[0 0 Cn_mod 0 0 0]; 
    Vold=[0; 0; 0; 0; 0; 0];
    for i=1:timesteps
        
        Vin=waveform(source,i);

        In=0.001*randn();
        F=[Vin; 0; -In; 0; 0; 0];
        Nodal_Voltage_withNoise(source,1,i+1)=i*stepsize;
        Nodal_Voltage_withNoise(source,2,i+1)=Vin;
        
        A=C/stepsize+G;
        V=(A)\(C*Vold/stepsize+F);
        Nodal_Voltage_withNoise(source,3,i+1)=V(5);

        Vold=V;
    end  
end
    if timesteps == 1000
        row=1;
        mu=zeros(3,timesteps+1);
        mu(:,:)=Nodal_Voltage_withNoise(row,:,:);
        figure(11)
        hold on;
        plot(mu(1,:),mu(2,:),'Color','black');
        plot(mu(1,:),mu(3,:),'Color','red');
        hold off;
        legend('V_i','V_O');
        title('Voltages for Gaussian Pulse Input with Noise');
        ylabel('Voltage');
        xlabel('Time');

        figure(12)
        X=fft(mu(2,:));
        Y=fft(mu(3,:));
        hold on;
        plot(finite,fftshift(abs(X)),'Color','black');
        plot(finite,fftshift(abs(Y)),'Color','red');
        hold off;
        legend('V_i','V_O');
        title('Frequency Domain for Gaussian Pulse Input with Noise');
        ylabel('Magnitude');
        xlabel('Frequency');

        row=1;
        mu=zeros(3,timesteps+1);
        mu(:,:)=Nodal_Voltage_withNoise(row,:,:);
        figure(13)
        subplot(3,1,1)
        hold on;
        plot(mu(1,:),mu(2,:),'Color','black');
        plot(mu(1,:),mu(3,:),'Color','red');
        hold off;
        legend('V_i','V_O');
        title('Voltages with Noise for Varrying Capacitance, Cn=10\mu F');
        ylabel('Voltage');
        xlabel('Time');

        row=2;
        mili=zeros(3,timesteps+1);
        mili(:,:)=Nodal_Voltage_withNoise(row,:,:);
        subplot(3,1,2)
        hold on;
        plot(mili(1,:),mili(2,:),'Color','black');
        plot(mili(1,:),mili(3,:),'Color','red');
        hold off;
        legend('V_i','V_O');
        title('Cn=1mF');
        ylabel('Voltage');
        xlabel('Time');

        row=3;
        mili_ten=zeros(3,timesteps+1);
        mili_ten(:,:)=Nodal_Voltage_withNoise(row,:,:);
        subplot(3,1,3)
        hold on;
        plot(mili_ten(1,:),mili_ten(2,:),'Color','black');
        plot(mili_ten(1,:),mili_ten(3,:),'Color','red');
        hold off;
        legend('V_i','V_O');
        title('Cn=10mF');
        ylabel('Voltage');
        xlabel('Time'); 
        
        figure(14)
        subplot(3,1,1);
        X=fft(mu(2,:));
        Y=fft(mu(3,:));
        hold on;
        plot(finite_difference,fftshift(abs(X)),'Color','black');
        plot(finite_difference,fftshift(abs(Y)),'Color','red');
        hold off;
        axis([-30 30 0 130])
        legend('V_i','V_O');
        title('Frequency Domain for Cn = 10\mu(F)');
        ylabel('Magnitude');
        xlabel('Frequency');
        X=fft(mili(2,:));
        Y=fft(mili(3,:));
        subplot(3,1,2);
        hold on;
        plot(finite_difference,fftshift(abs(X)),'Color','black');
        plot(finite_difference,fftshift(abs(Y)),'Color','red');
        hold off;
        axis([-30 30 0 130])
        legend('V_i','V_O');
        title('Frequency Domain for Cn = 10\mu(F)');
        ylabel('Magnitude');
        xlabel('Frequency');
        X=fft(mili_ten(2,:));
        Y=fft(mili_ten(3,:));
        subplot(3,1,3);
        hold on;
        plot(finite_difference,fftshift(abs(X)),'Color','black');
        plot(finite_difference,fftshift(abs(Y)),'Color','red');
        hold off;
        axis([-30 30 0 500])
        legend('V_i','V_O');
        title('Frequency Domain for Cn = 10\mu(F)');
        ylabel('Magnitude');
        xlabel('Frequency');
    end

    figure(15)
    subplot(2,1,iter)
    row=1;
    mu=zeros(3,timesteps+1);
    mu(:,:)=Nodal_Voltage_withNoise(row,:,:);
    hold on;
    plot(mu(1,:),mu(2,:),'Color','black');
    plot(mu(1,:),mu(3,:),'Color','red');
    hold off;
    legend('V_i','V_O');
    title(['Voltages with Noise for Different Timesteps. ',num2str(timesteps),' timesteps']);
    ylabel('Voltage');
    xlabel('Time');
    iter = iter + 1; 
end


