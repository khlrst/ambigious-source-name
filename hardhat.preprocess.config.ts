import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "hardhat-preprocessor";
import { preprocessImports } from "./preprocess-imports";

const config: HardhatUserConfig = {
  preprocess: {
    eachLine: (hre) => ({
      transform: (line: string, file: { absolutePath: string }) => {
        return preprocessImports("contracts", line, file);
      },
    }),
  },
  solidity: {
    version: "0.8.27", // Matching Foundry's solc version
    settings: {
      optimizer: {
        enabled: true,
        runs: 1337, // Matching Foundry's optimizer_runs
      },
      viaIR: true, // Matching Foundry's via_ir setting
    },
  }, 
  paths: {
    sources: "./contracts",
    artifacts: "./artifacts", 
    cache: "./cache_hardhat",
  },
  typechain: {
    outDir: "typechain",
    target: "ethers-v6",
  }
};

export default config; 