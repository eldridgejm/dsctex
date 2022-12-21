\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dscslides}

\newif\ifhandout

\ifcsname handout\endcsname
    \handouttrue
    \PassOptionsToClass{handout}{beamer}
\else
    \handoutfalse
\fi

% this will consume the outputdir option, if passed
\RequirePackage{minted}

\LoadClass[aspectratio=169, 14pt]{beamer}
\setbeamersize{text margin left=.75in}
\setbeamersize{text margin right=.75in}

\RequirePackage{amsthm}
\RequirePackage{booktabs}
\RequirePackage{tikz}
\RequirePackage{enumitem}
\RequirePackage{hyperref}
\RequirePackage{tcolorbox}
\RequirePackage[normalem]{ulem}
\RequirePackage{soul}

% fonts
\RequirePackage[sfdefault,lining,semibold,book]{FiraSans}
\RequirePackage[medium,scale=.925]{FiraMono}
\RequirePackage[mathrm=sym]{unicode-math}
\RequirePackage[usefilenames]{firamath-otf}

% fira's vdots are broken, see:
% https://tex.stackexchange.com/questions/540732/vdots-missing-in-fira-math
% the fix is to use DejaVu Sans Math for vdots
\setmathfont{texgyredejavu-math.otf}[range={\vdots,\ddots}]


\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

% commands
% ========
\newcommand{\python}[1]{\mintinline{python}{#1}}


% theorems
% ========
\newtheorem{remark}{Remark}


% parts
% =====
\newcommand{\lecturetitle}[2]{
    \begin{center}
        \fontsize{12pt}{0}\selectfont
        \textsf{Lecture #1}

        \vspace{1em}

        \fontsize{18pt}{0}\selectfont
        \textbf{#2}
    \end{center}
}

\newcommand{\centertitle}[1]{\begin{center}\textbf{\Large #1}\end{center}\vspace{.5em}}

\newcounter{lecturepartnum}
\newcommand{\parttitle}[2]{
\stepcounter{lecturepartnum}
\begin{frame}
    \begin{center}
        \includegraphics[scale=.8]{./fig/course-title.pdf}\\[1em]

        \fontsize{12pt}{0}\selectfont
        \textsf{Lecture \lecturenumber{} \textcolor{faded}{|} Part \thelecturepartnum}

        \vspace{1em}

        \fontsize{14pt}{0}\selectfont
        \term{#1}
    \end{center}
\end{frame}
}


% styling commands
% ================
\newcommand{\term}[1]{\textbf{\textcolor{pastelblue}{#1}}}
\newcommand{\bad}[1]{\textbf{\textcolor{pastelred}{#1}}}
\newcommand{\good}[1]{\textbf{\textcolor{darkgreen}{#1}}}
\newcommand{\highlight}[1]{\textbf{#1}}
\newcommand{\faded}[1]{{\textcolor{faded}{#1}}}

% color definitions
% =================

\definecolor{pastelred}{HTML}{d20000}
\definecolor{pastelblue}{HTML}{007aff}
\definecolor{pastelpurple}{HTML}{6E66BA}
\definecolor{pastelyellow}{HTML}{FBC05E}
\definecolor{pastelgreen}{HTML}{8fc34f}
\definecolor{darkblue}{rgb}{0,0,.5}
\definecolor{darkgreen}{HTML}{007355}
\definecolor{faded}{rgb}{.8, .8, .8}


\newcommand{\funfacttext}{
        \textbf{
        {\color{pastelred}F}%
        {\color{pastelblue}U}%
        {\color{pastelgreen}N}%
        }
        \textbf{
        {\color{pastelpurple}F}%
        {\color{pastelgreen}A}%
        {\color{pastelred}C}%
        {\color{pastelblue}T}%
        }%
}

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


\newenvironment{claim}{
    \begin{center}
    \begin{tcolorbox}[width=4in,
                  boxsep=.5em,
                  colback=white,
                  colframe=black!70,
                  left=2pt,
                  right=0pt,
                  top=2pt,
                  title={\bfseries Claim}
                  ]%%
    \small
}{
    \end{tcolorbox}
    \end{center}
}


\newcommand{\writinglines}[1]{%
    \foreach \x in {1,...,#1}{
        \begin{tikzpicture}
            \draw (0,0) -- (.9\textwidth,0);
            \path[use as bounding box] (0,0) rectangle (\textwidth,2em);
        \end{tikzpicture}
    }
}


\newcommand{\writedefinition}[2]{%
    \addvspace{1em}
    \textbf{Definition: \term{#1}}
    \writinglines{#2}
}


% beamer styles
% =============
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{itemize item}[triangle]
\newcommand{\drawtitle}[1]{%
    {
    \bfseries%
    \fontsize{14pt}{0}\selectfont%
    {#1}
    \color{black}%
    }
}
\setbeamertemplate{frametitle}{%
    \vspace{1.25em}%
    \drawtitle{\insertframetitle}%
}
\setbeamertemplate{itemize item}[triangle]

\setbeamercolor{structure}{fg=faded}
\setbeamercolor{alerted text}{fg=pastelred}
\setbeamercolor{frametitle}{fg=black}
\setbeamerfont*{block title}{family=\sffamily,series=\bf}
\setbeamercolor*{block title}{use=structure, fg=black}
\setbeamercolor*{block title example}{use=structure, fg=black}
\setbeamercolor*{local structure}{fg=black!20}


\setbeamerfont{frametitle}{size=\normalsize}


\setitemize{label=\usebeamerfont*{itemize item}%
  \usebeamercolor[fg]{itemize item}
  \usebeamertemplate{itemize item},
  itemsep=1.5em}

\setenumerate[1]{label=\usebeamerfont*{itemize item}\color{black!20}\arabic*.,itemsep=1.5em}
