# Potion Editor - Quick Installation Guide

Complete installation guide for setting up Potion Editor on your local machine.

## Prerequisites

Before installing, ensure you have:

- **Node.js 22+** ([Download](https://nodejs.org/) or use [nvm](https://github.com/nvm-sh/nvm))
- **pnpm 9+** (install with `npm install -g pnpm`)
- **Docker Desktop** ([Download](https://www.docker.com/products/docker-desktop))

## Quick Start (Automated)

The fastest way to get started:

```bash
# Navigate to the project directory
cd potion-editor

# Run the automated installation script
./scripts/install.sh

# Start development servers (in two terminals)
# Terminal 1:
pnpm dev

# Terminal 2:
pnpm yjs:dev

# Or use the startup script to run both:
./scripts/start-dev.sh
```

## Manual Installation

If you prefer to install step-by-step:

### 1. Install Dependencies

```bash
cd potion-editor
pnpm install
```

### 2. Set Up Environment Variables

```bash
# Copy the example environment file
cp .env.example .env

# Generate a secure secret key
openssl rand -base64 32

# Edit .env and update:
# - DATABASE_URL (already set for local Docker)
# - BETTER_AUTH_SECRET (paste the generated secret)
# - UPLOADTHING_TOKEN (get from https://uploadthing.com)
# - UPLOADTHING_APP_ID (get from https://uploadthing.com)
# - ANTHROPIC_API_KEY (get from https://console.anthropic.com)
```

### 3. Start Docker Services

```bash
# Start PostgreSQL and Redis
docker compose up -d

# Verify services are running
docker compose ps
```

You should see:
```
NAME                STATUS
potion-postgres     Up
potion-redis        Up
```

### 4. Set Up Database

```bash
# Generate Prisma client
pnpm db:generate

# Create database tables
pnpm db:push
```

### 5. Start Development Servers

You need **two terminals**:

**Terminal 1 - Next.js App:**
```bash
pnpm dev
```

**Terminal 2 - Hocuspocus YJS Server:**
```bash
pnpm yjs:dev
```

### 6. Access the Application

Open your browser and navigate to:
- **Application**: http://localhost:3000
- **WebSocket Server**: ws://localhost:4444

## Verification

### Check Docker Services

```bash
# View running containers
docker compose ps

# Check PostgreSQL
docker exec potion-postgres pg_isready -U postgres

# Check Redis
docker exec potion-redis redis-cli ping
```

### Check Database

```bash
# Open Prisma Studio to view the database
pnpm db:studio

# Opens at http://localhost:5555
```

### Check Development Servers

1. **Next.js**: Should show compilation success
2. **Hocuspocus**: Should show "Listening on port 4444"
3. **Browser**: Should load without console errors

## Common Scripts

```bash
# Development
pnpm dev              # Start Next.js dev server
pnpm yjs:dev          # Start Hocuspocus server
./scripts/start-dev.sh # Start both servers

# Database
pnpm db:push          # Push schema to database
pnpm db:generate      # Generate Prisma client
pnpm db:studio        # Open Prisma Studio

# Build & Production
pnpm build            # Build for production
pnpm start            # Start production server

# Utilities
pnpm lint             # Run ESLint
./scripts/stop.sh     # Stop all services
```

## Troubleshooting

### Port Already in Use

```bash
# For port 3000
lsof -ti:3000 | xargs kill -9

# For port 4444
lsof -ti:4444 | xargs kill -9

# Or use the stop script
./scripts/stop.sh
```

### Docker Issues

```bash
# Restart Docker services
docker compose restart

# View logs
docker compose logs -f postgres
docker compose logs -f redis

# Reset everything
docker compose down -v
docker compose up -d
```

### Database Connection Errors

```bash
# Ensure Docker is running
docker compose ps

# Check connection in .env matches:
# DATABASE_URL="postgresql://postgres:postgres@localhost:5432/potion_editor"

# Regenerate Prisma client
pnpm db:generate
pnpm db:push
```

### Module Not Found Errors

```bash
# Clear and reinstall
rm -rf node_modules pnpm-lock.yaml
pnpm install
pnpm db:generate
```

### Build Errors

```bash
# Clear Next.js cache
rm -rf .next

# Full clean
rm -rf .next node_modules pnpm-lock.yaml
pnpm install
pnpm build
```

## Environment Variables

Required variables in `.env`:

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://postgres:postgres@localhost:5432/potion_editor` |
| `BETTER_AUTH_SECRET` | Secret key for authentication | Generate with `openssl rand -base64 32` |
| `BETTER_AUTH_URL` | Base URL for auth | `http://localhost:3000` |
| `NEXT_PUBLIC_YJS_URL` | WebSocket server URL | `ws://localhost:4444` |
| `YJS_PORT` | Hocuspocus server port | `4444` |
| `YJS_HOST` | Hocuspocus server host | `0.0.0.0` |
| `REDIS_URL` | Redis connection string | `redis://localhost:6379` |
| `UPLOADTHING_TOKEN` | UploadThing API token | Get from [uploadthing.com](https://uploadthing.com) |
| `UPLOADTHING_APP_ID` | UploadThing app ID | Get from [uploadthing.com](https://uploadthing.com) |
| `ANTHROPIC_API_KEY` | Anthropic API key for AI features | Get from [console.anthropic.com](https://console.anthropic.com) |
| `NEXT_PUBLIC_APP_URL` | Public app URL | `http://localhost:3000` |
| `NODE_ENV` | Environment | `development` |

## Next Steps

After successful installation:

1. **Test the editor**: Open http://localhost:3000 and try creating a document
2. **Test real-time collaboration**: Open the same document in multiple browser tabs
3. **Set up API keys**: Add UploadThing and Anthropic API keys to enable file uploads and AI features
4. **Read the docs**: Check `README.md` for feature documentation
5. **Review the implementation guide**: See `IMPLEMENTATION_GUIDE.md` for development roadmap

## Production Deployment

See the main `README.md` file for deployment instructions for:
- Vercel (Next.js app)
- Railway/Fly.io (Hocuspocus server)
- Vercel Postgres or external PostgreSQL
- Upstash Redis or external Redis

## Getting Help

- **Documentation**: See `README.md` and other docs in the project root
- **Plate.js Docs**: https://platejs.org/docs
- **Discord**: https://discord.gg/mAZRuBzGM3
- **Issues**: Open an issue on GitHub

---

**Installation complete!** You're ready to start building with Potion Editor. 🎨
