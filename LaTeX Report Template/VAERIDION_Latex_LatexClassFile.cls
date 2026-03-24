\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{VAERIDION_Latex_LatexClassFile}[Vaeridion class file]

\newif\if@nativefonts
\DeclareOption{nativefonts}{\@nativefontstrue}
\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[10pt]{book}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
%% English is the default language, but Dutch is used for some sections.
\RequirePackage[ngerman,dutch,english]{babel}
\RequirePackage[en-GB]{datetime2}
\RequirePackage{calc}
\RequirePackage[nooneline,footnotesize,justification=centering]{caption}
%\RequirePackage{chapterbib}
\RequirePackage{etaremune}
\RequirePackage{fancyhdr}
\RequirePackage[flushmargin,hang,perpage]{footmisc}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\ifxetex
    \RequirePackage[xetex]{geometry}
    \RequirePackage[xetex]{graphicx}
    \RequirePackage[xetex]{hyperref}
    \RequirePackage{fontspec}
    \RequirePackage{xltxtra}
    \defaultfontfeatures{Ligatures=TeX}
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
\RequirePackage{lettrine}
\RequirePackage{metalogo}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{tikz}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
%\RequirePackage[nottoc,numbib]{tocbibind}
\RequirePackage[numbib]{tocbibind}

%% If the document is not compiled with XeLaTeX, we need to use the native
%% fonts.
\ifxetex
	\@nativefontsfalse
\else
	\@nativefontstrue
\fi

\if@nativefonts
    %% The native font is Utopia Regular with Fourier math. We use Latin Modern
    %% as a fallback, since Utopia lacks support for sans-serif and monospace.
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{lmodern}
    \RequirePackage{fourier}
    %% The style for titles is small caps.
    \def\titlefont{\rmfamily}
    \def\titleshape{\scshape}
    \def\titlestyle{\titlefont\titleshape\bfseries}
    \if@print
        \def\headerstyle{\titlefont\titleshape\bfseries}
    \else
        \def\headerstyle{\titlefont\titleshape\bfseries}        
    \fi
\else

   
    \fontfamily{Avenir Next LT Pro}\selectfont
    
    \RequirePackage{unicode-math}
    \setmainfont{Avenir Next LT Pro}[
	    BoldFont = {Avenir Next LT Pro Bold},
	    ItalicFont = {Avenir Next LT Pro Italic},
	    BoldItalicFont = {Avenir Next LT Pro Bold Italic},
	    Ligatures=TeX
    ]

        \setsansfont[
    %Path = fonts/,
    %Extension = .ttf,
    %BoldFont = *-Bold,
    %ItalicFont = *,
    %ItalicFeatures = FakeSlant,
    %BoldItalicFont = *-Bold,
    %BoldItalicFeatures = FakeSlant
        Ligatures=TeX,
        BoldFont = {Avenir Next LT Pro Bold}
     ]{Avenir Next LT Pro}
    \setmonofont[
        %Path = fonts/,
        %Extension = .ttf,
        %UprightFont = *MT,
        %BoldFont = *-BoldMT,
        %ItalicFont = *-ItalicMT,
        %BoldItalicFont = *-BoldItalicMT
        BoldFont = Courier New Bold,
        ItalicFont = {Courier New Italic},
        BoldItalicFont = {Courier New Bold Italic}
    ]{Courier New}
    \setmathfont{Cambria Math}
    %\setmathfont[
        %Path = fonts/,
        %Extension = .ttf
    %]{CambriaMathRegular}
    %% The default style for text is Tahoma (sans-serif).
    \renewcommand*\familydefault{\sfdefault}
    %% The default style for titles is Bookman Old Style (serif).
    \def\titlefont{\rmfamily}
    \def\titleshape{}
    \if@print
        %\def\titlestyle{\titlefont\titleshape\bfseries}
        \def\titlestyle{\titlefont\titleshape}
    \else
        \def\titlestyle{\titlefont\titleshape}
%        \def\titlestyle{\titlefont\titleshape\bfseries}
    \fi
    \def\headerstyle{\titlestyle}
\fi

%% Define the TU Delft house style colors.
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

%% Set the paper size to 17 by 24 cm, approximately halfway between A4 and A5.
\if@print
    %% In print mode we add a 3 mm bleed on the outside of the page.
    \geometry{
        papersize = {176mm,246mm},
        layoutsize = {167mm,240mm},
        layoutoffset = {3mm,3mm},
        bindingoffset = -3mm,
    }
\else
    %\geometry{papersize={170mm,240mm}}
	\geometry{papersize={210mm,297mm}}
\fi
%% We decrease the margins slightly from the default (scale = 0.7).
\geometry{hscale=0.78,vscale=0.78}
\setlength{\oddsidemargin}{3pt} 
\setlength{\evensidemargin}{-12pt} 

%% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}
%% Redefine the author command to accept a first and last name, and to add the
%% full name to the PDF meta data.
\renewcommand*\author[2]{%
    \def\@firstname{#1}%
    \def\@lastname{#2}%
    \hypersetup{pdfauthor=#1\ #2}%
}

%% Remove the header and page number on empty pages.
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

\if@print%
    \newcommand*\cropmarks{%
      \ifodd\c@page%
    %        \begin{tikzpicture}[remember picture,overlay]
    %            \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
    %            \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
    %           \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
    %            \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);
    %        \end{tikzpicture}%
    %        \begin{tikzpicture}[remember picture,overlay]
    %            \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
    %            \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
    %            \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
    %            \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
    %        \end{tikzpicture}%
       \else%
    %        \begin{tikzpicture}[remember picture,overlay]
    %            \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
    %            \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
    %            \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
    %            \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);

    %           \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
    %            \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
    %            \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
    %            \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
    %        \end{tikzpicture}%
        \fi%
    }
\else
    \newcommand*\cropmarks{}
\fi%

%%% Thumb indices consist of white text on a rectangular colored background. The
%%% font-size is 75% of the size of thumb height.
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

%% We need the TikZ library calc to calculate the coordinates of the thumb
%% indices.
\usetikzlibrary{calc}

%% The lthumb command prints the current chapter number in a thumb index on the
%% left (even) page.
\newcommand*\lthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (left margin) at (1in+\evensidemargin+15pt,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top left) at ($(current page.north west)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom right) at ($(top left)+(left margin)-(\thumbhspace,\thumbheight)$);
            %% Shift the left edge to prevent the rounded corner from showing.
            \coordinate (top left) at ($(top left)-(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=thumb,rounded corners=\thumbedge](top left) rectangle (bottom right);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center right) at ($(bottom right)+(0pt,0.5\thumbheight)$);
            \node at (center right)[anchor=east,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{tudelft-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% rthumb draws a thumb index on the right (odd) page.
\newcommand*\rthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (right margin) at (1in+\evensidemargin+15pt,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top right) at ($(current page.north east)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom left) at ($(top right)-(right margin)-(-\thumbhspace,\thumbheight)$);
            %% Shift the left right to prevent the rounded corner from showing.
            \coordinate (top right) at ($(top right)+(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=thumb,rounded corners=\thumbedge](top right) rectangle (bottom left);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center left) at ($(bottom left)+(0pt,0.5\thumbheight)$);
            \node at (center left)[anchor=west,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{tudelft-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% DATE FORMATS
% Set command to change \today 
\renewcommand{\today}{%
	\ifnum\day<10 0\fi\the\day\space%
	\ifcase\month
	\or Jan.\or Feb.\or Mar.\or Apr.\or May.\or Jun.%
	\or Jul.\or Aug.\or Sep.\or Oct.\or Nov.\or Dec.%
	\fi\space\the\year}
%Define new format
\newcommand{\formatdate}[3]{%
	\ifnum#1<10 0\fi#1\space%
	\ifcase#2
	\or Jan.\or Feb.\or Mar.\or Apr.\or May.\or Jun.%
	\or Jul.\or Aug.\or Sep.\or Oct.\or Nov.\or Dec.%
	\fi\space#3%
}

%% Page style for empty pages.
\fancypagestyle{empty}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyhead{\cropmarks}
    \fancyhead[LE,LO]{ 
    	\mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    	\makecell[cl]{ \\[2pt] } \\[-9pt]
    }
       \fancyhead[C]{\titlefont \documentNumber{}  \\ \documentType{} \\ \@title}
    \fancyhead[RO]{\cropmarks\rthumb\titlefont Revision: \revisionNumber \\ \today \\ Page: \thepage {} of \pageref{LastPage}}
    \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}

%% Fancy style for the main matter.
\fancypagestyle{veryempty}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    %% Page numbers on the top left and top right.
    \fancyhead[LE,LO]{ 
    	\mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
    	\makecell[cl]{ \\[2pt] } \\[-9pt]
    }
    \fancyhead[RO]{\titlefont Page: \thepage {} of \pageref{LastPage}}
    %% Chapter name on the left (even) page.
    \fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}
    %% Section name on the right (odd) page.
    \fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}
%page numbers in footer
    \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
  }

%% Page style for title pages.
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\footrulewidth}{0.0pt}% Line at the footer visible
    \renewcommand*\headrulewidth{0pt}
    %% Page numbers on the top left and top right.
   %\fancyhead[LE]{\cropmarks\lthumb\titlefont}
   \fancyhead[LE,LO]{ 
   	\mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
   	\makecell[cl]{ \\[2pt] } \\[-9pt]
   }
   \fancyhead[C]{\titlefont \documentNumber{} \\ \documentType{} \\ \@title}
   \fancyhead[RO]{\cropmarks\titlefont Revision: \revisionNumber \\ \today \\ Page: \thepage {} of \pageref{LastPage}}
   %% Chapter name on the left (even) page.
   %\fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}
   %% Section name on the right (odd) page.
  % \fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}
%page numbers in footer
    \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
}

%% Fancy style for the main matter.
\fancypagestyle{mainmatter}{%
    \fancyhf{}
        \renewcommand{\footrulewidth}{0.0pt}% Line at the footer visible
    \renewcommand*\headrulewidth{0pt}
\fancyhead[LE,LO]{ 
	\mbox{\makecell[cl]{\includegraphics[height=30pt]{figures/VAERIDION Logo gray}}}
	\makecell[cl]{ \\[2pt] } \\[-9pt]
}
   
    %% Page numbers on the top left and top right.
    %\fancyhead[LE]{\cropmarks\lthumb\titlefont}
    \fancyhead[C]{\titlefont \documentNumber{} \\ \documentType{} \\ \@title}
    \fancyhead[RO]{\cropmarks\titlefont Revision: \revisionNumber \\ \today \\ Page: \thepage {} of \pageref{LastPage}}
    %% Chapter name on the left (even) page.
    %\fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}
    %% Section name on the right (odd) page.
    %\fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}
%page numbers in footer
    \fancyfoot[C]{\titlefont\scriptsize{The information contained in this document is confidential, privileged and only for the information of the intended recipient. \\ This document shall not be reproduced or disclosed to a third party without the express written consent of Vaeridion GmbH.}}
  }

%% The mainmatter style is default for normal pages.
\pagestyle{mainmatter}

%% Print the current chapter and section at the top of the page 
\renewcommand*\chaptermark[1]{\markboth{\thechapter.\ \color{title}#1}{}}
\renewcommand*\sectionmark[1]{\markright{\thesection.\ \color{title}#1}}

%% The setheader command can be used to print the title of unnumbered chapters
%% in the page header.
\newcommand*\setheader[1]{\markboth{\color{title}#1}{\color{title}#1}}

%% Change the headrule command (from fancyhdr.sty) to draw the line below the
%% header in the title color.
%\renewcommand*\headrule{%
 %   \if@fancyplain%
  %      \let\headrulewidth\plainheadrulewidth%
  %  \fi%
   % {\color{title}\hrule\@height\headrulewidth\@width\headwidth}%
    %\vskip-\headrulewidth%
	%				}

%% Draw the line above a footnote in the title color as well.
\renewcommand*\footnoterule{%
    \vspace*{-3pt}%
    {\color{title}\hrule width 0.5\textwidth height 0.4pt}%
    \vspace*{2.6pt}%
}

%----------- Table of contents formatting
\setlocalecaption{english}{contents}{Table of Contents}
%-----------------------------------

%% A part title starts with a huge (96pt) bold black number, flushed to the
%% right, followed by the part name on the next line in the title color.
\titleformat{\part}[display]
    {\flushleft\titlestyle}
    {\fontsize{40pt}{40pt}\selectfont\bfseries\thepart}
    {0pt}
    {\LARGE\color{title}}
%% Separate the title from the text by two empty lines.
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, the part name is preceded by an empty line, printed
%% in bold, and not followed by a line of dots.
%\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont\bfseries}{1.5em}{0pc}
\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont}{1.5em}{0pc}
%% Chapter titles have the same layout as parts.
\titleformat{\chapter}[block]
    {\LARGE\titlestyle}
%        {\Large\headerstyle} %ADDED
%    {\fontsize{40pt}{40pt}\selectfont\bfseries\thechapter}
     %   {\fontsize{40pt}{40pt}\selectfont\thechapter}
    %{0pt}
    %{\LARGE\color{title}}
     {\color{title}\selectfont\thechapter}
%     {\LARGE\selectfont\thechapter}
    {5pt}{\color{title}}
    
    
\titlespacing{\chapter}{0pt}{0pt}{1\baselineskip}
%% In the table of contents, a chapter is similar to a part, except that it is
%% preceded by half an empty line.
%\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\titlefont\bfseries}{1.5em}{0pc}
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\color{black}}{1.5em}{3pt}
%% Section titles start with the number in bold, followed by the name printed
%% in the title color.
\titleformat{\section}
    {\Large\headerstyle}
    {\thesection\ }
     %   {\bfseries\thesection.\ }
    {5pt}
    {\color{title}}
%% Sections are preceded by an empty line.
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
%% In the table of contents, section names are followed by a line of dots 8pt
%% apart.
\dottedcontents{section}[3.8em]{\titlefont}{2.3em}{3pt}

%% Subsection titles have the same layout as section titles, except in a smaller
%% font.
\titleformat{\subsection}
    {\large\headerstyle}
%    {\bfseries\thesubsection.\ }
        {\thesubsection\ }
    {5pt}
    {\color{title}}
\titlespacing{\subsection}{0pt}{\baselineskip}{0pt}
\dottedcontents{subsection}[7em]{\titlefont}{3.2em}{3pt}

%% Subsubsections have the same font and color as sections and subsections, but
%% are not preceded by a number.
\titleformat{\subsubsection}
    {\headerstyle}
    {}
    {0pt}
    {\color{title}}
%% Subsubsections are preceded by an empty line and do not appear in the table
%% of contents.
\titlespacing{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Color the bullets of the itemize environment and make the symbol of the third
%% level a diamond instead of an asterisk.
\renewcommand*\labelitemi{\color{title}\textbullet}
\renewcommand*\labelitemii{\color{title}--}
\renewcommand*\labelitemiii{\color{title}$\diamond$}
\renewcommand*\labelitemiv{\color{title}\textperiodcentered}

%% The dedication is vertically centered on a separate page and flushed to the
%% right.
\newcommand\dedication[1]{%
    %\thispagestyle{empty}%
    \vspace*{\fill}%
    \begin{flushright}%
        #1%
    \end{flushright}%
    \vspace*{\fill}%
    \cleardoublepage%
}

%% Define an unnumbered footnote command.
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

%% The authors environment is used to display the authors of a chapter on the
%% title page. This is only necessary if multiple people contributed
%% significantly to the chapter.
\newcommand*\authors[1]{%
    \begin{center}%
        {\Large\bfseries #1}%
    \end{center}%
    \vspace{2\baselineskip}%
}

%% The epigraph environment can be used to to add a quote to the title page of
%% a chapter.
\newcommand\epigraph[3][2\baselineskip]{%
    \begin{flushright}%
        {\rmfamily\itshape #2}%
        \vskip 0.5\baselineskip%
        #3%
    \end{flushright}%
    \vspace{#1}%
}

%% The abstract environment is used for the abstract of a chapter.
\newenvironment{abstract}{%
    \list{}{\leftmargin\rightmargin}%
    \item%
    \relax%
    \rmfamily\itshape%
}{%
    \endlist%
}

%% Define a drop command which can be used to generate drop caps at the
%% beginning of a section.
\renewcommand*\LettrineTextFont{\titleshape}
\newcommand*\dropcap[2]{
    \lettrine[lines=2,findent=0.2em,nindent=0pt]{\color{title} #1}{#2}%
}

%% Create an unnumbered reference section.
%\addto\captionsenglish{\renewcommand*\bibname{\color{title}References}}
\addto\captionsenglish{\renewcommand*\bibname{References}}
%\newcommand*\references[1]{%
%\bibliographystyle{VAERIDION_Latex_bibliography_style}
%\bibliography{#1}%
%}

%% Hyperlinks are cyan, except in print mode, when they are all black.
\hypersetup{
    colorlinks = true,
    citecolor = title,
    linkcolor = title,
    urlcolor = title
}

