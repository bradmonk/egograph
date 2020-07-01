function [nodes] = getnodes(searchTerm)



if isstring(searchTerm)
    searchTerm = char(searchTerm);
end


S.searchTerm = searchTerm;


S.baseStart = ...
'http://suggestqueries.google.com/complete/search?&output=toolbar&gl=us&hl=en&q=%22';

S.baseEnd = ...
'%22%20vs%20';


S.query = [S.baseStart S.searchTerm S.baseEnd];


wo = weboptions('RequestMethod','get','ContentType','text');

xmldata = webread(S.query,wo);

pause(.1)


TXT = string(xmldata);

%keyboard

TX = split(TXT,"<");

TXX = regexprep(TX ,'?','');                    % remove '?'
TXX = regexprep(TXX ,'xml.+','');               % remove the xml ver line
TXX = regexprep(TXX ,'toplevel>','');           % remove ''
TXX = regexprep(TXX ,'CompleteSuggestion>',''); % remove 'CompleteSuggestion>'
TXX = regexprep(TXX ,'"','');                   % remove '"'
TXX = regexprep(TXX ,'suggestion data=','');    % remove 'suggestion data='
TXX = regexprep(TXX ,' vs ','');                % remove the search term
TXX = regexprep(TXX ,searchTerm,'');            % remove ' vs '
TXX = regexprep(TXX ,'/','');                   % remove '/'
TXX = regexprep(TXX ,'>','');                   % remove '>'
TXX = regexprep(TXX ,'^ +','');                 % remove leading spaces



% REMOVE BLANK LINES
n = size(TXX,1);
si = nan(n,1);
for i = 1:n
    si(i) = TXX(i) ~= "";
end
nodes = TXX(si==1);

end









