*$include C:\Users\gabriela.bregadioli\Desktop\Leticia\IMPLEMENTAÇÃO GAMS\comparação pratica Toledo\IMPLEMENTAÇÃO GAMS.24.1\dados10.gms
$include C:\Users\lemiq\Desktop\Mestrado\IMPLEMENTAÇÃO GAMS\comparação pratica Toledo\IMPLEMENTAÇÃO GAMS.24.1\dados3.gms
*$include G:\IMPLEMENTAÇÃO GAMS.24\dados1.gms

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
a(j,t)

des(j,t);



x.fx(j,'t0') = 0;


Equations
*modelo
*OBJ, R1, R2, R3, R4, R5, R6, R7, R8, R9, R11;
*h
OBJ, R1, R2, R3, R4, R19, R20, R24, R25, R26, R27;



OBJ.. F =E= sum(t$(ord(t)>1),sum(j,c(j,t)*x(j,t)+sc(j,t)*a(j,t))) + sum(t$(ord(t)>1),sum(j,sum(l,ct(j,l,t)*z(j,l,t))));
*custo com energia relacionados ao funcionamento e acionamento das bombas de captação e transferencia

R1(j,t)$(ord(t)>1).. is(j,t) =E= (1-p)*is(j,t-1) + v(j,t)*x(j,t) + sum(l,w(l,j,t)*z(l,j,t)) - sum(l,w(j,l,t)*z(j,l,t)) - sum(k,d(j,k,t));
*balanceamento de estoque

R2(j,t)$(ord(t)>1).. a(j,t) =G= x(j,t) - x(j,t-1);
*se a bomba ficou loada durante todo o periodo anterior ela pode ser utilizada sem custo de acionamento

R3(j,t)$(ord(t)>1).. min(j) =L= is(j,t);
R4(j,t)$(ord(t)>1).. is(j,t) =L= max(j);
*volumes min e max

*R5(j,t,tl)$((ord(t)>1) and (ord(t) <= ord(tl) and ord(tl) <= (ord(t) + tau))).. a(j,t) =L= x(j,tl);
*tempo minimo ligada

*R6(j,k,t)$((ord(t)>1)  and (d(j,k,t) > 0)).. sum(i,db(i,'linf')*y(i,k,t)) =L= d(j,k,t);
*R7(j,k,t)$((ord(t)>1)  and (d(j,k,t) > 0)).. d(j,k,t) =L= sum(i,db(i,'lsup')*y(i,k,t));
*demanda em uma faixa

*R8(k,t).. sum(i,y(i,k,t)) =L= 1;
*volume em uma faixa de demanda

*R9(j,k,t)$(ord(t)>1).. is(j,t) =G= sum(i,y(i,k,t)*vol(j,i));
*estoque maior que a soma das faixas

*R11(j).. is(j,'t24') =L= (1+b)*is(j,'t0');
*estoque final = % estoque inicial




*heuristica



R19(j,t)$(ord(t)>1).. -a(j,t) * (max(j) - min(j)) =L= is(j,t-1) - (1+omega)*min(j);
R20(j,t)$(ord(t)>1).. is(j,t-1) - (1+omega)*min(j) =L= (1-a(j,t))*(max(j)-min(j));
*- m*a(j,t);
*liga bomba

R24(j,t)$(ord(t)>1).. a(j,t) + des(j,t) =L= 1;
R25(j,t)$(ord(t)>1).. a(j,t) - des(j,t) =E= x(j,t) - x(j,t-1);
*liga/desliga

R26(j,t)$(ord(t)>1).. m -des(j,t) * (max(j) - min(j)) =L= ((1-omega)*max(j)) - is(j,t-1);
R27(j,t)$(ord(t)>1).. ((1-omega)*max(j)) - is(j,t-1) =L= (1-des(j,t))*(max(j)-min(j));
*desliga no maximo


MODEL agua /all/;
OPTION MIP=CPLEX;
SOLVE agua using MIP minimizing F;


* imprimindo resultados

*file resultados/ resultados_Leticia.gdx/;
*resultados.pc=6;
*resultados.nd=4;
*put resultados;

*put 'Resultados da Letícia' put '' /;

*loop(i,
*         put i.tl put y.l(i) put /;
*);



****************MODELO GABRIELA


*imprimir resultados no excel

*         nome do arquivo       nome do arquivo.excel

**file res_modelo_curto_prazo/ res_modelo_curto_prazo.gdx/;
**res_modelo_curto_prazo.pc=6;
**res_modelo_curto_prazo.nd=4;
**put res_modelo_curto_prazo;



* quando quer fazer conta com os resultados

*           nome do resultado

**PARAMETER GER_T_H, GER_T_T, CUSTO, VOL_T, DEM_T;

*          contas

**         GER_T_H = SUM(J$(DADOS_J(J,'TIPO') eq 1), SUM(T, pg.l(j,t)));
**         GER_T_T = SUM(J$(DADOS_J(J,'TIPO') eq 2), SUM(T, pg.l(j,t)));
**         DEM_T = sum(I, sum (T, pd.l(i,t)));
**         CUSTO = sum(T, sum (I, sum(M, LDb(i,m,t)*pDb.L(m,i,t)))) - SUM(T, SUM(J, SUM (N,   LGb(j,n,t)*pGb.L(n,j,t))));
**         VOL_T = SUM(j, V.L(J,'T24'));

*          imprimindo resultados

**PUT GER_T_H  put '&' put GER_T_T  put '&' put DEM_T  put '&' put CUSTO  put '&' put VOL_T;
