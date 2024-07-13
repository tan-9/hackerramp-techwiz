import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import os

master_csv_path = "C:/Users/tanay/Downloads/myntra_excel.csv"
order_csv_path = 'C:/Users/tanay/Desktop/tan/files/userOrders.csv'
wl_csv_path = 'C:/Users/tanay/Desktop/tan/files/userWishlist.csv'
search_csv_path = 'C:/Users/tanay/Desktop/tan/files/userSearch.csv'

df = pd.read_csv(master_csv_path)
# print(df.columns)

df.drop(df.columns[[0,1,4,5,7,8,10,12,14,16,17,21,22,23,25]], axis=1, inplace=True)
df.rename(columns={'title':'item'}, inplace=True)
df.rename(columns={'dominant_color':'color'}, inplace=True)
df.fillna(0, inplace=True)
# Assuming your dataframe is named 'df'
df.drop_duplicates(subset='product_id', keep='first', inplace=True)
df.drop_duplicates(subset='item', keep='first', inplace=True)
# print(df.isnull().sum())

# sample_size = 1200
# df = df.sample(sample_size)

# print(df.head())

userOrders_df = pd.read_csv(order_csv_path)
userWishlist_df = pd.read_csv(wl_csv_path)
userSearch_df = pd.read_csv(search_csv_path)

userOrders_df.fillna('.', inplace=True)
userWishlist_df.fillna('.', inplace=True)
# print(df.columns)
# print(userOrders_df.columns)
# # print(userSearch_df.columns)
# print(userWishlist_df.columns)

most_ordered_brand = userOrders_df['brand'].value_counts().idxmax()
most_wishlisted_brand = userWishlist_df['brand'].value_counts().idxmax()

# print(most_ordered_brand, '/n',most_wishlisted_brand)
# print(df['purl'].iloc[0])

def get_category(url):
    url_split = url.split('/')
    category = url_split[3]
    return category

userOrders_df['category'] = userOrders_df['link'].apply(lambda x: pd.Series(get_category(x)))
userWishlist_df['category'] = userWishlist_df['link'].apply(lambda x: pd.Series(get_category(x)))
df['category'] = df['link'].apply(lambda x: pd.Series(get_category(x)))

#content based filtering

tfidf = TfidfVectorizer(min_df=2, ngram_range=(1,3))

df['data'] = df['category'] + ' ' + df['item'] + ' ' + df['brand']
master_category = df['data'].to_list()
user_category = pd.concat([userOrders_df['category'], userWishlist_df['category'],  userOrders_df['product'], userWishlist_df['product'], userOrders_df['brand'], userWishlist_df['brand']]).unique().tolist()

user_cat = pd.concat([userOrders_df['category'], userWishlist_df['category'], userOrders_df['brand'], userWishlist_df['brand']]).unique().tolist()

all_desc = master_category + user_category

tfidf.fit(all_desc)

master_matrix = tfidf.transform(master_category)
user_matrix = tfidf.transform(user_category)
cos_sim = cosine_similarity(master_matrix)

# calculating preferred price range

user_ordered_price = userOrders_df['price']
meanPrice = user_ordered_price.mean()
stdPrice = user_ordered_price.std()
preferred_range = (meanPrice-stdPrice, meanPrice+stdPrice)

def f():
    recommendations = []
    added_ids = set()
    brand_freq = {}

    for user_input in user_category:
        # Find index of the first occurrence of user_input in the dataframe
        words = user_input.split()
        print()
        for word in words:
            print(word)
            try:
                id_of_item = df[df['data'].str.contains(word, case=False)].index[0]
                distances = cos_sim[id_of_item]
                product_list = sorted(list(enumerate(distances)), reverse=True, key=lambda x: x[1])[1:11]
                
                for i in product_list:
                    item_id = df['product_id'].iloc[i[0]]
                    item_price = df['variant_price'].iloc[i[0]]
                    item_brand = df['brand'].iloc[i[0]]
                    if item_id not in added_ids and (preferred_range[0]<=item_price<=preferred_range[1]):
                        if brand_freq.get(item_brand, 0) < 5:
                            brand_freq[item_brand] = brand_freq.get(item_brand, 0) + 1 
                            added_ids.add(item_id)
                            item_info = {
                                'id': df['product_id'].iloc[i[0]],
                                'brand': df['brand'].iloc[i[0]],
                                'item': df['item'].iloc[i[0]],
                                'image': df['images'].iloc[i[0]].split('|')[0].strip(),
                                'price': df['variant_price'].iloc[i[0]],                   
                            }
                            recommendations.append(item_info)
            except IndexError:
                print(f"Category '{word}' not found in master data")
        
    return pd.DataFrame(recommendations)

recommendations_df = f()
recommendations_df = recommendations_df.sample(frac=1).reset_index(drop=True)

print(recommendations_df)
project_dir = "C:/Users/tanay/Desktop/tan/myntra-hackerramp/fashionFeed"
data_dir = os.path.join(project_dir, "data")
file_path = os.path.join(data_dir, "recommendations.csv")
os.makedirs(data_dir, exist_ok=True)
recommendations_df.to_csv(file_path, index=False)





