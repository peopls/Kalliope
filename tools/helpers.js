const fs = require('fs');
const entities = require('entities');
const libxml = require('libxmljs');
const bible = require('./bible-abbr.js');

const safeMkdir = dirname => {
  try {
    fs.mkdirSync(dirname);
  } catch (err) {
    if (err.code !== 'EEXIST') throw err;
  }
};

const writeJSON = (filename, data) => {
  const json = JSON.stringify(data, null, 2);
  fs.writeFileSync(filename, json);
};

const loadXMLDoc = filename => {
  if (!fs.existsSync(filename)) {
    return null;
  }
  const data = fs.readFileSync(filename);
  if (data == null) {
    return null;
  }
  try {
    return libxml.parseXmlString(data);
  } catch (err) {
    console.log(`Problem with ${filename}`);
    throw err;
  }
};

const replaceDashes = html => {
  if (html == null) {
    return null;
  }
  return html
    .replace(/ -&nbsp;/g, ' —&nbsp;')
    .replace(/ - /g, ' — ')
    .replace(/>- /g, '>— ')
    .replace(/&nbsp;- /g, '&nbsp;— ')
    .replace(/ -&ldquo;/g, ' —&ldquo;')
    .replace(/ -$/gm, ' —')
    .replace(/ -([\!;\?\.»«,:\n])/g, / —$1/);
};

const htmlToXml = (html, collected) => {
  const regexp = /<xref\s+(digt|poem|keyword|work|bibel|ord)=['"]([^'"]*)['"][^>]*>/;
  let decoded = entities.decodeHTML(
    replaceDashes(
      html
        .replace(/\n *(----*) *\n/g, (match, p1) => {
          return `\n<hr width=${p1.length}/>\n`;
        })
        .replace(/^\n/, '')
        .replace(/^(\d+\.?)\s*\n/gm, '<num>$1</num>')
        .replace(/^(\d+\.?)/gm, '<num>$1</num>')
        .replace(/^\s*(<right>.*)$/gm, '$1')
        .replace(/^\s*(<center>.*)$/gm, '$1')
        .replace(/\n( +)/g, (match, p1) => {
          return '\n' + '&nbsp;'.repeat(p1.length);
        })
        .replace(/\n/g, '<br/>')
        .replace(/,,/g, '&bdquo;')
        .replace(/''/g, '&ldquo;')
    )
  );
  while (decoded.match(regexp)) {
    decoded = decoded.replace(regexp, (_, type, id) => {
      if (type === 'poem') {
        const meta = collected.texts.get(id);
        if (meta == null) {
          const error = `xref dead poem link: ${id}`;
          throw error;
        } else {
          return `<a ${type}="${id}">»${meta.title}«</a>`;
        }
      } else if (type === 'keyword') {
        const meta = collected.keywords.get(id);
        if (meta == null) {
          const error = `xref dead keyword link: ${id}`;
          throw error;
        } else {
          return `<a ${type}="${id}">${meta.title}</a>`;
        }
      } else if (type === 'ord') {
        const meta = collected.dict.get(id);
        if (meta == null) {
          const error = `xref dead dictionary link: ${id}`;
          throw error;
        } else {
          return `<a dict="${id}">${meta.title}</a>`;
        }
      } else if (type === 'bibel') {
        const originalAttribute = `${id}`;
        id = id.replace(/^bibel/, '');
        let verses = id.match(/,(.*)$/);
        if (verses != null) {
          id = id.replace(',' + verses[1], '');
          verses = verses[1];
        }
        let chapter = id.match(/(\d*)$/);
        if (chapter != null) {
          id = id.replace(chapter[1], '');
          chapter = chapter[1];
        } else {
          const error = `xref dead bible link: ${originalAttribute}`;
          throw error;
        }
        const abbr = bible.abbrevations[id];
        if (abbr == null) {
          const error = `xref dead bible link: ${originalAttribute}`;
          throw error;
        } else if (verses == null) {
          return `<a bible="${originalAttribute}">${abbr}${chapter}</a>`;
        } else {
          return `<a bible="${originalAttribute}">${abbr}${chapter},${verses}</a>`;
        }
      }
    });
  }
  return decoded;
};

module.exports = { safeMkdir, writeJSON, loadXMLDoc, htmlToXml, replaceDashes };
