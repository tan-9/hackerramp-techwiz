import pandas as pd

# Load the master products database
master_df = pd.read_csv('fashionFeed/backend/files/master.csv')

# print(master_df.head())

master_df.drop(master_df.columns[3], axis=1, inplace=True)

master_df.rename(columns={'seller':'brand'}, inplace=True)
print(master_df.columns)

userOrders_df = pd.read_csv('fashionFeed/backend/files/userOrders.csv')
userWishlist_df = pd.read_csv('fashionFeed/backend/files/userWishlist.csv')
userSearch_df = pd.read_csv('fashionFeed/backend/files/userSearch.csv')

userOrders_df.fillna(0, inplace=True)
userWishlist_df.fillna(0, inplace=True)
# print(userOrders_df.isnull().sum())
# print(userWishlist_df.isnull().sum())
# print(userSearch_df.isnull().sum())

print(master_df['purl'].iloc[0])

def get_category(url):
    url_split = url.split('/')
    category = url_split[3]
    return category

master_df['category'] = master_df['purl'].apply(lambda x: pd.Series(get_category(x)))

print(master_df.head())






