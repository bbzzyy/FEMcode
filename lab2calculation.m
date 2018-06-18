clear
clc
syms s
s_y=1;
t_v=3;
t_h=1;
b=20;
h=40;
Ixx_v=t_v*(h^3)/12;
Ixx_h=(t_h^3)*(b-t_v)/12+(((h-t_h)/2)^2)*(t_h*(b-t_v));
%moment of inertia
Ixx=Ixx_v+2*Ixx_h;
s1=b-(t_v/2);
s2=h-t_h;
s3=s1;

y1=@(s_1) -(h-t_h)/2+(s_1*0);
q12=-(s_y*t_h/Ixx)*int(y1,0,s);
q_12=q12+0;
q2=subs(q_12,'s',{s1});

y2=@(s_2) s_2-((h-t_h)/2);
q23=-(s_y*t_v/Ixx)*int(y2,0,s);
q_23=q23+q2;
q3=subs(q23,'s',{s2})+q2;

y3=@(s_3) (h-t_h)/2+(s_3*0);
q34=-(s_y*t_h/Ixx)*int(y3,0,s);
q_34=q34+q3;
q4=subs(q34,'s',{s3})+q3;

M_h=double(int(q_12*(h-t_h)/2,s,0,(b-t_v/2)));
M=2*M_h;
c=M


