%---------------------- Script description --------------------------------
% The script to calculate theoretical reduction spectrum for vertical component due to the
% presence of water column above the site and the corresponding set of
% Butterwoth filters objects to simulate this reduction
%------------------------------- Input ------------------------------------

c = 1500;       % sound speed in water, m/s
H = 51;         % water depth, m
a = 0.5;        % P-wave impedance ratio between seawater and seafloor soil
F0 = 1;         % lower frequency limit (or natural frequency of seismograph), Hz
Fs = 100;       % sample rate, Hz
N = 5000;       % number of points in frequency vector

n = 2;          % order of the Butterworth filter
e = 1.5;        % allowed deviation from resonant frequences, Hz (bandstop of filter: [Fres-e Fres+e])

%------------------------------ Output ------------------------------------
% F             - theoretical water column reduction spectrum 
% f             - corresponding frequency vector (for F spectrum), Hz
% bsFilt        - cell array with set of Butterwoth filters objects
% hh_compl      - complex frequency response of the set of Butterwoth filters
% ff_compl      - corresponding frequency vector (for hh_compl), Hz
%--------------------------------------------------------------------------

f = linspace(F0,Fs/2,N);         % frequency vector
              
i = 1;
b = 1;
while 1
    Fres1 = b*c/4/H;
    if Fres1 >= F0 &&  Fres1 <= Fs/2
        Fres(i) = Fres1;        % resonant frequencies of water column
        i = i+1;
    else
        break
    end
    b = b+2;
end
Fres = Fres';

for i = 1:1:length(f)
    F(i) = 1/sqrt(1+(a^2)*(tan(3.14*f(i)/2/Fres(1))^2));     % Reduction spectrum
end

for i = 1:1:length(Fres)
    bsFilt{i} = designfilt('bandstopiir','FilterOrder',n, ...
         'HalfPowerFrequency1',Fres(i)-e,'HalfPowerFrequency2',Fres(i)+e, ...
         'SampleRate',Fs, 'DesignMethod', 'butter');
    [hh{i},ff{i}] = freqz(bsFilt{i},[],Fs);
    if i==2
       hh_compl =  hh{i-1}.*hh{i};
    end
    if i>2
        hh_compl = hh_compl.*hh{i};     % Complex response of filter
    end
end
ff_compl = ff{1};

p = plot(f,F,'r',ff_compl,hh_compl,'b')
p(1).LineWidth = 3;
p(2).LineWidth = 3;
p(2).LineStyle = '--';
set(gcf,'color','w');
xlabel('Frequency (Hz)')
ylabel('|F(f)|')
set(gca,'FontAngle', 'italic')
set(gca, 'FontSize', 16) 
legend('Reduction curve', 'Response of filter')