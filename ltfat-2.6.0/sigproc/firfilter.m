function gout=firfilter(name,M,varargin)
%FIRFILTER  Construct an FIR filter
%   Usage:  g=firfilter(name,M);
%           g=firfilter(name,M,...);
%
%   `firfilter(name,M)` creates an FIR filter of length *M*. This is
%   exactly the same as calling |firwin|. The name must be one of the
%   accepted window types of |firwin|.
%
%   `firfilter(name,M,fc)` constructs a filter with a centre
%   frequency of *fc* measured in normalized frequencies.
%
%   If one of the inputs is a vector, the output will be a cell array
%   with one entry in the cell array for each element in the vector. If
%   more input are vectors, they must have the same size and shape and the
%   the filters will be generated by stepping through the vectors. This
%   is a quick way to create filters for |filterbank| and |ufilterbank|.
%
%   `firfilter` accepts the following optional parameters:
%
%     'fs',fs     If the sampling frequency *fs* is specified then the length
%                 *M* is specified in seconds and the centre frequency
%                 *fc* in Hz.
%
%     'complex'   Make the filter complex valued if the centre frequency
%                 is non-zero. This is the default.
%
%     'real'      Make the filter real-valued if the centre frequency
%                 is non-zero.
%
%     'delay',d   Set the delay of the filter. Default value is zero.
%
%     'causal'    Create a causal filter starting at the first sample. If
%                 specified, this flag overwrites the delay setting.
%
%   It is possible to normalize the impulse response of the filter by
%   passing any of the flags from the |setnorm| function. The default
%   normalization is `'energy'`.
%
%   The filter can be used in the |pfilt| routine to filter a signal, or
%   in can be placed in a cell-array for use with |filterbank| or |ufilterbank|.
%
%   See also: blfilter, firwin, pfilt, filterbank

% XXX Implement passing additional parameters to firwin

% Define initial value for flags and key/value pairs.
definput.import={'setnorm'};
definput.importdefaults={'energy'};
definput.keyvals.delay=0;
definput.keyvals.fc=0;
definput.keyvals.fs=[];
definput.flags.delay={'delay','causal'};
definput.flags.real={'complex','real'};

[flags,kv]=ltfatarghelper({'fc'},definput,varargin);

[M,kv.fc,kv.delay]=scalardistribute(M,kv.fc,kv.delay);

if ~isempty(kv.fs)
    M=round(M*kv.fs);
    kv.fc=kv.fc/kv.fs*2;
end;

Nfilt=numel(M);
gout=cell(1,Nfilt);
for ii=1:Nfilt
    g=struct();
    
    if flags.do_causal
        g.offset=0;
        smallshift=0;
    else
        d=floor(kv.delay);
        smallshift=d-floor(d);
        g.offset=d-floor(M/2);
    end;

    g.h=fftshift(firwin(name,M(ii),'shift',smallshift(ii),flags.norm));
    g.fc=kv.fc(ii);
    g.realonly=flags.do_real;
    g.fs=kv.fs;
        
    gout{ii}=g;
end;
if Nfilt==1
    gout=g;
end;






