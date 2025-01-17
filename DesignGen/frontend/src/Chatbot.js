import React, { useState } from 'react';
import './Chatbot.css';

const Chatbot = () => {
  const [prompt, setPrompt] = useState('');
  const [imageUrl, setImageUrl] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    const imgPath = '/red-tshirt.jpg';
    console.log('Image path:', imgPath);
    setImageUrl(imgPath);
    alert('This is a placeholder image. In a real application, an image generated by the API will be displayed here.');
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          placeholder="Enter image description"
        />
        <button type="submit">Generate Image</button>
      </form>
      {imageUrl && (
        <div>
          <img src={imageUrl} alt="Generated" className="generated-image" />
          <p>This is a placeholder image. In a real application, an image generated by the API will be displayed here.</p>
        </div>
      )}
    </div>
  );
};

export default Chatbot;
