
[filename, pathname] = uigetfile('*.h5');

data = h5read([pathname filename], '/data');

sampRate = double(h5read([pathname filename], '/sampRate'));

fs = h5read([pathname filename], '/info/SamplingRate');

L = length(data);
t = [0:L-1]/sampRate;

osr = h5read([pathname filename], '/OSR');
osr = h5read([pathname filename], '/info/OverSampling');
