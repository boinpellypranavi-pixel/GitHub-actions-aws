const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'Backend is healthy' });
});

app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});
// Export the app for testing purposes
module.exports = app;
