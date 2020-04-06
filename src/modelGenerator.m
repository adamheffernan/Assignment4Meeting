function [C,G] = modelGenerator(R_1,R_2,R_3,R_4,R_O,C_1,C_n,L_1,alpha)

% V = [ V1; V2; V3; V4; V5; IL; In]

%%Creating Matrix with the KCL equations at each node


G=zeros(6);
C=zeros(6);

%% V1
G(1,:)=[1 0 0 0 0 0]; % V1
C(1,:)=[0 0 0 0 0 0]; % V1

%% V2
G(2,:)=[(-1/R_1) (1/R_2+1/R_1) 0 0 0 1]; 
C(2,:)=[-C_1 +C_1 0 0 0 0];

%% V3
G(3,:)=[0 0 1/R_3 0 0 -1]; 
C(3,:)=[0 0 C_n 0 0 0]; 

%% V4
G(4,:)=[0 0 (-1*alpha/R_3) 1 0 0]; 
C(4,:)=[0 0 0 0 0 0]; 

%% V5
G(5,:)=[0 0 0 -1/R_4 (1/R_4+1/R_O) 0]; 
C(5,:)=[0 0 0 0 0 0];

%% V6
G(6,:)=[0 -1 1 0 0 0]; 
C(6,:)=[0 0 0 0 0 L_1]; 
end

