%%ECE5200 Hung-Hsiu Yen(yen.142)
%Problem 1(c)
weight_ls=firls(11*15-1,[0 0.8 1.2 2.8 3.2 4.8 5.2 6.8 7.2 8.8 9.2 10.8 11.2 12.8 13.2 15]/15,[15 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);
poly_weight_ls = reshape(weight_ls,[15,11]);%each row is a polyphase filter

[H1, omega1] = freqz(weight_ls,1,512);
f1 = omega1/pi;


subplot(3,1,1);
plot(f1, 20*log10(abs(H1)),'LineWidth',2);
grid on;
title('Weighted Least Squares')
xlabel('Normalized Frequency (xpi rad/sample) ') 
ylabel('Magnitude (dB)') 
axis([0,1,-70,30]);


subplot(3,1,2);
for i=1:15
  hold on
  [H2, omega2] = freqz(poly_weight_ls(i,:),1,512);
  f2 = omega2/pi;
  plot(f2, 20*log10(abs(H2)),'LineWidth',2);
  grid on;
  title('Polyphase Filter')
  xlabel('Normalized Frequency (xpi rad/sample) ') 
  ylabel('Magnitude (dB)')  
  axis([0,1,-0.5,0.5]); 
end

subplot(3,1,3);
for i=1:15
     hold on
     gd=grpdelay(poly_weight_ls(i,:));
     plot(f2, gd,'LineWidth',2);
     title('Group Delay');
     xlabel('Normalized Frequency (xpi rad/sample) ') 
     ylabel('Group Delay (samples)') 
     grid on;
     axis([0,1,4,6]);
end
%%
%Problem 1(d)
equi_ripple=firpm(11*15-1,[0 0.8 1.2 2.8 3.2 4.8 5.2 6.8 7.2 8.8 9.2 10.8 11.2 12.8 13.2 15]/15,[15 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);
poly_equi_ripple = reshape(equi_ripple,[15,11]);%each row is a polyphase filter


[H1, omega1] = freqz(equi_ripple,1,512);
f1 = omega1/pi;

subplot(3,1,1);
plot(f1, 20*log10(abs(H1)),'LineWidth',2);
grid on;
title('Equiripple')
xlabel('Normalized Frequency (xpi rad/sample) ') 
ylabel('Magnitude (dB)') 
axis([0,1,-70,30]);


subplot(3,1,2);
for i=1:15
  hold on
  [H2, omega2] = freqz(poly_equi_ripple(i,:),1,512);
  f2 = omega2/pi;
  plot(f2, 20*log10(abs(H2)),'LineWidth',2);
  grid on;
  title('Polyphase Filter')
  xlabel('Normalized Frequency (xpi rad/sample) ') 
  ylabel('Magnitude (dB)')  
  axis([0,1,-0.5,0.5]); 
end

subplot(3,1,3);
for i=1:15
     hold on
     gd=grpdelay(poly_equi_ripple(i,:));
     plot(f2, gd,'LineWidth',2);
     title('Group Delay');
     xlabel('Normalized Frequency (xpi rad/sample) ') 
     ylabel('Group Delay (samples)') 
     grid on;
     axis([0,1,4,6]);
end
%%
%Problem 1(e)
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

[H1, omega1] = freqz(master_filter,1,512);
f1 = omega1/pi;

subplot(3,1,1);
plot(f1, 20*log10(abs(H1)),'LineWidth',2);
grid on;
title('Hamming')
xlabel('Normalized Frequency (xpi rad/sample) ') 
ylabel('Magnitude (dB)') 
axis([0,1,-70,30]);

subplot(3,1,2);
for i=1:15
  hold on
  [H2, omega2] = freqz(poly_master_filter(i,:),1,512);
  f2 = omega2/pi;
  plot(f2, 20*log10(abs(H2)),'LineWidth',2);
  grid on;
  title('Polyphase Filter')
  xlabel('Normalized Frequency (xpi rad/sample) ') 
  ylabel('Magnitude (dB)')  
  axis([0,1,-0.5,0.5]); 
end

subplot(3,1,3);
for i=1:15
     hold on
     gd=grpdelay(poly_master_filter(i,:));
     plot(f2, gd,'LineWidth',2);
     title('Group Delay');
     xlabel('Normalized Frequency (xpi rad/sample) ') 
     ylabel('Group Delay (samples)') 
     grid on;
     axis([0,1,4,6]);
end