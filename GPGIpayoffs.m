%  Africa, China, EU, Eurasia, India, Japan, Latin America, Middle East, other high income countries, Russia, US, other non-OECD Asia
bar(categorical({'Africa', 'China', 'EU', 'Eurasia', 'India', 'Japan', 'Latin \newline America', 'Middle \newline East', 'Other \newline High \newline Income', 'Russia', 'US', 'Zother \newline Asia'}),transpose(A(:,1:12)))
  hold on
legend('Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB and Malaria','Forest Carbon Partnerships \newline Carbon Fund', 'International \newline Thermonuclear \newline Reactor (ITER)', 'Carbon Pricing \newline Reward Fund')
[h, ~, plots] = legend('Clean Development \newline Mechanism (CDM)','Coalition for \newline Epidemic Preparedness \newline Innovation (CEPI)','Global Fund for \newline AIDS, TB and Malaria','Forest Carbon Partnerships \newline Carbon Fund', 'International \newline Thermonuclear \newline Reactor (ITER)', 'Carbon Pricing \newline Reward Fund');
for idx = 1:length(h.String)
    h.String{idx} = ['\color[rgb]{' num2str(plots(idx).Color) '} ' h.String{idx}]
end
grid on
  ax = gca; % current axes
  ax.FontSize = 18;

