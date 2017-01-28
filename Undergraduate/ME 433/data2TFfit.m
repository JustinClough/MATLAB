function [sys] = data2TFfit(freq,mdb,thd,nz,np)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Main File: data2TFfit.m 
%Description: The function dataTFfit determines the transfer function from 
%frequency response data.
%input param: freq - frequency in radians / second
%             mdb- magnitude in dB
%             thd- the phase angle in degrees
%             nz - order of the numerator of the transfer function
%             np - order of the denominator of the transfer function
%output param: sys - transfer function that was fitted to the data
% Created by: L.A. Rodriguez & H.L. Weiss
% Created on: 01/06/15
% Last editted on: 01/09/15 (L.A. Rodriguez)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mag=10.^(mdb/20); 

data = frd(mag.*exp(j*thd*pi/180),freq);

%Estimate a transfer function using data
sys =tf( tfest(data,np,nz));

% Bode plot of the data and the fitted transfer function
figure
[mag,phase,wout] =bode(sys,freq);

% magnitude plot
subplot(2,1,1);
semilogx(freq,mdb, 'ko','MarkerFaceColor','k');hold on;
semilogx(wout,20*log10(squeeze(mag)), 'b-');
legend('Test Data','Model Fit')
ylabel('Magnitude (dB)')
grid

% phase plot
subplot(2,1,2); 
semilogx(freq,thd, 'ko','MarkerFaceColor','k');hold on;
semilogx(wout,squeeze(phase), 'b-');
legend('Test Data','Model Fit')
xlabel('Frequency (rad/s)')
ylabel('Phase (deg)')
grid

