; inherits: (jsx)

(jsx_text) @gruvbox.fg2

(named_imports ["{" "}"] @tsx.named_imports.bracket )

(member_expression "?." @gruvbox.red)

(unary_expression "!" @gruvbox.red)

(if_statement
 (statement_block ["{" "}"] @gruvbox.orange))

(return_statement
 (parenthesized_expression ["(" ")"] @gruvbox.red))

(switch_statement
 (switch_body ["{" "}"] @gruvbox.orange))

(for_statement
 (statement_block ["{" "}"] @gruvbox.orange))

(arrow_function "=>"  @gruvbox.yellow)

(arrow_function
 (parenthesized_expression ["(" ")"] @tdc))

(arrow_function
 (statement_block ["{" "}"] @gruvbox.yellow))

(function
 (statement_block ["{" "}"] @gruvbox.yellow))
