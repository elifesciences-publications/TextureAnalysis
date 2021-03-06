function coorkinds=btc_coorkinds(letcodes,dict)
% coorkinds=btc_coorkinds(letcodes,dict) analyzes the letter codes to 
% determine how many of each order, and how much they are rotated from the
% standard rotation  (b, d, t are standard for beta_hv, beta_diag (NW to SE) and theta)
%
% fields of coorkinds are 'alpha','beta_hv','beta_diag','theta','delta'
% (assuming default "ordernames" of dict, typically
% letcodes:  a 1-d array of characters, e.g., char(fieldnames(letcode))
% dict:  dictionary of binary correlation names, generated by btc_define;
%    btc_define called if this field is empty
%
%  coorkinds.[ordername] is an array indicating which rotations are present.
%    if empty, then none are present.
%
%    See also: BTC_DEFINE, BTC_TEST.
%
if (nargin<2)
    dict=btc_define;
end
if ~isfield(dict,'name_order_aug_unique') %for backward compatibility with saved versions of dict
    %that do not have this field
    fns=cellstr(strvcat(unique(dict.name_order_aug)));
else
    fns=dict.name_order_aug_unique;
end
coorkinds=[];
for ifn=1:size(fns,1)
%    coorkinds=setfield(coorkinds,fns{ifn},[]);
     coorkinds.(fns{ifn})=[];
end
for q=1:length(letcodes)
    k=find(dict.codel==letcodes(q));
    fn=dict.name_order_aug{k};
    rot=dict.rot(k);
%   coorkinds=setfield(coorkinds,fn,[getfield(coorkinds,fn) rot]);
    coorkinds.(fn)=[coorkinds.(fn) rot];
end
return
