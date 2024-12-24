# frozen_string_literal: true

# Enable all rules by default
all

# Disable line length
exclude_rule "MD013"

# Disable requiring output after shell commands
exclude_rule "MD014"

# Headers can’t end in the follow punctuation
rule "MD026", punctuation: ",;:"

# Ordered lists should be ascending
rule "MD029", style: "ordered"

# Allow inline HTML
exclude_rule "MD033"

# Disabled because it finds false positives of bare URLs in inline HTML
exclude_rule "MD034"

# TODO: Create rule for space between fence and language
# TODO: Create rule for no front matter `title`
