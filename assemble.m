function [K,Q,M,Ksigma]=assemble(le,EI,GJ,I0,A,J0,q,qt,S,T,m,P,ndof,nelem)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble system stiffness matrix, load vector, mass matrix (not necessary)
% and initial stress matrix
% File name: assemble.m
%
% K		System stiffness matrix
% Q		System load vector
% M		System mass matrix
% Ksigma        System initial stress matrix
%
% le		element length [m]
% EI		element bending stiffness [Nm2]
% GJ		element torsional stiffness [Nm2]
% I0		element polar moment of inertia [m4]
% A		element cross-section area [m2]
% J0		element mass moment of inertia [kgm]
% q             element transverse pressure load [N/m]
% qt            element torsion pressure load [Nm/m]
% S             transverse point load [N]
% T             local torque [Nm]
% m		element mass per unit length [kg/m]
% P		applied buckling load [N], positive if tensile
% ndof		number of degrees of freedom
% nelem		number of elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% matrix for one element
Ke=elk(le,EI,GJ);%stiffness matrix for one element
Kesigma=elksigma(le,P,I0,A);%initial stress matrix for one element
Qe=elq(le,q,qt);%load 
%% assemble
K=zeros(ndof);
Q=zeros(ndof,1);
M=zeros(ndof);
Ksigma=zeros(ndof);
n=0;
for i=1:nelem
    K(n+1:n+6,n+1:n+6)=K(n+1:n+6,n+1:n+6)+Ke;
    Ksigma(n+1:n+6,n+1:n+6)=Ksigma(n+1:n+6,n+1:n+6)+Kesigma;
    Q(n+1:n+6,1)=Q(n+1:n+6,1)+Qe;
    n=n+3;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add concentrated loads
[m,~]=size(Q);
Q(m-2)=Q(m-2)+S;%add point load
Q(m)=Q(m)+T;%add point torque
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end