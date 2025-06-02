import fs from "fs";
import path from "path";

function getRemappings(remappingsPath: string = "./remappings.txt") {
    return fs
        .readFileSync(path.join(__dirname, remappingsPath), "utf8")
        .split("\n")
        .filter(Boolean) // remove empty lines
        .map((line) => line.trim().split("="));
}

function processLibImports(line: string, find: string, replace: string, right: string) {
    let replacer : string = "";
    const depth = right.split("\/").length;
    for (let i = 0; i < depth; i++) {
        replacer += "../";
    }
    return line.replace(find, replacer + replace);
}

function processInternalImports(line: string, find: string, right: string) {
    let replacer : string = "";
    const newRight = right.split(`${find}`)[1];
    const internalDepth = newRight.split("\/").length - 1;
    for (let i = 0; i < internalDepth; i++) {
        replacer += "../";
    }
    if (internalDepth == 0) replacer = "./";
    return line.replace(find, replacer);
}

function processExternalImports(line: string, find: string, replace: string, right: string) {
    let replacer : string = "";
    const depth = right.split("\/").length - 2;
    for (let i = 0; i < depth; i++) {
        replacer += "../";
    }
    return line.replace(find, replacer + replace);
}

export function preprocessImports(src: string, line: string, files: { absolutePath: string })  : string {
    
    if (line.match(importRegex)) {
        getRemappings().forEach(([find, replace]) => {
            // split the path of the file and get the right path
            const right = files.absolutePath.split(`\/${src}\/`)[1];
            // if the line includes the find string, process the import
            if (line.includes(find)) {
                if (line.includes(processed)) return line; // skip already processed imports
                if (replace.includes("lib/")) {
                    line = processLibImports(line, find, replace, right);
                } else if (right.includes(find)) {
                    line = processInternalImports(line, find, right);
                } else {
                    line = processExternalImports(line, find, replace, right);
                }
            }
        });
    }
    return line;
}

const importRegex = /.*\}\s+from\s+/i; // adjust regex to match the import statement
const processed = "from \"\.";