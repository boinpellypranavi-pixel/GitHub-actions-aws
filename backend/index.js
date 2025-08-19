1  const express = require('express');
2  const app = express();
3  const PORT = process.env.PORT || 5000;
4
5  app.use(express.json());
6
7  app.get('/api/health', (req, res) => {
8    res.json({ status: 'Backend is healthy' });
9  });
10
11 app.listen(PORT, () => {
12   console.log(`Backend running on port ${PORT}`);
13 });
