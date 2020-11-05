[x,fs] = audioread('sine-440.wav');    % read audio file 
window = hamming(1024); % generate window (hamming) with M = 1024
% the MFCC coefficients are found using cepstral coefficients which by
% default returns MFCC coefficients. 
S = stft(x,window,length(window)/4,256,fs);  % First the signal is converted to frequency domain using stft
cepFeatures = cepstralFeatureExtractor; 
cepFeatures = cepstralFeatureExtractor('InputDomain','Frequency','SampleRate',fs,'LogEnergy','Append');
[coeffs,delta,deltadelta] = cepFeatures(S); % coefficients are found using stft of the input audio file
nbins = 60;
%for i = 1:size(coeffs,2)
%   figure;
%    histogram(coeffs(:,i),nbins,"Normalization","pdf"); % the coefficients are plotted
%    title(sprintf("coefficient %d",i-1));
%end

function [STFT,f,t] = stft(x,win,hop,nfft,fs)
x = x(:);
xlen = length(x);
wlen = length(win);
no = ceil((1+nfft)/2);    
L = 1+fix((xlen-wlen)/hop); 
STFT = zeros(no, L);       
for i = 0:L-1
   
    xw = x(1+i*hop : wlen+i*hop).*win;
    
    
    X = fft(xw, nfft);
    
  
    STFT(:, 1+i) = X(1:no);
end

t = (wlen/2:hop:wlen/2+(L-1)*hop)/fs;
f = (0:no-1)*fs/nfft;
end
