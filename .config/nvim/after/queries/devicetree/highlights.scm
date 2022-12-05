;; extends
(reference
  label: (identifier) @property (#eq? @property "kp"))

(reference
  label: (identifier) @variable.builtin (#not-any-of? @variable.builtin "kp" "none" "trans"))

(reference
  label: (identifier) @punctuation.bracket (#any-of? @punctuation.bracket "trans"))
