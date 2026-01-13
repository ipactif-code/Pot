# Potion Editor - Setup Verification Checklist

Use this checklist to verify your setup is complete and working correctly.

## ✅ Phase 1: Initial Setup

### Prerequisites
- [ ] Node.js 22+ installed (`node --version`)
- [ ] pnpm installed (`pnpm --version`)
- [ ] Docker Desktop installed and running (`docker --version`)
- [ ] Git installed (`git --version`)
- [ ] Code editor (VS Code recommended)

### Project Setup
- [ ] Project cloned/created
- [ ] Navigate to project directory
- [ ] `.env` file created and configured
- [ ] All required API keys added to `.env`

### Verify .env Configuration
```bash
# Check these variables exist and have values:
grep -E "DATABASE_URL|BETTER_AUTH_SECRET|NEXT_PUBLIC_YJS_URL|REDIS_URL" .env
```

Expected output should show all 4 variables with values.

## ✅ Phase 2: Dependencies & Services

### Install Dependencies
```bash
pnpm install
```
- [ ] Installation completes without errors
- [ ] `node_modules/` directory created
- [ ] `pnpm-lock.yaml` file created

### Start Docker Services
```bash
docker-compose up -d
```
- [ ] PostgreSQL container running
- [ ] Redis container running

### Verify Docker Services
```bash
docker-compose ps
```
Expected output:
```
NAME                STATUS
potion-postgres     Up
potion-redis        Up
```

### Test PostgreSQL Connection
```bash
docker exec -it potion-postgres psql -U postgres -d potion_editor -c "\dt"
```
- [ ] Connection succeeds (even if no tables yet)

### Test Redis Connection
```bash
docker exec -it potion-redis redis-cli ping
```
Expected output: `PONG`

## ✅ Phase 3: Database Setup

### Generate Prisma Client
```bash
pnpm db:generate
```
- [ ] Prisma client generated successfully
- [ ] `node_modules/.prisma/` directory created

### Push Database Schema
```bash
pnpm db:push
```
- [ ] All 8 tables created
- [ ] No errors reported

### Verify Database Tables
```bash
docker exec -it potion-postgres psql -U postgres -d potion_editor -c "\dt"
```
Expected tables:
- [ ] users
- [ ] sessions
- [ ] accounts
- [ ] verifications
- [ ] documents
- [ ] document_versions
- [ ] discussions
- [ ] comments
- [ ] files

### Optional: Open Prisma Studio
```bash
pnpm db:studio
```
- [ ] Studio opens at http://localhost:5555
- [ ] Can view all tables
- [ ] Tables are empty (expected)

## ✅ Phase 4: Application Servers

### Terminal 1: Start Next.js
```bash
pnpm dev
```
- [ ] Next.js starts without errors
- [ ] Compiling... message appears
- [ ] Listening on http://localhost:3000
- [ ] No compilation errors

### Terminal 2: Start Hocuspocus (YJS)
```bash
pnpm yjs:dev
```
- [ ] Hocuspocus server starts
- [ ] Listening on port 4444
- [ ] WebSocket server ready
- [ ] Connected to Redis

## ✅ Phase 5: Application Testing

### Test Next.js Application
1. Open http://localhost:3000 in browser
- [ ] Page loads successfully
- [ ] No console errors
- [ ] Redirects to `/editor`
- [ ] Welcome message displays

### Test Hot Reload
1. Edit `app/editor/page.tsx`
2. Change text in the component
3. Save file
- [ ] Page automatically reloads
- [ ] Changes appear immediately
- [ ] No errors in terminal

### Test Build Process
```bash
pnpm build
```
- [ ] Build completes successfully
- [ ] `.next` directory created
- [ ] No build errors
- [ ] Build output shows page statistics

## ✅ Phase 6: Development Workflow

### Test Database Operations
```bash
# Open Prisma Studio
pnpm db:studio

# In Studio:
# 1. Click on 'users' table
# 2. Click 'Add record'
# 3. Fill in fields
# 4. Click 'Save 1 change'
```
- [ ] Record created successfully
- [ ] Can view record in table
- [ ] Can edit record
- [ ] Can delete record

### Test TypeScript
```bash
# Run type checking
npx tsc --noEmit
```
- [ ] Type checking completes
- [ ] No type errors (initially)

### Test Linting
```bash
pnpm lint
```
- [ ] Linting completes
- [ ] Shows any issues (fix if needed)

## ✅ Phase 7: Verify File Structure

### Check Key Files Exist
```bash
ls -la
```
- [ ] `package.json` exists
- [ ] `tsconfig.json` exists
- [ ] `next.config.mjs` exists
- [ ] `tailwind.config.ts` exists
- [ ] `prisma/schema.prisma` exists
- [ ] `docker-compose.yml` exists
- [ ] `.env` exists (not `.env.example`)

### Check Directory Structure
```bash
ls -la app/ components/ src/ registry/
```
- [ ] All main directories exist
- [ ] Subdirectories created

## ✅ Phase 8: Documentation Review

### Read Core Documentation
- [ ] `README.md` - Setup and features overview
- [ ] `IMPLEMENTATION_GUIDE.md` - Development roadmap
- [ ] `PROJECT_SUMMARY.md` - Architecture overview
- [ ] `QUICK_REFERENCE.md` - Common commands

### Understand Next Steps
- [ ] Know where to start (Phase 2: Core UI Components)
- [ ] Have implementation guide open
- [ ] Understand component structure
- [ ] Ready to begin development

## 🐛 Common Issues & Solutions

### Issue: Port 3000 already in use
```bash
# Find and kill process
lsof -ti:3000 | xargs kill -9

# Or use different port
PORT=3001 pnpm dev
```

### Issue: Port 4444 already in use
```bash
# Find and kill process
lsof -ti:4444 | xargs kill -9

# Or change YJS_PORT in .env
```

### Issue: Docker services not starting
```bash
# Check Docker is running
docker info

# Remove existing containers
docker-compose down -v

# Start fresh
docker-compose up -d
```

### Issue: Database connection error
```bash
# Check PostgreSQL is running
docker-compose ps

# Check connection string in .env
# Should match: postgresql://postgres:postgres@localhost:5432/potion_editor

# Restart PostgreSQL
docker-compose restart postgres
```

### Issue: Prisma errors
```bash
# Regenerate client
pnpm db:generate

# Reset database
pnpm db:push

# If still errors, clear and reinstall
rm -rf node_modules/.prisma
pnpm install
pnpm db:generate
```

### Issue: Module not found errors
```bash
# Clear and reinstall
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

### Issue: Build fails
```bash
# Clear Next.js cache
rm -rf .next

# Clear everything
rm -rf .next node_modules pnpm-lock.yaml
pnpm install
pnpm build
```

## 📊 Success Criteria

Your setup is complete when:

✅ **All checkboxes are checked**
✅ **Both servers (Next.js + Hocuspocus) run without errors**
✅ **Application loads in browser at http://localhost:3000**
✅ **No console errors in browser**
✅ **Can connect to database via Prisma Studio**
✅ **Docker services show "Up" status**
✅ **Hot reload works (save file = page updates)**
✅ **Build process completes successfully**

## 🎉 You're Ready!

If all checks pass, you're ready to start implementing features!

**Next Steps:**
1. Open `IMPLEMENTATION_GUIDE.md`
2. Start with Phase 2: Core UI Components
3. Follow the guide step-by-step
4. Build incrementally and test frequently

## 💡 Pro Tips

1. **Keep terminals open**: Run Next.js and Hocuspocus in separate terminal tabs
2. **Use Prisma Studio**: Keep it open to monitor database changes
3. **Check console**: Browser DevTools console for client errors
4. **Check terminal**: Server logs for backend errors
5. **Commit often**: Use git to save progress frequently
6. **Test early**: Test each feature as you build it
7. **Read docs**: Keep Plate.js docs handy

## 📞 Need Help?

- Check the troubleshooting section above
- Review documentation files
- Check Plate.js Discord: https://discord.gg/mAZRuBzGM3
- Open an issue on GitHub

---

Happy coding! 🚀
