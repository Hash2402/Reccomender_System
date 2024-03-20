install.packages("recommenderlab")
library(recommenderlab)

#Loading Data
data("MovieLense")

str(MovieLense) #Structure
slotNames(MovieLense)
str(as(MovieLense,"data.frame"))

head(as(MovieLense,"data.frame"))

recommenderRegistry$get_entries(dataType="realRatingMatrix")

#Item based collaborative model

#Build an evaluating scheme

evls = evaluationScheme(MovieLense,method="split",train=0.8,given=12);
#given =12 is the internal testing part of evaluation where it takes 12 ratings on its won

print(evls)

#getData

trg = getData(evls,'train')
print(trg)

test_known =getData(evls,'known')
test_known

test_unknown=getData(evls,'unknown')
test_unknown


#1 User based reccomender model 
ubc= Recommender(trg,"UBCF")

#predictions
pred_ubc = predict(ubc,test_known,type="ratings")
pred_ubc

#Accuracy

acc_ubc = calcPredictionAccuracy(pred_ubc,test_unknown)
acc_ubc

as(test_unknown,'matrix')[1:5,1:4]
as(pred_ubc,'matrix')[1:5,1:4]

#UBCF does not work properly in case of a new user as the user may have not watched any movies
#Cold start 

#Item Cold start is also an issue as a new movie may not have many reccomendations and may never be reccomeneded in the future

ibc=Recommender(trg,"IBCF")

pred_ibc=predict(ibc,test_known,type="ratings")
pred_ibc

#Accuracy
acc_ibc = calcPredictionAccuracy(pred_ibc,test_unknown)
acc_ibc

as(test_unknown,'matrix')[1:8,1:4]
as(pred_ibc,'matrix')[1:8,1:4]

#Top reccomendations 

p_ub_top =predict(ubc,test_known)
p_ub_top

movie=as(p_ub_top,"list")
movie[1]

