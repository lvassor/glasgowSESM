# Statistics Workbook 1 – Summarising and Presenting Data

1. The dataset ‘alert_rct.xls’ contains results from a randomised controlled trial evaluating the effect of fluvastatin on cardiac outcomes in renal transplant recipients. Renal transplant recipients are at increased risk of premature cardiovascular disease and this trial investigated the effects of fluvastatin on cardiac and renal endpoints in this population (thanks to Prof Alan Jardine, Professor of Renal Medicine and Head of Undergraduate Medical School, for permission to use this data set. NOTE: the data you have is real but is a random sample which is approximately half the size of the trial population).

    a.) It’s important to know the type of data you have, as this will dictate how you can summarise, plot and ultimately analyse the data. Which are the quantitative and which are qualitative variables in dataset (ignore patid as that’s just an ID and not a variable of interest)?
    
    *Quantitative:*
    *age, dbp, sbp, bmi, ldl_b, ldl_6, cho_b, cho_6, hdl_b, hdl_6, tri_b, tri_6*

    *Qualitative:*
    *randgrp, sex, csmoker*

    Comparing the descriptive statistics of demographics and baseline measurements of other variables of interest (in this case age, sex, smoking, BMI, total cholesterol, LDL, HDL and triglycerides) between the placebo and treatment (Fluvastatin, here) groups is commonly done in randomised controlled trials. Why is it important to check this?

    *It is important to check this as this gives us an overall feel for the ditribution of the data as well as any correlations that exist. This will help inform any interpretations of results that we make post-analysis. It is also important when constructing models as two explanatory variables may correlate with one another, which is informative to predictions. It is also important as a randomised control trial relies on random group assignments, so checking descriptive statistics allows us to check whether the distributions in each group are broadly similar, to not bias any results.*

    <p style="color: #57A0D3">Answer: It’s important to compare baseline measurements and demographics of the different arms of a randomised controlled trial as randomisation is used to try and ensure there is balance between the arms of the study, i.e. they are similar groups of individuals (e.g. they aren’t noticeably younger in one group). It’s also done to check that the distribution of these variables in the data are as expected (e.g. are the participants around the age that we’d expect renal transplant patients to be).</p>

    For these data, compare between the 2 treatment groups the variables ‘age’, ‘sex’ and baseline triglycerides (‘tri_b’) using descriptive statistics. What do the descriptive statistics tell you?
    ```
        randgrp age_N age_N_total age_Mean age_SE_Mean age_StDev age_Min age_Q1
        <dbl> <int>       <int>    <dbl>       <dbl>     <dbl>   <dbl>  <dbl>
    1       0   504         504     49.4       0.470      10.6    23.6   41.4
    2       1   496         496     49.9       0.492      11.0    27.1   41.5
    # ℹ 3 more variables: age_Median <dbl>, age_Q3 <dbl>, age_Max <dbl>
    # A tibble: 2 × 11
    randgrp tri_b_N tri_b_N_total tri_b_Mean tri_b_SE_Mean tri_b_StDev tri_b_Min
        <dbl>   <int>         <int>      <dbl>         <dbl>       <dbl>     <dbl>
    1       0     499           499       2.15        0.0582        1.30       0.4
    2       1     489           489       2.19        0.0519        1.15       0.6
    ```

    *For the continuous measurements like baseline triglyceride, data seems similar for both groups - very close mean, standard deviation and standard error.*
    <img src="../output/wb1SummarisingPresentingData/age_boxplot.png" style="width: 40%">
    
    *Age seems very similar - same quartiles and mean in each group. *
    Another issue that can cause problems in clinical trials is missing data. How much missing data is there data?*

    <img src="../output/wb1SummarisingPresentingData/tri_b_boxplot.png" style="width: 40%">

    *Baseline triglyceride all simialr although some greater outliers in the 0 group which may skew results.*

    <!-- For the categorical variable counts:
    <img src="../output/wb1SummarisingPresentingData/sex_count_.png" style="width: 40%"> -->

    <p style="color: #57A0D3">Answer: For the continuous baseline measurements Randomisation seems to have worked very well as can be seen in the summary statistics tables below (and more easily in the boxplots and bar chart). For ‘age’ and ‘tri_b’, we can see there’s little difference between groups for any of the quantitative baseline variables, for almost all summary statistics (mean, SD etc) except perhaps minima and maxima; these differ more as these are unstable summary statistics since each one is based on a single person.
    This is not surprising as sample size is large and randomisation should work very well in large samples (in small samples there is a greater likelihood of imbalances between groups – a technique called minimisation can be used here to ensure balance, though only for the variables specified).
    The descriptive statistics can also be used to show that the variable Age appears to be symmetric, with mean ages being similar to median ages and the distance between median and Q1 being similar to the distance between Q3 and the median. For example, the median-Q1=8 years and Q3-median=9 years for both groups and the means and medians are almost identical (means=49.4 (placebo) and 49.9 (drug) and medians=49.2 and 49.7 years).
    However, Tricglycerides are not symmetric – they are somewhat positively skewed. This can be seen as median-Q1 (=0.4 (placebo) and 0.5 (drug)) is smaller than Q3-median (=0.8 (placebo) and 0.7 (drug) mmol/L). Also as the mean (2.2) is a fair bit larger than the median (1.8 or 1.9).
    The categorical variable sex has fairly similar proportions across both treatment groups, although there are slightly more males in the placebo group (66.5% (placebo) and 63.5% (drug) are male). This extent of imbalance is unlikely to be an issue and is not unexpected in a small proportion of measured baseline variables.</p>

    
Another issue that can cause problems in clinical trials is missing data. How much missing data is
there data?

*In total there were 214 missing values in the dataset. Never more than 2.5% of a variable column.*
```        Variable Missing_Count
patid      patid           0.0
randgrp  randgrp           0.0
age          age           0.0
sex          sex           0.0
csmoker  csmoker           0.0
dbp          dbp           0.6
sbp          sbp           0.5
bmi          bmi           2.1
ldl_b      ldl_b           2.2
ldl_6      ldl_6           4.2
cho_b      cho_b           1.2
cho_6      cho_6           2.5
hdl_b      hdl_b           1.8
hdl_6      hdl_6           2.6
tri_b      tri_b           1.2
tri_6      tri_6           2.5
```
<p style="color: #57A0D3">Answer: There is some missing data for some variables, but it is never more than 2.5% of the
data. If a study has a lot of missing data, that can be an issue. There are a set of
methods to deal with missing data called “imputation”, though note that none can help
if there are systematic reasons why there missing data is happening.
Another reason to show this data is so those familiar with Renal Transplant patients
can check whether the patients in the sample are similar to Renal Transplant patients
in general – i.e. are their mean ages (about 50), BP (85/140), BMI (~26) etc. or the
spread of these typical? Also do such patients in general tend to be twice as likely to
be men as women and are about 1 in 5 smokers? We won’t know this, but experts in
the area will do.</p>

b) Given that the drug studied in the trial is a statin, it is of interest to see what has happened to LDL cholesterol levels over time. To do this calculate the percentage reduction in LDL concentrations between baseline and 6 weeks after randomisation.

```
randgrp `mean(ldl_diff, na.rm = TRUE)`
    <dbl>                          <dbl>
1       0                          0.889
2       1                        -25.7  
```
Group 1 treatment shows a 25.7% mean reduction in ldl levels.

c) Obtain descriptive statistics to compare the percentage reduction in lipid concentrations calculated in b) between the placebo and fluvastatin treatment groups. What are the mean percentage reductions for the two treatment groups?

```
randgrp ldl_diff_N ldl_diff_N_total ldl_diff_Mean ldl_diff_SE_Mean ldl_diff_StDev ldl_diff_Min ldl_diff_Q1 ldl_diff_Median ldl_diff_Q3 ldl_diff_Max
    <dbl>      <int>            <int>         <dbl>            <dbl>          <dbl>        <dbl>       <dbl>           <dbl>       <dbl>        <dbl>
1       0        478              478         0.889            0.988           21.6        -58.7       -10.6             0          8.79        200  
2       1        460              460       -25.7              0.857           18.4        -72.3       -37.3           -29.1      -16.7          71.4
```

d) Given the results of c) what is your subjective impression of the effectiveness of fluvastatin in lowering LDL?

Fluvastatin shows a clear reduction in LDL versus the Placebo, on average at 26% reduction versus 1% increase (mean)

<p style="color: #57A0D3">Answer: It’s clear that Fluvastatin reduces LDL much more on average (nearly 26% for mean, 29% for
median) than placebo (1% increase for mean, 0% change for median)) does in sample. Given
that Q3 Fluvastatin has greater reduction (16.7%) than Q1 placebo (10.6%), the boxes of a
boxplot do not overlap. Min and Max values suggest some large outliers – a few patients in
both group have unusually large reductions or increases in LDL. The plots show the same as the summary statistics and also show that a small percentage of
patients in both groups can have large changes. The fact that these are larger in the positive
direction is likely to be because these percentage changes and can’t go below -100 (since they
are a kind of rescaled ratio). Note also from the individual value plot that there are far more
individuals whose ldl does not change at all (in both groups) compared to what we would
expect from the rest of the distributions – there’s a big spike in both at 0. This gives some
concern that some ldl values may not always have been properly recorded (perhaps not
recorded at one time point with the other time point’s value used as a proxy).</p>

2. The dataset ‘ischaemic_damage.xls’ contains the results from a study comparing the brain
damage after experimental stroke in two strains of rats (thank you to Drs Deborah Dewar and Chris
McCabe for permission to use these data). The strains of rat are SHRSP and WKY and a major
biological difference between them is that SHRSP rats develop hypertension in early adulthood whilst
WKY rats remain normotensive. The purpose of the experiment was to determine if the amount of
brain damage resulting from experimentally-induced stroke, induced by occlusion of the middle
cerebral artery, was different in the two strains of rats. The primary measurements are the areas of
ischaemic damage in 8 anatomically separate sections of brain. This is then computed into an overall
volume but it is also interesting to plot the areas over distance to see how the two groups might
differ depending on the anatomical location of the damage.

a) Obtain descriptive statistics for the area of damage at the back of the brain for the SHRSP and WKY strains of rat.

```
  strain area_N area_N_total area_Mean area_SE_Mean area_StDev area_Min area_Q1 area_Median area_Q3 area_Max
   <dbl>  <int>        <int>     <dbl>        <dbl>      <dbl>    <dbl>   <dbl>       <dbl>   <dbl>    <dbl>
1      1      6            6      37.6         3.18       7.78    28.9     32.4        36.3    41.1     50.3
2      2      5            5      20.4         6.36      14.2      1.37    17.1        20.8    21.5     41.2
```

b) What is your subjective impression of the difference in ischaemic damage between the two strains of rat at the back of the brain? Based on this evidence alone, do you think the distribution of area measurements is symmetrical? How did you reach your conclusion?

My subjective impression is that the SHRSP rats that are prone to developing hypertension during early adulthood had greater damage, on average, at the back of the brain than the WKY rats. This is represented by the greater mean (37.6 v 20.4) and median (36.3 v 20.8) damage area. Both data appear to be symmetrical with similar values for mean and median. My impression is that hypertension results in greater damage via induced stroke. Noted that WKY rats have a greater standard deviation than SHRSP rats (14.2, 7.78) perhaps indicating that not having hypertension can result in a greater variety of damage.

<img src="../output/wb1SummarisingPresentingData/area_boxplot.png" style="width: 40%">

<p style="color: #57A0D3">Answer: There appears to be more damage at back of brain for SHRSP strain than WKY strain on average, since the mean damage for SHRSP is 38 mm2 is almost twice that (20 mm2) for WKY.
Mean (37.6 (SHRSP) & 20.4 (WKY)) ≈ Median (36.3 (SHRSP) & 20.8 (WKY)); also median sitting approximately in middle of Q1 and Q3, so no evidence of the data not coming from a normal distribution. Caveat – this is based on small numbers, so the descriptive statistics will be unstable.</p>

c) Produce a clustered boxplot showing the area of ischaemic damage for each section of the brain, for both strains of rat. What is your subjective impression of the plot?

<img src="../output/wb1SummarisingPresentingData/ischaemic_damage_cluster_boxplot.png" style="width: 40%">

Greater damage tends to be experienced by both rat strains in the mid sections of the brain. The front of the brain tends not to experience as great an extent of damage, as represented by area, as the mid sections. SHRSP rats also tend to have tighter distributions with less spread, indicating that the damage experienced by different individuals similar. Anomalies also indicate extreme values of damage for this strain, possibly represented by the same individual.

<p style="color: #57A0D3">Answer: The plot shows that damage in both strains is greater in the middle of the brain
compared to front and back. It also appears to show that the SHRSP strain (in blue)
tends to have greater damage than the WKY strain (green), although there is overlap
at almost all sections (levels). The boxplots appear rather variable in nature across
the sections in each group, but it should be borne in mind that boxplots are not the
best way to display these data as n is very small for both groups (n=5 and 6).
Note that one strain 1 (SHRSP) animal is often a large outlier (it has very large area of
ischaemic damage). We can see this as outliers show row numbers and these are all
adjacent (34,35,…,39). These data are repeated measurements, and ways to
analyse and display that type of data are discussed more in a later lecture.
Debbie Dewar on why damage is greater in the middle sections: “The reason for the
greater amount of damage in the middle of the brain relates to the blood supply. When
you occlude the middle cerebral artery the bit in the middle has a greater severity of
ischaemia because it does not get much supply from other arteries (anterior and
posterior cerebral). As you move away from the middle the tissue gets more and more
supply from the other arteries and so the area which has severe enough ischaemia to
result in damage gets smaller”.
My initial thought had been that the brain cross-sectional area could be largest in
middle and this might be a cause. However, I’ve been told that the total brain area is
much the same at each slice.</p>

d) Produce a clustered plot of the mean and standard deviation of the area of ischaemic damage for
each section of the brain, for both strains of rat. How does the plot compare to the boxplot above?
Again, what is your subjective impression of the plot? Do you think this plot or the boxplot from part
c) gives a better impression of central tendency and spread?

<img src="../output/wb1SummarisingPresentingData/ischaemic_damage_cluster_boxplot_mean_stdev.png" style="width: 40%">
This clustered boxplot of means and standard deviations supports c) in showing overlaps between the strains and greater means for the SHRSP rats in general. Also shows how SHRSP rats exhibit greater variation in the results. However, should be noted that the greater standard deviation and mean values are skewed by the extreme values which are visible in c). c) also gives a better sense of central tendency given it conveys information about the upper and lower quartiles as well as median and mean averages - allowing us to see the distribution of the data more clearly. 

<p style="color: #57A0D3">Answer: Both have their advantages and disadvantages – mean+/-SD is less busy and shows
trends more easily, but gives no idea of the shape of the data (it gives the misleading
impression of symmetrical distributions). The boxplots are perhaps relatively better, as
you can see outliers but Q1, median & Q3 are likely to be very unstable due to small
numbers.
A scatterplot might actually be the best option because you see the data points. Also,
as the data are repeated measures, each rat’s 8 values could be linked by a line – see
later lecture.</p>

e) Produce a scatterplot of the volume of ischaemic damage against the strain of rat. What is your subjective impression of the plot? (NOTE: You will first need to select cases and enter ‘level = 1’ as above so that the plot contains only 1 volume measurement per rat).

<img src="../output/wb1SummarisingPresentingData/ischaemic_damage_scatter_plot_level1.png" style="width: 40%">

Generally, at the front of the brain, there is a greater average volume for SHRSP rats with an extreme value as shown in the other cluster plots.

<p style="color: #57A0D3">Answer: There is a greater volume of damage for SHRSP strain than WKY strain on average
(median looks around 500 mm3 SHRSP and around 300 mm3 for WKY). However, it’s
hard to tell whether there is a statistically significant difference between the groups as
the sample sizes are very small (n= 6 and 5) and though there is little overlap between
groups, there is some and quite a lot variability within each group.</p>

3. The dataset ‘pregnancy_longitudinal.xls’ contains the results from a longitudinal study during pregnancy (thanks to Dr Dilys Freeman for permission to use these data). Measurements were taken at trimester 1, trimester 2, trimester 3, at delivery and at a 3 month postnatal visit. The mother’s BMI was recorded at baseline as well as longitudinal measurements of maternal plasma that relate to the nutrition and development of the baby (leptin, triglyceride and glucose). It is of interest to know how maternal obesity influences the development of the baby. NOTE: we will not include the postnatal measurements in our exploration of the data set.

You can see there is missing data in some cells.
a) What possible reasons can you think of that would lead to missing data in this study?

Dropout from study, no-show to blood measurements, hence why every missing point is missing for the whole row except BMI.

<p style="color: #57A0D3">Answer: Missed appointments? Mothers moving out of area? Etc. Missing data are very
commonly found in datasets and there can be issues in how to deal with this,
especially when there is a lot of missing data. Sophisticated analyses based on
imputation can be used, although note that even they may not always be effective.
Note that we do not cover imputation in this course.</p>

b) How many of the pregnant women were clinically obese at baseline? What is the percentage of women who were clinically obese at baseline in the sample?

34 women clinically obese at baseline, equating to 50.7%

<p style="color: #57A0D3">Answer: Around half of the women (50.7%) are clinically obese at baseline. Make sure you do Data > Select cases first to get n = 67 as the denominator. [Is Obesity around 50% in the population of pregnant women? It might look like these data suggest it, but in fact we can’t tell as this was a study where the aim was to recruit 50% obese and 50% non-obese women. The actual prevelance of obesity is impossible to obtain from this. This needs to be borne in mind when looking at a case-control study.</p>

c) Produce a scatterplot of leptin against gestational age with a marker indicating whether the mother was clinically obese. What is your subjective impression of the plot? Why do the data appear to be grouped? Are there any outliers in the data?

<img src="../output/wb1SummarisingPresentingData/leptin_scatter_plot.png" style="width: 40%">

<p style="color: #57A0D3">Answer: Higher maternal leptin on average for obese mothers as compared to mothers who
are not obese. The data are grouped because measurements are made at similar but
not identical times during pregnancy (around about 12 weeks, 26 weeks, etc.). The
final ‘grouping’ is more spread out because includes both 3rd trimester visit and
delivery measurements (babies aren’t all born at exactly 40 weeks). The data also
appear as if it may be somewhat positively skewed at some measurement times.
There is also one very obvious outlier (see below)! Also, note that whilst in theory it
would be good to show a line joining each individual woman’s values (as the data are
repeated measurements), the sheer number of lines shown would make the plot very
“busy” and harder to interpret</p>

d) Another way to present these data is to use the broader groupings of trimesters and delivery as the x-axis. Produce a clustered boxplot of leptin against measurement time (T1, T2, T3, at delivery), for mothers who are and are not clinically obese. What is your subjective impression of the plot?

<img src="../output/wb1SummarisingPresentingData/leptin_trimester_clusterplot.png" style="width: 40%">

<p style="color: #57A0D3">Answer: Very similar to the scatterplot, but it’s now clearer how leptin is on average higher for
obese women. It also appears that leptin may be more variable after the first
trimester, and more variable in obese women.
(By the way, the outlying data point in leptin is not a true measurement, it was a data
entry error. This illustrates the importance of producing descriptive statistics and
graphs – errors can be spotted - although not all errors will be as obvious as this one.
The true value for this data point is 111.2 ng/ml).</p>
