# Show tab-completion options on first <tab> instead of waiting
# for multiple completions.
set show-all-if-ambiguous on

# Case insensitive tab-completion
set completion-ignore-case on

$if Bash
  # In bash only, enable "magic space" so that typing space
  # will show completions. i.e. !!_ (where _ is space)
  # will expand !! for you.
  Space: magic-space
$endif