process_result <- function(listoflist){
  N <- length(listoflist)
  M <- length(listoflist[[1]])
  return_value <- list(rep(0,M))
  for(i in 1:M){
    temp_sum <- 0
    for(j in 1:N){
      temp_sum <- temp_sum + listoflist[[j]][i]
    }
    return_value[[1]][i] <- temp_sum / N #this looks weird
  }
  return(return_value)
}

# test_process_result <- function(){
#   
#   temp <- list()
#   expected_result <- list(rep(2.5, 4))
#   temp[1] <-  list(c(1, 1, 1, 1))
#   temp[2] <-  list(c(2, 2, 2, 2))
#   temp[3] <-  list(c(3, 3, 3, 3))
#   temp[4] <-  list(c(4, 4, 4, 4))
#   
#   actual_result <- process_result(temp)
#   print(actual_result)
#   print(expected_result)
#   
#   if(identical(actual_result, expected_result) == TRUE){
#     print("test_process_result passed")
#   }
#   else{
#     print("test_process_result failed")
#   }
# }
# test_process_result()

#-------------------------------------From http://tinyurl.com/TH-RF-Example--------------------------------#
#source("ML10_RandomForest_UsageExample_iris.r")
data(iris)

run_randomForest <- function(indep,dep){
  my.randomForest <- randomForest(x=indep,y=dep, importance=TRUE, proximity=TRUE, ntree=50,mtry=3)
  my.randomForest.predict <- predict(my.randomForest, indep)
  
  len.randomForest.predict <- length(my.randomForest.predict)
  
  return_list <- list()
  true.positive <- 0
  true.negative <- 0
  false.positive <- 0
  false.negative <- 0
  for ( i in 1:len.randomForest.predict ){
    if ( my.randomForest.predict[i] == 1 && my.randomForest.predict[i] == dep[i]){
      true.positive <- true.positive + 1
    }
    else if(my.randomForest.predict[i] == 0 && my.randomForest.predict[i] == dep[i]){
      true.negative <- true.negative + 1
    }
    else if(my.randomForest.predict[i] == 1 && my.randomForest.predict[i] != dep[i]){
      false.positive <- false.positive + 1
    }
    else if(my.randomForest.predict[i] == 0 && my.randomForest.predict[i] != dep[i]){
      false.negative <- false.negative + 1
    }
  }
  
  return_list[length(return_list)+1] <- true.positive/len.randomForest.predict
  return_list[length(return_list)+1] <- true.negative/len.randomForest.predict
  return_list[length(return_list)+1] <- false.positive/len.randomForest.predict
  return_list[length(return_list)+1] <- false.negative/len.randomForest.predict
  
  
  return(return_list)
}

multiple_runs <- function(){
  proportion_correct <-list()
  for( i in 1:10 ){
    proportion_correct[i] <- run_randomForest(iris[,1:4],iris[,5])
  }
  
  average.confusion.matrix <- process_result(proportion_correct)
  #print(average.confusion.matrix)
  
  
}

multiple_runs()
#-----------------------------------------------------------------------------------------------------#