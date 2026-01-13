#!/bin/bash

# Potion Editor Stop Script
# Stops all running services

echo "🛑 Stopping Potion Editor services..."
echo ""

# Stop Docker services
if docker ps | grep -q potion-postgres || docker ps | grep -q potion-redis; then
    echo "🐳 Stopping Docker containers..."
    docker compose down
    echo "✅ Docker containers stopped"
else
    echo "ℹ️  No Docker containers running"
fi

# Kill any running Next.js or Node processes on our ports
echo "🔍 Checking for processes on ports 3000 and 4444..."

if lsof -ti:3000 &> /dev/null; then
    echo "   Stopping process on port 3000..."
    lsof -ti:3000 | xargs kill -9 2>/dev/null || true
fi

if lsof -ti:4444 &> /dev/null; then
    echo "   Stopping process on port 4444..."
    lsof -ti:4444 | xargs kill -9 2>/dev/null || true
fi

echo ""
echo "✅ All services stopped"
