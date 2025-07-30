const fs = require('fs');
const path = require('path');

class DirectoryScanner {
    constructor(rootPath = '.', outputFile = 'dir.md') {
        this.rootPath = path.resolve(rootPath);
        this.outputFile = outputFile;
        this.structure = [];
    }

    shouldIgnore(itemPath, itemName) {
        const ignoredItems = [
            'node_modules',
            '.git',
            '.DS_Store',
            'Thumbs.db',
            '.env',
            '.gitignore',
            this.outputFile
        ];
        
        return ignoredItems.includes(itemName) || itemName.startsWith('.');
    }

    getRelativePath(fullPath) {
        return path.relative(this.rootPath, fullPath).replace(/\\/g, '/');
    }

    scanDirectory(dirPath, depth = 0) {
        try {
            const items = fs.readdirSync(dirPath, { withFileTypes: true })
                .filter(item => !this.shouldIgnore(path.join(dirPath, item.name), item.name))
                .sort((a, b) => {
                    if (a.isDirectory() && !b.isDirectory()) return -1;
                    if (!a.isDirectory() && b.isDirectory()) return 1;
                    return a.name.localeCompare(b.name);
                });

            const result = [];

            for (const item of items) {
                const fullPath = path.join(dirPath, item.name);
                const relativePath = this.getRelativePath(fullPath);
                const indent = '  '.repeat(depth);

                if (item.isDirectory()) {
                    result.push(`${indent}- ${item.name}`);
                    
                    const subItems = this.scanDirectory(fullPath, depth + 1);
                    result.push(...subItems);
                } else {
                    result.push(`${indent}- [${item.name}](${relativePath})`);
                }
            }

            return result;
        } catch (error) {
            console.error(`Error scanning directory ${dirPath}:`, error.message);
            return [];
        }
    }

    generateMarkdown() {
        console.log(`Scanning directory: ${this.rootPath}`);
        
        const structure = this.scanDirectory(this.rootPath);
        
        return structure.join('\n') + '\n';
    }

    writeToFile() {
        try {
            const content = this.generateMarkdown();
            const outputPath = path.join(this.rootPath, this.outputFile);
            
            fs.writeFileSync(outputPath, content, 'utf8');
            console.log(`✅ Directory structure saved to: ${outputPath}`);
            console.log(`📁 Total lines generated: ${content.split('\n').length - 1}`);
        } catch (error) {
            console.error('❌ Error writing file:', error.message);
        }
    }

    run() {
        console.log('🔍 Starting directory scan...');
        this.writeToFile();
        console.log('✨ Scan complete!');
    }
}

function parseArguments() {
    const args = process.argv.slice(2);
    let rootPath = '.';
    let outputFile = 'dir.md';

    for (let i = 0; i < args.length; i++) {
        switch (args[i]) {
            case '--path':
            case '-p':
                rootPath = args[i + 1];
                i++;
                break;
            case '--output':
            case '-o':
                outputFile = args[i + 1];
                i++;
                break;
            case '--help':
            case '-h':
                console.log(`
Directory Scanner to Markdown

Usage: node script.js [options]

Options:
  -p, --path <path>     Root directory to scan (default: current directory)
  -o, --output <file>   Output markdown file name (default: directory-structure.md)
  -h, --help           Show this help message

Examples:
  node script.js
  node script.js --path ./my-project --output structure.md
  node script.js -p ../parent-folder -o folder-map.md
                `);
                process.exit(0);
        }
    }

    return { rootPath, outputFile };
}

// Main execution
if (require.main === module) {
    const { rootPath, outputFile } = parseArguments();
    
    // Validate root path exists
    if (!fs.existsSync(rootPath)) {
        console.error(`❌ Error: Directory "${rootPath}" does not exist.`);
        process.exit(1);
    }

    if (!fs.statSync(rootPath).isDirectory()) {
        console.error(`❌ Error: "${rootPath}" is not a directory.`);
        process.exit(1);
    }

    const scanner = new DirectoryScanner(rootPath, outputFile);
    scanner.run();
}

module.exports = DirectoryScanner;
