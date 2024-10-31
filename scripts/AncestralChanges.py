"""
Created on Thu Mar 28 12:14:01 2019

@author: david
"""
import baltic as bt
import pandas as pd

treeFile = 'annotated_tree.nexus'
outFile = 'annotated_tree_events.csv'
myTree=bt.loadNewick(treeFile, absoluteTime=False)
myTree.setAbsoluteTime(2023.786301) # need to set this to time of last sampled tip

myTree.traverse_tree() ## required to set heights
myTree.treeStats() ## report stats about tree

changes = 0
times = []
origins = []
destinations = []
for k in myTree.Objects: ## iterate over a flat list of branches
    
    "Assign node UNKNOWN region if not give"
    if 'country' in k.traits:
        region = k.traits['country']
    else:
        region = 'UNKNOWN'
        k.traits['country'] = region 
    
    "Find parent region if given"
    if k.parent.traits:
        parent_region = k.parent.traits['country']
    else:
        parent_region = 'UNKNOWN'
        
    if region != parent_region:
        changes += 1
        times = times + [k.absoluteTime]
        origins = origins + [parent_region]
        destinations = destinations + [region]
        
        
print("Total number of state changes: " + str(changes))

df = pd.DataFrame({'EventTime' : times})
df['Origin'] = origins
df['Destination'] = destinations

df.to_csv(outFile)  
    

