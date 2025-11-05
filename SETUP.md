# Quick Setup Guide

## Local Development Setup

1. **Install Dependencies**
   ```bash
   bundle install
   ```

2. **Create Environment File**
   ```bash
   cp .env.example .env
   # Edit .env and add your API keys (optional)
   ```

3. **Initialize Database**
   ```bash
   rails db:create db:migrate
   ```

4. **Start Server**
   ```bash
   rails server
   ```

5. **Visit**
   ```
   http://localhost:3000
   ```

## Deployment

The app is ready to deploy! See `DEPLOYMENT.md` for detailed instructions.

### Quick Deploy to Render (Recommended)

1. Push to GitHub
2. Go to [render.com](https://render.com)
3. Create new Web Service
4. Connect your GitHub repo
5. Use `render.yaml` for automatic configuration
6. Add environment variables:
   - `SECRET_KEY_BASE` (generate with `rails secret`)
   - `REPLICATE_API_TOKEN` (optional, for real AI processing)
7. Deploy!

## What's Included

✅ Rails 7 application structure
✅ Upload UI with validation
✅ Backend processing endpoint
✅ AI service integration (Replicate/OpenAI with mock fallback)
✅ Results display page with 4 generated images
✅ Loading indicators and error handling
✅ Tailwind CSS styling
✅ Deployment configurations (Render, Railway, Fly.io, Heroku)

## Notes

- The app works with mock images if no API keys are provided
- For production, add API keys to enable real AI processing
- See `README.md` for full documentation

