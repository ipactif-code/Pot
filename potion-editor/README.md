# Potion Editor

A powerful rich text editor built with Plate.js, featuring real-time collaboration, AI assistance, and a beautiful UI - replicating [potion.platejs.org](https://potion.platejs.org).

## Features

### 🎨 Rich Text Editing
- **52 Plate.js plugins** including headings, lists, tables, code blocks, callouts, toggles, and more
- **Advanced formatting**: Bold, italic, underline, strikethrough, code, colors, fonts
- **Media support**: Images, videos, audio, file attachments, embeds
- **Math equations**: LaTeX support with inline and block equations
- **Tables**: Resizable columns, cell backgrounds, add/remove rows and columns
- **Code blocks**: Syntax highlighting for 80+ languages

### 🤝 Real-Time Collaboration
- **YJS + Hocuspocus** for real-time sync
- **Remote cursors** showing collaborators
- **Presence indicators** with user names and colors
- **Conflict-free editing** with CRDT technology
- **Redis scaling** for horizontal scaling

### 💬 Comments & Suggestions
- **Inline comments** on any text selection
- **Discussion threads** with replies
- **Tracked changes** suggestion mode
- **Resolve/unresolve** discussions

### 🤖 AI Assistance
- **Claude integration** for content generation
- **AI commands**: Rewrite, expand, shorten, summarize
- **Inline completions** as you type
- **Context-aware suggestions**

### 📋 Version History
- **Automatic versioning** with snapshots
- **Side-by-side diff** visualization
- **Restore previous versions**
- **Collapsed unchanged sections**

### 🎯 Other Features
- **Slash commands** for quick insertion
- **Drag and drop** for blocks and media
- **Markdown shortcuts** with autoformat
- **Table of contents** auto-generation
- **Dark mode** support
- **Export to PDF/DOCX**
- **Print mode**
- **Public/private documents**

## Tech Stack

- **Framework**: Next.js 15.5.7 + React 19
- **Editor**: Plate.js 52 (Pro)
- **Database**: PostgreSQL + Prisma
- **Real-time**: Hocuspocus + YJS + Redis
- **Auth**: Better-Auth
- **API**: tRPC
- **UI**: shadcn/ui + Radix UI + Tailwind CSS 4
- **File Upload**: UploadThing
- **AI**: Anthropic Claude (via AI SDK)
- **State**: Jotai + Zustand + React Query

## Prerequisites

- **Node.js** 22+ (recommend using [nvm](https://github.com/nvm-sh/nvm))
- **pnpm** 9+ (`npm install -g pnpm`)
- **Docker** & Docker Compose (for PostgreSQL + Redis)

## Installation

### 1. Clone and Install Dependencies

```bash
# Clone the repository
git clone <your-repo-url>
cd potion-editor

# Install dependencies with pnpm
pnpm install
```

### 2. Set Up Environment Variables

```bash
# Copy the example env file
cp .env.example .env

# Edit .env with your actual values
```

Required environment variables:

```env
# Database
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/potion_editor"

# Better Auth
BETTER_AUTH_SECRET="your-secret-key-here-min-32-chars-generate-with-openssl-rand-base64-32"
BETTER_AUTH_URL="http://localhost:3000"

# YJS / Hocuspocus
NEXT_PUBLIC_YJS_URL="ws://localhost:4444"
YJS_PORT=4444
YJS_HOST="0.0.0.0"

# Redis
REDIS_URL="redis://localhost:6379"

# UploadThing (get from https://uploadthing.com)
UPLOADTHING_TOKEN="your-uploadthing-token"
UPLOADTHING_APP_ID="your-uploadthing-app-id"

# Anthropic (get from https://console.anthropic.com)
ANTHROPIC_API_KEY="sk-ant-..."

# Next.js
NEXT_PUBLIC_APP_URL="http://localhost:3000"
NODE_ENV="development"
```

### 3. Start Docker Services

```bash
# Start PostgreSQL and Redis
docker-compose up -d

# Check services are running
docker-compose ps
```

### 4. Set Up Database

```bash
# Generate Prisma client
pnpm db:generate

# Push schema to database
pnpm db:push

# Optional: Open Prisma Studio to view database
pnpm db:studio
```

### 5. Start Development Servers

You need to run TWO servers:

**Terminal 1 - Next.js App:**
```bash
pnpm dev
```

**Terminal 2 - Hocuspocus YJS Server:**
```bash
pnpm yjs:dev
```

The app will be available at:
- **Next.js**: http://localhost:3000
- **Hocuspocus**: ws://localhost:4444

## Project Structure

```
potion-editor/
├── app/                          # Next.js App Router
│   ├── (dynamic)/               # Dynamic routes
│   │   ├── (main)/              # Main app routes
│   │   │   ├── (protected)/[documentId]/  # Editor page
│   │   │   └── (auth)/login/              # Auth pages
│   │   ├── (public)/            # Public preview
│   │   └── (export)/            # PDF/Print export
│   ├── api/                     # API routes
│   │   ├── auth/[...all]/       # Better-Auth
│   │   ├── trpc/[trpc]/         # tRPC
│   │   ├── uploadthing/         # File uploads
│   │   └── [[...route]]/        # Hono catch-all
│   ├── editor/                  # Standalone editor demo
│   ├── globals.css              # Global styles
│   └── layout.tsx               # Root layout
│
├── components/                   # React components
│   ├── editor/                  # Editor components
│   │   ├── plugins/             # Custom Plate plugins
│   │   ├── ui/                  # Editor UI components
│   │   ├── utils/               # Editor utilities
│   │   └── version-history/     # Version history
│   ├── sidebar/                 # Navigation sidebar
│   ├── navbar/                  # Top navigation
│   ├── ui/                      # Base UI components
│   └── providers/               # Context providers
│
├── registry/                     # Plate.js Registry
│   ├── components/editor/       # Editor setup
│   │   └── plugins/             # Plugin configs (52 files)
│   └── ui/                      # Plate UI components (104 files)
│
├── src/
│   ├── server/                  # Backend code
│   │   ├── yjs/                 # Hocuspocus server
│   │   ├── api/                 # tRPC routers
│   │   ├── hono/                # Hono HTTP routes
│   │   └── auth/                # Better-Auth config
│   ├── trpc/                    # tRPC client
│   ├── hooks/                   # Shared hooks
│   └── lib/                     # Utilities
│
├── prisma/
│   └── schema.prisma            # Database schema
│
├── docker-compose.yml           # PostgreSQL + Redis
├── package.json                 # Dependencies
└── README.md                    # This file
```

## Key Scripts

```bash
# Development
pnpm dev              # Start Next.js dev server
pnpm yjs:dev          # Start Hocuspocus server
pnpm build            # Build for production
pnpm start            # Start production server

# Database
pnpm db:push          # Push schema to database
pnpm db:generate      # Generate Prisma client
pnpm db:studio        # Open Prisma Studio

# Linting
pnpm lint             # Run ESLint
```

## Usage

### Creating a Document

1. Navigate to http://localhost:3000
2. You'll be redirected to `/editor`
3. Start typing or use `/` for slash commands

### Real-Time Collaboration

1. Open the same document in multiple browser windows
2. Each user gets a unique cursor color
3. See real-time edits from all collaborators

### Using AI

1. Select text
2. Press `Cmd/Ctrl + J` or click AI button
3. Choose an AI action (rewrite, expand, etc.)

### Adding Comments

1. Select text
2. Press `Cmd/Ctrl + Shift + M` or click comment button
3. Type your comment and submit

### Version History

1. Click the version history button in the toolbar
2. Browse previous versions
3. View side-by-side diffs
4. Restore a previous version if needed

## Configuration

### Customizing the Editor

Edit `components/editor/editor-kit-app.tsx` to add/remove plugins:

```typescript
export const EditorKit = [
  CopilotKit,
  AIKit,
  BlockMenuKit,
  // Add your custom plugins here
];
```

### Changing Collaboration Settings

Edit `src/server/yjs/server.ts`:

```typescript
const server = Server.configure({
  port: 4444,
  timeout: 10000,
  debounce: 2000,        // Adjust save debounce
  maxDebounce: 10000,    // Adjust max debounce
});
```

### Styling

- Global styles: `app/globals.css`
- Tailwind config: `tailwind.config.ts`
- Component styles: Individual component files

## Deployment

### Deploy to Vercel

```bash
# Install Vercel CLI
pnpm install -g vercel

# Deploy
vercel
```

**Important**: You'll need to:
1. Set up PostgreSQL database (use Vercel Postgres or external)
2. Set up Redis (use Upstash or external)
3. Deploy Hocuspocus server separately (Railway, Fly.io, etc.)
4. Update environment variables

### Deploy Hocuspocus Server

The Hocuspocus server needs to run separately:

**Option 1: Railway**
1. Create new project on Railway
2. Add Redis service
3. Deploy from `src/server/yjs/`
4. Set environment variables

**Option 2: Fly.io**
1. Create `fly.toml` config
2. Deploy with `fly deploy`

## Troubleshooting

### Database Connection Issues

```bash
# Check Docker services
docker-compose ps

# Restart services
docker-compose restart

# View logs
docker-compose logs -f postgres
```

### YJS Connection Issues

```bash
# Check Hocuspocus is running
curl http://localhost:4444

# Check Redis connection
redis-cli ping
```

### Build Errors

```bash
# Clear Next.js cache
rm -rf .next

# Reinstall dependencies
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Regenerate Prisma client
pnpm db:generate
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT

## Acknowledgments

- [Plate.js](https://platejs.org) - The amazing editor framework
- [Hocuspocus](https://tiptap.dev/hocuspocus) - Real-time collaboration
- [YJS](https://docs.yjs.dev/) - CRDT implementation
- [shadcn/ui](https://ui.shadcn.com/) - Beautiful UI components
- [Anthropic](https://anthropic.com) - AI integration

## Support

For issues and questions:
- Open an issue on GitHub
- Check the [Plate.js documentation](https://platejs.org/docs)
- Join the [Plate.js Discord](https://discord.gg/mAZRuBzGM3)

---

Built with ❤️ using Plate.js
