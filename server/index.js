// importing packages
const express = require('express');
const mongoose = require('mongoose');

// importing from other files
const authRouter = require('./routes/auth');

// initialization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://manikttmg11:manik123@clustertest1.iy9k4g0.mongodb.net/?retryWrites=true&w=majority&appName=ClusterTest1";

// middleware
app.use(express.json());
app.use(authRouter);

// connection to MongoDB
mongoose.connect(DB)
    .then(() => {
        console.log("Database connected");
    })
    .catch((e) => {
        console.error("Database connection error:", e.message);
    });

// server listening
app.listen(PORT, () => {
    console.log(`Server connected to port ${PORT}`);
});
