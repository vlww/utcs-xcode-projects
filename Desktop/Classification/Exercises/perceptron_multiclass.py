# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).
# ----------


# Perceptron implementation
import Helpers.util
from random import uniform


class PerceptronClassifier:

    def __init__( self, legalLabels, max_iterations):
        self.legalLabels = legalLabels
        self.type = "perceptron"
        self.epochs = max_iterations
        self.weights = None 


    def classify(self, data):
        perceptron_index = 0
        highest_index = 0
        max_sum = float('-inf')
        for perceptron in self.weights:
            sum = 0
            for c in range(len(data)):
                sum += data[c]*perceptron[c]
            sum += perceptron[-1] #add bias
            if sum > max_sum:
                max_sum = sum
                highest_index = perceptron_index
            perceptron_index += 1
        return highest_index

 

    def train(self, train_data, labels):
        self.weights = [[],[],[],[],[],[],[],[],[],[]]
        for perceptron in self.weights:
            for i in range(len(train_data[0])):
                perceptron.append(uniform(-1,1))
        for epoch in range(self.epochs):
            incorrect = 0
            total = 0
            for record in range(len(train_data)):
                predicted = self.classify(train_data[record])
                actual = labels[record]
                total += 1
                if actual != predicted:
                    incorrect += 1
                    for weight in range(len(self.weights[predicted])):
                        self.weights[predicted][weight] = self.weights[predicted][weight] - train_data[record][weight]
                        self.weights[actual][weight] = self.weights[actual][weight] + train_data[record][weight]
            correct = total - incorrect
            print("epoch", epoch+1, "....", (correct/total)*100, "%")
    

