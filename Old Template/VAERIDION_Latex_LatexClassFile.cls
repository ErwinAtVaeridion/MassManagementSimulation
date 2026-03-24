
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{VAERIDION_Latex_LatexClassFile}[Vaeridion class file]

% ----- Options -----
\newif\if@nativefonts
\DeclareOption{nativefonts}{\@nativefontstrue}
\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[10pt]{book}

% ----- Core packages -----
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% Languages / dates / misc
\RequirePackage[ngerman,dutch,english]{babel}
\RequirePackage[en-GB]{datetime2}
\RequirePackage{calc}
\RequirePackage[nooneline,footnotesize,justification=centering]{caption}
\RequirePackage{etaremune}
\RequirePackage{fancyhdr}
\RequirePackage[flushmargin,hang,perpage]{footmisc}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}

% ----- Drivers and color -----
\ifxetex
  \RequirePackage[xetex]{geometry}
  \RequirePackage[xetex]{graphicx}
  \RequirePackage[xetex]{hyperref}
  % No fontspec / xltxtra / unicode-math: we stick to TeX defaults
  \RequirePackage[cmyk,table]{xcolor}
\else
  \RequirePackage[cmyk,pdftex,table]{xcolor}
  \ifpdf
    \RequirePackage[pdftex]{geometry}
    \RequirePackage[pdftex]{graphicx}
    \RequirePackage[pdftex]{hyperref}
  \else
    \RequirePackage[dvips]{geometry}
    \RequirePackage[dvips]{graphicx}
    \RequirePackage[hypertex]{hyperref}
  \fi
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
\fi

% Keep Latin Modern/CM only; no external fonts
\RequirePackage{lmodern}

% Document-level styling packages (unchanged)
\RequirePackage{lettrine}
\RequirePackage{metalogo}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{tikz}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[numbib]{tocbibind}

% ----- Font policy (simple defaults only) -----
% If compiled with XeLaTeX, do NOT force system fonts; use TeX defaults (LM/CM).
% If compiled with pdfLaTeX, T1+utf8+lmodern already set above.
% We keep headings macros as in your template.
\ifxetex
  \@nativefontsfalse
\else
  \@nativefontstrue
\fi

\if@nativefonts
  % pdfLaTeX path: Latin Modern + default Computer Modern math
  % (no 'fourier' / Utopia; keep it minimal)
  \def\titlefont{\rmfamily}
  \def\titleshape{\scshape}
  \def\titlestyle{\titlefont\titleshape\bfseries}
  \if@print
    \def\headerstyle{\titlefont\titleshape\bfseries}
  \else
    \def\headerstyle{\titlefont\titleshape\bfseries}
  \fi
\else
  % XeLaTeX path: keep plain TeX defaults (LM/CM)
  \def\titlefont{\rmfamily}
  \def\titleshape{}
  \def\titlestyle{\titlefont\titleshape}
  \def\headerstyle{\titlestyle}
  % If you prefer sans-serif body text, uncomment:
  % \renewcommand*\familydefault{\sfdefault}
\fi

% ----- Colors (unchanged) -----
\definecolor{tudelft-black}{cmyk}{0,0,0,1}
\definecolor{tudelft-white}{cmyk}{0,0,0,0}
\definecolor{anthracite}{cmyk}{0,0,0,0.8}
\definecolor{vaeridionblue}{cmyk}{1,0.6,0.1,0.7}

\if@print
  \colorlet{title}{black}
\else
  \colorlet{title}{vaeridionblue}
\fi
\colorlet{thumb}{anthracite}

% ----- Page geometry (unchanged) -----
\if@print
  \geometry{
    papersize = {176mm,246mm},
    layoutsize = {167mm,240mm},
    layoutoffset = {3mm,3mm},
    bindingoffset = -3mm,
  }
\else
  % \geometry{papersize={170mm,240mm}}
  \geometry{papersize={210mm,297mm}}
\fi
\geometry{hscale=0.78,vscale=0.78}
\setlength{\oddsidemargin}{3pt}
\setlength{\evensidemargin}{-12pt}

% ----- Title/author redefinitions (unchanged) -----
\renewcommand*\title[2][]{%
  \def\@subtitle{#1}%
  \def\@title{#2}%
  \hypersetup{pdftitle=#2}%
}
\renewcommand*\author[2]{%
  \def\@firstname{#1}%
  \def\@lastname{#2}%
  \hypersetup{pdfauthor=#1\ #2}%
}

% ----- clearpage handling (unchanged) -----
\def\cleardoublepage{%
  \clearpage%
  \if@twoside%
    \ifodd\c@page%
    \else%
      % \thispagestyle{empty}%
      \vspace*{\fill}%
      \newpage%
    \fi%
  \fi%
}

% ----- Thumb indices, styles, headers/footers (unchanged from your file) -----
% (All your fancyhdr, thumb, titlesec/titletoc formatting follows unchanged.)
% --- Start of your original styling content ---

\newcommand*{\cropmarks}{}
\newif\ifthumb
\newlength\thumbheight
\setlength\thumbheight{24pt}
\newlength\thumbedge
\setlength\thumbedge{4pt}
\newlength\thumbhspace
\setlength\thumbhspace{36pt}
\newlength\thumbvspace
\setlength\thumbvspace{2\thumbheight}
\newlength\thumbwidth
\setlength\thumbwidth{36pt}
\newlength\thumbspacing
\setlength\thumbspacing{2\thumbheight}

\usetikzlibrary{calc}

% (All your existing \fancypagestyle{empty|veryempty|plain|mainmatter} blocks,
% title/section/subsection formats, bullets, epigraph/abstract/dropcap,
% references label, hyperref colors, etc., are copied from your class as-is.)

% ----------------- BEGIN: copied unchanged styling from your class -----------------
\fancypagestyle{empty}{%
  \fancyhf{}
  \renewcommand*{\headrulewidth}{0pt}
  \renewcommand*{\footrulewidth}{0pt}
  \fancyhead{\cropmarks}
  \fancyhead[LE,LO]{%
    \mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    \makecell[cl]{ \\[2pt] } \\[-9pt]
  }
  \fancyhead[C]{\@title}
  \fancyhead[RO]{\cropmarks\titlefont \today \\ Page: \thepage {} of \pageref{LastPage}}
  \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}

\fancypagestyle{veryempty}{%
  \fancyhf{}
  \renewcommand*{\headrulewidth}{0pt}
  \fancyhead[LE,LO]{%
    \mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    \makecell[cl]{ \\[2pt] } \\[-9pt]
  }
  \fancyhead[RO]{\titlefont Page: \thepage {} of \pageref{LastPage}}
  \fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}
  \fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}
  \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}

\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\footrulewidth}{0.0pt}%
  \renewcommand*{\headrulewidth}{0pt}
  \fancyhead[LE,LO]{%
    \mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    \makecell[cl]{ \\[2pt] } \\[-9pt]
  }
  \fancyhead[C]{\titlefont \@title}
  \fancyhead[RO]{\cropmarks \titlefont \today \\ Page: \thepage {} of \pageref{LastPage}}
  \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}

\fancypagestyle{mainmatter}{%
  \fancyhf{}
  \renewcommand{\footrulewidth}{0.0pt}%
  \renewcommand*{\headrulewidth}{0pt}
  \fancyhead[LE,LO]{%
    \mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    \makecell[cl]{ \\[2pt] } \\[-9pt]
  }
  \fancyhead[C]{\titlefont \@title}
  \fancyhead[RO]{\cropmarks\titlefont \today \\ Page: \thepage {} of \pageref{LastPage}}
  \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}
\pagestyle{mainmatter}

\renewcommand*\chaptermark[1]{\markboth{\thechapter.\ \color{title}#1}{}}
\renewcommand*\sectionmark[1]{\markright{\thesection.\ \color{title}#1}}
\newcommand*\setheader[1]{\markboth{\color{title}#1}{\color{title}#1}}

\renewcommand*{\footnoterule}{%
  \vspace*{-3pt}%
  {\color{title}\hrule width 0.5\textwidth height 0.4pt}%
  \vspace*{2.6pt}%
}

\setlocalecaption{english}{contents}{Table of Contents}

\titleformat{\part}[display]
  {\flushleft\titlestyle}
  {\fontsize{40pt}{40pt}\selectfont\bfseries\thepart}
  {0pt}
  {\LARGE\color{title}}
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont}{1.5em}{0pc}

\titleformat{\chapter}[block]
  {\LARGE\titlestyle}
  {\color{title}\selectfont\thechapter}
  {5pt}{\color{title}}
\titlespacing{\chapter}{0pt}{0pt}{1\baselineskip}
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\color{black}}{1.5em}{3pt}

\titleformat{\section}
  {\Large\headerstyle}
  {\thesection\ }
  {5pt}
  {\color{title}}
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
\dottedcontents{section}[3.8em]{\titlefont}{2.3em}{3pt}

\titleformat{\subsection}
  {\large\headerstyle}
  {\thesubsection\ }
  {5pt}
  {\color{title}}
\titlespacing{\subsection}{0pt}{\baselineskip}{0pt}
\dottedcontents{subsection}[7em]{\titlefont}{3.2em}{3pt}

\renewcommand*\labelitemi{\color{title}\textbullet}
\renewcommand*\labelitemii{\color{title}--}
\renewcommand*\labelitemiii{\color{title}$\diamond$}
\renewcommand*\labelitemiv{\color{title}\textperiodcentered}

\newcommand\dedication[1]{%
  \vspace*{\fill}%
  \begin{flushright}%
    {\rmfamily\itshape #1}%
  \end{flushright}%
  \vspace*{\fill}%
  \cleardoublepage%
}

\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

\newcommand*\authors[1]{%
  \begin{center}{\Large\bfseries #1}\end{center}%
  \vspace{2\baselineskip}%
}

\newcommand\epigraph[3][2\baselineskip]{%
  \begin{flushright}%
    {\rmfamily\itshape #2}%
    \vskip 0.5\baselineskip%
    #3%
  \end{flushright}%
  \vspace{#1}%
}

\newenvironment{abstract}{%
  \list{}{\leftmargin\rightmargin}%
  \item\relax%
  \rmfamily\itshape%
}{\endlist}

\renewcommand*\LettrineTextFont{\titleshape}
\newcommand*\dropcap[2]{%
  \lettrine[lines=2,findent=0.2em,nindent=0pt]{\color{title} #1}{#2}%
}

\addto\captionsenglish{\renewcommand*\bibname{References}}

\hypersetup{
  colorlinks = true,
  citecolor = title,
  linkcolor = title,
  urlcolor = title
}

