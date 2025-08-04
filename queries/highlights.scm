(tag) @attribute
(type) @type
(module) @module
(function) @function
(arity) @number

(block_quote
  (quote_marker) @markup.quote
  (quote_content) @markup.raw.block
  (quote_marker) @markup.quote)

(section) @markup.heading
(email_address) @markup.link.email
(macro
  (tag)
  (expression
    (module) @module))

(section
  (section_marker) @_section_marker
  (#eq? @_section_marker "==")) @markup.heading.1
(section
  (section_marker) @_section_marker
  (#eq? @_section_marker "===")) @markup.heading.2
(section
  (section_marker) @_section_marker
  (#eq? @_section_marker "====")) @markup.heading.3

[
  (open_xhtml_tag)
  (close_xhtml_tag)
  (xhtml_tag)
] @tag

(em_xhtml_tag) @markup.strong

(inline_quote) @markup.raw

((macro
  (tag) @attribute
  (#match?  @attribute "\\@[^\\s]+")) @macro)

(external_link
  (link) @string.special.url) @markup.link

((quote_marker) @punctuation.bracket
 (quote_content)
 (quote_marker) @punctuation.bracket)

(language_identifier) @label
