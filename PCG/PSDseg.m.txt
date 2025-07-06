function [psd, freq] = PSDseg(Signal, fs, Segments)

    %INPUTS:    Signal -    this is the signal in which the PSD is calculated
    %                       for.
    %           fs -        Sampling frequency of the signal
    %           Segments -  Number of segments averages over. Break signal
    %                       up into ~0.5-1s segments (e.g. 20 segments for
    %                       10 second signal)
    %OUTPUTS:   use 'plot(freq,10*log10(psd), 'linewidth',1)' to plot
    %           results

    samples = floor(length(Signal)/Segments);
    psd = zeros(length(samples));
    j = 1;
    for ii = 1:Segments
        x = Signal(j:ii*samples);
        j=j+samples;
    
        N=samples;
        X=fft(x);
        X=X(1:floor(N/2)+1);
        psdX = (1/(fs*N))*abs(X).^2;
        psdX(2:end-1) = 2*psdX(2:end-1);
    
        psd = psd + psdX;
    
    end
    psd = psd./Segments;
    freq = 0:fs/samples:fs/2;
end
