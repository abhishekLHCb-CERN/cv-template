%% hepcv.cls : classic CV class by Abhishek Bohare (LuaLaTeX or XeLaTeX). MIT licence.
%% Classic-only CV class. Options: variant=postdoc|industry|long|oneside  paper=a4|letter
%%          fontsize=10.5pt|10pt|11pt (default 10.5pt)  lang=british|american  pagebudget=N  font=source|lato|libertinus
%%          LuaLaTeX or XeLaTeX: ats=true|false  icons=true|false  photo=<file>  photosize=<dim>
\RequirePackage{expl3}
\ProvidesExplClass{hepcv}{2026/11/25}{2.0}{HEP CV class}
\RequirePackage{l3keys2e}
\tl_new:N \g_hepcv_variant_tl   \tl_gset:Nn \g_hepcv_variant_tl { postdoc }
\tl_new:N \g_hepcv_theme_tl     \tl_gset:Nn \g_hepcv_theme_tl   { classic }
\tl_new:N \g_hepcv_paper_tl     \tl_gset:Nn \g_hepcv_paper_tl   { a4 }
\tl_new:N \g_hepcv_fontsize_tl  \tl_gset:Nn \g_hepcv_fontsize_tl { 10.5pt }
\tl_new:N \g_hepcv_lang_tl      \tl_gset:Nn \g_hepcv_lang_tl    { british }
\tl_new:N \g_hepcv_font_tl      \tl_gset:Nn \g_hepcv_font_tl    { source }
\bool_new:N \g_hepcv_ats_bool
\bool_new:N \g_hepcv_icons_bool
\tl_new:N \g_hepcv_photo_tl
\tl_new:N \g_hepcv_photosize_tl  \tl_gset:Nn \g_hepcv_photosize_tl { 26mm }
\int_new:N \g_hepcv_pagebudget_int \int_gset:Nn \g_hepcv_pagebudget_int { -1 }
\keys_define:nn { hepcv/class }
  {
    variant    .choices:nn = { postdoc , industry , long , oneside } { \tl_gset_eq:NN \g_hepcv_variant_tl \l_keys_choice_tl } ,
    theme      .choices:nn = { classic }               { \tl_gset_eq:NN \g_hepcv_theme_tl \l_keys_choice_tl } ,
    paper      .choices:nn = { a4 , letter }                         { \tl_gset_eq:NN \g_hepcv_paper_tl \l_keys_choice_tl } ,
    fontsize   .choices:nn = { 10pt , 10.5pt , 11pt }                         { \tl_gset_eq:NN \g_hepcv_fontsize_tl \l_keys_choice_tl } ,
    lang       .choices:nn = { british , american }                  { \tl_gset_eq:NN \g_hepcv_lang_tl \l_keys_choice_tl } ,
    font       .choices:nn = { source , lato , libertinus }          { \tl_gset_eq:NN \g_hepcv_font_tl \l_keys_choice_tl } ,
    ats        .bool_gset:N = \g_hepcv_ats_bool ,
    icons      .bool_gset:N = \g_hepcv_icons_bool ,
    photo      .tl_gset:N   = \g_hepcv_photo_tl ,
    photosize  .tl_gset:N   = \g_hepcv_photosize_tl ,
    pagebudget .int_gset:N = \g_hepcv_pagebudget_int ,
    unknown    .code:n = \msg_warning:nnx { hepcv } { badoption } { \l_keys_key_str }
  }
\msg_new:nnn { hepcv } { badoption } { Unknown~class~option~'#1'. }
\ProcessKeysOptions { hepcv/class }
\msg_new:nnn { hepcv } { needlua }
  { Theme~'classic'~needs~fontspec~and~therefore~LuaLaTeX~or~XeLaTeX.~Compile~with~lualatex~(Overleaf:~Menu~>~Compiler~>~LuaLaTeX)~or~use~theme=navy,~mono~or~sidebar~with~pdfLaTeX. }
\str_if_eq:VnT \g_hepcv_theme_tl { classic }
  { \sys_if_engine_pdftex:T { \msg_fatal:nn { hepcv } { needlua } } }
\int_compare:nT { \g_hepcv_pagebudget_int < 0 }
  {
    \int_gset:Nn \g_hepcv_pagebudget_int
      { \str_case:Vn \g_hepcv_variant_tl { { industry } { 2 } { oneside } { 1 } { postdoc } { 4 } { long } { 0 } } }
  }
\cs_new_protected:Npn \hepcv_loadclass:n #1 { \LoadClass [ #1 ] { article } }
\str_if_eq:VnTF \g_hepcv_fontsize_tl { 11pt }
  { \exp_args:Nx \hepcv_loadclass:n { 11pt , \g_hepcv_paper_tl paper } }
  { \exp_args:Nx \hepcv_loadclass:n { 10pt , \g_hepcv_paper_tl paper } }
%% Type scale (non-classic themes, 10.5 pt option): 8.5 / 9.5 / 10.5 / 12.5 / 14.5 pt, leading 13.6 pt (1.30).
%% Nothing in the document is set below 8.5 pt.  The classic theme scales its own font instead.
\str_if_eq:VnT \g_hepcv_fontsize_tl { 10.5pt }
  {
    \str_if_eq:VnF \g_hepcv_theme_tl { classic }
      {
        \renewcommand \normalsize { \@setfontsize \normalsize { 10.5 } { 13.6 } \let \@listi \@listI }
        \renewcommand \small { \@setfontsize \small { 9.5 } { 12.4 } \let \@listi \@listI }
        \renewcommand \footnotesize { \@setfontsize \footnotesize { 8.5 } { 11 } \let \@listi \@listI }
        \renewcommand \scriptsize { \@setfontsize \scriptsize { 8.5 } { 11 } }
        \renewcommand \tiny { \@setfontsize \tiny { 8.5 } { 11 } }
        \renewcommand \large { \@setfontsize \large { 12.5 } { 15.5 } }
        \renewcommand \Large { \@setfontsize \Large { 14.5 } { 17.5 } }
        \DeclareMathSizes { 10.5 } { 10.5 } { 8.5 } { 8.5 }
        \DeclareMathSizes { 9.5 } { 9.5 } { 8.5 } { 8.5 }
        \DeclareMathSizes { 8.5 } { 8.5 } { 8.5 } { 8.5 }
      }
  }
\cs_gset_nopar:cpn { @classoptionslist } {}

\str_if_eq:VnTF \g_hepcv_theme_tl { classic }
  { \RequirePackage { hepcv-fonts-classic } }
  {
  \RequirePackage [ T1 ] { fontenc }
  \RequirePackage [ utf8 ] { inputenc }
  \str_case:VnF \g_hepcv_font_tl
    {
      { lato }       { \RequirePackage [ default ] { lato } }
      { libertinus } { \RequirePackage { libertinus } }
    }
    { \RequirePackage [ default ] { sourcesanspro } }
  }
\cs_new_protected:Npn \hepcv_babel:n #1 { \RequirePackage [ #1 ] { babel } }
\exp_args:NV \hepcv_babel:n \g_hepcv_lang_tl
\RequirePackage { geometry }
\cs_new_protected:Npn \hepcv_geom:nnnn #1#2#3#4
  { \geometry { top = #1 , bottom = #2 , left = #3 , right = #4 , footskip = 7mm , includefoot = false } }
\str_case:Vn \g_hepcv_variant_tl
  {
    { oneside }  { \hepcv_geom:nnnn { 15mm } { 16mm } { 24.5mm } { 24.5mm } }
    { industry } { \hepcv_geom:nnnn { 15mm } { 17mm } { 24.5mm } { 24.5mm } }
    { postdoc }  { \hepcv_geom:nnnn { 16mm } { 18mm } { 23mm } { 23mm } }
    { long }     { \hepcv_geom:nnnn { 16mm } { 18mm } { 23mm } { 23mm } }
  }
\RequirePackage { hepcv-core }
\cs_new_protected:Npn \hepcv_theme:n #1 { \RequirePackage { hepcv-theme- #1 } }
\exp_args:NV \hepcv_theme:n \g_hepcv_theme_tl
\IfFileExists { hepcv-pubs.sty } { \RequirePackage { hepcv-pubs } } {}
\IfFileExists { hepcv-a11y.sty }
  { \RequirePackage { hepcv-a11y } }
  { \RequirePackage [ hidelinks , unicode ] { hyperref } \input { glyphtounicode } \pdfgentounicode = 1 }
