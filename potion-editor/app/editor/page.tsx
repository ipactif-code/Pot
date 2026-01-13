'use client';

import { useState } from 'react';

export default function EditorPage() {
  const [mounted, setMounted] = useState(false);

  // Wait for client-side hydration
  if (typeof window === 'undefined') {
    return null;
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto p-8">
        <div className="mb-8">
          <h1 className="text-4xl font-bold mb-2">Potion Editor</h1>
          <p className="text-muted-foreground">
            A powerful rich text editor with real-time collaboration
          </p>
        </div>

        <div className="rounded-lg border bg-card p-8">
          <div className="prose dark:prose-invert max-w-none">
            <h2>Welcome to Potion Editor! 🎉</h2>
            <p>
              This is a demo page. The full editor components will be added in the next steps.
            </p>
            <p>Features coming soon:</p>
            <ul>
              <li>Rich text editing with 52 Plate.js plugins</li>
              <li>Real-time collaboration with YJS</li>
              <li>AI-powered writing assistance</li>
              <li>Comments and suggestions</li>
              <li>Version history</li>
              <li>And much more!</li>
            </ul>
          </div>
        </div>

        <div className="mt-8 flex gap-4">
          <button className="rounded-lg bg-primary px-4 py-2 text-primary-foreground hover:bg-primary/90">
            Get Started
          </button>
          <button className="rounded-lg border px-4 py-2 hover:bg-accent">
            Learn More
          </button>
        </div>
      </div>
    </div>
  );
}
