/** @type {import('@vivliostyle/cli').VivliostyleConfigSchema} */
module.exports = {
  title: 'Example of Table of Contents',
  author: 'spring-raining',
  language: 'en',
  size: 'A5',
  entry: [
    './manuscript/frontmatter.html',
    {
      path: 'toccy-template.html',
      output: 'index.html',
      rel: 'contents'
    },
    './manuscript/01_Computing Paradigms.html',
    './manuscript/02_Algorithm Design and Analysis.html',
    './manuscript/03_Systems and Architecture.html',
  ],
  output: 'draft.pdf',
  toc: {
    title: 'Table of My Contents',
    htmlPath: 'toc.html',
    sectionDepth: 1,
  },
};
