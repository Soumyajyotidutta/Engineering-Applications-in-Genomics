# Fall22
Works/MATLAB/CoLab

The Rank Sum Test
Given two samples X1, X2,…, Xn   and Y1, Y2,…, Ym  from populations X and Y, we wish to test the hypotheses
This is the test procedure
1.	Arrange the m + n observations in ascending order. In case of a tie use the mean rank.
2.	Define Wx and Wy as the sum of ranks of samples in  X and Y. 
3.	In the precompiled table locate w α for sample sizes m, n.
4.	 The null hypotheses H0 is rejected in favor of H1 if either of Wx or Wy is less than or equal to w α. Here α is the significance level.
Exercise 1.1

Following is a sample of scores of students on a standardized test. 
Section :1	60,51,48,49,48
Section :2	61,62,62,49,50,52,61,63  

QUESTIONS
1.	Is there any reason to suspect students in one section are performing better? Use the rank sum test with α =0.01, 0.05. 

2.	If the highest scores in each class are dropped, how does it change the conclusion? (α =0.05).









Image Analysis 

Follow the paper discussed in class  

Exercise 1.2 

1.	Derive equation (10) starting from equation (7) in the paper. 
2.	Generate two sets R {r1, r2… rn} and G{ g1, g2… gn} of  i.i.d  gaussian points, with mean =1 and  standard deviation σ =0.10. (n=100)
3.	Compute the set T{t1, t2… tn}, where ti= ri/ gi .
4.	Now use (10) to estimate c from T.  
5.	Repeat 1-4. for σ = 0.15 and 0.2 . What do you observe?

Hint:  Matlab function random can be used to generate points.


Now download the files spot.m, spot.fig, spotdata.mat .
Launch matlab and use command spot to run the tool. 
Exercise 1.3 
Load image 1 
1.	Take a guess at the ratio T (Red /Green) value (by looking at the image). 
2.	Calculate the ratio T (R/G) for significance levels 0.05, 0.01. 
3.	Repeat 1 for significance level 0.01 4 times, do you get the same value of T? Explain source of variation. 
Now load image 2. 
1.	What is the trend of the size of target site area as you change significance level? Watch carefully this area flashes briefly in the image. 
2.	Do a scatter plot of T values vs. significance level. Take more than 1 observation/ significance level. Use log scale for significance level axis. 
Hint:  The matlab function scatter can be used.
Assume that red and green channels are calibrated i.e. m=1. Use Table 1 in the paper.

Exercise 1.4

1.	An estimate for the coefficient of variation c is obtained as  , what are the lower and upper limits for a 95% confidence interval. 
2.	The ratio T, for gene CMAR is found as 2.06 in a sample. What is the status of this gene? (It is up regulated /down regulated/ unregulated)
3.	Does the conclusion (in 2.) change if the estimate   was =0.30. 
 

Tables  for 1.1.
