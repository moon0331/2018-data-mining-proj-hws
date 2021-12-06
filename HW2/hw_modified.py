import sys
sys.path.append("/home/swe3033/.local/lib/python2.7/site-packages")

from pyspark import SparkConf, SparkContext
conf=SparkConf()
conf.set('spark.master','local')
conf.set('spark.app.name','my app')
sc=SparkContext(conf=conf)

import numpy as np
import pandas as pd
import csv
from sklearn.metrics import confusion_matrix, classification_report
from collections import Counter
from math import sqrt
import time

def getCSVFile(filename):
	with open(filename) as f:
        	reader=csv.reader(f)
        	data=list(reader)
        	#data=np.array(data, dtype=np.dtype(object))

	for line in data:
        	for i in range(1,len(line)):
                	line[i]=int(line[i])
	return data

def threeFold(data):
	return [ data[:1289], data[1289:2578], data[2578:] ]

def knn(targetdata):
        #print(1)
        def vecnorm(x, y):
                assert(len(x)==len(y))
                val=0
                for i in range(len(x)):
                        val+=(x[i]-y[i])**2
                return val

        k=targetdata['k']
        train={ 'label' : targetdata['train_label'],
                'data'  : targetdata['train_vector'] }
        test ={ 'label' : targetdata['test_label'],
                'data'  : targetdata['test_vector']  }
        knnResult=[]

        result=[]
        testData=test['data']
        for j, trainData in enumerate(train['data']):
                norm=vecnorm(testData, trainData)
                result.append(tuple([j, norm]))
        result.sort(key=lambda x:x[1], reverse=False)
        label_result=[train['label'][d[0]] for d in result[:k]]
        ans=Counter(label_result).most_common(1)[0][0]
        knnResult.append(ans)

        return knnResult

def train(fold, foldnum): # f for debug.txt
	startTime=time.clock()
	b_trainData=[]
	b_testData=[]
	#f.write('test fold[%d] data, others will be training data\n\n'%foldnum)
	
	for i in range(3):
		if i==foldnum:
			b_testData.append(fold[i])
		else:
			b_trainData.append(fold[i])

	trainData=b_trainData[0]+b_trainData[1]
	testData=b_testData[0]

	wholeData=[] #each element is 'data' below defined
	for i in range(1289):
		thisTestData=testData[i]
		data={	'train_label'	: [line[0] for line in trainData],
			'train_vector'	: [line[1:] for line in trainData],
			'test_label'	: str(thisTestData[0]),
			'test_vector'	: thisTestData[1:],
			'k'		: 3
			}
		wholeData.append(data)

	dataRDD=sc.parallelize(wholeData) ###########
	result=dataRDD.flatMap(knn) #function
	resultList=result.collect() #data
	
	#returnValues

	y_true=[line[0] for line in testData]
	y_pred=resultList
	conf_matrix=confusion_matrix(y_true, y_pred)
	scores=classification_report(y_true, y_pred)

	endTime=time.clock()
	elapsed=endTime-startTime

	return y_true, y_pred, conf_matrix, scores, elapsed

if __name__=='__main__':

	data=getCSVFile('../../swe3033/local/data/letter-recognition.csv')
			
	fold=threeFold(data)

	f=open('debug.txt','w')

	for foldnum in range(3):
		f.write('test fold[%d] data, others will be training data\n\n'%foldnum)
		
		y_true, y_pred, conf_matrix, scores, elapsed = train(fold, foldnum)

		f.write(str(conf_matrix)+'\n\n')
		f.write(str(scores)+'\n')
		timeConsumed='%f second elapsed\n\n'%elapsed
		f.write(timeConsumed)
		f.write('===================================================================\n')