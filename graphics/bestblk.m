function [mb,nb] = bestblk(siz,k)

if nargin==1, k = 100; end % Default block size

%
% Find possible factors of siz that make good blocks
%

% Define acceptable block sizes
m = floor(k):-1:floor(min(ceil(siz(1)/10),k/2));
n = floor(k):-1:floor(min(ceil(siz(2)/10),k/2));

% Choose that largest acceptable block that has the minimum padding.
[dum,ndx] = min(ceil(siz(1)./m).*m-siz(1)); blk(1) = m(ndx);
[dum,ndx] = min(ceil(siz(2)./n).*n-siz(2)); blk(2) = n(ndx);

if nargout==2,
  mb = blk(1); nb = blk(2);
else
  mb = blk;
end