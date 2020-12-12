'''
# 
# Python Interpreter
# Ashish Agarwal (ashish.agarwal@chicagobooth.edu)
#
'''


import pandas as pd 
import numpy as numpy
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

import statsmodels.api as sm


# exec(%matplotlib inline)
# ipython.magic('matplotlib','inline')


data = pd.read_csv('Taxi_Data_Reg2_2013.csv')

# define the data/predictors as the pre-set feature names  
# df = pd.DataFrame(data, columns=data.feature_names)

# Put the target (Y Value) in another DataFrame
# target = pd.DataFrame(data.target, columns=["TripTipPercent"])

# print (data)
print (data.head())
# print (data.hist())
# data.info()
# data.describe()
# data.columns

# sns.pairplot(data)
sns.distplot(data['TripTipPercent'])

# data.corr()

X = data[['TripFare','TripSeconds','TripMiles']]
# X = data[['TripFare']]
y = data['TripTipPercent']

model = sm.OLS(y, X,missing='drop').fit()
predictions = model.predict(X)
model.summary()


'''
# 
# Python Interpreter
# Ashish Agarwal (ashish.agarwal@chicagobooth.edu)
#
'''


import pandas as pd 
import numpy as numpy
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

import statsmodels.api as sm


# exec(%matplotlib inline)
# ipython.magic('matplotlib','inline')


data = pd.read_csv('Taxi_Data_Reg2_2013.csv')

# define the data/predictors as the pre-set feature names  
# df = pd.DataFrame(data, columns=data.feature_names)

# Put the target (Y Value) in another DataFrame
# target = pd.DataFrame(data.target, columns=["TripTipPercent"])

# print (data)
print (data.head())
# print (data.hist())
# data.info()
# data.describe()
# data.columns

# sns.pairplot(data)
sns.distplot(data['TripTipPercent'])

# data.corr()

# X = data[['TripFare','TripSeconds','TripMiles']]
X = data[['TripFare']]
X = sm.add_constant(X) ## let's add an intercept (beta_0) to our model

y = data['TripTipPercent']

model = sm.OLS(y, X,missing='drop').fit()
predictions = model.predict(X)
model.summary()

# plt.scatter(y,predictions)
plt.scatter(data[['TripFare']], y)
plt.plot(data[['TripFare']], predictions, color='red')
plt.show()

sns.regplot(x='TripFare', y='TripTipPercent', data=data);