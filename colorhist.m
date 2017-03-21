
function colorhist = colorhist(rgb)   
if size(rgb,3)~=3   
    error('3 components is needed for histogram');   
end   
% globals   
H_BITS = 4; S_BITS = 2; V_BITS = 2;   
%rgb2hsv可用rgb2hsi代替，见你以前的提问。  
hsv = uint8(255*rgb2hsv(rgb));   
  
imgsize = size(hsv);   
% get rid of irrelevant boundaries   
i0=round(0.05*imgsize(1));  i1=round(0.95*imgsize(1));   
j0=round(0.05*imgsize(2));  j1=round(0.95*imgsize(2));   
hsv = hsv(i0:i1, j0:j1, :);   
   
% histogram   
for i = 1 : 2^H_BITS   
    for j = 1 : 2^S_BITS   
        for k = 1 : 2^V_BITS   
            colorhist(i,j,k) = sum(sum(bitshift(hsv(:,:,1),-(8-H_BITS))==i-1 & bitshift(hsv(:,:,2),-(8-S_BITS))==j-1 & bitshift(hsv(:,:,3),-(8-V_BITS))==k-1 ));               
        end           
    end   
end   
colorhist = reshape(colorhist, 1, 2^(H_BITS+S_BITS+V_BITS));   
% normalize   
%colorhist = colorhist/sum(colorhist);  