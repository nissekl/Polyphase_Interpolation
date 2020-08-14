	
%%ECE5200 Hung-Hsiu Yen(yeb.142)
%Problem 2(a)
%full-bandwidth signal 
rng(0);
u = randn(1,1000);
full_sig = 20*log10(abs(fft(u,8192)));



%Weight-LS 
pass_stop_band = [0 0.6 0.8 1];
A = [1 1 0 0];
W = [1 1];
filter_sig = firls(50,pass_stop_band,A,W);


%Filtering
x=conv(u,filter_sig);
sig_after_filter = 20*log10(abs(fft(x,8192)));
freq = linspace(0,2,8192);

subplot(2,1,1);
plot(freq,full_sig,'LineWidth',2);
grid on;
xlim([0 1]);
title('Random full-bandwidth signal ')
xlabel('Normalized Frequency (xpi rad/sample) ') 
ylabel('Magnitude (dB)') 

subplot(2,1,2);
plot(freq, sig_after_filter,'LineWidth',2);
grid on;
xlim([0 1]);
title('Random Filter-bandwidth signal ')
xlabel('Normalized Frequency (xpi rad/sample) ') 
ylabel('Magnitude (dB)') 



%%
%Problem 2(b) Weighted Least Squares
weight_ls=firls(11*15-1,[0 0.8 1.2 2.8 3.2 4.8 5.2 6.8 7.2 8.8 9.2 10.8 11.2 12.8 13.2 15]/15,[15 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);
poly_weight_ls = reshape(weight_ls,[15,11]);%each row is a polyphase filter
ym1=zeros(1,15900);
for i = 1:15
    vn1=conv(poly_weight_ls(i,:),x);
    upsample_vn1 = upsample(vn1,15); 
    upsample_vn1_de = circshift(upsample_vn1,i-1);
    ym1=ym1+upsample_vn1_de;
end

subplot(3,1,1)
x_up=upsample(x,15);
new_ym1=ym1(83:end);
m = 500*15:510*15;
stem(m/15, x_up(m))
hold on
plot(m/15, new_ym1(m))
title('Weighted Least Squares')



%Problem 2(c) Equiripple
equi_ripple=firpm(11*15-1,[0 0.8 1.2 2.8 3.2 4.8 5.2 6.8 7.2 8.8 9.2 10.8 11.2 12.8 13.2 15]/15,[15 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);
poly_equi_ripple = reshape(equi_ripple,[15,11]);%each row is a polyphase filter
ym2=zeros(1,15900);
for i = 1:15
    vn2=conv(poly_equi_ripple(i,:),x);
    upsample_vn2 = upsample(vn2,15);
    upsample_vn2_de = circshift(upsample_vn2,i-1);
    ym2=ym2+upsample_vn2_de;
end

subplot(3,1,2)
x_up=upsample(x,15);
new_ym2=ym2(83:end);
m = 500*15:510*15;
stem(m/15, x_up(m))
hold on
plot(m/15, new_ym2(m))
title('Equiripple')


%Problem 2(d) hamming
ham_w = (hamming(11))';
master_filter=[];
for p=0:14
    hp=[];
    for n = 0:10
        hp = [hp,sinc((15*n-82+p)/15)];
        %hp = [hp,n*15+p];%for index checking
    end
    master_filter=[master_filter;hp.*ham_w];%each row is a polyphase filter
    %master_filter=[master_filter;hp];%for index checking
end

master_filter=reshape(master_filter,1,[]);
poly_master_filter = reshape(master_filter,[15,11]);%each row is a polyphase filter
ym3=zeros(1,15900);
for i = 1:15
    vn3=conv(poly_master_filter(i,:),x);
    upsample_vn3 = upsample(vn3,15);
    upsample_vn3_de = circshift(upsample_vn3,i-1);
    ym3=ym3+upsample_vn3_de;
end
subplot(3,1,3)
x_up=upsample(x,15);
new_ym3=ym3(83:end);
m = 500*15:510*15;
stem(m/15, x_up(m))
hold on
plot(m/15, new_ym3(m))
title('Hamming')
