function [defl,teta,fi,umax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate deformed beam bending and torsion shape and plot results
% File name: bending.m
%
% Ks		Structural stiffness matrix
% Qs		Structural load vector
% K		System stiffness matrix 
% Q		System load vector
% nnode         number of nodes
% node_z          nodal z-coordinates
%
% defl		deflection vector of size nnodes
% teta		rotation vector of size nnodes
% fi            twist vector of size nnodes
% umax          maximum deflection
% tmax       maximum rotation
% fimax		maximum twist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[i,~]=size(K);
Kpp=K(1:3,1:3);Kpf=K(1:3,4:i);
Kfp=K(4:i,1:3);Kff=K(4:i,4:i);
Wp=[0 0 0]';%boundary condition of displacement
Wf=[];%displacement
defl=[];
teta=[];
fi=[];
Qp=Q(1:3,1);
Qf=Q(4:i,1);
% Solve equation system
Wf=Kff\Qf;
% Reaction loads are calculated
R=Kpf*Wf-Qp;
% Create result vector containing deflections, rotations and twist
% Separate deflections, rotations and twist in separate vectors
defl(1)=0;
teta(1)=0;
fi(1)=0;%boundary condition
for i=2:nnode
    defl(i)=Wf(3*i-5);
    teta(i)=Wf(3*i-4);
    fi(i)=Wf(3*i-3);
end
% Normalise deflections, rotations and twist and plot results
defln=normc(defl');
tetan=normc(teta');
fin=normc(fi');
%plot
figure
subplot(3,1,1)
plot(node_z,defln);title('Deflection of bending');
subplot(3,1,2)
plot(node_z,tetan);title('Rotation of bending');
subplot(3,1,3)
plot(node_z,fin);title('Twist of bending');
% Compute the maximum value
umax=defl(nnode);
tmax=teta(nnode);
fimax=fi(nnode);
% Reaction forces printout
end