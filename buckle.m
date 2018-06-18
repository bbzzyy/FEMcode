function [pb,ub]=buckle(Ks,Ksigmas,nnode,node_z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve beam buckling equation
% File name: buckle.m
% 
% Ks        Structural stiffness matrix
% Ksigmas	Structural inital stiffness matrix
% nnode     number of nodes
% node_z    nodal x-coordinates
%
% pb		Buckling load vector, in numerical order
% ub		matrix of eigenvalue dofs
% 		(row i of ub is buckling mode of buckling load i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate eigenvalues and eigenvectors
[V,D]=eig(Ks,-Ksigmas);%V is eigenvector, D is eigenvalue
ub=V;
[~,n]=size(Ks);
pb=sum(D);
ubn=roundn(ub,-2);

%%Create result vector containing deflections, rotations and twist
% for i=1:n
%     if ubn(3,i)~=0
%         Pcr_t=pb(i);
%         W_t=ubn(:,i);
%         break
%     end
% end
% % W_b=ub(:,101);%test
% for i=1:n
%     if ubn(3,i)==0
%         Pcr_b=pb(i);
%         W_b=ubn(:,i);
%         break
%     end
% end

% separate deflections, rotations and twist in separate vectors
% defl_b(1)=0;
% teta_b(1)=0;
% fi_t(1)=0;%boundary condition
% for i=2:nnode
%     defl_b(i)=W_b(3*i-5);
%     teta_b(i)=W_b(3*i-4);
%     fi_t(i)=W_t(3*i-3);
% end
% Normalise deflections, rotations and twist for plotting purposes
% only if columns contain elements <> 0
% defl_bn=normc(defl_b);
% teta_bn=normc(teta_b);
% fi_tn=normc(fi_t);
% % Plot buckling modes
% figure
% subplot(2,1,1)
% plot(node_z,defl_b);title('Deflection of buckling');
% subplot(2,1,2)
% plot(node_z,teta_b);title('Rotation of buckling');
% figure
% plot(node_z,fi_t);title('Twist of buckling');
end