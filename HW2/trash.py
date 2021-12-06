import pandas as pd
import numpy as np
import csv
from sklearn.metrics import confusion_matrix, classification_report
from collections import Counter

import sys
sys.path.append("/home/swe3033/.local/lib/python2.7/site-packages")

def KNN(trainData, testData, k):
    train={ 'label' :   trainData[:,0], 
            'data'  :   trainData[:,1:].astype(int)
            }
    test={  'label' :   testData[:,0],
            'data'  :   testData[:,1:].astype(int)
            }
    #result=[]
    #for data in train['data']:
        #print(data)
    #print(len(train['data']))
    #print(len(test['data']))
    knnResult=[]
    for i, testData in enumerate(test['data']):
        result=[]
        #print(i, 'th test data is :', testData)
        print(i, 'th label=',test['label'][i], end=' ')
        for j, trainData in enumerate(train['data']):
            vec=np.array(testData)-np.array(trainData)
            norm=np.linalg.norm(vec)
            result.append(tuple([j, norm]))
        result.sort(key=lambda x:x[1], reverse=False)
        label_result=[train['label'][d[0]] for d in result[:k]]
        #print(result[:k])
        #print(label_result)
        ans=Counter(label_result).most_common(1)[0][0]
        print('answer : ', ans)
        knnResult.append(ans)   
    return knnResult

def label2char(c):
    if c=='A': 
        return 0
    elif c=='B':
        return 1
    elif c=='C':
        return 2
    elif c=='D':
        return 3
    elif c=='F':
        return 4
    else:
        return None

def calResult(matrix):
    assert(len(matrix)==5 and len(matrix[0])==5)
    matrix=np.matrix(matrix)
    numOfData=matrix.sum()

    data_for_each_element=[]
    for _ in range(5):
        accuracy, precision, recall, f1score = 0,0,0,0

        TP, TN, FP, FN = 0,0,0,0

        #for 

if __name__=='__main__':

    with open('letter-recognition.csv') as f:
        reader=csv.reader(f)
        data=list(reader)
        data=np.array(data)

    print(data)
    data=[np.array(data[:1289]), np.array(data[1289:2578]), np.array(data[2578:])]
    k=3

    label_answer=list(data[1][:,0])
    train=np.concatenate((data[0], data[1]), axis=0)
    test=data[2]

    label_result=KNN(train, test, k)

    conf_matrix=[   [0,0,0,0,0],
                    [0,0,0,0,0],
                    [0,0,0,0,0],
                    [0,0,0,0,0],
                    [0,0,0,0,0]
                ]
    print(conf_matrix)

    assert(len(label_answer)==len(label_result))

    answer_tuple=[(label_answer[i], label_result[i]) for i in range(len(label_answer))]

    for answer, result in answer_tuple:
        actual=label2char(answer)
        predict=label2char(result)
        print(actual, predict)
        conf_matrix[actual][predict]+=1

    print(conf_matrix)

    final=confusion_matrix(label_answer, label_result)
    scores=classification_report(label_answer, label_result)
    print(final)
    print(scores)
    #accuracy, precision, recall, f1 = calResult(conf_matrix)