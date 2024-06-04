/* eslint-env node */

"use strict";

const fs = require("fs"),
    csvWriterModule = require("csv-writer"),
    fluid = require("infusion"),
    linkedom = require("linkedom");

const imerss = fluid.registerNamespace("imerss");

/** Parse an HTML document supplied as a symbolic reference into a linkedom DOM document
 * @param {String} path - A possibly module-qualified path reference, e.g. "%maxwell/src/html/template.html"
 * @return {Document} The document parsed into a DOM representation
 */
imerss.parseDocument = function (path) {
    const resolved = fluid.module.resolvePath(path);
    const text = fs.readFileSync(resolved, "utf8");
    return linkedom.parseHTML(text).document;
};

imerss.isUpper = function (char) {
    return /[A-Z]/.test(char);
};

imerss.capitalize = function (string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
};

imerss.writeCSV = function (fileName, headers, rows) {
    const csvWriter = csvWriterModule.createObjectCsvWriter({
        header: headers.map(field => ({id: field, title: field})),
        path: fileName
    });
    const promise = csvWriter.writeRecords(rows);
    promise.then(function () {
        console.log("Written " + rows.length + " lines to CSV file ", fileName);
    });
    return promise;
};
