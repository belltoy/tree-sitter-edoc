(block_quote
  (quote_marker)
  (quote_content) @injection.content
  (quote_marker)
  (#set! injection.language "erlang"))

(block_quote
  (quote_marker)
  language: (language_identifier) @injection.language
  (quote_content) @injection.content
  (quote_marker))
