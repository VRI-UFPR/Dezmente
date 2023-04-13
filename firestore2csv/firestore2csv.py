import pandas as pd
from datetime import datetime
from os import environ
from google.cloud import firestore

# load cloud firestore 
environ["GOOGLE_APPLICATION_CREDENTIALS"] = "./dezmente-ufpr-firebase-adminsdk.json"
db = firestore.Client()

df = pd.DataFrame() # output dataframe

users = db.collection('users').stream()
for user in users:

    # sign up info to dataframe row
    print(user)
    userdata_row = pd.DataFrame.from_dict(user.to_dict(), orient='index').T
    userdata_row.insert(0, 'userID', [user.id], True)
    
    testes = db.collection(f'users/{user.id}/testes').stream()
    for teste in testes:
        utc_time = datetime.fromtimestamp(teste.to_dict()['timestamp'].timestamp()) # convert timestamp
        
        results_row = pd.DataFrame()
        score = 0
        results = db.collection(f'users/{user.id}/testes/{teste.id}/results').stream()
        for result in results:
            data = result.to_dict()

            score += int(data['score'])

            data.pop('testType')
            id = str(data.pop('testId'))
    
            # result info to dataframe row
            key_row = []
            value_row = []
            for k,v in data.items():
                key_row.append(id + '_' + k)
                value_row.append(str(v))
            new_res_row = pd.DataFrame(index=key_row, data=value_row).T

            # concatenate all results
            results_row = pd.concat([results_row, new_res_row], join='outer')
        
        # concatenate all tests
        results_row = results_row.reindex(sorted(results_row.columns), axis=1) 
        results_row = results_row.apply(lambda x: pd.Series(x.dropna().values))
        results_row.insert(0, 'testDate', [utc_time], True)
        results_row.insert(45, 'totalScore', [str(score)], True)

        # concatenate tests row with user info
        test_row = pd.concat([userdata_row, results_row], join='outer')
        test_row = test_row.apply(lambda x: pd.Series(x.dropna().values))

        df = pd.concat([df, test_row]) # concatenate with full dataframe

df.sort_values(by='testDate')
df.to_csv('output.csv', index=False)