#source("ML10_RandomForest_UsageExample_iris.r")
data(iris)

run_randomForest <- function(indep,dep){
  my.randomForest <- randomForest(x=indep,y=dep, importance=TRUE, proximity=TRUE, ntree=50,mtry=3)
  my.randomForest.predict <- predict(my.randomForest, indep)
  
  len.randomForest.predict <- length(my.randomForest.predict)
  my.randomForest.result <- vector()
  my.randomForest.matches <- 0
  for ( i in 1:len.randomForest.predict ){
    if ( my.randomForest.predict[i] == dep[i] ){
      my.randomForest.matches <- my.randomForest.matches + 1
    }
  }
  
  my.randomForest.matches/len.randomForest.predict
}

multiple_runs <- function(){
  repeats <- 7
  average_correct <- 0;
  golf <- read.csv("Golf.csv")
  proportion_correct <-vector()
  for( i in 1:repeats){
    proportion_correct[i] <- run_randomForest(golf[,1:6],golf[,7])
    average_correct <- average_correct + proportion_correct[i]
  }
  
  a <- round((average_correct/repeats)*100,digits=1)
  x <- paste("Average correct over ", repeats, " runs is ",a,"%", sep="");
  print(x);
}

multiple_runs()