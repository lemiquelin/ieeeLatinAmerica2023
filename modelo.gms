$include C:\Users\lemiq\Desktop\Mestrado\IMPLEMENTAÇÃO GAMS\testes Toledo\IMPLEMENTAÇÃO GAMS.24.1\dados1.gms

Variables
F;


Positive Variables

*estoque de cada reservatorio j no periodo t
is(j,t);
is.fx(j,'t0')  =  270;

Binary Variables

*se a bomba j está acionada no periodo t
x(j,t)

*se há transferencia do reservatorio j para l no periodo t
z(j,l,t)

*se a demanda se encontra na faixa
y(i,k,t)

*se a bomba j é acionada no período t
a(j,t);

x.fx(j,'t0') = 0;


Equations
OBJ, R1, R2, R3, R4, R5, R6, R7, R8, R9, R11;
*R10, R11;


OBJ.. F =E= sum(t$(ord(t)>1),sum(j,c(j,t)*x(j,t)+sc(j,t)*a(j,t))) + sum(t$(ord(t)>1),sum(j,sum(l,ct(j,l,t)*z(j,l,t))));
*custo com energia relacionados ao funcionamento e acionamento das bombas de captação e transferencia

R1(j,t)$(ord(t)>1).. is(j,t) =E= (1-p)*is(j,t-1) + v(j,t)*x(j,t) + sum(l,w(l,j,t)*z(l,j,t)) - sum(l,w(j,l,t)*z(j,l,t)) - sum(k,d(j,k,t));
*balanceamento de estoque

R2(j,t)$(ord(t)>1).. a(j,t) =G= x(j,t) - x(j,t-1);
*se a bomba ficou loada durante todo o periodo anterior ela pode ser utilizada sem custo de acionamento

R3(j,t)$(ord(t)>1).. min(j) =L= is(j,t);
R4(j,t)$(ord(t)>1).. is(j,t) =L= max(j);
*volumes min e max

R5(j,t,tl)$((ord(t)>1) and (ord(t) <= ord(tl) and ord(tl) <= (ord(t) + tau))).. a(j,t) =L= x(j,tl);
*tempo minimo ligada

R6(j,k,t)$((ord(t)>1)  and (d(j,k,t) > 0)).. sum(i,db(i,'linf')*y(i,k,t)) =L= d(j,k,t);
R7(j,k,t)$((ord(t)>1)  and (d(j,k,t) > 0)).. d(j,k,t) =L= sum(i,db(i,'lsup')*y(i,k,t));
*demanda em uma faixa

R8(k,t).. sum(i,y(i,k,t)) =L= 1;
*volume em uma faixa de demanda

R9(j,k,t)$(ord(t)>1).. is(j,t) =G= sum(i,y(i,k,t)*vol(j,i));
*estoque maior que a soma das faixas

*R10(j).. (1-b)*is(j,'t0') =L= is(j,'t24');
R11(j).. is(j,'t24') =L= (1+b)*is(j,'t0');
*estoque final = % estoque inicial


MODEL agua /all/;
OPTION MIP = CPLEX;
SOLVE agua using MIP minimizing F;

