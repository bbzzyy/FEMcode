%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program
% Beam FE-code for bending about 1-axis and St.Venant torsion
%
% Use SI units exclusively
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc
% Definitions and input data
L=0.5;        % Length in [m]
E=7E+10;	% Youngs modulus [N/m2]
G=2.6923E+10;	% Shear modulus [N/m2]
I=32000E-12;	% Moment of inertia about x-axis [m4] Ixx
J=(1120/3)*10^-12;	% Torsional constant [m4]
EI=E*I;		% Bending stiffness [Nm2]
GJ=G*J;		% Torsional stiffness [Nm2]
I0=(136000/3)*10^-12;	% Polar moment of inertia [m4]
A=160E-6;	% Cross-section area [m2]
ro=2700;	% Material density [kg/m3]
J0=I0*ro;	% Mass moment of inertia [kgm]

% L=1;        % Length in [m]
% E=1;	% Youngs modulus [N/m2]
% G=1;	% Shear modulus [N/m2]
% I=1;	% Moment of inertia about x-axis [m4] Ixx
% J=1;	% Torsional constant [m4]
% EI=E*I;		% Bending stiffness [Nm2]
% GJ=G*J;		% Torsional stiffness [Nm2]
% I0=1;	% Polar moment of inertia [m4]
% A=1;	% Cross-section area [m2]
% ro=1;	% Material density [kg/m3]
% J0=I0*ro;	% Mass moment of inertia [kgm]

% Loads and masses
m=A*ro;		% mass per unit length of elements [kg/m]
q=0;            % Distributed load [N/m]
qt=0;		% Distributed torque [Nm/m]
S=0;           % Concentrated load at end of beam [N]
T=0;		% Beam end torque [Nm]
P=-1;		% Buckling load [N],-1

% Element input data
nelem=50;               % number of elements
% nelem=1;                % test
le=L/nelem;             % length of elements for even distribution
ndof=3*(nelem+1);	% number of degrees of freedom
nnode=nelem+1;		% number of nodes

% node coordinates
node_z=zeros(nnode,1);
for i=1:nnode
        node_z(i)=le*(i-1);
end

% Assmble stiffness, load, mass and initial stress matrix of the system
[K,Q,M,Ksigma]=assemble(le,EI,GJ,I0,A,J0,q,qt,S,T,m,P,ndof,nelem);

% Apply boundary conditions
% Remove locked dofs at x=0
% K,Q,M and Ksigma are now reduced and structural matrices formed
Ks=K(4:ndof,4:ndof);
Qs=Q(4:ndof);
Ms=M(4:ndof,4:ndof);
Ksigmas=Ksigma(4:ndof,4:ndof);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve beam bending and torsion equation
% and present results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [defl,teta,fi,umax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve beam buckling equation
% and plot results
% The torsional buckling modes will all give identical load factors
% pb is a vector of buckling loads, given in ascending order
% ub is a matrix of corresponding buckling modes
% (row i of ub is buckling mode of buckling load i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pb,ub]=buckle(Ks,Ksigmas,nnode,node_z);

% solve('(p-5526.98)*((136000/160*3)*(p-38644.89))-(p*7.5)^2=0','p')
