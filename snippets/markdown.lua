local markdown_snippets = {
}
local markdown_snippets_auto = {
  s({trig="\\and",wordTrig=false},{
    t("∧"),
  }),s({trig="\\or",wordTrig=false},{
    t("∨"),
  }),s({trig="\\then",wordTrig=false},{
    t("→"),
  }),s({trig="\\not",wordTrig=false},{
    t("¬"),
  }),s({trig="\\nec",wordTrig=false},{
    t("◻"),
  }),s({trig="\\pos",wordTrig=false},{
    t("⋄"),
  }),s({trig="\\tf",wordTrig=false},{
    t("∴"),
  }),s({trig="\\iff",wordTrig=false},{
    t("↔"),
  }),s({trig="\\isnot",wordTrig=false},{
    t("≠"),
  }),
}

return markdown_snippets, markdown_snippets_auto
