#!/bin/bash

# Potion Editor Installation Script
# This script completes the installation and starts all required services

set -e

echo "🎨 Potion Editor Installation Script"
echo "====================================="
echo ""

# Check for required tools
echo "📋 Checking prerequisites..."

if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed"
    echo "Please install Docker Desktop from: https://www.docker.com/products/docker-desktop"
    echo "Or install Docker Engine: https://docs.docker.com/engine/install/"
    exit 1
fi

if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm is not installed"
    echo "Install with: npm install -g pnpm"
    exit 1
fi

echo "✅ All prerequisites found"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found"
    echo "Please run this script from the potion-editor directory"
    exit 1
fi

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env

    # Generate a secure secret
    SECRET=$(openssl rand -base64 32)

    # Update the .env file
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s|DATABASE_URL=\"postgresql://user:password@localhost:5432/potion_editor\"|DATABASE_URL=\"postgresql://postgres:postgres@localhost:5432/potion_editor\"|" .env
        sed -i '' "s|BETTER_AUTH_SECRET=\"your-secret-key-here-min-32-chars\"|BETTER_AUTH_SECRET=\"$SECRET\"|" .env
    else
        # Linux
        sed -i "s|DATABASE_URL=\"postgresql://user:password@localhost:5432/potion_editor\"|DATABASE_URL=\"postgresql://postgres:postgres@localhost:5432/potion_editor\"|" .env
        sed -i "s|BETTER_AUTH_SECRET=\"your-secret-key-here-min-32-chars\"|BETTER_AUTH_SECRET=\"$SECRET\"|" .env
    fi

    echo "✅ .env file created with secure secret"
    echo "⚠️  Please edit .env and add your API keys for:"
    echo "   - UPLOADTHING_TOKEN"
    echo "   - UPLOADTHING_APP_ID"
    echo "   - ANTHROPIC_API_KEY"
    echo ""
fi

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    pnpm install
    echo "✅ Dependencies installed"
    echo ""
fi

# Start Docker services
echo "🐳 Starting Docker services (PostgreSQL + Redis)..."
docker compose up -d

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
for i in {1..30}; do
    if docker exec potion-postgres pg_isready -U postgres &> /dev/null; then
        echo "✅ PostgreSQL is ready"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "❌ PostgreSQL failed to start"
        exit 1
    fi
    sleep 1
done

# Wait for Redis to be ready
echo "⏳ Waiting for Redis to be ready..."
for i in {1..30}; do
    if docker exec potion-redis redis-cli ping &> /dev/null; then
        echo "✅ Redis is ready"
        break
    fi
    if [ $i -eq 30 ]; then
        echo "❌ Redis failed to start"
        exit 1
    fi
    sleep 1
done

echo ""

# Generate Prisma client
echo "🔧 Generating Prisma client..."
pnpm db:generate
echo "✅ Prisma client generated"
echo ""

# Push database schema
echo "📊 Pushing database schema..."
pnpm db:push
echo "✅ Database schema created"
echo ""

echo "✨ Installation complete!"
echo ""
echo "🚀 To start development:"
echo ""
echo "   Terminal 1 (Next.js):"
echo "   $ pnpm dev"
echo ""
echo "   Terminal 2 (Hocuspocus/YJS):"
echo "   $ pnpm yjs:dev"
echo ""
echo "   Then open: http://localhost:3000"
echo ""
echo "📚 Additional commands:"
echo "   $ pnpm db:studio    # Open Prisma Studio"
echo "   $ pnpm build        # Build for production"
echo "   $ pnpm lint         # Run linter"
echo ""
