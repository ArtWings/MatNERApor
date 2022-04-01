%---------------------- Script description --------------------------------
% The script to apply the set of Butterwoth filters to input accelerogram to simulate 
% reduction of spectrum for vertical component due to the presence of water
% column above the site
%------------------------------- Input ------------------------------------

acc = ACC1;             % input accelerogram [cm/s^2] from workspace
FilterSet = bsFilt;     % cell array with set of Butterworth filters objects
Ftheor = F;             % theoretical water column reduction spectrum 
ftheor = f;             % corresponding frequency vector (for F spectrum)
sm = 20;                % number of points for smoothing FFT spectra

%------------------------------ Output ------------------------------------
% acc_filt  - filtered accelerogram;
%--------------------------------------------------------------------------
      
acc_filt = acc;
for i = 1:1:length(FilterSet)
    acc_filt = filter(FilterSet{i}, acc_filt);
end

NFFT_acc = 2^nextpow2(length(acc));
bbb = Fs/2*linspace(0, 1, NFFT_acc/2+1);
fourier_acc = fft(detrend(acc), NFFT_acc);

NFFT_acc_filt = 2^nextpow2(length(acc_filt));
fourier_acc_filt = fft(detrend(acc_filt), NFFT_acc_filt);

norm_factor = max(smooth(abs(fourier_acc(1:NFFT_acc/2+1)), sm));
dt = 1/Fs;
t = (1:1:length(acc))*dt;

figure(1)
subplot(2,1,1); plot(t, acc, 'k')
set(gca, 'FontSize', 15);
xlabel('Time, s');
legend('input acc','Location','northeast');
set(gca,'FontAngle', 'italic');

subplot(2,1,2); plot(t, acc_filt, 'k')
set(gca, 'FontSize', 15);
xlabel('Time, s');
legend('output acc','Location','northeast');
set(gca,'FontAngle', 'italic');

set(gcf,'Color','w');

figure(2)
p = loglog(bbb, smooth(abs(fourier_acc(1:NFFT_acc/2+1)), sm), 'r', bbb, smooth(abs(fourier_acc_filt(1:NFFT_acc_filt/2+1)), sm), 'b', f, norm_factor*F, 'g');
p(1).LineWidth = 3;
p(2).LineWidth = 3;
p(3).LineWidth = 3;
p(3).LineStyle = '--';
set(gcf,'color','w');
xlabel('Frequency (Hz)')
ylabel('|F(f)|')
set(gca,'FontAngle', 'italic')
set(gca, 'FontSize', 16) 
legend('before filtering', 'after filtering', 'theoretical reduction spectrum', 'Location', 'southwest')
