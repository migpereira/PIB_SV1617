function generate_card()
% Array of symbols
symbols = {imread('0.bmp'), imread('1.bmp'), imread('2.bmp'), imread('3.bmp'), imread('4.bmp'), imread('5.bmp'), imread('6.bmp'), imread('7.bmp'), imread('8.bmp'), imread('9.bmp'), imread('A.bmp'), imread('B.bmp'), imread('C.bmp'), imread('D.bmp')};

% Card color range
card_colors = [255 0 0;
               55 3 247;
               80 208 222;
               32 164 57;
               248 239 52;
               167 161 177];
% Symbol color range
symbol_colors = [0 0 0;
                 255 255 255;
                 0 0 0;
                 0 0 0;
                 198 20 185;
                 147 85 17;
                 0 0 0;
                 255 255 255;
                 93 221 163;
                 0 0 0;
                 134 42 42;
                 0 0 0;
                 0 0 0];

[symb_rows, symb_cols] = size(symbols{1});
rows = 8*symb_rows;
cols = 25*symb_cols;
% Create card
image=zeros(rows,cols,3);
% Generate a number that corresponds to the index of array card_colors
card_idx = randi(size(card_colors,1));
image(:,:,1)=card_colors(card_idx,1);   %Red Component
image(:,:,2)=card_colors(card_idx,2);   %Green Component
image(:,:,3)=card_colors(card_idx,3);   %Blue Component

% Transform each binary image of the symbols into an RGB image
for i = 1:size(symbols,2)
    symbols{i} = 255-255 * uint8(symbols{i});
    symbols{i} = cat(3,symbols{i},symbols{i},symbols{i});
end

% Insert the 6 numbers(1,2,3,4,5,6) on top of the card
image(1:symb_rows,3*symb_cols:3*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{2});
image(1:symb_rows,7*symb_cols:7*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{3});
image(1:symb_rows,11*symb_cols:11*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{4});
image(1:symb_rows,15*symb_cols:15*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{5});
image(1:symb_rows,19*symb_cols:19*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{6});
image(1:symb_rows,23*symb_cols:23*symb_cols+symb_cols-1,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{7});

% Insert the 4 words(A,B,C,D) on left of the card
image(symb_rows:symb_rows+symb_rows-1,1:symb_cols,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{11});
image(3*symb_rows:3*symb_rows+symb_rows-1,1:symb_cols,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{12});
image(5*symb_rows:5*symb_rows+symb_rows-1,1:symb_cols,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{13});
image(7*symb_rows:7*symb_rows+symb_rows-1,1:symb_cols,:) = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{14});

% Generate the numbers of card
for i = symb_rows:2*symb_rows:rows
    count = 3;
    for j = 2*symb_cols:symb_cols:cols
        if(count ~= 0)
            idx = randi(size(symbols,2)-4);
            symbol = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symbols{idx});
            image(i:i+symb_rows-1,j:j+symb_cols-1,:) = symbol;
            count = count-1;
        else count = 3;
        end
    end
end

figure; imshow(uint8(image));
end

% Auxiliary function which colors a symbol
function [symb_out] = color_symbol(symbol_colors, card_colors, card_idx, symb_rows, symb_cols, symb)
    symb_idx = randi(size(symbol_colors,1));
    for i = 1:symb_rows
        for j = 1:symb_cols
            if(symb(i,j,1) == 255) symb(i,j,1) = card_colors(card_idx,1);
            else symb(i,j,1) = symbol_colors(symb_idx,1);
            end
            if(symb(i,j,2) == 255) symb(i,j,2) = card_colors(card_idx,2);
            else symb(i,j,2) = symbol_colors(symb_idx,2);
            end
            if(symb(i,j,3) == 255) symb(i,j,3) = card_colors(card_idx,3);
            else symb(i,j,3) = symbol_colors(symb_idx,3);
            end
        end
    end
    symb_out = symb;
end