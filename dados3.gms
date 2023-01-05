*demanda media

Set
*numero de reservatorios
j /1*3/;
alias(j,l);


Set
*periodos incluido t=0
t /t0*t24/;
alias(t,tl);


Set
*centros consumidores
k /1*3/;

Set
*faixas de demanda
i /1*3/;

Table
*limites das faixas de demanda
db(i,*)
  linf lsup
1    0  100
2  100  200
3  200  300;

Table
*demanda do centro k no periodo t
d(j,k,t)
     t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1.1  10  15  16  15  20  20  90 115 131  190  152  187  193  208  214  229  255  265  260  208  150   73   20    5
1.2   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
1.3   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.1   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.2  10  10  10  18  20  20  95 125 141  190  170  187  193  218  234  239  255  270  265  218  155   88   30   13
2.3   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
3.1   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
3.2   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
3.3  15  15  20  20  22  30 100 105 121  197  162  167  183  198  214  229  245  260  260  198  135   73   10   5;

Table
*custo de manter ligada a bomba j no periodo t
c(j,t)
   t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1  30  30  30  30  30  30  30  30  30   30   30   30   30   30   30   30   30   60   60   60   30   30   30   30
2  30  30  30  30  30  30  30  30  30   30   30   30   30   30   30   30   30   60   60   60   30   30   30   30
3  30  30  30  30  30  30  30  30  30   30   30   30   30   30   30   30   30   60   60   60   30   30   30   30;

Table
*custo de partida da bomba j no periodo t
sc(j,t)
   t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
2   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
3   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1;

Table
*vaz�o da bomba j no per�odo t
v(j,t)
   t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1 300 300 300 300 300 300 300 300 300  300  300  300  300  300  300  300  300  300  300  300  300  300  300  300
2 300 300 300 300 300 300 300 300 300  300  300  300  300  300  300  300  300  300  300  300  300  300  300  300
3 300 300 300 300 300 300 300 300 300  300  300  300  300  300  300  300  300  300  300  300  300  300  300  300;

Table
*vaz�o da bomba j para l no per�odo t
w(j,l,t)
      t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1.1    0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
1.2   50  50  50  50  50  50  50  50  50   50   50   50   50   50   50   50   50   50   50   50   50   50   50   50
1.3    0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.1   50  50  50  50  50  50  50  50  50   50   50   50   50   50   50   50   50   50   50   50   50   50   50   50
2.2    0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.3   50  50  50  50  50  50  50  50  50   50   50   50   50   50   50   50   50   50   50   50   50   50   50   50
3.1    0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
3.2   50  50  50  50  50  50  50  50  50   50   50   50   50   50   50   50   50   50   50   50   50   50   50   50
3.3    0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0;


Parameter
*volume min do reservatorio j
min(j)
/1 270
 2 270
 3 270/;

Parameter
*volume max do reservatorio j
max(j)
/1 2000
 2 1000
 3 1000/;

Table
*custo de transferencia do reservat�rio j para l no per�odo t
ct(j,l,t)
     t1  t2  t3  t4  t5  t6  t7  t8  t9  t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
1.1   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
1.2   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
1.3   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.1   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
2.2   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
2.3   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
3.1   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
3.2   1   1   1   1   1   1   1   1   1    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
3.3   0   0   0   0   0   0   0   0   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0;

Scalar
p /0.1/;

Table
*estoque em t=0
jose(j,t)
  t0
1 270
2 270
3 270;

Table
*fra��o de t=0 que a bomba � acionada
maria(j,t)
  t0
1  0
2  0
3  0;

Scalar
tau /2/;

Table
vol(j,i)
    1   2   3
1 270 300 350
2 270 300 350
3 270 300 350;

Scalar
b /0.25/;
