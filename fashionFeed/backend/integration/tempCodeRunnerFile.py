from flask import Flask, jsonify
import pandas as pd
import os

app = Flask(__name__)

@app.route('/recommendations', methods = ['GET'])

def get_recommendations():
    project_dir = "C:/Users/tanay/Desktop/tan/myntra-hackerramp/fashionFeed"
    data_dir = os.path.join(project_dir, "data")
    file_path = os.path.join(data_dir, "recommendations.csv")

    recommendations_df = pd.read_csv(file_path)
    recommendations = recommendations_df.to_dict(orient='records')
    return jsonify(recommendations)

if __name__ == '__main__':
    app.run(debug=True)