from random import uniform


# Make a prediction with weights
def classify(row, weights):
    sum = 0
    for c in range(len(row)-1):
        sum += row[c]*weights[c]
    sum += weights[-1] #add bias
    if sum < 0:
        return 0
    if sum >= 0:
        return 1

 
#Estimate Perceptron weights using stochastic gradient descent
def train(train_data, n_epoch, l_rate=1):
    weights = []
    for i in range(60):
        weights.append(uniform(-1,1))
    for epoch in range(n_epoch):
        incorrect = 0
        total = 0
        for record in train_data:
            predicted = classify(record, weights)
            actual = record[-1]
            error = actual - predicted
            total += 1
            if actual != predicted:
                incorrect += 1
                for w in range(len(weights)):
                    weights[w] = weights[w] + l_rate*(error*record[w])
        correct = total - incorrect
        #print("epoch", epoch+1, "....", (((correct/total)*1000)//1)/10, "%")
        #if (epoch == n_epoch-1):
        #    return (((correct/total)*1000)//1)/10
    return weights

def test(test_data, weights):
    correct = 0
    total = 0
    for record in test_data:
        predicted = classify(record, weights)
        actual = record[-1]
        total += 1
        if actual == predicted:
            correct += 1
    return (((correct/total)*1000)//1)/10



def cross_validate(dataset, n_folds, n_epoch):
    fold_length = len(dataset)/n_folds
    folds = []
    sum = 0
    for n in range(n_folds):
        fold_dataset = dataset[int(fold_length*n):int(fold_length*(n+1))] #test dataset
        train_dataset = dataset[0:int(fold_length*n)] + dataset[int(fold_length*(n+1)):int(len(dataset))]
        trained_weights = train(train_dataset, n_epoch)
        accuracy = test(fold_dataset, trained_weights)
        folds.append(accuracy)
    print("Folds:", folds)
    for i in folds:
        sum += i 
    print("Mean accuracy:", (sum/len(folds))*1000//1/1000, "%")
            