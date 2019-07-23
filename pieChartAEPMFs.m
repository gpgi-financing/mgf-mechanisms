proportionsGoingToGPGIs=[0.0688    0.3036    0.0729    0.1140    0.0018    0.3535]
labels = {'Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB and Malaria','Forest Carbon Partnerships \newline Carbon Fund', 'International \newline Thermonuclear \newline Reactor (ITER)', 'Carbon Pricing \newline Reward Fund'};
hh=pie(proportionsGoingToGPGIs,labels)
set(findobj(hh,'type','text'),'fontsize',27);


% pText = findobj(pie(proportionsGoingToGPGIs),'Type','text');
% percentValues = get(pText,'String'); 
% txt = labels; 
% combinedtxt = strcat(txt,percentValues); 

al= [0.0684    0.2863    0.0689    0.1060    0.0017    0.3564];
proportionsGoingToGPGIs=[0.0688    0.3036    0.0729    0.1140    0.3535]/(1-al(5));
labels = {'Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB \newline and Malaria','Forest Carbon \newline Partnerships \newline Carbon Fund', 'Carbon Pricing \newline Reward Fund'};
hh=pie(proportionsGoingToGPGIs,labels)
set(findobj(hh,'type','text'),'fontsize',26);