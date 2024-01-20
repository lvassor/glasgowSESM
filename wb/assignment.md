# MED5538 Evidence Based Biomedical Research Methods and Statistics Summative Assessment

#### GUID: 2957161

**1.a. Using either Minitab or SPSS, obtain appropriate descriptive statistics and suitable plots for the variables Sex, DepCat, RegCat and DFMT individually (i.e. do not look at any relationships between these variables). Provide a short interpretation of the output you produce for each variable.**

The data in the sample are all complete except one entry, which contains a NA value for deprivation category. Since we are comparing dental health between areas with different deprivation categories, this record was removed.

This leaves 40 male and 59 female individuals in the sample, giving us a moderately even spread between the sexes, although containing more females than males. Should there be sex-based differences in dental health, this perhaps would present some issues with our sample, but given we are comparing averages between areas, this ensures we are covering a relatively equal spread of both sexes within area averages.

| Sex | n | proportion |
|---|---|-----------|
| 1 | 40 | 40.40404 |
| 2 | 59 |  59.59596 |

<img src="../output/assignment/sex_barplot.png" style="width: 40%">
<br><br>
DepCat is a categorical variable representing deprivation category for the postcode area of the record. Summary statistics are as follows:

| DepCat |  n | proportion |
|--------|----|------------|
|      4 | 18 |         18.18 |
|      6 | 33 |         33.33 |
|      7 | 48 |         48.48 |


<img src="../output/assignment/depcat_barplot.png" style="width: 40%">


DepCat = 7 is the greatest level of deprivation in this study, and represents a greater proportion of the sample, contrasted with the more affluent areas of DepCat = 4. Such a difference in proportion may cause mean averages to be susceptible to skewing.

Children in the most deprived area (DepCat=7) have the greatest number of decayed, filled or missing teeth (DFMT) (mean=6.35, median=5). In a slightly less deprived area (DepCat=6), children have fewer DFMT (mean=3.78, median=2). In the least deprived/most affluent area of the sample (DepCat=4), the average DFMT is interesting insofar as the mean is slightly less (mean=3.22), while the median is greater (median=3) than DepCat=6. 

CORRECT HIS Only in the least deprived area do the data appear to be symmetrical (mean approximates median), as shown by the boxplot. For DepCat 6 and 7, the data do not appear to be symmetrical, indicating that a handful of individuals with extreme levels of poor dental health may be skewing the mean. This is congruent with the variability of the data, as shown by the standard deviations, which differ across the deprivation categories but are as great, if not greater, than their corresponding mean.

| DepCat | DFMT_N | DFMT_N_total | DFMT_Mean | DFMT_SE_Mean | DFMT_StDev | DFMT_Min | DFMT_Q1 | DFMT_Median | DFMT_Q3 | DFMT_Max |
|--------|--------|--------------|-----------|--------------|------------|----------|---------|-------------|--------|----------|
| 4      | 18     | 18           | 3.222222  | 0.7256080    | 3.078494   | 0        | 0.00    | 3           | 5.75   | 9        |
| 6      | 33     | 33           | 3.787879  | 0.8231471    | 4.728620   | 0        | 0.00    | 2           | 5.00   | 17       |
| 7      | 48     | 48           | 6.354167  | 0.7698264    | 5.333513   | 0        | 1.75    | 5           | 10.00  | 20       |

2. Formal Analysis Output

**Levene's Test for Homogeneity of Variance (center = median)**

| Df | F value | Pr(>F) |
|----|---------|--------|
| 1  | 4.6299  | 0.0339 |
| 97 |         |        |



**Welch Two Sample t-test**

|                  |                  |
|:----------------:|:----------------:|
| **data:**         | DFMT by Poorest  |
| **t:**            | -2.8561          |
| **df:**           | 89.241           |
| **p-value:**      | 0.005335         |
| **alternative hypothesis:** | true difference in means between group 0 and group 1 is not equal to 0 |
| **95 percent confidence interval:** | -4.6901221 -0.8417406 |
| **sample estimates:** | |
| mean in group 0 | mean in group 1 |
| 3.588235 | 6.354167 |

This is a 2-sample t-test and Confidence Interval (CI) comparing DFMT count of children living in one of the poorest areas of Glasgow (deprivation category of 7), and children not living in one of the poorest areas (deprivation categories of 4 and 6). To help decide whether equal variances should be assumed or not, Levene’s test is used (H0 (null hypothesis): population variances for poorest and not poorest areas are the same). Since the p-value = 0.0339, i.e. is less than the significance level of 0.05, there is evidence against the null hypothesis. Therefore, we reject the null hypothesis of equal variances, concluding that the assumption of equal variances is violated. This means we should use a version of the t-test and CI that does not assume homogeneity of variance, such as the Welch Two Sample t-test, rather than Student's t-test.

For the Welch's t-test, the H0 is that the population mean DFMT count for the poorest area = population mean DFMT count for non-poorest areas. H1 is that they are unequal. Since the p-value of 0.005335 is less than 0.05, we have sufficient evidence to reject the null hypothesis that DFMT counts are the same for both groups. There is sufficient evidence to conclude that the mean DFMT values are significantly different between the two groups (Poorest 0 and Poorest 1). The negative t-value suggests that the mean DFMT value is lower in group 1 (CHECK THIS) compared to group 0. The 95 percent confidence interval for the difference in means does not include zero, supporting the significance of the result.

The CI indicates that in the population we have 95% confidence that children's count of decayed, missing or filled teeth in the poorest areas of Glasgow is likely to be anywhere between almost 1 to almost 5 more teeth than outside of the poorest areas/more affluent areas. This represents a substantial difference given that children have 20 deciduous teeth by age 3, and upwards of this ahead of growing a full set of 32 teeth as adults. CAN YOU BE THIS CONFIDENT?

Whilst this represents a substantial difference, there are several caveats needed when interpreting results. Firstly, it was shown that a large proportion of the sample represented areas with the maximum deprivation category versus the lowest score in this study (48.5% v 18.2%). Given the greater standard deviation of DepCat=7 (5.3) compared to the other categories, this means we have a greater sample of children within these categories, with greater spread in the data, versus other categories (despite the outliers shown in the box plot). From this we can say that the mean of poorer areas is likely being subjected to skewing from greater values (note the relative length of the whisker for the poorer group, as well as the mean for DepCat = 6 (which is still relatively deprived) being much closer to that of DepCat =4. A larger study would need to take place in which an equal sample is taken from more affluent areas, as well as greater samples from each category to account for the effect of extreme values and variability in the data.

Question 2:
State the assumptions of regression that can be assessed using residual plots. For each of
these, state which residual plot or plots are useful for assessing the assumption and
describe how the assumption can be checked, giving brief details of what should be
looked for in each plot. [Note: there is no need to analyze any data in this question.


Residuals vs. Fitted Values:

Assessment: Checks for linearity and independence.
What to Look For: A horizontal line with no discernible pattern indicates linearity and independence. Patterns or curvature may suggest non-linearity or violations of independence.
Normal Q-Q Plot:

Assessment: Checks for normality of residuals.
What to Look For: A roughly straight line indicates normality. Deviations from a straight line suggest departures from normality.
Scale-Location (Spread of Residuals):

Assessment: Checks for homoscedasticity (constant variance of residuals).
What to Look For: A horizontal line with constant spread indicates homoscedasticity. A funnel-shaped pattern may suggest heteroscedasticity.
Residuals vs. Leverage:

Assessment: Checks for outliers and influential points.
What to Look For: Points outside the Cook's distance threshold are potential outliers or influential observations.

AMEND THESE AS THEY ARE FROM CHAT GPT