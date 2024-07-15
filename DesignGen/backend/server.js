const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 5000;

app.use(express.json());

// Root URL route
app.get('/', (req, res) => {
  res.send('Image Generator Chatbot Backend is running');
});

app.post('/generate-image', async (req, res) => {
  const { prompt } = req.body;

  try {
    const response = await axios.post(
      'https://api.openai.com/v1/images/generations',
      {
        prompt: prompt,
        n: 1,
        size: '512x512',
      },
      {
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
        },
      }
    );

    const imageUrl = response.data.data[0].url;
    res.json({ imageUrl });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error generating image');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
