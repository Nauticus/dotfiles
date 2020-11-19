; Inherits: (jsx),javascript
(call_expression
 (identifier) @gruvbox.aqua)

(named_imports ["{" "}"] @tsx.named_imports.bracket )

(member_expression "?." @gruvbox.aqua)

(unary_expression "!" @gruvbox.blue)

(if_statement
 (statement_block ["{" "}"] @gruvbox.orange))

(if_statement
 (parenthesized_expression ["(" ")"] @gruvbox.orange))

(return_statement
 (parenthesized_expression ["(" ")"] @gruvbox.red))

(switch_statement
 (switch_body ["{" "}"] @gruvbox.orange))

(switch_statement
 (parenthesized_expression ["(" ")"] @gruvbox.orange))

(for_statement
 (statement_block ["{" "}"] @gruvbox.orange))

(try_statement 
 (statement_block ["{" "}"] @gruvbox.red))

(call_expression
 (arguments ["(" ")"] @gruvbox.fg2))

(catch_clause
 (statement_block ["{" "}"] @gruvbox.red))

(arrow_function "=>"  @gruvbox.yellow)

(arrow_function
 (parenthesized_expression ["(" ")"] @tdc))

(arrow_function 
 (formal_parameters ["(" ")"] @gruvbox.yellow))

(arrow_function
 (statement_block ["{" "}"] @gruvbox.yellow))

(function
 (statement_block ["{" "}"] @gruvbox.yellow))

; Intrinsic tag

(jsx_opening_element (nested_identifier "." @gruvbox.orange))
(jsx_closing_element (nested_identifier "." @gruvbox.orange))
(jsx_self_closing_element (nested_identifier "." @gruvbox.orange))

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
(jsx_self_closing_element ((nested_identifier (identifier) @tdd (identifier) @type)))

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
 ["<" "/"] @tag.type.delimiter
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]")))

(jsx_closing_element
 name: ((identifier) @type
  (#lua-match? @type "^[A-Z]"))
   ">" @tag.type.delimiter)

(jsx_self_closing_element ["/" "<" ">"] @tag.type.delimiter)

(jsx_self_closing_element "<" @gruvbox.blue ((identifier) @tag.selfclosing (#match? @tag.selfclosing "^[a-z]+$" )))

(jsx_self_closing_element ((identifier) @tag.selfclosing (#match? @tag.selfclosing "^[a-z]+$" )) ["/" ">"] @gruvbox.blue)

(jsx_self_closing_element 
 ((identifier) @tag.selfclosing
 (#match? @tag.selfclosing "^[a-z]+$" )))

