close
clear

//GERAL
N = 8  //number of symbols
O = 2   //tx oversample

uf_n = 1:(O*N)
ef_n = 1:(O*N)
df_n  = ef_n
uf = uf_n //inicializa
ef = ef_n //inicializa
df = df_n //inicializa

//gera a mensagem
tmp = grand(1, N, "uin", -3, 3)

//gera a mensagem sobreamostrada
for i = 1:N
    for j = 1:O
        uf(O*i-O+j) = tmp(i);
    end
end

//gera o ruído
noise = ( grand(1, N*O, "uin", -100, 100) ) / 1000

//DCT
jam   = ones(O*N) - 2*grand(1, O*N, "uin", 0, 1) 
//wjam  = ones(O*N) - 2*grand(1, O*N, "uin", 0, 1) 
wjam = jam

//jam   = ones(O*N)
dct_type = "dct4"
norm_factor = 1/(2*N*O)
tmp1 = dct(uf,1,dct_type)

ef = norm_factor*dct((tmp1 . *jam),-1,dct_type)//+ jam2)

ef = ef //+ noise

tmp2 = dct(ef,1,dct_type)

df = norm_factor*dct((tmp2 . *wjam),-1,dct_type)//- jam2)

tmp3 = dct(uf,1,dct_type)


subplot (331)
xtitle('input')
plot2d2 (uf_n,uf)
//plot2d2 (n,m)
subplot (332)
xtitle('line')
plot2d2 (ef_n,ef)

subplot (333)
xtitle('output')
//plot2d2 (n,r)
plot2d2(df_n,df)
subplot (334)
xtitle ('fft(m)')
plot2d3(uf_n,tmp1)
subplot (335)
xtitle ('fft(x)')
plot2d3(ef_n,tmp2)
subplot (336)
xtitle ('fft(r)')
plot2d3(uf_n,tmp3)

//subplot (337)
//xtitle ('fft(r)')
//plot2d2(uf_n,uf+noise)
