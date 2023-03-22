# risk factor의 영향이 시간에 따라 일정하지 않을 경우 (비례위험 가정이 성립하지 않는 경우), restricted mean survival time (RMST) 모형이 대안으로 사용된다


#예시 데이터 pbc 사용
library(survival)


# time, status(1:death, 0:censor), arm(1:D-penicillamine, 0:Placebo)
library(survRM2)
D = rmst2.sample.data()
head(D[,1:3])


#RMST는 area under the curve of the survival function up to specific time point
# 즉, time T까지 환자들의 상태를 기록하였을 때, 평균적으로 ut까지 생존하더라
# censored observation이 없을 경우 그냥 survival time의 평균과 같다
# restricted mean is a measure of average survival from time 0 to a specified time point



# RMST로 test of the diffrence in restricted means

#RMTL은 area above the curve of the survival function up to a certain time T
#시간0에서부터 정해진 시점까지의 평균 생존의 척도를 보여줌
#restricted => restricted time interval
#그래서 rmst가 더 reliable (for example, when we have a censored case at a specific time point)


# 두 treatment 그룹에서의 비교 ut(1) ut(0)



time   = D$time #event 발생 시간
status = D$status #event가 발생했는지 안했는지
arm    = D$arm #어떤 treatment (1:active treatment arm, 0: control arm)

obj= rmst2(time, status, arm, tau=10) #tau는 restricted time point T
obj


plot(obj, xlab="Years", ylab="Probability")

#RMTL ratios approximate HRs for each trial
#Comparing the RMST ratios for the two groups could then help you determine which treatment is more effective.
#RMTL ratio can be used to compare the expected time lost 



#3개의 다른 contrast measure
x=D[,c(4,6,7)]
head(x)

rmst2(time, status, arm, tau=10, covariates=x)

