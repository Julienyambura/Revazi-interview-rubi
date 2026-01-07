# Deployment Guide

This guide will help you deploy the Virtual Try-On application to various platforms.

## Prerequisites

1. **Ruby 3.0+** installed locally
2. **Git** repository initialized
3. **API Keys** for AI services (Replicate or OpenAI)

## Quick Deploy Options

### Option 1: Render (Recommended)

1. **Create a Render Account**

   - Go to [render.com](https://render.com)
   - Sign up for a free account

2. **Create New Web Service**

   - Click "New" → "Web Service"
   - Connect your GitHub repository
   - Or use the Render CLI

3. **Configure Build Settings**

   - **Build Command**: `bundle install && rails assets:precompile`
   - **Start Command**: `bundle exec rails server -e production -p $PORT`
   - **Environment**: Ruby

4. **Set Environment Variables**

   - `RAILS_ENV` = `production`
   - `SECRET_KEY_BASE` = (generate with `rails secret`)
   - `REPLICATE_API_TOKEN` = (your Replicate API token)
   - OR `OPENAI_API_KEY` = (your OpenAI API key)

5. **Deploy**
   - Click "Create Web Service"
   - Render will automatically build and deploy
   - Your app will be available at `https://your-app-name.onrender.com`

**Note**: Render.yaml is included in the repo for easier setup.

### Option 2: Railway

1. **Create Railway Account**

   - Go to [railway.app](https://railway.app)
   - Sign up with GitHub

2. **New Project**

   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository

3. **Railway Auto-Detection**

   - Railway will auto-detect Rails
   - It will run `bundle install` and start the server

4. **Set Environment Variables**

   - Go to Variables tab
   - Add:
     - `RAILS_ENV` = `production`
     - `SECRET_KEY_BASE` = (generate with `rails secret`)
     - `REPLICATE_API_TOKEN` = (your token)
     - OR `OPENAI_API_KEY` = (your key)

5. **Deploy**
   - Railway will automatically deploy
   - Your app will be available at a Railway-provided URL

### Option 3: Fly.io

1. **Install Fly CLI**

   ```bash
   curl -L https://fly.io/install.sh | sh
   ```

2. **Login to Fly**

   ```bash
   fly auth login
   ```

3. **Initialize Fly App**

   ```bash
   fly launch
   ```

4. **Set Secrets**

   ```bash
   fly secrets set SECRET_KEY_BASE=$(rails secret)
   fly secrets set REPLICATE_API_TOKEN=your_token_here
   # OR
   fly secrets set OPENAI_API_KEY=your_key_here
   ```

5. **Deploy**
   ```bash
   fly deploy
   ```

### Option 4: Heroku

1. **Install Heroku CLI**

   ```bash
   # macOS
   brew tap heroku/brew && brew install heroku
   ```

2. **Login**

   ```bash
   heroku login
   ```

3. **Create App**

   ```bash
   heroku create your-app-name
   ```

4. **Set Config Vars**

   ```bash
   heroku config:set SECRET_KEY_BASE=$(rails secret)
   heroku config:set REPLICATE_API_TOKEN=your_token_here
   heroku config:set RAILS_ENV=production
   ```

5. **Deploy**
   ```bash
   git push heroku main
   ```

## Generate Secret Key Base

Run this command locally to generate a secure secret key:

```bash
rails secret
```

Copy the output and use it as your `SECRET_KEY_BASE` environment variable.

## Environment Variables Summary

| Variable              | Description                                     | Required   |
| --------------------- | ----------------------------------------------- | ---------- |
| `RAILS_ENV`           | Set to `production`                             | Yes        |
| `SECRET_KEY_BASE`     | Rails secret key (generate with `rails secret`) | Yes        |
| `REPLICATE_API_TOKEN` | Replicate API token                             | Optional\* |
| `OPENAI_API_KEY`      | OpenAI API key                                  | Optional\* |

\*At least one AI service key is recommended. Without any, the app will use mock images.

## Database Setup

For production, you may want to use PostgreSQL instead of SQLite:

1. Update `Gemfile`:

   ```ruby
   gem 'pg', '~> 1.1'
   ```

2. Update `config/database.yml` for production:

   ```yaml
   production:
     adapter: postgresql
     url: <%= ENV['DATABASE_URL'] %>
   ```

3. Most platforms (Render, Railway, Heroku) provide PostgreSQL automatically.

## Post-Deployment

After deployment:

1. **Test the Application**

   - Visit your deployed URL
   - Try uploading images
   - Verify all four images are generated

2. **Monitor Logs**

   - Check platform logs for errors
   - Verify API calls are working

3. **Set Up Custom Domain** (Optional)
   - Most platforms allow custom domain configuration
   - Follow platform-specific instructions

## Troubleshooting

### Build Failures

- Ensure Ruby version matches `.ruby-version`
- Check that all dependencies are in `Gemfile`
- Verify build commands are correct

### Runtime Errors

- Check environment variables are set correctly
- Verify API keys are valid
- Check logs for specific error messages

### Database Errors

- Ensure database is provisioned (for PostgreSQL)
- Run migrations if needed: `rails db:migrate`

## Support

For platform-specific issues:

- **Render**: [render.com/docs](https://render.com/docs)
- **Railway**: [docs.railway.app](https://docs.railway.app)
- **Fly.io**: [fly.io/docs](https://fly.io/docs)
- **Heroku**: [devcenter.heroku.com](https://devcenter.heroku.com)
