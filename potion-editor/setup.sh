#!/bin/bash

# Potion Editor - Quick Setup Script
# This script will help you set up the development environment

set -e

echo "🚀 Potion Editor - Quick Setup"
echo "================================"
echo ""

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm is not installed"
    echo "Install it with: npm install -g pnpm"
    exit 1
fi

echo "✅ pnpm found"

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running"
    echo "Please start Docker Desktop and try again"
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Step 1: Copy env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env
    echo "✅ .env file created"
    echo "⚠️  Please edit .env and add your API keys:"
    echo "   - BETTER_AUTH_SECRET (generate with: openssl rand -base64 32)"
    echo "   - UPLOADTHING_TOKEN"
    echo "   - ANTHROPIC_API_KEY"
    echo ""
    read -p "Press Enter once you've updated .env..."
else
    echo "✅ .env file already exists"
fi

# Step 2: Start Docker services
echo ""
echo "🐳 Starting Docker services (PostgreSQL + Redis)..."
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 5

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Docker services are running"
else
    echo "❌ Failed to start Docker services"
    exit 1
fi

# Step 3: Install dependencies
echo ""
echo "📦 Installing dependencies..."
pnpm install

# Step 4: Setup database
echo ""
echo "🗄️  Setting up database..."
pnpm db:generate
pnpm db:push

echo ""
echo "✅ Setup complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Start Next.js dev server:  pnpm dev"
echo "   2. Start YJS server:          pnpm yjs:dev (in another terminal)"
echo "   3. Open http://localhost:3000"
echo ""
echo "📖 Read IMPLEMENTATION_GUIDE.md for development roadmap"
echo ""
