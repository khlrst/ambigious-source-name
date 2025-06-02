# ambigious-source-name

This project demonstrates a solution for bypassing Hardhat compilation issues when working with Foundry remappings in the same project.

## Problem

When using Hardhat and Foundry in the same project, there can be compilation issues due to different import resolution strategies. Foundry uses remappings while Hardhat Foundry has more strict import resolution system, which can lead to conflicts.

## Solution

The solution involves preprocessing Solidity files to handle imports differently based on the compilation method:

### Hardhat Compilation with Preprocessing

When compiling with Hardhat using preprocessing:

```bash
# Using preprocess config
npx hardhat compile --config hardhat.preprocess.config.js
```

The preprocessing step modifies import statements in Solidity files to ensure compatibility between Hardhat and Foundry's import resolution systems.

### How it works

The preprocessing is implemented using Hardhat's preprocessing plugin. Here's the key code:

```typescript
import "hardhat-preprocessor";
import { transformImports } from "./hardhat-preprocess/preprocess";

// hardhat.preprocess.config.ts
preprocess: {
  eachLine: (hre) => ({
    transform: (line: string, file: { absolutePath: string }) => {
      return transformImports("contracts", line, file);
    },
  }),
  ...// other config properties
}

// preprocess.ts
export function transformImports(src: string, line: string, files: { absolutePath: string }) : string {
    if (line.match(importRegex)) {
        getRemappings().forEach(([find, replace]) => {
            ....
            // Transform import paths based on remappings
            // This handles different cases:
            // 1. Library imports (starting with "lib/")
            // 2. Internal project imports
            // 3. External imports
            // The function calculates the correct relative path
            // based on the file's location and the remapping rules
        });
    }
    return line;
}
```

The preprocessing works by:
1. Reading Foundry's remappings from `remappings.txt`
2. For each import statement in Solidity files:
   - Checks if the import matches any remapping rules
   - Calculates the correct relative path based on the file's location
   - Transforms the import statement to use the correct path
3. This ensures that imports work correctly in both Hardhat and Foundry environments

