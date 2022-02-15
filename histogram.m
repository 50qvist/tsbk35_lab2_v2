function [n,x] = histogram(y)


m = floor(min(y(:))):ceil(max(y(:)));

n = hist(y,m);
 
x = m';

end