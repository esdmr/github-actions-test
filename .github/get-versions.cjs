#!/usr/bin/env node
const fs = require('fs');

const packageMeta = JSON.parse(fs.readFileSync('package.json', 'utf8'));

if (typeof packageMeta !== 'object' || packageMeta === null) {
	throw new TypeError('::error::Invalid package json');
}

const nodeVersion = packageMeta.engines?.node;

if (typeof nodeVersion !== 'string') {
	throw new Error('::error::Node.JS version not found');
}

const pinnedNodeVersion = nodeVersion.replace(/^(?:[<>]=|\^|~)/, '');

if (!pinnedNodeVersion.match(/^\d+(?:\.\d+){0,2}$/)) {
	throw new Error(`::error::Invalid Node.JS version: ${pinnedNodeVersion}`);
}

const pnpmVersion = packageMeta.packageManager;

if (!pnpmVersion) {
	throw new Error('::error::pnpm version not found');
}

const pinnedPNPMVersion = pnpmVersion.replace(/^pnpm@/, '');

if (!pinnedPNPMVersion.match(/^\d+(?:\.\d+){2}$/)) {
	throw new Error(`::error::Invalid pnpm version: ${pinnedPNPMVersion}`);
}

console.log(`::set-output name=pnpm::${pinnedPNPMVersion}`);
console.log(`::set-output name=node::${pinnedNodeVersion}`);
