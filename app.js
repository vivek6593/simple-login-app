const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Mock user data
const USERNAME = 'admin';
const PASSWORD = 'password123';

// Routes
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    if (username === USERNAME && password === PASSWORD) {
        res.redirect('/dashboard.html');
    } else {
        res.redirect('/?error=1');
    }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
