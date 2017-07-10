function thin_image = fingerprint_enhancement_morph(filename)

close all;

IBW = fingerprint_enhancement(filename);

thin_image=~bwmorph(IBW,'thin',Inf);

figure(1);
subplot(131); imshow(imread(filename)); title(' original ' );
subplot(132); imshow(IBW); title(' fingerprint enhancement ' );
subplot(133); imshow(thin_image); title(' fingerprint enhancement morph ' );
end