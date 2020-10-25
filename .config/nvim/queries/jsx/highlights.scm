; Intrinsic tag

(jsx_opening_element ("<" @tag.type.delimiter
  (nested_identifier (identifier) @tdd (identifier) @type)))

(jsx_opening_element 
 ((nested_identifier (identifier) @tdd (identifier) @type)
 ">" @tag.type.delimiter))

(jsx_closing_element (["/" "<"] @tag.type.delimiter
(nested_identifier (identifier) @tdd (identifier) @type)))

(jsx_closing_element (
 (nested_identifier (identifier) @tdd (identifier) @type)
 ">" @tag.type.delimiter))

; Handle the dot operator effectively - <My.Component />
(jsx_self_closing_element ((nested_identifier (identifier) @tag (identifier) @type)))

(jsx_opening_element
 "<" @tag.intrinsic.delimiter
 name: ((identifier) @tag
  (#lua-match? @tag "^[a-z]")))
(jsx_opening_element
 name: ((identifier) @tag
  (#lua-match? @tag "^[a-z]"))
 ">" @tag.intrinsic.delimiter)
(jsx_closing_element
 ["/" "<"] @tag.intrinsic.delimiter
 name: ((identifier) @tag
  (#lua-match? @tag "^[a-z]")))
(jsx_closing_element
 name: ((identifier) @tag
  (#lua-match? @tag "^[a-z]"))
 ">" @tag.intrinsic.delimiter)

; Type tag
(jsx_opening_element
 "<" @tag.type.delimiter
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]")))
(jsx_opening_element
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]"))
 ">" @tag.type.delimiter)
(jsx_closing_element
 ["/" "<"] @tag.type.delimiter
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]")))
(jsx_closing_element
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]"))
 ">" @tag.type.delimiter)

(jsx_self_closing_element ["/" "<" ">"] @tag.type.delimiter)

(jsx_self_closing_element 
 ((identifier) @tag.selfclosing
 (#match? @tag.selfclosing "^[a-z]" )))

(jsx_expression ["{" "}"] @jsx_expression.bracket)

; (jsx_attribute
;      (property_identifier)
;      (jsx_expression
;         "{" @jsx_expression.bracket
;         "}" @jsx_expression.bracket))
