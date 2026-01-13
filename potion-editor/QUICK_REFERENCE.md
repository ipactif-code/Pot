# Potion Editor - Quick Reference Guide

## 🚀 Common Commands

### Setup & Installation
```bash
# Quick setup (recommended)
./setup.sh

# Manual setup
pnpm install
docker-compose up -d
cp .env.example .env
pnpm db:push
```

### Development
```bash
# Start Next.js dev server (Terminal 1)
pnpm dev

# Start Hocuspocus server (Terminal 2)
pnpm yjs:dev

# Start both with Docker
docker-compose up
```

### Database
```bash
# Generate Prisma client
pnpm db:generate

# Push schema to database
pnpm db:push

# Open Prisma Studio (database GUI)
pnpm db:studio

# Create migration (production)
npx prisma migrate dev --name your_migration_name

# Reset database (WARNING: deletes all data)
npx prisma migrate reset
```

### Docker
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Remove volumes (WARNING: deletes data)
docker-compose down -v
```

## 🔧 Environment Variables

### Required Variables
```env
# Database
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/potion_editor"

# Auth
BETTER_AUTH_SECRET="generated-with-openssl-rand-base64-32"
BETTER_AUTH_URL="http://localhost:3000"

# YJS
NEXT_PUBLIC_YJS_URL="ws://localhost:4444"
YJS_PORT=4444

# Redis
REDIS_URL="redis://localhost:6379"
```

### Optional Variables
```env
# File Upload
UPLOADTHING_TOKEN="your-token"
UPLOADTHING_APP_ID="your-app-id"

# AI
ANTHROPIC_API_KEY="sk-ant-..."

# Analytics (optional)
NEXT_PUBLIC_ANALYTICS_ID=""
```

### Generate Secrets
```bash
# Generate Better-Auth secret
openssl rand -base64 32

# Generate random UUID
node -e "console.log(require('crypto').randomUUID())"
```

## 📁 Project Structure Quick Reference

```
potion-editor/
├── app/                    # Next.js App Router
│   ├── api/               # API routes (auth, tRPC, upload)
│   ├── editor/            # Main editor page
│   └── (dynamic)/         # Dynamic routes
│
├── components/            # React components
│   ├── editor/           # Editor-specific
│   ├── sidebar/          # Navigation
│   └── ui/               # Base UI
│
├── registry/             # Plate.js components
│   ├── components/       # Plugin configs
│   └── ui/               # Editor nodes
│
├── src/
│   ├── server/          # Backend code
│   │   ├── yjs/        # Collaboration
│   │   ├── api/        # tRPC
│   │   └── auth/       # Authentication
│   ├── lib/            # Utilities
│   └── hooks/          # React hooks
│
└── prisma/
    └── schema.prisma    # Database schema
```

## 🎯 Common Tasks

### Add a New Plugin

1. Create plugin config:
```typescript
// registry/components/editor/plugins/my-plugin-kit.tsx
export const MyPluginKit = [
  createPlatePlugin({
    key: 'my-plugin',
    // ... plugin config
  }),
];
```

2. Add to EditorKit:
```typescript
// components/editor/editor-kit-app.tsx
export const EditorKit = [
  // ... existing plugins
  MyPluginKit,
];
```

### Add a New UI Component

1. Create component:
```typescript
// components/ui/my-component.tsx
export function MyComponent() {
  return <div>...</div>;
}
```

2. Use in editor:
```typescript
import { MyComponent } from '@/components/ui/my-component';
```

### Add a New tRPC Router

1. Create router:
```typescript
// src/server/api/routers/my-router.ts
export const myRouter = router({
  list: publicProcedure.query(async () => {
    // ... query logic
  }),
});
```

2. Add to root router:
```typescript
// src/server/api/root.ts
export const appRouter = router({
  // ... existing routers
  my: myRouter,
});
```

### Add a New Database Table

1. Update schema:
```prisma
// prisma/schema.prisma
model MyModel {
  id        String   @id @default(cuid())
  name      String
  createdAt DateTime @default(now())
}
```

2. Push to database:
```bash
pnpm db:push
```

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Find process using port 3000
lsof -ti:3000

# Kill process
kill -9 $(lsof -ti:3000)

# Or use different port
PORT=3001 pnpm dev
```

### Database Connection Failed
```bash
# Check Docker is running
docker ps

# Restart PostgreSQL
docker-compose restart postgres

# Check connection
psql postgresql://postgres:postgres@localhost:5432/potion_editor
```

### Prisma Issues
```bash
# Regenerate client
pnpm db:generate

# Reset and push
npx prisma migrate reset
pnpm db:push

# Clear cache
rm -rf node_modules/.prisma
pnpm db:generate
```

### YJS Not Connecting
```bash
# Check Hocuspocus is running
curl http://localhost:4444

# Check Redis
redis-cli ping

# Restart services
docker-compose restart redis
```

### Build Errors
```bash
# Clear Next.js cache
rm -rf .next

# Clear node modules
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Clear everything
rm -rf .next node_modules pnpm-lock.yaml
pnpm install
pnpm db:generate
```

## 📊 Useful URLs

| Service | URL | Description |
|---------|-----|-------------|
| Next.js | http://localhost:3000 | Main application |
| Hocuspocus | ws://localhost:4444 | YJS server |
| Prisma Studio | http://localhost:5555 | Database GUI |
| PostgreSQL | localhost:5432 | Database |
| Redis | localhost:6379 | Cache |

## 🔑 Keyboard Shortcuts (Editor)

| Shortcut | Action |
|----------|--------|
| `Cmd/Ctrl + B` | Bold |
| `Cmd/Ctrl + I` | Italic |
| `Cmd/Ctrl + U` | Underline |
| `Cmd/Ctrl + J` | AI menu |
| `Cmd/Ctrl + Shift + M` | Add comment |
| `Cmd/Ctrl + K` | Add link |
| `Cmd/Ctrl + D` | Duplicate block |
| `Cmd/Ctrl + /` | Toggle comment |
| `/` | Slash commands |
| `@` | Mention |
| `:` | Emoji |

## 📦 Package Management

```bash
# Add package
pnpm add package-name

# Add dev dependency
pnpm add -D package-name

# Remove package
pnpm remove package-name

# Update all packages
pnpm update

# Update specific package
pnpm update package-name

# Check outdated
pnpm outdated
```

## 🧪 Testing (Future)

```bash
# Run all tests
pnpm test

# Run specific test file
pnpm test -- path/to/test

# Run with coverage
pnpm test:coverage

# Run e2e tests
pnpm test:e2e
```

## 🚢 Deployment

### Vercel
```bash
# Install Vercel CLI
pnpm add -g vercel

# Deploy
vercel

# Production deploy
vercel --prod
```

### Environment Setup
1. Set environment variables in Vercel dashboard
2. Add PostgreSQL database (Vercel Postgres or external)
3. Add Redis (Upstash or external)
4. Deploy Hocuspocus server separately

## 📝 Git Workflow

```bash
# Create feature branch
git checkout -b feature/my-feature

# Commit changes
git add .
git commit -m "feat: add my feature"

# Push to remote
git push origin feature/my-feature

# Merge to main
git checkout main
git merge feature/my-feature
```

## 🔍 Debugging

### Enable Verbose Logging
```typescript
// src/server/db.ts
const db = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});
```

### React DevTools
```bash
# Install extension
# Chrome: https://chrome.google.com/webstore/detail/react-developer-tools
# Firefox: https://addons.mozilla.org/firefox/addon/react-devtools/
```

### Network Debugging
```bash
# View all network requests in browser DevTools
# Network tab -> Filter by type (XHR, WS, etc.)
```

## 📚 Resources

- **Plate.js**: https://platejs.org/docs
- **Next.js**: https://nextjs.org/docs
- **Prisma**: https://prisma.io/docs
- **tRPC**: https://trpc.io/docs
- **Tailwind**: https://tailwindcss.com/docs
- **YJS**: https://docs.yjs.dev
- **Hocuspocus**: https://tiptap.dev/hocuspocus

## 💡 Tips

1. **Use TypeScript**: Get better autocomplete and catch errors early
2. **Hot reload**: Save files and see changes instantly
3. **Database migrations**: Use migrations in production, push in dev
4. **Git commits**: Use conventional commits (feat:, fix:, docs:, etc.)
5. **Component structure**: Keep components small and focused
6. **State management**: Use React Query for server state, Jotai for client state
7. **Testing**: Write tests as you build features
8. **Documentation**: Document complex logic inline

## 🎓 Learning Path

1. **Week 1**: Next.js basics, App Router, Server Components
2. **Week 2**: Plate.js fundamentals, plugins, components
3. **Week 3**: Real-time collaboration, YJS, Hocuspocus
4. **Week 4**: Advanced features, AI, version history
5. **Week 5**: Testing, optimization, deployment

---

Keep this guide handy for quick reference! 📖
