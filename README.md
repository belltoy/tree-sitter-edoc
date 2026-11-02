# tree-sitter-edoc

_A tree-sitter grammar for the Erlang documentation generator (edoc) syntax_

### Status

`tree-sitter-edoc` is somewhat complete - it's usable but not very good yet.
Some improvements to do:

* Tags may only start on line beginnings
* Doc tags could parse the subject-line (everything before first `.`)
* Inject Erlang into `@type` and `@spec`? I lean towards no, those should be migrated into `-type` and `-spec` attributes and might be tricky to parse
* Find bugs! :bug:

## Extensions to standard EDoc syntax

This grammar includes the following extensions to the [standard EDoc syntax](https://www.erlang.org/doc/apps/edoc/chapter.html#wiki-notation):

* Single-backtick inline quotes can end with either a single quote or a backtick: both `` `code' `` and `` `code` `` are accepted. Standard EDoc requires a single quote as the closing delimiter. A backtick inside a single-backtick quote therefore ends it in this grammar.
* Code blocks can include a language identifier immediately after the opening triple backticks, followed by a newline. The identifier is exposed for syntax highlighting; blocks still end with three single quotes (`'''`).
* `TODO:` is recognized as a tag, alongside the usual `@name` tags.

These extensions support editor highlighting; they do not add support for these forms to the EDoc documentation generator.

## Changes from upstream tree-sitter-edoc

This fork builds on [the-mikedavis/tree-sitter-edoc](https://github.com/the-mikedavis/tree-sitter-edoc). Compared with upstream commit [`74774af`](https://github.com/the-mikedavis/tree-sitter-edoc/commit/74774af), it includes:

* **Inline quotes:** accepts backtick closing delimiters for single-backtick quotes and exposes inline delimiters and contents as `quote_marker` and `quote_content` nodes.
* **Block quotes:** parses triple-backtick quotes as `block_quote` nodes, including one-line blocks, rather than also treating them as inline quotes.
* **External links:** recognizes bracketed `http`, `https`, `ftp`, and `file` URLs as `external_link` nodes, including optional links in `@author` lines.
* **Parsing fixes:** recognizes lines of five or more hyphens as separators, adjusts XHTML tag and plain-text matching, and fixes braced hexadecimal escapes in quoted atoms.
* **Editor queries:** ships `queries/highlights.scm` and `queries/injections.scm` for highlighting and code block language injection.
* **Parser metadata:** adds `tree-sitter.json` with query paths and regenerates the parser for Tree-sitter ABI 15 (upstream uses ABI 14). The package and parser metadata versions are `0.0.2`.

## How to setup in Neovim

The `edoc` parser is not registered in the default `nvim-treesitter` parser list, so you need to add it manually.

```lua
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').zimbu = {
      install_info = {
        url = 'https://github.com/belltoy/tree-sitter-edoc',
        branch = 'main',
        generate = false,
        generate_from_json = false,
        queries = 'queries',        -- install queries from given directory
      },
    }
  end
})
```

And add `edoc` filetype to your autocmd list to start treesitter highlighting for edoc files:

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = [
    -- other filetypes you want to highlight
    'edoc',
  ],
  callback = function()
    pcall(vim.treesitter.start)
  end
})
```

See [Adding custom languages](https://github.com/nvim-treesitter/nvim-treesitter#adding-custom-languages) for more information.
