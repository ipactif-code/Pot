# Potion Editor - Implementation Guide

This guide will walk you through implementing all the components from the Potion template to create a fully functional rich text editor.

## Phase 1: Foundation Setup ✅ COMPLETE

We've completed:
- ✅ Project structure
- ✅ Package.json with all dependencies
- ✅ TypeScript configuration
- ✅ Tailwind CSS 4 setup
- ✅ Next.js 15 configuration
- ✅ Prisma schema
- ✅ Docker Compose for PostgreSQL + Redis
- ✅ Environment variables template
- ✅ Basic providers and utilities

## Phase 2: Core UI Components (Next Step)

### Priority 1: Base UI Components
Location: `registry/ui/`

These are the foundation shadcn/ui components we need:

1. **Button** (`button.tsx`) - Already have similar, adapt
2. **Input** (`input.tsx`)
3. **Textarea** (`textarea.tsx`)
4. **Tooltip** (`tooltip.tsx`)
5. **Popover** (`popover.tsx`)
6. **Dialog** (`dialog.tsx`)
7. **Dropdown Menu** (`dropdown-menu.tsx`)
8. **Command** (`command.tsx`)
9. **Separator** (`separator.tsx`)
10. **Toggle** (`toggle.tsx`)
11. **Toolbar** (`toolbar.tsx`)

### Priority 2: Editor Base Components

1. **Editor** (`registry/ui/editor.tsx`)
   - Main editor container with variants
   - Styling and focus management

2. **EditorStatic** (`registry/ui/editor-static.tsx`)
   - Read-only rendering

3. **Toolbar** (`registry/ui/toolbar.tsx`)
   - Base toolbar with button groups

## Phase 3: Plate.js Plugin System

### Step 1: Create Plugin Configurations
Location: `registry/components/editor/plugins/`

Basic plugins to implement first:
1. `basic-blocks-kit.tsx` - Paragraph, headings, blockquote
2. `basic-marks-kit.tsx` - Bold, italic, underline
3. `list-kit.tsx` - Bulleted/numbered lists
4. `link-kit.tsx` - Hyperlinks

### Step 2: Create Node Components
Location: `registry/ui/`

1. `paragraph-node.tsx`
2. `heading-node.tsx`
3. `blockquote-node.tsx`
4. `list-node.tsx` (BulletedListElement, NumberedListElement)
5. `link-node.tsx`

### Step 3: Assemble Editor Kit
Location: `components/editor/editor-kit-app.tsx`

Combine all plugins into EditorKit array.

## Phase 4: Editor Provider & Setup

### Step 1: Plate Provider
Location: `components/editor/plate-provider.tsx`

Three variants:
1. **DocumentPlate** - Full editor with YJS
2. **PublicPlate** - Demo editor with localStorage
3. **PrintPlate** - Print/export mode

### Step 2: Editor Wrapper
Location: `components/editor/plate-editor.tsx`

Main editor component that:
- Manages YJS connection
- Handles loading states
- Toggles TOC sidebar
- Applies text styles

## Phase 5: Advanced Features

### Toolbar System

1. **Floating Toolbar** (`registry/ui/floating-toolbar.tsx`)
   - Selection-based toolbar
   - Position calculations

2. **Floating Toolbar Buttons** (`registry/ui/floating-toolbar-buttons.tsx`)
   - Format buttons (bold, italic, etc.)
   - AI button
   - Comment button
   - Turn into dropdown

### Slash Commands

1. **Slash Node** (`registry/ui/slash-node.tsx`)
   - Inline combobox
   - Command groups
   - Insert handlers

2. **Inline Combobox** (`registry/ui/inline-combobox.tsx`)
   - Generic combobox component
   - Filter logic
   - YJS awareness

### Block Menu

1. **Block Menu** (`registry/ui/block-menu.tsx`)
   - Context menu on blocks
   - Drag handle
   - Action items

2. **Block Draggable** (`registry/ui/block-draggable.tsx`)
   - Drag and drop
   - Drop indicators

## Phase 6: Media Components

### Priority Order:

1. **Image Element** (`registry/ui/media-image-node.tsx`)
   - Lazy loading
   - Resize handles
   - Caption

2. **Media Placeholder** (`registry/ui/media-placeholder-node.tsx`)
   - Upload UI
   - Progress indicator

3. **Video/Audio/File** 
   - Similar structure to image

## Phase 7: Collaboration Features

### YJS Integration

1. **Hocuspocus Server** (`src/server/yjs/server.ts`)
   - WebSocket server
   - Authentication
   - Document persistence
   - Redis extension

2. **YJS Document Handler** (`src/server/yjs/document.ts`)
   - Load/save snapshots
   - Y.doc ↔ Slate conversion

3. **Remote Cursor Overlay** (`registry/ui/remote-cursor-overlay.tsx`)
   - Render remote cursors
   - User labels

### Comments System

1. **Comment Plugin** (`registry/components/editor/plugins/comment-kit.tsx`)
2. **Comment Node** (`registry/ui/comment-node.tsx`)
3. **Floating Discussion** (`registry/ui/floating-discussion.tsx`)
4. **Block Discussion** (`registry/ui/block-discussion.tsx`)

## Phase 8: Additional Features

### Code Blocks
1. **Code Block Node** (`registry/ui/code-block-node.tsx`)
   - Language selector
   - Syntax highlighting
   - Copy button

### Tables
1. **Table Node** (`registry/ui/table-node.tsx`)
   - Resize handles
   - Add/remove rows/columns

### Special Blocks
1. **Callout** (`registry/ui/callout-node.tsx`)
2. **Toggle** (`registry/ui/toggle-node.tsx`)
3. **TOC** (`registry/ui/toc-node.tsx`)
4. **Equation** (`registry/ui/equation-node.tsx`)

## Phase 9: Version History

1. **Version Panel** (`components/editor/version-history/version-history-panel.tsx`)
2. **Diff Visualization** (`components/editor/version-history/diff-plate.tsx`)
3. **Version Restoration**

## Phase 10: AI Integration

1. **AI Menu** (`registry/ui/ai-menu.tsx`)
2. **AI Toolbar Button** (`registry/ui/ai-toolbar-button.tsx`)
3. **Hono AI Routes** (`src/server/hono/routes/ai.ts`)

## Phase 11: API & Backend

### tRPC Routers

1. **Document Router** (`src/server/api/routers/document.ts`)
   - CRUD operations
   - Publishing
   - Archiving

2. **Comment Router** (`src/server/api/routers/comment.ts`)
   - Create discussions
   - Add comments
   - Resolve threads

3. **Version Router** (`src/server/api/routers/version.ts`)
   - Create snapshots
   - List versions
   - Restore

### Authentication

1. **Better-Auth Setup** (`src/server/auth/auth.ts`)
2. **Auth Routes** (`app/api/auth/[...all]/route.ts`)

## Implementation Strategy

### Recommended Order:

1. **Week 1: Core Editor**
   - Base UI components
   - Basic text editing
   - Paragraph, headings, lists
   - Bold, italic, underline

2. **Week 2: Enhanced Editing**
   - Slash commands
   - Floating toolbar
   - Block menu
   - Drag and drop
   - Links

3. **Week 3: Media & Special Blocks**
   - Images
   - Code blocks
   - Tables
   - Callouts, toggles

4. **Week 4: Collaboration**
   - YJS setup
   - Hocuspocus server
   - Remote cursors
   - Real-time sync

5. **Week 5: Comments & Suggestions**
   - Comment system
   - Discussion threads
   - Tracked changes

6. **Week 6: Advanced Features**
   - Version history
   - AI integration
   - Export (PDF, DOCX)

7. **Week 7: Backend & API**
   - tRPC routers
   - Authentication
   - Document CRUD

8. **Week 8: Polish & Testing**
   - Bug fixes
   - Performance optimization
   - Testing
   - Documentation

## Testing Strategy

### Unit Tests
- Individual component rendering
- Plugin functionality
- Utilities and helpers

### Integration Tests
- Editor interactions
- Toolbar actions
- Slash commands

### E2E Tests
- Full editing workflows
- Collaboration scenarios
- Document operations

## Deployment Checklist

### Pre-deployment:
- [ ] Environment variables set
- [ ] Database migrations run
- [ ] Redis configured
- [ ] File upload configured
- [ ] AI API keys set

### Deploy Steps:
1. Deploy PostgreSQL database
2. Deploy Redis instance
3. Deploy Hocuspocus server
4. Deploy Next.js app
5. Test real-time collaboration
6. Test file uploads
7. Test AI features

### Post-deployment:
- [ ] Monitor error logs
- [ ] Check database connections
- [ ] Verify YJS sync
- [ ] Test from multiple locations
- [ ] Performance monitoring

## Resources

- **Plate.js Docs**: https://platejs.org/docs
- **Potion Demo**: https://potion.platejs.org
- **Hocuspocus Docs**: https://tiptap.dev/hocuspocus
- **YJS Docs**: https://docs.yjs.dev/
- **Better-Auth**: https://better-auth.com/docs
- **Prisma**: https://www.prisma.io/docs

## Next Steps

Ready to start? Here's what to do next:

1. **Install dependencies**:
   ```bash
   pnpm install
   ```

2. **Start Docker services**:
   ```bash
   docker-compose up -d
   ```

3. **Set up database**:
   ```bash
   cp .env.example .env
   # Edit .env with your values
   pnpm db:push
   ```

4. **Start development**:
   ```bash
   # Terminal 1
   pnpm dev
   
   # Terminal 2
   pnpm yjs:dev
   ```

5. **Begin implementing** Phase 2: Core UI Components

Let's build an amazing editor! 🚀
