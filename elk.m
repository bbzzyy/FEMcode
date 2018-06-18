function [Ke]=elk(le,EI,GJ)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element stiffness matrix
% File name: elk.m
% 
% le [m]	Element length
% EI [Nm2]	Element bending stiffness (constant in this version)
% GJ [Nm2]	Element torsional stiffness (constant in this version)
%
% Ke is returned - element stiffness matrix
%
% Make sure the stiffness matrix is symmetric!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x le1 EI1 GJ1
N1=1-3*(x/le1)^2+2*(x/le1)^3;
N2=-x+2*(x^2/le1)-x^3/(le1^2);
N3=1-x/le1;
N4=3*(x/le1)^2-2*(x/le1)^3;
N5=(x^2/le1)-(x^3/le1^2);
N6=x/le1;
N_b=[N1 N2 0 N4 N5 0];%shape function of bending
N_t=[0 0 N3 0 0 N6];%shape function of torsion
G=diff(N_b,2);
B=diff(N_t);
Kb=G'*EI1*G;
Kt=B'*GJ1*B;
Keb=int(Kb,x,0,le1);%stiffness matrix of bending
Ket=int(Kt,x,0,le1);%stiffness matrix of torsion
Ke=Keb+Ket;
Ke=subs(Ke,'le1,EI1,GJ1',{le,EI,GJ});
Ke=double(Ke);
% Ke=[12*EI/(le^3) -6*EI/(le^2) 0 -12*EI/(le^3) -6*EI/(le^2) 0;
%     -6*EI/(le^2) 4*EI/(le) 0 6*EI/(le^2) 2*EI/(le) 0;
%     0 0 GJ/le 0 0 -GJ/le;
%     -12*EI/(le^3) 6*EI/(le^2) 0 12*EI/(le^3) 6*EI/(le^2) 0;
%     -6*EI/(le^2) 2*EI/(le) 0 6*EI/(le^2) 4*EI/(le) 0;
%     0 0 -GJ/le 0 0 GJ/le];
end