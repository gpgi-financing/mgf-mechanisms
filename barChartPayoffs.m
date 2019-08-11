  % %Africa, China, EU, Eurasia, India, Japan, Latin America, Middle East, other high income countries, Russia, US, other non-OECD Asia
% bar(categorical({'Africa', 'China', 'EU', 'Eurasia', 'India', 'Japan'}),transpose(A(:,1:6)))
% legend('Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB and Malaria','Forest Carbon Partnerships \newline Carbon Fund', 'International \newline Thermonuclear \newline Reactor (ITER)', 'Carbon Pricing \newline Reward Fund')
% [h, ~, plots] = legend('Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB and Malaria','Forest Carbon Partnerships \newline Carbon Fund', 'International \newline Thermonuclear \newline Reactor (ITER)', 'Carbon Pricing \newline Reward Fund');
% for idx = 1:length(h.String)
%     h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
% end


  bar(categorical({'Africa', 'China', 'EU', 'Eurasia', 'India', 'Japan','Latin America', 'Middle East', 'Other High Income', 'Russia', 'US', 'zother Asia'}),transpose(A))
  legend('Clean Development Mechanism (CDM)','Coalition for Epidemic Preparedness Innovation (CEPI)','Global Fund for AIDS, TB and Malaria','Forest Carbon Partnerships Carbon Fund', 'International Thermonuclear Reactor (ITER)', 'Carbon Pricing Reward Fund')
  ax = gca; % current axes
  ax.FontSize = 18;

bar_handle = bar(transpose(A),'grouped');
grid on

set(bar_handle(1),'FaceColor','r')
set(bar_handle(2),'FaceColor','g')
set(bar_handle(3),'FaceColor','c')
set(bar_handle(4),'FaceColor','b')
set(bar_handle(5),'FaceColor','p')
set(bar_handle(6),'FaceColor','r')

CrudeOilImporters2017Normalised=[0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]/sum([0,	414.6,	551.6,		0,		223.2,	157.8,	0,		0,		0,		0,	313.8,	248.4]);
CrudeOilExporters2017Normalised=[-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]/(-sum([-243.1,	0,	0,		-68.1,		0,	0,	-202.5,		-923.8,		-116.7,		-261.1,	0,	0]));
NetCrudeOilImports2017Normalised=CrudeOilImporters2017Normalised+CrudeOilExporters2017Normalised;
ProportionsOfSCC=[0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]/sum([0.11,0.16,0.12,0.01,0.12,0.02,0.07,0.10,0.04,0.01,0.1,0.12]);
bEstimates=reductionInOilRevenuesPerDollarRaisedViaTaxesOnFlightEmissions*NetCrudeOilImports2017Normalised+AggregateMitigationBenefitsDueToKerosineConsumptionDecrease*ProportionsOfSCC
%bEstimates=[0.0214 0.0748 0.0694 -0.0007 0.0512 0.0152 0.0109 -0.0214 0.0062 -0.0120 0.0498 0.0526];
bEstimates=[-0.0031    0.0163    0.0186   -0.0016    0.0099    0.0048   -0.0033   -0.0224   -0.0019   -0.0069    0.0116    0.0106];
bar(categorical({'Africa', 'China', 'EU', 'Eurasia', 'India', 'Japan','Latin America', 'Middle East', 'Other High Income', 'Russia', 'US', 'zother Asia'}),[-0.0031    0.0163    0.0186   -0.0016    0.0099    0.0048   -0.0033   -0.0224   -0.0019   -0.0069    0.0116    0.0106])
ax = gca; % current axes
ax.FontSize = 24;
grid on