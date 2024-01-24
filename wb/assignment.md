# MED5538 Evidence Based Biomedical Research Methods and Statistics Summative Assessment

#### GUID: 2957161

**1.a. Using either Minitab or SPSS, obtain appropriate descriptive statistics and suitable plots for the variables Sex, DepCat, RegCat and DFMT individually (i.e. do not look at any relationships between these variables). Provide a short interpretation of the output you produce for each variable.**

The data in the sample are all complete except one entry, which contains a NA value for deprivation category. Since we are comparing dental health between areas with different deprivation categories, this record was removed.

### Sex

Sex is a categorical variable, coded as as 1 for male and 2 for female in our dataset, summary below:

| Sex | n | proportion |
|---|---|-----------|
| 1 | 40 | 40.40404 |
| 2 | 59 |  59.59596 |

<img src="../output/assignment/sex_barplot.png" style="width: 40%">

Removing the NA value leaves 40 male and 59 female individuals in the sample, giving us a moderately even spread between the sexes, although containing more females than males. Should there be sex-based differences in dental health, this perhaps would present some issues with our sample, but given we are comparing averages between geographic areas, this gives us representation of both sexes with fairly even coverage. 

### RegCat

RegCat is a categorical variable representing registration status of individuals in the sample population, detailing whether they were previously registered with a dental surgery but their registration lapsed ("Lapsed"), never registered ("NotReg"), or currently registered with a dentist ("Reg"). Summary below:

| RegCat |  n  | proportion |
|--------|----:|------------:|
| Lapsed | 10  |    10.10101 |
| NotReg | 42  |    42.42424 |
|   Reg  | 47  |    47.47475 |

<img src="../output/assignment/regcat_barplot.png" style="width: 40%">

As the table data shows, there is roughly a 50/50 spread between individuals currently registered with a dentist and those who are not. This is important for the study since we would expect a correlation between those registered to a dentist and their dental health.  

### DepCat

DepCat is a categorical variable representing deprivation category for the postcode sector of the record. Summary statistics are as follows:

| DepCat |  n | proportion |
|--------|----|------------|
|      4 | 18 |         18.18 |
|      6 | 33 |         33.33 |
|      7 | 48 |         48.48 |


<img src="../output/assignment/depcat_barplot.png" style="width: 40%">


DepCat = 7 is the greatest level of deprivation in this study, and represents a greater proportion of the sample (almost 50%), contrasted with the more affluent areas of DepCat = 4 (less than 20% of the sample, 18 individuals). Small absolute counts such as this can make mean averages more susceptible to outliers and introduce greater variability, presenting issues in comparative tests between populations. In addition, sample sizes of less than 30 can begin to present challenges for certain statistical tests that have an assumption of normality.

| DepCat | DFMT_N | DFMT_N_total | DFMT_Mean | DFMT_SE_Mean | DFMT_StDev | DFMT_Min | DFMT_Q1 | DFMT_Median | DFMT_Q3 | DFMT_Max |
|--------|--------|--------------|-----------|--------------|------------|----------|---------|-------------|--------|----------|
| 4      | 18     | 18           | 3.222222  | 0.7256080    | 3.078494   | 0        | 0.00    | 3           | 5.75   | 9        |
| 6      | 33     | 33           | 3.787879  | 0.8231471    | 4.728620   | 0        | 0.00    | 2           | 5.00   | 17       |
| 7      | 48     | 48           | 6.354167  | 0.7698264    | 5.333513   | 0        | 1.75    | 5           | 10.00  | 20       |


Children in the most deprived area (DepCat=7) have the greatest number of decayed, filled or missing teeth (DFMT) on average (mean=6.35, median=5). In a slightly less deprived area (DepCat=6), children have fewer DFMT (mean=3.78, median=2). In the least deprived/most affluent area of the sample (DepCat=4), the average DFMT is interesting insofar that the mean is slightly less (mean=3.22), while the median is greater (median=3) than DepCat=6. This indicates that in DepCat 6 at least 50% of children in the population have a maximum of 2 DFMT whule in a more affluent area (DepCat 4), 50% of the children have a maximum of 3 DFMT - an interesting observation. However since the DepCat 6 mean is higher, this suggests that there are several extreme values which skew the mean average to be greater than DepCat 4, which is confimed by the greater standard deviation of 4.73 versus 3.08. DepCat 7 shows that for both mean and median values, DFMT is greater, however DepCat 7 also has the greatest standard deviation at 5.33. The median suggests that in the most deprived area, overall there is a greater count of DFMT, howver the trend of greater means and standard deviations as the area becomes more deprived suggests that more deprived areas give way to more extreme values which skew the averages.

It is unclear whether the difference between 


2. Subjective Impression and Assumption Checking (maybe move the above table into this section)

| Poorest | DFMT_N | DFMT_N_total | DFMT_Mean | DFMT_SE_Mean | DFMT_StDev | DFMT_Min | DFMT_Q1 | DFMT_Median | DFMT_Q3 | DFMT_Max |
|---------|--------|--------------|-----------|--------------|------------|----------|---------|-------------|---------|----------|
|    0    |   51   |      51      |  3.588    |    0.588     |   4.196    |    0     |   0.00  |      3      |   5.5   |    17    |
|    1    |   48   |      48      |  6.354    |    0.770     |   5.334    |    0     |   1.75  |      5      |   10.0  |    20    |

Children in the poorest areas have an average decayed, missing or filled teeth (DFMT) count of around 6 (mean=6.35, median = 5). Children not living in the poorest areas have an average DFMT count of around 3 (mean=3.588, median=3). This may be a significant difference but this is unclear, given the variability of the data (standard deviation for group 0 = 4.20 and group 1 = 5.33, and the two boxes overlap substantially). The sample size for each group is fairly substantial and exceeds the n=30 threshold, below which some statistical tests begin to lose robustness, however the standard deviation for each group is certainly large, relative to its respective mean, indicating that the means are being skewed by extreme values, supported by each group's lower median. 

Both distributions in the dental data set seem to depart from normality: they are not symmetric, the median for group 0 is roughly at the mid-point of Q1 to Q3 however this is not so for group 1; and whiskers are not similar lengths. For group 0 the mean is similar to the median however this is not the case for group 1. We assume that the data were independently and randomly sampled having read the study design. Furthermore, given that the data are count data, meaning they are discrete and non-negative, they do not approximate a normal distribution, especially at the sample sizes collected.  Since normality is an assumption of the t-test, I would conclude from these attributes of the data that they are not appropriate for a t-test, and that a Possion or negative binomial regression may be more appropriate for the data collected.

(Nevertheless, the task is to perform a 2-tailed t-test. 

An assumption of a standard t-test (student's t) is that variance is equal in both groups. For this test, we can assume that the variance between groups is not equal and opt for the Welch's t-test, which is less restrictive than Student's test and does not have this assumption. (Levene's test for equal variances is robust against departures from the normal distribution, however for simplicity, here the Welch's t-test is used with no assumption of equal variance.)

Formal Analysis Output
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

Interpretation

This is a 2-sample t-test and Confidence Interval (CI) comparing DFMT count of children living in one of the poorest areas of Glasgow (deprivation category of 7), and children living in less poor (less deprived) areas (deprivation categories of 4 and 6), encoded as "Poorest" group 0 and group 1. Since we have opted for a Welch's 2-tailed t-test, we do not need to check for equal variance, although this can be confirmed with Levene's test, which is robust against departures from normality. ADD LEVENE'S RESULT

For the t-test, the H0 is that the population mean DFMT count for the poorest area = population mean DFMT count for non-poorest areas. H1 is that they are unequal. Since the p-value of 0.005335 is less than 0.05, we have sufficient evidence to reject the null hypothesis that DFMT counts are the same for both groups. There is sufficient evidence to conclude that the mean DFMT values are significantly different between the two groups (Poorest 0 and Poorest 1). The negative t-value suggests that the mean DFMT value is lower in group 0 compared to group 1 (since the mean in group 1 is greater (6.35 v 3.59), the test algorithm is comparing 0 to 1, yielding a negative difference). 

The 95%CI for the difference in means does not include zero, supporting the significance of the result. The CI indicates that in the population we have 95% confidence that children's count of decayed, missing or filled teeth in less poor/more affluent areas of Glasgow is likely to be anywhere between almost 1 (0.84) to almost 5 (4.69) fewer than in the poorest/most deprived areas. Although there is a significant difference between groups, the results are inconclusive since a difference of 1 decayed, missing or filled tooth may not be of signicant medical importance, whereas a difference of 5 decayed, missing or filled teeth likely is. This is especially so given that children have 20 deciduous teeth by age 3, and upwards of this ahead of growing a full set of 32 teeth as adults. Even by conservatively assuming a full set of 32 teeth (unlikely for children), a difference of 5 teeth being DFMT is a substantial proportion. A larger study across other cities in Scotland or the UK, comparing affluent and deprived areas would be needed to answer this.

There are also several caveats needed when interpreting results. Firstly, the aforementioned list of assumptions of the t-test noted that count data (DFMT count) violate the assumoption of normality. At large numbers, count data can approximate normal distributions, however the number in the dental data are smaller samples and they are non-negative and not continuous and so cannot be normally distributed.

Firstly, it was shown that a large proportion of the sample represented areas with the maximum deprivation category versus the lowest score in this study (48.5% v 18.2%). Given the greater standard deviation of DepCat=7 (5.3) compared to the other categories, this means we have a greater sample of children within these categories, with greater spread in the data, versus other categories (despite the outliers shown in the box plot). From this we can say that the mean of poorer areas is likely being subjected to skewing from greater values (note the relative length of the whisker for the poorer group, as well as the mean for DepCat = 6 (which is still relatively deprived) being much closer to that of DepCat =4. A larger study would need to take place in which an equal sample is taken from more affluent areas, as well as greater samples from each category to account for the effect of extreme values and variability in the data.

Question 2:
State the assumptions of regression that can be assessed using residual plots. For each of these, state which residual plot or plots are useful for assessing the assumption and describe how the assumption can be checked, giving brief details of what should be looked for in each plot. [Note: there is no need to analyze any data in this question.)

The assumptions of a regression are as follows:
1. Constant variance, or homoscedasticity: the uniformity of the spread of Y is constant across the range of X. 
2. Linearity: the mean value of Y is a linear function of X.
3. Independence of observations: observations are not influenced by (or dependent on) one another and are independently sampled.
4. Normality of residuals: residuals follow a normal distribution.
5. Error-free values for x: the values of X are error-free and accurately measured.

To test these assumptions with the sample population data, the following plots can be used:

1. Homoscedasticity: Use a Residual vs Fitted plot and look for a consistent spread of residuals across the range of fitted values. A horizontal line with constant spread indicates homoscedasticity. A funnel-shaped pattern may suggest heteroscedasticity.
2. Linearity: Again, use a Residual vs Fitted plot. A horizontal line with no discernible pattern indicates linearity and independence. Patterns or curvature may suggest non-linearity or violations of independence.
3. Independence of observations: this depends on sampling methodology. However, in some cases (such as time series analysis), some data points may be related to data points at previous points in time (autocorrelation). Autocorrelation (which can violate the assumption of independence) can be assessed using Autcorrelation Function (ACF) plots. Spikes on the plot represent correlation at different time lags. There should be significant autocorrelation at a time lag of 0 since any observation is perfectly correlated with itself. There should be no significant autocorrelation at other time lags. If there are significant spikes or patterns at non-zero lags, this may be indicative of some structure or dependency in the data.
4. Normality of residuals: Use a Normal Q-Q plot (quantile-quantile plot) of residuals. A Normal Q-Q plot assesses whether the dataset follows a theoretical normal distribution by plotting observed quantiles (from the sample population) on the y-axis against theoretical, normal quantiles on the x-axis. A roughly linear relationship (plots typically contain a reference line) indicates that the observed data follow a normal distribution, meeting this assumption. Data will typically not be perfectly normally distributed, and a sigmoid pattern is usually expected, which is still indicative of normality. More pronounced deviations like skewness or heavy tails indicate a departure from normality.
5. Error-free values for x: Not directly assessed through residual plots. This involves careful data collection and validation processes during the study design and data gathering phases.

INCLUDE IMAGE OF PLOTS

**Information Session Notes**
* Include graph in question 2 if you want
* Interpretation incljdes one sentence of what is shown in table and graphs for each variable. other sentence should give us an idea of what this tells us about the dataset
* some variables quantitative and some qual - look at topic 1 for displaying variables
* subjective impression should include whether you think there will a statistically significant difference or not and why - measures. how big is the difference between the two distribution (Using various metrics) and other things that will impact statistical significance. 
* list assumptions made by proposed analysis. study validity of those assumptions. if assumptions don't hold for some reason, go ahead and do t-test. if not appropriate, then say its not appropriate (normally distributed?)

confidence interval - computer will calculate. 
formulate null/alternative hypotheses. calculate test statistic. 
point out (un)equal variances. is data iid? don't know how people have been chosen. assuming independent and randomly sampled, appropriate to use t-test that assumes equal variances.

Either compare variances and if ratio is less than 2 then fine, or you can argue that not assuming equal variances is always fine, or can use levene's test - have to argue which.

if using "equal variances not assumed" argument, then don't need to use levene's test. 

use "population" variance.

direction of difference. look at sample means for direction. discuss this difference.

clinical relevance
look at each end of confidence interval - are they potentially giving me a different conclusion if that is what the difference is. may have different conclusions. if each end gives you same conclusion, you can be sure of difference. if confidence interval too wide to get an answer, then larger study needed

mention briefly population of interest