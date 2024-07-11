import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

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
# print(userOrders_df.isnull().sum())
# print(userWishlist_df.isnull().sum())
# print(userSearch_df.isnull().sum())

# print(df['purl'].iloc[0])

def get_category(url):
    url_split = url.split('/')
    category = url_split[3]
    return category

userOrders_df['category'] = userOrders_df['link'].apply(lambda x: pd.Series(get_category(x)))
userWishlist_df['category'] = userWishlist_df['link'].apply(lambda x: pd.Series(get_category(x)))
df['category'] = df['link'].apply(lambda x: pd.Series(get_category(x)))

#content based filtering

tfidf = TfidfVectorizer(min_df=2, ngram_range=(1,1))

df['data'] = df['category'] + ' ' + df['item'] + ' ' + df['brand']
master_category = df['data'].to_list()
user_category = pd.concat([userOrders_df['category'], userWishlist_df['category'],  userOrders_df['product'], userWishlist_df['product'], userOrders_df['brand'], userWishlist_df['brand']]).unique().tolist()

user_cat = pd.concat([userOrders_df['category'], userWishlist_df['category'], userOrders_df['brand'], userWishlist_df['brand']]).unique().tolist()

all_desc = master_category + user_category

tfidf.fit(all_desc)

master_matrix = tfidf.transform(master_category)
user_matrix = tfidf.transform(user_category)
cos_sim = cosine_similarity(master_matrix)  

def f():
    recommendations = []

    for user_input in user_cat:
        # Find index of the first occurrence of user_input in the dataframe
        try:
            id_of_item = df[df['data'].str.contains(user_input, case=False)].index[0]
            distances = cos_sim[id_of_item]
            product_list = sorted(list(enumerate(distances)), reverse=True, key=lambda x: x[1])[1:16]
            
            for i in product_list:
                item_info = {
                    'id': df['product_id'].iloc[i[0]],
                    'brand': df['brand'].iloc[i[0]],
                    'item': df['item'].iloc[i[0]],
                    'image': df['images'].iloc[i[0]].split('|')[0],
                    'price': df['variant_price'].iloc[i[0]],                   
                }
                recommendations.append(item_info)
        except IndexError:
            print(f"Category '{user_input}' not found in master data.")
    
    return pd.DataFrame(recommendations)

recommendations_df = f()

print(recommendations_df)

    
    # similarities = cos_sim[idx]
    # print(similarities)
    # top_indices = similarities.argsort()[-5:][::-1]
    # print(f"Recommendations for user category '{user_data}':")
    # for index in top_indices:
    #     print(f"  {df['item'].iloc[index]}")




