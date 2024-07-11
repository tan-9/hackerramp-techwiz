import pandas as pd
# from sklearn.feature_extraction.text import TfidfVectorizer
# from sklearn.preprocessing import OneHotEncoder

# Load the master products database
master_df = pd.read_csv('fashionFeed/backend/files/master.csv')

# print(master_df.head())

master_df.drop(master_df.columns[3], axis=1, inplace=True)

master_df.rename(columns={'seller':'brand'}, inplace=True)
# print(master_df.columns)

userOrders_df = pd.read_csv('fashionFeed/backend/files/userOrders.csv')
userWishlist_df = pd.read_csv('fashionFeed/backend/files/userWishlist.csv')
userSearch_df = pd.read_csv('fashionFeed/backend/files/userSearch.csv')

userOrders_df.fillna(0, inplace=True)
userWishlist_df.fillna(0, inplace=True)
# print(userOrders_df.columns)
# print(userSearch_df.columns)
# print(userWishlist_df.columns)

most_ordered_brand = userOrders_df['brand'].value_counts().idxmax()
most_wishlisted_brand = userWishlist_df['brand'].value_counts().idxmax()

# print(most_ordered_brand, '\n',most_wishlisted_brand)
# print(userOrders_df.isnull().sum())
# print(userWishlist_df.isnull().sum())
# print(userSearch_df.isnull().sum())

# print(master_df['purl'].iloc[0])

def get_category(url):
    url_split = url.split('/')
    category = url_split[3]
    return category

userOrders_df['category'] = userOrders_df['link'].apply(lambda x: pd.Series(get_category(x)))
userWishlist_df['category'] = userWishlist_df['link'].apply(lambda x: pd.Series(get_category(x)))
master_df['category'] = master_df['purl'].apply(lambda x: pd.Series(get_category(x)))

print(userWishlist_df.head())

# content-based filtering

# encoder = OneHotEncoder()
# encoded_brand = encoder.fit_transform(master_df[['brand']])
#add categories for user wishlist and user orders then encode categories







