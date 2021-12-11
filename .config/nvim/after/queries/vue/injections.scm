; inherits: html_tags

(
  (style_element
    (raw_text) @scss)
)

(
  (script_element
    (raw_text) @typescript)
)

((interpolation
  (raw_text) @typescript))

((directive_attribute
    (quoted_attribute_value
      (attribute_value) @typescript)))

(
  (template_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (text) @pug)
  (#eq? @_lang "pug")
)

(comment) @comment
