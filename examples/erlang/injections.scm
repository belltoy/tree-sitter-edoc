;; extends

((comment) @injection.content
          (#set! injection.language "edoc")
          (#match? @injection.content "^\\s*\\%+.*")
          (#mytrim! @injection.content "^%s*[%%][%%]*%s*")
          (#set! "priority" 101))
