
# KPI 1 (No of Invoice by Accnt Exec)

SELECT acc_exe AS Acc_exe, income_class,COUNT(*) AS Invoice_count FROM invoice WHERE income_class 
IS NOT NULL AND income_class != '' AND acc_exe IS NOT NULL AND 
acc_exe != ''GROUP BY acc_exe, income_class ORDER BY income_class DESC, Invoice_count DESC;


# KPI 2 (Yearly Meeting Count) 
SELECT 
COUNT(CASE WHEN meeting_date < '2020-01-01' THEN 1 END) AS 2019_meeting_count,
COUNT(CASE WHEN meeting_date >= '2020-01-01' THEN 1 END) AS 2020_meeting_count
FROM meeting;


# KPI 3.1 (NEW)
SELECT 
CONCAT(ROUND((SELECT SUM(new_budget) FROM budgets) / 1000000, 2), ' mn') AS New_target,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'New') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'New')) / 1000000, 2), ' mn') AS New_achieved,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'New') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'New')
) / NULLIF((SELECT SUM(new_budget) FROM budgets), 0) * 100, 2), '%') AS Achieved_percentage,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'New') / 1000000, 2), ' mn') AS New_invoice,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'New') /
 NULLIF((SELECT SUM(new_budget) FROM budgets), 0) * 100, 2), '%'
    ) AS Invoice_percentage;


# KPI 3.2 (Cross Sell)
SELECT CONCAT(ROUND((SELECT SUM(cross_sell_budget) FROM budgets) / 1000000, 2), ' mn') AS Cross_sell_target,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'Cross Sell') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'Cross Sell')) / 1000000, 2), ' mn') AS Cross_sell_achieved,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'Cross Sell') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'Cross Sell')) / NULLIF((SELECT SUM(cross_sell_budget) FROM 
budgets), 0) * 100, 2), '%') AS Achieved_percentage,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'Cross Sell') / 1000000, 2), ' mn') AS Cross_sell_invoice,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'Cross Sell') / NULLIF((SELECT SUM(cross_sell_budget) FROM 
budgets), 0) * 100, 2), '%') AS Invoice_percentage;



# KPI 3.3 (Renewal)
SELECT CONCAT(ROUND((SELECT SUM(renewal_budget) FROM budgets) / 1000000, 2), ' mn') AS Renewal_target,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'Renewal') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'Renewal')) / 1000000, 2), ' mn') AS Renewal_achieved,
CONCAT(ROUND(((SELECT COALESCE(SUM(amount), 0) FROM brokerage WHERE income_class = 'Renewal') +
(SELECT COALESCE(SUM(amount), 0) FROM fees WHERE income_class = 'Renewal')) / NULLIF((SELECT SUM(renewal_budget) FROM 
budgets), 0) * 100, 2), '%') AS Achieved_percentage,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'Renewal') / 1000000, 2), ' mn') AS Renewal_invoice,
CONCAT(ROUND((SELECT SUM(amount) FROM invoice WHERE income_class = 'Renewal') / NULLIF((SELECT SUM(renewal_budget) FROM 
budgets), 0) * 100, 2), '%') AS Invoice_percentage;


# KPI 4 (Stage funnel by Revenue)

select distinct(stage) as Stage, concat(round(sum(revenue_amount)/1000),"K") 
as Revenue from oppurtinity group by stage;


# KPI 5 (No of meeting by acc_exe)

select distinct(acc_exe) as Acc_exe,count(*) as Meeting_count from meeting group by acc_exe ;


# KPI 6 (Top open Opppurtinity)

SELECT DISTINCT(opportunity_name) AS Opportunity_name, CONCAT(ROUND(SUM(revenue_amount) / 1000), 'K') AS Revenue FROM oppurtinity 
WHERE stage != 'Negotiate' GROUP BY opportunity_name ORDER BY SUM(revenue_amount) DESC LIMIT 4;