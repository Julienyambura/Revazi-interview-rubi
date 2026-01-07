const express = require("express");
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const axios = require("axios");
require("dotenv").config();

const app = express();
const PORT = 3000;

// Configure multer for file uploads
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// Serve static files
app.use(express.static("public"));

// Routes
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.post(
  "/api/upload",
  upload.fields([
    { name: "model_photo", maxCount: 1 },
    { name: "clothing_photo", maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const modelPhoto = req.files?.model_photo?.[0];
      const clothingPhoto = req.files?.clothing_photo?.[0];

      if (!modelPhoto || !clothingPhoto) {
        return res.status(400).json({
          error: "Please upload both a model photo and a clothing photo.",
        });
      }

      // Generate mock images (replace with actual AI API calls)
      const generatedImages = await generateMockImages(
        modelPhoto,
        clothingPhoto
      );

      res.json({ images: generatedImages });
    } catch (error) {
      console.error("Error processing images:", error);
      res
        .status(500)
        .json({ error: "Error processing images: " + error.message });
    }
  }
);

async function generateMockImages(modelPhoto, clothingPhoto) {
  // Mock implementation - returns base64 encoded images
  // In production, replace with actual AI API calls (Replicate, OpenAI, etc.)

  return {
    enhanced_product: {
      base64: modelPhoto.buffer.toString("base64"),
      content_type: modelPhoto.mimetype,
    },
    model_wearing: {
      base64: modelPhoto.buffer.toString("base64"),
      content_type: modelPhoto.mimetype,
    },
    product_back: {
      base64: clothingPhoto.buffer.toString("base64"),
      content_type: clothingPhoto.mimetype,
    },
    model_wearing_back: {
      base64: modelPhoto.buffer.toString("base64"),
      content_type: modelPhoto.mimetype,
    },
  };
}

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});




