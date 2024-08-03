from math import sqrt

def normalize_data(train, test):
    minvalue = []
    maxvalue = []
    for r in range(len(train)):
        if r == 0:
            for c in range(len(train[r])):
                minvalue.append(train[r][c])
                maxvalue.append(train[r][c])
        for c in range(len(train[r])):
            if train[r][c] < minvalue[c]:
                minvalue[c] = train[r][c]
            if train[r][c] > maxvalue[c]:
                maxvalue[c] = train[r][c]
    for r in range(len(train)):
        for c in range(len(train[r])):
            train[r][c] = (train[r][c]-minvalue[c])/(maxvalue[c]-minvalue[c])
    for r in range(len(test)):
        for c in range(len(test[r])):
            test[r][c] = (test[r][c]-minvalue[c])/(maxvalue[c]-minvalue[c])
    return train, test

def get_distances(point, data):
    distances = []
    for record in data:
        sums = 0
        for f in range(len(record)):
            sums += (point[f]-record[f])**2
        distance = sqrt(sums)
        distances.append(distance)
    return distances

def run_knn(train_set, test_set, k):
    #first, scale the data

    train_set, test_set = normalize_data(train_set, test_set)

    #start a list of predictions
    preds = []
    actual_labels = []
    for record in test_set:
        actual_labels.append(record[-1])
    #go through each test record and get its k nearest neighbors
    for record in test_set:

    #compute distances from record to all the training records
    #careful here! remember the label is in the last column
    #do NOT pass the label into the distance calculation!

        distances = get_distances(record, train_set[0:len(train_set)-1]) 
        print(distances)
        closest_labels = []
        for i in range(1, k+1):
            minval = float("inf")
            mindex = 0
            for j in range(len(distances)):
                if distances[j] < minval:
                    minval = distances[j]
                    mindex = j
            closest_labels.append(train_set[mindex][-1])
            distances[mindex] = float("inf")
        print(closest_labels)
        #figure out which training records are the k closest ones
        #of the k nearest neighbors, which class label is the majority
        zerocounter = 0
        onecounter = 0
        for label in closest_labels:
            if label == 0:
                zerocounter += 1
            if label == 1:
                onecounter += 1
        if zerocounter > onecounter:
            preds.append(0)
        else:
            preds.append(1)
        #this is the predicted label - add it to the preds list

    return preds, actual_labels

def run_CV(data, k=3, folds=5):
    pass
