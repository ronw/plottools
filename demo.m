%% Load some data
[dsrc1 fs] = wavread('sounds/ssc/clean/t25_bwik1s_m25_bgwf4n.wav');
[dsrc2 fs] = wavread('sounds/ssc/clean/t25_bwik1s_m25_bgwf4n_masker.wav');

dmix = dsrc1 + dsrc2;

NFFT = 640;
NWIN = NFFT; 
NHOP = NFFT / 4;
Ssrc1 = dB(stft(dsrc1, NFFT, NWIN, NHOP));
Ssrc2 = dB(stft(dsrc2, NFFT, NWIN, NHOP));
Smix = dB(stft(dmix, NFFT, NWIN, NHOP));

Msrc1 = melfcc(dsrc1);
Msrc2 = melfcc(dsrc2);
Mmix = melfcc(dmix);


%% plotall
% plotall lets you organize multiple subplots using a single function call.
plotall(Smix, Ssrc1, Ssrc2);
% Note that this is equivalent to passing in a cell array of data as a
% single argument:
plotall({Smix, Ssrc1, Ssrc2});

%% Panning and zooming
clf
% Note the nifty scrollbars that let you pan and zoom the x-, y-, and 
% color axes.  Left click and drag to scroll.  Right click to zoom.
plotall(Smix, Ssrc1, Ssrc2)
plotall(Smix, Ssrc1, Ssrc2, 'clim', [-40 27.2], 'xlim', [45 127], 'ylim', [1 100]);

%% Configuring subplot layout
clf
% plotall can automatically manage subplot layout.
% (Note that subplots are filled in row-wise)
plotall(Smix, Smix, Ssrc1, Ssrc2, 'subplot', [2 2]);

%% Aligning axes
clf
% Let each subplot have independent y and color axes, but keep the time
% axis fixed across all subplots.
plotall(Ssrc1, Msrc1, 'align', 'x')

%%
clf
% Sometimes you don't want anything to be aligned.
plotall(dsrc1, Ssrc1, 'align', '')

%% Pages
clf
% If the 'subplots' property is set but there are more arguments than
% subplots, the subplots are split over multiple "pages".  Pages can be
% navigated using the controls on the top right of the figure.
% See the'plot_pages' function for another way to get this functionality
% without the rest of plotall's goodies.
plotall(Smix, Ssrc1, Ssrc2, 'subplot', [2 1])

%% More properties
clf
% You can pass in name-value pairs to configure different properties
% of the subplots.  Passing cell arrays in lets you configure
% different properties for each subplot, otherwise properties are
% shared across all subplots.  See 'help plotall' for more details.
t = [1:NHOP:length(dmix)] / fs;
% Quantize things to the nearest hundredth of a second.
t = round(t * 100) / 100;
xticks = 1:20:length(t);
f = [0:NFFT/2] * fs / NFFT * 1e-3;
yticks = 1:80:length(f);
plotall(Smix, Ssrc1, Ssrc2, 'clim', [-25 25], 'colorbar', false, ...
	'ytick', yticks, 'yticklabel', f(yticks), ...
	'ylabel', 'Frequency (kHz)', ...
	'xtick', {[], [], xticks}, 'xticklabel', t(xticks), ...
	'xlabel', {'', '', 'Time (seconds)'}, ...
	'title', {'Mixture', 'Clean source 1', 'Clean source 2'}, ...
	'pub', true)  % "'pub', true" turns off the scrollbars.


%% Usage
help plotall

