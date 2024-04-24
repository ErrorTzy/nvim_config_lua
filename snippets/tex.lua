local line_begin = require("luasnip.extras.expand_conditions").line_begin

local latex_snippets = {

  --markdown

  s("*",
  fmta([[
    \textit{<>}
  ]],{i(1),})
  ),s("**",
  fmta([[
    \textbf{<>}
  ]],{i(1),})
  ),


  -- documentclass

  s("a",
  fmta([[
    \documentclass{article}
    % packages
    
    % info
    \author{}
    \title{}
    
    \begin{document}
    \maketitle{}
    <>
    \end{document}
  ]],{i(1),}),{condition = line_begin}
  ),s("b",
  fmta([[
    \documentclass{beamer}
    \usetheme{SimplePlus}
    
    \title{}
    \author{}
    
    \begin{document}
    
    \begin{frame}
    \titlepage{}
    \end{frame}
    
    \begin{frame}{Overview}
    \tableofcontents
    \end{frame}
    
    \section{First Section}
    \begin{frame}{Title}
    <>
    \end{frame}
    
    \end{document}
  ]],{i(1),}),{condition = line_begin}
  ),

  -- enviornments

  s("figure",
  fmta([[
    \begin{figure}[h]
    \centering
    <>
    \caption{<>}
    \label{<>}
    \end{figure}
  ]],{i(1),i(2),i(3)}),{condition = line_begin}
  ),s("include",
  fmta([[
    \includegraphics[width=\textwidth]{<>}
  ]],{i(1),})
  ),s(
    "bib",
    {
      t({
        "\\usepackage[style=apa,backend=biber,doi=false,isbn=false,url=false,eprint=false]{biblatex}",
        "\\DeclareLanguageMapping{english}{american-apa}",
        "\\addbibresource{/home/scott/Documents/WorkingFiles/writings/.resources/biblatex.bib}"
      }),
    },
    {condition = line_begin}
  ),

}

local latex_auto_snippets = {

  -- markdown

  s("# ",
  fmta([[
    \section{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("## ",
  fmta([[
    \subsection{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("### ",
  fmta([[
    \subsubsection{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("#### ",
  fmta([[
    \subsubsubsection{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("##### ",
  fmta([[
    \paragraph{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("###### ",
  fmta([[
    \subparagraph{<>}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("- ",
  fmta([[
    \begin{itemize}
    \item <>
    \end{itemize}
  ]],{i(1),}),
  {condition = line_begin}
  ),s("1. ",
  fmta([[
    \begin{enumerate}
    \item <>
    \end{enumerate}
  ]],{i(1),}),
  {condition = line_begin}
  ),

  -- handy command

  s("uu",
  fmta([[
    \usepackage{<>}
  ]],{i(1),}),{condition = line_begin}
  ),s("...",{
    t("\\dots"),
  }),

}

return latex_snippets, latex_auto_snippets

