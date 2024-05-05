local markdown_snippets = {
}
local markdown_snippets_auto = {
  s("\\and",{
    t("∧"),
  }),s("\\or",{
    t("∨"),
  }),s("\\then",{
    t("→"),
  }),s("\\not",{
    t("¬"),
  }),s("\\nec",{
    t("◻"),
  }),s("\\pos",{
    t("⋄"),
  }),s("\\tf",{
    t("∴"),
  }),s("\\iff",{
    t("↔"),
  }),s("\\isnot",{
    t("≠"),
  }),
}

return markdown_snippets, markdown_snippets_auto
