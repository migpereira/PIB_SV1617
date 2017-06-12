function fingerprint_enhancement_morph(filename)
    IBW = fingerprint_enhancement(filename);
    %SE = [1 1 1;
    %      1 1 1;
    %      1 1 1];
    %AUX = imcomplement(IBW);
    resImage =  bwmorph(IBW,'thin');
    
    %resImage = imcomplement(resImage);
    
    figure(1); set(gcf,'Name', 'Binária');
    subplot(121); imshow(IBW); title(' Imagem original' );
    subplot(122); imshow(resImage); title(' Imagem com P.M.' );
end