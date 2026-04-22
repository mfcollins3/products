// Copyright 2026 Michael F. Collins, III
// Licensed under the Naked Products Source-Available Temporary License
// See LICENSE.md for license terms

import { describe, it, expect } from 'vitest';
import { version } from '../src/commands/version.js';

describe('cli skeleton', () => {
  it('exports a semver-shaped version string', () => {
    expect(version).toMatch(/^\d+\.\d+\.\d+/);
  });
});
