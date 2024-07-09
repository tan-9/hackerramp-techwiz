import pandas as pd

# Load the master products database
df = pd.read_json('https://query.data.world/s/tf7lztreshn5ebbh3zlkhvslpeqfv7?dws=00000')

print(df.head())

df.drop(df.columns[[1,2,5]], axis=1, inplace=True)
print(df.columns)

df.rename(columns={'name':'product'}, inplace=True)
print(df.dtypes)

