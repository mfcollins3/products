// Copyright 2026 Michael F. Collins, III
// Licensed under the Naked Products Source-Available Temporary License
// See LICENSE.md for license terms

import React from 'react';
import { Text } from 'ink';

export const version = '0.1.0';

export default function VersionCommand() {
  return <Text>{version}</Text>;
}
