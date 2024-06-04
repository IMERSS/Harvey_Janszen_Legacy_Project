/* eslint-env node */

"use strict";

const linkedom = require("linkedom"),
    fluid = require("infusion");

const imerss = fluid.registerNamespace("imerss");

require("./utils.js");


imerss.isReasonableNode = function (node, index) {
    return index !== 0;
};

imerss.speciesFormingText = [" cfr. "];

imerss.isAuthorityForming = function (node) {
    return node.getAttribute("style") !== "font-style:italic;" && !imerss.speciesFormingText.includes(node.innerHTML);
};

imerss.nodeToText = function (node) {
    const text = node.innerHTML;
    return text.replace("&#160;", " ").replace("&amp;", "&");
}

imerss.extractData = function (node) {
    return {
        Taxon: node.innerText
    };
}

imerss.scrapeEFlora = async function (inPath, outPath) {
    const now = Date.now();
    const doc = imerss.parseDocument(inPath);
    const nodes = doc.querySelectorAll("*").length;
    console.log("Loaded " + nodes + " nodes in " + (Date.now() - now) + "ms");
    const sixties = doc.querySelectorAll(`td[width="60%"]`);
    console.log(sixties.length + " sixties");
    const reason = sixties.filter(imerss.isReasonableNode);
    const extracted = reason.map(imerss.extractData);

    const first = extracted.slice(0, 50);
    console.log(first);

    await imerss.writeCSV(outPath, Object.keys(extracted[0]), extracted);
};

imerss.scrapeEFlora("data/data_digitization/eflora_data/E-Flora BC_ Species Search Page.html",
    "data/data_digitization/eflora_data/eflora_weeds.csv").then();
