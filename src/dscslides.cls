% dscslides.cls
%
% author: Justin Eldridge
% email: jeldridge@ucsd.edu
%
% A wrapper around Beamer for creating lecture slides in DSC classes @ UCSD.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dscslides}

% handout option definition ============================================================

% the ifhandout boolean controls whether or not the handout option is passed
% to Beamer, and whether frame numbers are used.
%
% the ifhandout boolean can be set to true by defining a handout variable;
% if that variable is defined, ifhandout is set to true.
%
% because variables can be defined using the `usepretex` argument of most
% latex compilers, this provides a way of setting of determining whether the
% slides are built as handouts or not at compiled time.

\newif\ifhandout

\ifcsname handout\endcsname
    \handouttrue
    \PassOptionsToClass{handout}{beamer}
\else
    \handoutfalse
\fi

% packages =============================================================================

\LoadClass[aspectratio=169, 14pt]{beamer}

\RequirePackage{tikz}
\RequirePackage{enumitem}
\RequirePackage{tcolorbox}

% fonts ================================================================================

\RequirePackage[sfdefault,lining,semibold,book]{FiraSans}
\RequirePackage[medium,scale=.925]{FiraMono}
\RequirePackage[mathrm=sym]{unicode-math}
\RequirePackage[usefilenames]{firamath-otf}

% fira's vdots are broken, see:
% https://tex.stackexchange.com/questions/540732/vdots-missing-in-fira-math
% the fix is to use DejaVu Sans Math for vdots
\setmathfont{texgyredejavu-math.otf}[range={\vdots,\ddots}]

\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

% beamer styling =======================================================================

\setbeamersize{text margin left=.75in}
\setbeamersize{text margin right=.75in}

% no navigation symbols
\setbeamertemplate{navigation symbols}{}

\setbeamercolor{structure}{fg=faded}

\setbeamertemplate{itemize item}[triangle]
\setitemize{label=\usebeamerfont*{itemize item}%
  \usebeamercolor[fg]{itemize item}
  \usebeamertemplate{itemize item},
  itemsep=1.5em
}

\setenumerate[1]{label=\usebeamerfont*{itemize item}\color{black!20}\arabic*.,itemsep=1.5em}

\setbeamercolor{alerted text}{fg=pastelred}

\setbeamerfont*{block title}{family=\sffamily,series=\bf}
\setbeamercolor*{block title}{use=structure, fg=black}
\setbeamercolor*{block title example}{use=structure, fg=black}
\setbeamercolor*{local structure}{fg=black!20}

% if this is a handout, show frame numbers in bottom right
\ifhandout
    \setbeamertemplate{footline}[frame number]
\fi

% color definitions ====================================================================

\definecolor{pastelred}{HTML}{d20000}
\definecolor{pastelblue}{HTML}{007aff}
\definecolor{pastelpurple}{HTML}{6E66BA}
\definecolor{pastelyellow}{HTML}{FBC05E}
\definecolor{pastelgreen}{HTML}{8fc34f}
\definecolor{darkblue}{rgb}{0,0,.5}
\definecolor{darkgreen}{HTML}{007355}
\definecolor{faded}{rgb}{.8, .8, .8}

% commands =============================================================================

% configuration ------------------------------------------------------------------------

\newcommand{\coursetitle}[1]{
    \newcommand{\thecoursetitle}{#1}
}

\newcommand{\lecturenumber}[1]{
    \newcommand{\thelecturenumber}{#1}
}

% titles -------------------------------------------------------------------------------

\newcounter{lecturepartnum}
\newcommand{\parttitle}[1]{
    \stepcounter{lecturepartnum}
    \begin{frame}
        \begin{center}
            \thecoursetitle

            \fontsize{12pt}{0}\selectfont
            \textsf{Lecture \thelecturenumber{} \textcolor{faded}{|} Part \thelecturepartnum}

            \vspace{1em}

            \fontsize{14pt}{0}\selectfont
            \term{#1}
        \end{center}
    \end{frame}
}

\newcommand{\centertitle}[1]{\begin{center}\textbf{\Large #1}\end{center}\vspace{.5em}}

% fill in writing lines ----------------------------------------------------------------

\newcommand{\writinglines}[1]{%
    \foreach \x in {1,...,#1}{
        \begin{tikzpicture}
            \draw (0,0) -- (.9\textwidth,0);
            \path[use as bounding box] (0,0) rectangle (\textwidth,2em);
        \end{tikzpicture}
    }
}

% text styles --------------------------------------------------------------------------

\newcommand{\term}[1]{\textbf{\textcolor{pastelblue}{#1}}}
\newcommand{\bad}[1]{\textbf{\textcolor{pastelred}{#1}}}
\newcommand{\good}[1]{\textbf{\textcolor{darkgreen}{#1}}}
\newcommand{\highlight}[1]{\textbf{#1}}

\newcommand{\funfacttext}{
        \textbf{
        {\color{pastelred}F}%
        {\color{pastelblue}U}%
        {\color{darkgreen}N}%
        }
        \textbf{
        {\color{pastelpurple}F}%
        {\color{darkgreen}A}%
        {\color{pastelred}C}%
        {\color{pastelblue}T}%
        }%
}

% environments =========================================================================

\newenvironment{exercise}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=pastelpurple!100,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Exercise}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}

\newenvironment{funfact}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=pastelyellow!70,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries \funfacttext}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}

\newenvironment{mainidea}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=darkgreen!100,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Main Idea}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}

\newenvironment{warning}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=pastelred!100,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Warning!}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}

\newenvironment{defn}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=pastelblue!100,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Definition}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}

\newenvironment{thm}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=black!100,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Theorem}
                  ]%%
}{
    \end{tcolorbox}
    \end{center}
}
