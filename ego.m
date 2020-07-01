%==========================================================================
%% STEP-1: SET PROJECT FOLDER PATHS
%==========================================================================
close all; clear; clc; rng('shuffle');



% SPECIFY PROJECT FOLDER PATH
PROJECT_FOLDER_PATH = ...
    '/Users/bradleymonk/Documents/MATLAB/myMatlab/discord/egomap';



% ADD PATHS TO WORKSPACE
P.home  = PROJECT_FOLDER_PATH; cd(P.home);
P.funs  = [P.home filesep 'funs'];
P.webs  = [P.home filesep 'webs'];
P.data  = [P.home filesep 'data'];
addpath(join(string(struct2cell(P)),pathsep,1))
cd(P.home); P.f = filesep;






%==========================================================================
%% STEP-2: SET PARAMS FOR VS. SEARCH QUERY
%==========================================================================
clc; clearvars -except P


searchTerm = "discord";

P.searchTerm = searchTerm;

Nterms  = 10;
Ndeep = 5;




%==========================================================================
%% STEP-3: GET  VS.TERMS  FOR INITIAL SEARCH TERM
%==========================================================================
clc; clearvars -except P searchTerm Nterms Ndeep


nodes = getnodes(searchTerm);

nodeset = [searchTerm; nodes];

TOP = nodeset;

disp(TOP)





%==========================================================================
%% STEP-4: GET 2ND-LEVEL VS.TERMS
%==========================================================================
clc; clearvars -except P searchTerm Nterms Ndeep nodeset TOP


EGO = strings(11,11);

EGO(:,1) = TOP;

for i = 2:11
disp(i)

    searchTerm = EGO(i,1);

    nodes = getnodes(searchTerm);

    T = [searchTerm; nodes];

    EGO(1:(numel(T)),i) = T;


end


disp(EGO)




%return
%==========================================================================
%% STEP-5: GET 3RD-LEVEL VS.TERMS
%==========================================================================
clc; clearvars -except P searchTerm Nterms Ndeep nodeset TOP EGO




EG = EGO(2:end,2:end);
EG = EG(:);


% REMOVE SINGLETS & BLANK LINES
EG = regexprep(EG ,'^\w$','');
n = size(EG,1);
si = nan(n,1);
for i = 1:n
    si(i) = EG(i) ~= "";
end
EG = EG(si==1)';



N = size(EG,2);


EGOS = strings(11,N);


for i = 1:N
disp(i)

    searchTerm = EG(1,i);

    nodes = getnodes(searchTerm);

    T = [searchTerm; nodes];

    EGOS(1:(numel(T)),i) = T;

end



disp(EGOS)





%==========================================================================
%% STEP-6: CREATE 2-COLUMN EGO MATRIX
%==========================================================================
clc; clearvars -except P EGOS


TOP = EGOS(1,:)';
BOT = EGOS(2:end,:);


N = numel(TOP);

EGO = repmat(TOP,1,10)';
EGO = reshape(EGO,N*10,[]);

M = size(EGO,1);

EGOMX = strings(M,2);

EGOMX(:,1) = EGO;


j = 1;
for i = 1:N
disp(i)


    EGOMX(j:(j+9),2) = BOT(:,i);


j = j+10;
end




%==========================================================================
%% STEP-7: CLEAN UP EGO MATRIX
%==========================================================================
clc; clearvars -except P EGOMX



TXX = EGOMX(:,2);


% REMOVE SINGLETS
% TXX = regexprep(TXX ,'^\w$','');


% REMOVE BLANK LINES
n = size(TXX,1);
si = nan(n,1);
for i = 1:n
    si(i) = TXX(i) ~= "";
end

EGO_MATRIX = EGOMX(si==1,:);






%==========================================================================
%% STEP-8: CREATE DIGRAPH
%==========================================================================
clc; clearvars -except P EGOMX EGO_MATRIX



DIG = digraph(EGO_MATRIX(:,1),EGO_MATRIX(:,2));





% CREATE FIGURE WINDOW
%-----------------------------------------------------------------------
close all;
fh1=figure('Units','pixels','Position',[100 40 1200 750],'Color','w');
ax1=axes('Units','pixels','Position',[120 50 1000 670],'Color','none');
%-----------------------------------------------------------------------


ph=plot(DIG,'Layout','layered');

title(sprintf('''%s'' ego digraph',P.searchTerm))

highlight(ph,ones(10,1),2:11,'EdgeColor','r')








% % CREATE FIGURE WINDOW
% %-----------------------------------------------------------------------
% close all;
% fh1=figure('Units','pixels','Position',[100 40 1200 750],'Color','w');
% ax1=axes('Units','pixels','Position',[120 50 1000 670],'Color','none');
% %-----------------------------------------------------------------------
% 
% GRA = graph(EGO_MATRIX(:,1),EGO_MATRIX(:,2),'omitselfloops');
% 
% plot(GRA);




