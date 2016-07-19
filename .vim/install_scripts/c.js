/**
 * XadillaX created at 2016-07-13 14:39:36 With ♥
 *
 * Copyright (c) 2016 Souche.com, all rights
 * reserved.
 */
"use strict";

const fs = require("fs");
const path = require("path");

const filename = path.join(__dirname, "../bundle/c.vim/c-support/templates/Templates");

let template = fs.readFileSync(filename, "utf8");

const AUTHOR = "XadillaX";
const AUTHORREF = "zkd";
const COMPANY = "Souche Inc. CHINA";
const COPYRIGHT = "Copyright (c) |YEAR|, |AUTHOR|";
const EMAIL = "i@2333.moe";
const ORGANIZATION = "Design & Development Center, |COMPANY|";

template = template.replace(/'AUTHOR',\s*'.*'/, `'AUTHOR', '${AUTHOR}'`)
    .replace(/'AUTHORREF',\s*'.*'/, `'AUTHORREF', '${AUTHORREF}'`)
    .replace(/'COMPANY',\s*'.*'/, `'COMPANY', '${COMPANY}'`)
    .replace(/'COPYRIGHT',\s*'.*'/, `'COPYRIGHT', '${COPYRIGHT}'`)
    .replace(/'EMAIL',\s*'.*'/, `'EMAIL', '${EMAIL}'`)
    .replace(/'ORGANIZATION',\s*'.*'/, `'ORGANIZATION', '${ORGANIZATION}'`);

fs.writeFileSync(filename, template, "utf8");
