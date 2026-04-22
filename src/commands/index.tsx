// Copyright 2026 Michael F. Collins, III
// Licensed under the Naked Products Source-Available Temporary License
// See LICENSE.md for license terms

import React from 'react';
import { Box, Text } from 'ink';

export default function DefaultCommand() {
  return (
    <Box flexDirection="column" padding={1}>
      <Text bold>Naked Products</Text>
      <Text>
        TUI coming soon. Try <Text bold>nakedproducts --help</Text> for
        available commands.
      </Text>
    </Box>
  );
}
