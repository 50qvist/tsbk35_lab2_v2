clear all
clc

[original_sound, Fs] = audioread("fullHey.wav");
soundSize = size(original_sound)
length(original_sound)
if soundSize(2) ~= 1
    original_sound = original_sound(:,1);
end


%===Parameters===
block_size = 512
quantization_steps = 24.417;

%original_sound = original_sound(1:block_size*10000/2);

%===Size of each quantization step (y-axis)===
quantization_size = ((max(original_sound)-min(original_sound))/quantization_steps);
%===Transform with mdct===
transform_sound = mdct(original_sound, block_size);

%===Quantize===
quantized_transform_sound = round(transform_sound / quantization_size);

%===Reconstruct===
reconstructed_sound = imdct(quantized_transform_sound * quantization_size);

%===Write to audio file===
audiowrite('reconstructed_sound.wav', reconstructed_sound, Fs);

%===||===Calculate stats of compression===||===

%===Rate===

quant_hist = histogram(quantized_transform_sound(:));
probs = quant_hist / sum(quant_hist);
R = huffman(probs)


%===Signal to noise===

our_snr = snr(original_sound, reconstructed_sound-original_sound)


















