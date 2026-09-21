Regional Sales Performance Analysis
SQL-based analysis of Superstore Canada's regional sales data (2009–2012),
investigating whether pricing strategy or market size drives regional
sales differences — and where to prioritize marketing investment.

Business Questions
	•	Pricing: Should we lower prices further in regions with low total
sales (e.g., Nunavut) to try to increase demand?
	•	Investment: Of all 8 regions, which markets should we prioritize
for additional marketing and sales investment?

Approach
	1.	Queried transactional sales data in SQL Server (SuperStore dataset).
	2.	Enriched the data with Statistics Canada population estimates by
joining a separate Region_Population reference table.
	3.	Built a Customers per 100,000 Population metric to separate
small markets from genuinely underperforming ones.
	4.	Visualized the results as simple charts in Power BI (bar, bubble, and donut charts).
  
Methodology Note
Population figures were initially summed across the four sales years
(2009–2012), which inflated the denominator — population is a "stock"
that shouldn't be summed across years the way revenue (a "flow") can
be. This was corrected by dividing by 4 to recover the average annual
population, which is the statistically defensible denominator to pair
against unique customers. See sql/regional_sales_analysis.sql for the
corrected query and full explanation.

Key Finding
Nunavut's low absolute sales reflect a small, already well-served
market — not weak performance (114 customers per 100K population,
3rd highest in Canada). Ontario and Quebec, despite the largest
populations, have among the lowest customers per 100K (~2), representing
the biggest untapped opportunity for marketing investment.

Tools
SQL Server, Power BI (static charts), Word

Contents
	•	report/Regional_Sales_Analysis.pdf — full written report (includes all charts)
	•	sql/regional_sales_analysis.sql — all queries: table setup, population
figures for the study period, and the corrected metric query

Next Steps
	1.	Study the strategy behind the highest-reach region (Yukon):
analyze what is driving its outsized customers-per-100K rate(channel mix, local partnerships, marketing approach).
	2.	Apply those findings to the low-reach regions: use the
playbook from Yukon to inform outreach strategy in underperforming markets.
	3.	Focus investment and expansion on the two large-population,
low-reach regions (Ontario and Quebec) identified in this
analysis, while maintaining the other markets that already show
high customer reach and strong performance.
