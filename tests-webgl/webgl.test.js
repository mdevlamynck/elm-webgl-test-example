const fs = require('fs');
const path = require('path');
const { compileSync } = require('node-elm-compiler');
const puppeteer = require('puppeteer');

const { toMatchImageSnapshot } = require('jest-image-snapshot');
expect.extend({ toMatchImageSnapshot });

const testCaseFolder = path.resolve(__dirname, './elm/');
const testCaseFiles = fs.readdirSync(testCaseFolder);
const buildFolder = path.resolve(__dirname, './.build/');
let browser;

beforeEach(async function () {
    browser = await puppeteer.launch({defaultViewport: {width: 800, height: 600}});
});

afterEach(async function () {
    await browser.close();
});

test.each(testCaseFiles)('%s', async function (elm) {
    const htmlOutput = path.resolve(buildFolder, elm + '.html');
    compileSync([path.resolve(testCaseFolder, elm)], { output: htmlOutput, optimize: true, debug: false, verbose: false });

    const page = await browser.newPage();
    await page.goto('file://' + htmlOutput);
    const image = await page.screenshot();

    expect(image).toMatchImageSnapshot();
});
