Task: An Analysis of Power Plant Investment Opportunities using a Compound Exchange Option
====================================================

Assume that you are a quantitative financial analyst working for an international energy company. You are asked to evaluate various investment opportunities of power plants using the compound exchange option (hereafter, CEO) approach as in Section 5 of October 29, 2013 version of Kang and Letourneau (2013).

a) Assume that you study Kang and Letourneau (2013) to do your job. Assume that you study Carr (1988) because Kang and Letourneau cites Carr (1988). Assume that you find a technical error in Carr (1988). Specifically, assume that you have found that the first equation in page 1243 is
wrong. Carr (1988) mistakenly wrote 𝑑1(𝑦, 𝜏) = (ln(𝑦)+𝜎^2𝜏)/𝜎√𝜏. The correct formula should be 𝑑1(𝑦, 𝜏) = (ln(𝑦)+𝟎.𝟓𝜎^2𝜏)/𝜎√𝜏.

Use Monte-Carlo simulation to verify that 𝑑1(𝑦, 𝜏) = (ln(𝑦)+𝟎.𝟓𝜎^2𝜏)/𝜎√𝜏 is the correct formula. In other words, show that the analytic solution in Eq. (27) of Carr (1988) is the same as the Monte-Carlo simulation for a CEO. To calculate Eq. (27) of Carr (1988), use the following parameter: V =51.8195, D = 34.5303, q =0.5555, 𝜏𝑐= 1, 𝜏𝑠=13.5730, 𝜎𝑉 = 0.5862, 𝜎𝐷 = 0.4790 and 𝜌= 0.6386. To do the Monte-Carlo simulation for a CEO, use the same parameters, but you will need an additional parameter: risk-free interest rate. For the risk-free interest rate, use r =0.0400.

b) To ensure that you understand Section 5 of Kang and Letourneau (2013) correctly and you have skill to implement the CEO method in the paper, replicate figure 2 in Kang and Letourneau (2013) using the analytic solution (Eq. (6) in Kang and Letourneu (2013)). Then, replicate figure 2 in Kang and Letourneau (2013) using the MC simulation.

To replicate figure 2, use the following parameters (I am giving parameters because numbers in the paper may not have enough digits.):
- 𝐸0 =51.8195 $/MWh;
- 𝐻=8.732 mmbtu/MWh for the coal plant and 𝐻=7.223 mmbtu/MWh for the natural gas plant;
- 𝐹0=0.50 $/mmbtu for the coal plant and 𝐹0=4.7806 $/mmbtu for the natural gas plant;
- 𝑀=205.35 pounds/mmbtu for the coal plant and 𝑀=118.00 pounds/mmbtu for the natural gas plant;
- 𝐾=36.06 $/MWh for the coal plant and 𝐾=19.18 $/MWh for the natural gas plant;
- 𝐼𝑛𝑡𝑒𝑟𝑒𝑠𝑡 𝑟𝑎𝑡𝑒=0.04;
- 𝜏𝑐=1;
- 𝜏𝑠 =13.5730
- 𝜎𝐸 =0.5862;
- 𝜎𝐹=0 for the coal plant and 𝜎𝐹=0.4790 for the natural gas plant;
- 𝜌=0 for the coal plant and 𝜌=0.6386 for the natural gas plant;
- 𝑃0 varies between 0 $/pound and 0.0175 $/pound. (In other words, $0/ton to $35/ton.)

c) You should evaluate various investment opportunities of a power plant. The data the instructor has uploaded to the Blackboard system (“Data4TermProject2013cFall.xlsx”) contains parameters for 30 investment opportunities. Data for each investment opportunity contain a proposed location of a power plant (e.g., California and Virginia) and a proposed type of a power plant (Coal Plant and Natural Gas Plant). Each different location has different electricity and fuel prices. Because the data provides 15 locations and 2 types of plants, total number of investment opportunities you evaluate is 30 (=15 locations x 2 plants). For each investment opportunity, you consider 4 cases: “Base Case,” “No Emission Cost Case,” “High Emission Cost Case,” and “High Capital Cost Case” as defined in the data the instructor has provided. Hence, the data contains 120 rows (=30 investment opportunities x 4 cases).

For each row of the provided data, calculate the CEO premia and the “exercise frequencies” using Monte-Carlo simulation. (For “exercise frequencies,” see Kang and Letourneau, 2013.) When you do this task, first notice that Eq. (6) of Kang and Letourneau (2013) implicitly assumes that
the strike price 𝐾 of CEO will change as (𝐻 × (𝐹𝜏𝑆 + 𝑀𝑃𝜏𝑆 )) changes. However, this assumption is unrealistic. In your Monte-Carlo simulation, fix K to a constant. In other words, you need to
slightly change your MC simulation that you used in a) and b).

Use appropriate variance reduction techniques as necessary to increase the calculation speed of Monte-Carlo simulation. (Control the absolute error within plus/minus 1 cents with a 95% confidence.) Calculation speed is important in this exercise because you, as a quantitative financial analyst, may repeat this exercise for many other locations and plant types later per request of your management.

Finally make a recommendation of which investment opportunity is the most valuable and discuss why you make such a recommendation. You should logically support your recommendation. For each investment opportunity, you consider 4 cases - “Base Case,” “No Emission Cost Case,” “High Emission Cost Case,” and “High Capital Cost Case” – as defined in the provided data. If necessary, fell free to create other “cases,” such as “Extremely High Emission Cost Case,” and use the results to argue for your recommendation.
