# delay fiction dot org

a magazine, for stories

## building the website

run `src/script` to build with the expectation of publication. add `local` to build for local testing.

to publish, push it to the master branch on github. we're not as sophisticated operationally as our sophisticated literary taste would lead you to believe.

#t stories

add stories as markdown files in the directory `src/data/posts/<the-issue>/`. stories require a few metadata fields to work right:

```
issue: YYYY-MM
title: 'The Title'
author: Author Person
tag: the type of work this is
opener: 'The first sentence from the short story.'
issue_order: 1
```

should be pretty self-explanatory. the art will need to be named the same slug as the .md file.

## issues

issues are empty .md files with a small amount of yaml frontmatter, named in the format `YYYY-MM.md`. they go in `src/data/issues/`. issues just require a title and a description. like stories, the art needs to be named the same slug as their .md file.

## volumes

at the moment, volumes just require a .md file named `YYYY.md` in `src/data/volumes/` with a title. volumes don't have art.

## static pages

static pages are .md files in `src/data/static/`. static pages can have content in the actual markdown file. they only require a title.
