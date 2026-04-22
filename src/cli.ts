#!/usr/bin/env node
// Copyright 2026 Michael F. Collins, III
// Licensed under the Naked Products Source-Available Temporary License
// See LICENSE.md for license terms

import Pastel from 'pastel';

const app = new Pastel({
  importMeta: import.meta,
  name: 'nakedproducts',
  description: 'AI-powered product initialization assistant.',
  version: '0.1.0'
});

await app.run();
