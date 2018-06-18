function [Qe]=elq(le,q,qt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element load vector
% File name: elq.m
% 
% le [m]	Element length
% q  [N/m]	Element pressure load (constant in this version)
% Qe is returned - element load vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x le1 q1 qt1
N1=1-3*(x/le1)^2+2*(x/le1)^3;
N2=-x+2*(x^2/le1)-(x^3/le1^2);
N3=1-x/le1;
N4=3*(x/le1)^2-2*(x/le1)^3;
N5=(x^2/le1)-(x^3/le1^2);
N6=x/le1;
N_b=[N1 N2 0 N4 N5 0];%shape function of bending
N_t=[0 0 N3 0 0 N6];%shape function of torsion
qe_b=q1*N_b';
qe_t=qt1*N_t';
Qe_b=int(qe_b,x,0,le1);
Qe_t=int(qe_t,x,0,le1);
Qe=Qe_b+Qe_t;
Qe=subs(Qe,'le1,q1,qt1',{le,q,qt});
Qe=double(Qe);
end