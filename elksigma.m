function [Kesigma]=elksigma(le,P,I0,A)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element initial stress stiffness matrix
% File name: elksigma.m
% 
% le [m]	Element length
% P  [N]	"Tensile" buckling load
% Kesigma is returned - element initial stress matrix
%
% Make sure the initial stress matrix is symmetric!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x le1 P1 I01 A1
N1=1-3*(x/le1)^2+2*(x/le1)^3;
N2=-x+2*(x^2/le1)-x^3/(le1^2);
N3=1-x/le1;
N4=3*(x/le1)^2-2*(x/le1)^3;
N5=(x^2/le1)-(x^3/le1^2);
N6=x/le1;
N_b=[N1 N2 0 N4 N5 0];%shape function of bending
N_t=[0 0 N3 0 0 N6];%shape function of torsion
B_b=diff(N_b);
B_t=diff(N_t);
Kb=B_b'*P1*B_b;
Kt=B_t'*(I01*P1/A1)*B_t;
Kesigma_b=int(Kb,x,0,le1);
Kesigma_t=int(Kt,x,0,le1);
Kesigma=Kesigma_b+Kesigma_t;
Kesigma=subs(Kesigma,'le1,P1,I01,A1',{le,P,I0,A});
Kesigma=double(Kesigma);
end