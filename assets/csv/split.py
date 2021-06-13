import csv
from itertools import groupby
from operator import itemgetter
import pandas as pd

def divideIntoLists(file_path):
    # file_path = "./med_list.csv"
    # file_path = "./medA.csv"
    data = []

    with open(file_path) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        line_count = 0
        for row in csv_reader:
            if line_count == 0:
                line_count += 1
            else:
                tempList = list(row)
                data.append(tempList[1])
                line_count += 1
        print(line_count)
    
    print('Done')
    multiList = []
    for letter, words in groupby(sorted(data), key=itemgetter(1)):
        multiList.append(list(words))
    return multiList

mList = divideIntoLists("./med_list.csv")
for item in mList:
    char = item[0][0]
    dict = {"items" : item}
    df = pd.DataFrame(dict)
    df.to_csv("med" + char + ".csv")
    mSublist = divideIntoLists("./med" + char + ".csv")
    for subItems in mSublist:
        dict = {"items" : subItems}
        df = pd.DataFrame(dict)
        df.to_csv("med" + char + subItems[0][1] + ".csv")
print("CSV written");