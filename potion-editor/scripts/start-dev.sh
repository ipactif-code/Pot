#!/bin/bash

# Potion Editor Development Startup Script
# Starts both Next.js and Hocuspocus servers in parallel

set -e

echo "🎨 Starting Potion Editor Development Servers"
echo "=============================================="
echo ""

# Check if Docker services are running
echo "🐳 Checking Docker services..."

if ! docker ps | grep -q potion-postgres; then
    echo "⚠️  PostgreSQL container not running. Starting Docker services..."
    docker compose up -d
    sleep 3
fi

if ! docker ps | grep -q potion-redis; then
    echo "⚠️  Redis container not running. Starting Docker services..."
    docker compose up -d
    sleep 3
fi

echo "✅ Docker services are running"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Shutting down development servers..."
    kill $(jobs -p) 2>/dev/null
    exit 0
}

trap cleanup EXIT INT TERM

# Start Next.js dev server
echo "🚀 Starting Next.js dev server (port 3000)..."
pnpm dev &
NEXT_PID=$!

# Wait a moment before starting YJS
sleep 2

# Start Hocuspocus YJS server
echo "🔗 Starting Hocuspocus YJS server (port 4444)..."
pnpm yjs:dev &
YJS_PID=$!

echo ""
echo "✨ Development servers running!"
echo ""
echo "📱 Next.js:     http://localhost:3000"
echo "🔌 Hocuspocus:  ws://localhost:4444"
echo ""
echo "Press Ctrl+C to stop all servers"
echo ""

# Wait for all background jobs
wait
