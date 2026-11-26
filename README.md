# Classic CV template (LaTeX)

Author: Abhishek Bohare.

Source Sans Pro Light, indigo accent, circular photo, icons, date gutter, keyword tags. MIT licence; fonts under the SIL OFL (`fonts/OFL.txt`).

Build: `latexmk main.tex` (LuaLaTeX and biber). Overleaf: upload the folder as a zip, set Compiler to LuaLaTeX.
Edit `main.tex` and `refs.bib`; replace `photo.jpg`. Add `ats=true` to the class options for a plain ATS-safe layout. Entry macros: `\cventry`, `\cvbullets`, `\cvmetric`, `\cvskills`, `\cvsection`.
