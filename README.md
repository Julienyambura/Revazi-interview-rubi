# Virtual Try-On Web Application

A Ruby on Rails web application that allows users to upload photos of a model and clothing item, then generates AI-enhanced images including virtual try-on results.

## Features

- **User Interface**: Clean, intuitive UI for uploading model and clothing photos
- **Photo Submission**: Form with validation for both required images
- **Backend Processing**: AI-powered image generation using Replicate/OpenAI APIs
- **Image Generation**: Creates four types of images:
  - Enhanced product photo (clean background, no wrinkles)
  - Model wearing the clothing item (virtual try-on)
  - Back view of the product
  - Back view of model wearing the clothing
- **Display Results**: Beautiful grid layout showing all generated images
- **Loading Indicators**: Visual feedback during processing
- **Error Handling**: Comprehensive error handling and user feedback

## Tech Stack

- **Backend**: Ruby on Rails 7.0
- **Frontend**: HTML, Tailwind CSS (via CDN), JavaScript
- **Database**: SQLite (development)
- **AI Integration**: Replicate API or OpenAI API (with mock fallback)
- **Deployment**: Ready for Render, Railway, Fly.io, or Heroku

## Prerequisites

- Ruby 3.0+ (required for Rails 7)
- Bundler
- Node.js (for asset pipeline)

## Setup Instructions

### 1. Install Dependencies

```bash
# Install Ruby gems
bundle install

# Install Node.js dependencies (if needed)
npm install
```

### 2. Configure Environment Variables

Create a `.env` file in the root directory:

```bash
cp .env.example .env
```

Edit `.env` and add your API keys:

```env
# Choose one AI service:
REPLICATE_API_TOKEN=your_replicate_api_token_here
# OR
OPENAI_API_KEY=your_openai_api_key_here

# Rails configuration
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_base_here
```

**Get API Keys:**
- **Replicate**: Sign up at [replicate.com](https://replicate.com) and get your API token
- **OpenAI**: Sign up at [platform.openai.com](https://platform.openai.com) and get your API key

**Note**: If no API keys are provided, the app will use mock images (returns the original uploaded images) for demonstration purposes.

### 3. Initialize Database

```bash
rails db:create
rails db:migrate
```

### 4. Start the Server

```bash
rails server
```

The application will be available at `http://localhost:3000`

## Usage

1. Navigate to the home page
2. Upload a photo of a human model
3. Upload a photo of a clothing item (dress, shirt, etc.)
4. Click "Generate Images"
5. Wait for AI processing (loading indicator will show)
6. View the four generated images on the results page

## Project Structure

```
app/
  controllers/
    uploads_controller.rb    # Handles file uploads and processing
  services/
    ai_image_service.rb      # AI integration service
  views/
    uploads/
      new.html.erb          # Upload form
      show.html.erb         # Results display
config/
  routes.rb                 # Application routes
Gemfile                     # Ruby dependencies
```

## AI Service Configuration

The application supports multiple AI providers:

### Replicate (Recommended for Virtual Try-On)

Replicate offers specialized virtual try-on models like:
- `cuuupid/idm-vton`
- `levihsu/OOTDiffusion`
- Other virtual try-on models

Set `REPLICATE_API_TOKEN` in your `.env` file.

### OpenAI

OpenAI DALL-E 3 can be used for image generation, though it doesn't support virtual try-on directly. You would need to combine GPT-4 Vision with DALL-E for more complex workflows.

Set `OPENAI_API_KEY` in your `.env` file.

### Mock Mode

If no API keys are provided, the app runs in mock mode, returning the original uploaded images. This is useful for:
- Development and testing
- Demonstrating the UI/UX flow
- Testing without API costs

## Deployment

### Render

1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Set build command: `bundle install && rails assets:precompile`
4. Set start command: `rails server -e production`
5. Add environment variables in Render dashboard:
   - `REPLICATE_API_TOKEN` or `OPENAI_API_KEY`
   - `SECRET_KEY_BASE` (generate with `rails secret`)
   - `RAILS_ENV=production`

### Railway

1. Connect your GitHub repository
2. Railway will auto-detect Rails
3. Add environment variables in Railway dashboard
4. Deploy

### Heroku

```bash
heroku create your-app-name
heroku config:set REPLICATE_API_TOKEN=your_token
heroku config:set SECRET_KEY_BASE=$(rails secret)
git push heroku main
```

### Fly.io

```bash
fly launch
fly secrets set REPLICATE_API_TOKEN=your_token
fly secrets set SECRET_KEY_BASE=$(rails secret)
fly deploy
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `REPLICATE_API_TOKEN` | Replicate API token | Optional (if using Replicate) |
| `OPENAI_API_KEY` | OpenAI API key | Optional (if using OpenAI) |
| `SECRET_KEY_BASE` | Rails secret key | Required for production |
| `RAILS_ENV` | Environment (development/production) | Required |

## Development Notes

- The app uses mock images by default when no API keys are provided
- Image processing is synchronous (for production, consider background jobs)
- Large images may take time to process
- Consider implementing Active Storage for better file handling in production

## Future Enhancements

- [ ] Background job processing (Sidekiq/Resque)
- [ ] Active Storage integration for file management
- [ ] Image optimization and compression
- [ ] Multiple AI model support
- [ ] User accounts and image history
- [ ] Direct image download
- [ ] Progress tracking for long-running jobs

## License

This project is created for interview purposes.

## Support

For issues or questions, please contact the development team.

