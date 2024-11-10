% dscproblemset.cls
%
% author: Justin Eldridge
% email: jeldridge@ucsd.edu
%
% A class for creating problem sets (exams, homeworks, discussion worksheets, etc.).

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dscproblemset}

\LoadClass[twoside]{article}

\RequirePackage{enumitem}
\RequirePackage{environ}
\RequirePackage{ifthen}
\RequirePackage{mdframed}
\RequirePackage{scrextend}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}

% solution hiding ======================================================================

% if true, solutions will be shown. Otherwise they will be hidden
\newif\ifshowsoln
\showsolntrue

\ifcsname hidesoln\endcsname
    \showsolnfalse
\fi

% commands =============================================================================

% draw a box with text in it
\newcommand{\remarkbox}[1]{
    \begin{mdframed}
        #1
    \end{mdframed}
}

% titles -------------------------------------------------------------------------------

% draw the problem set's title
% Arguments:
%   #1: the course name
%   #2: the problem set name
%   #3: the date
\NewDocumentCommand{\pstitle}{ m m o }{
    \begin{center}
        \begin{tikzpicture}
            \node[align=center] (title) at (0,0) {
                    {
                        \fontsize{13pt}{13pt}\selectfont
                        \textbf{#1 - #2}
                    }
                    \IfNoValueTF{#3}{
                    }{
                        \\#3
                    }
                };
                \draw[line width=1]
                    ([yshift=3]title.north west)
                    --
                    ([yshift=3]title.north east);
            \draw[line width=1]
                    ([yshift=-2]title.south west)
                    --
                    ([yshift=-2]title.south east);
        \end{tikzpicture}
    \end{center}
    \vspace{2em}
}

% Draws signature boxes for the students to the left and right of the exam taker
% if the exam is versioned, a space to right the version will also appear.
% This can be overridden by redefining the \adjacentstudents command
\newcommand{\adjacentstudents}{
    \begin{center}
        \begin{minipage}{.47\textwidth}
            \centering
            Name of student to your \textbf{left}:\\
            \inlineresponsebox[.95\textwidth]{}\\[1em]
            \ifcsname version\endcsname
                Exam version of student to your \textbf{left}:\\
                \inlineresponsebox[.5in]{}
            \fi
        \end{minipage}
        \begin{minipage}{.47\textwidth}
            \centering
            Name of student to your \textbf{right}:\\
            \inlineresponsebox[.95\textwidth]{}\\[1em]
            \ifcsname version\endcsname
                Exam version of student to your \textbf{right}:\\
                \inlineresponsebox[.5in]{}
            \fi
        \end{minipage}

        \vspace{.5em}
        (Write ``N/A'' if a wall/aisle is to your left/right.)
    \end{center}
}

% display the exam front page with spots for student name, signature, students
% sat next to, etc. if the exam is versioned, the version will appear, as will
% a place to write the exam version of the students seated on the left and
% right
\newcommand{\examfrontpage}[4]{
    \thispagestyle{empty}

    \pstitle{%
        #1%
    }{%
        #2}[#3]

    \begin{tabular}{rl}
        Name: & \inlineresponsebox[4in]{SOLUTIONS}\\
        PID: & \inlineresponsebox[3in]{}\\
        \ifcsname version\endcsname
        Exam Version: & \drawinlinebox{.5in}{.5in}{\version{}}
        \fi
    \end{tabular}

    \vspace{1em}

    \setlength{\parindent}{0em}
    By signing below, you agree that you will behave honestly and fairly during
    and after this exam. You should not discuss any part of this exam with
    anyone who has not yet taken it. \vspace{1em}

    Signature: \inlineresponsebox[3in]{}

    \vspace{1em}

    \adjacentstudents{}

    \vspace{1em}

    \remarkbox{
        #4
    }

    \vfill

    \begin{center}
        (Please do not open your exam until instructed to do so.)
    \end{center}

    \newpage
}

% scratch pages ------------------------------------------------------------------------

% show a mostly-empty scratch page
\newcommand{\scratchpage}{
    \newpage
    \pagestyle{plain}
    \begin{center}
        (You may use this area for scratch work.)
    \end{center}
}

% show a mostly-empty scratch page with a message that is OK to detach
\newcommand{\scratchpagedetach}{
    \newpage
    \pagestyle{plain}
    \begin{center}
        (You may detach and use this page for scratch work. You do not need to turn it in.)
    \end{center}
}

% misc ---------------------------------------------------------------------------------

% command to load problems from particular subdirectory
\newcommand{\inputproblem}[2][]{
    {
        \newcommand{\probdescription}{#1}
        \newcommand{\thisdir}{./problems/#2/}
        \input{problems/#2/problem.tex}
    }
}

% display a place to write name/pid on every physical page
\newcommand{\nameoneverypage}{
    % page headers only on odd pages
    \pagestyle{fancy}
    \fancyhead{}
    \fancyhead[RO]{PID or Name: \rule{3in}{.5pt}}
    \renewcommand{\headrulewidth}{0pt}
}

% execute the code only if the version matches
\newcommand{\onlyversion}[2]{%
    \ifthenelse{\equal{\version}{#1}}{%
        #2
    }{%
    }%
}


% problem environments =================================================================

\newcounter{probnum}
\newcounter{progprobnum}
\newcounter{subprobnum}[probnum]

% separation between problems
\newcommand{\probsep}{0.5cm}

% separation between subproblems
\newcommand{\subprobsep}{.25cm}

% create a new problem set environment with proper spacing
\newenvironment{probset}{
    \begin{list}{}{
        \leftmargin=0em
        \labelwidth=3cm
        \itemsep=\probsep
        \parindent=1cm
    }
}{
    \end{list}
}

% create a new block of subproblems, indented to the right
\newenvironment{subprobset}{
    \begin{list}{}{
        \leftmargin=1cm
        \labelwidth=1cm
        \itemsep=\subprobsep
    }
}{
    \end{list}
}

% the text that appears before the problem number
\newcommand{\probtext}{Problem}

% create a new numbered problem
% the optional argument is meant for point totals, descriptions, etc. If empty,
% nothing will be printed next to the problem number.
\newenvironment{prob}[1][]{
    \stepcounter{probnum}
    \item \textbf{\probtext{} \theprobnum.} #1%
        \ifcsname probdescription\endcsname%
            \probdescription{}
        \fi%

}{}

% create a new lettered subproblem
\newenvironment{subprob}{
    \stepcounter{subprobnum}
    \item[\textbf{\alph{subprobnum})}]%
}{}

% the text that appears before the programming problem number
\newcommand{\progprobtext}{Programming Problem}

\newenvironment{progprob}[1][]{
    \stepcounter{progprobnum}
    \setcounter{subprobnum}{0}
    \item \textbf{\progprobtext{} \theprogprobnum.} #1

}{}

% responses and solutions ==============================================================

\newcommand{\solutiontext}{
    \textbf{Solution:}
}

% if showsoln is true: draws a box containing solution text
% if showsoln is false: does nothing
\NewEnviron{soln}{
    \mdfsetup{skipabove=1em, skipbelow=1em}
    \ifshowsoln
        \begin{mdframed}
             \solutiontext \BODY
        \end{mdframed}
    \fi
}

% if showsoln is true: draws a box containing solution text (same as soln)
% if showsoln is false: draws the box, but without the solution text
% This differs from soln above. It requires a size argument:

%    \begin{responsebox}{3in}
%       This is the solution
%    \end{responsebox}
\NewEnviron{responsebox}[1]{
    \mdfsetup{skipabove=1em, skipbelow=1em}
        \begin{mdframed}
            \ifshowsoln
                \solutiontext \BODY
            \else
                \vspace*{#1}
            \fi
        \end{mdframed}
}

% draws an inline box. Lower level than \inlineresponsebox, which should typically
% be used instead.
% Arguments:
%   #1: width of the box
%   #2: height of the box
%   #3: text to include in the box
\newcommand{\drawinlinebox}[3]{
    \tikz[baseline=-.5em]{
        \node[
            draw, rectangle, inner sep=0, text centered, minimum height=#2,
            text width=#1, align=center
        ] at (0,0) {
            #3
        };
        \useasboundingbox
            ([shift={(1mm,1mm)}]current bounding box.north east)
            rectangle
            ([shift={(-1mm,-1mm)}]current bounding box.south west);
    }%
}

% controls the width of the inline response box
\newlength{\inlineresponseboxwidth}
\setlength{\inlineresponseboxwidth}{1.5in}

% controls the height of the inline response box
\newlength{\inlineresponseboxheight}
\setlength{\inlineresponseboxheight}{3.25em}

% Draw an inline response box.
% if showsoln is true: draws the box and the included text
% if showsoln is false: draws the box only
% Arguments:
%   #1: width of the box (optional, default 1.5in)
%   #2: height of the box (optional, default 3.25em)
%   #3: text to include in the box
\NewDocumentCommand{\inlineresponsebox}{ O{\inlineresponseboxwidth} O{\inlineresponseboxheight} m }{
    \drawinlinebox{#1}{#2}{
        \ifshowsoln
            #3
        \fi
    }
}

% the shape of the bubble in \bubble and \correctbubble
\newcommand{\bubbleshape}{circle}

% draw a response bubble
\newcommand{\bubble}[2][]{
    \tikz[baseline=-.25em]{
        \node[\bubbleshape, draw, #1] {};
    }
    #2
    \if\relax\detokenize{#2}\relax
    \else
        % if #2 is not empty, put a space at the end to separate it from other bubbles.
        % this is useful for making inline lists of choices
        \quad
    \fi
}

% draw a response bubble
% if showsoln is true: fills the bubble, showing that it is correct
% if showsoln is false: draws an unfilled bubble
\newcommand{\correctbubble}[1]{
    \ifshowsoln
        \bubble[fill=black!90]{#1}%
    \else
        \bubble[]{#1}%
    \fi
}

% define a "choices" environment with each choice on its own line(s), to be used as follows:
%
% \begin{choices}
%     \choice This is an option.
%     \choice So is this.
%     \correctchoice This is correct.
%     \choice This is not.
% \end{choices}
\NewEnviron{choices}[1][circle]{
    \renewcommand{\bubbleshape}{#1}

    \newcommand{\choice}{%
        \item[\bubble{}]
    }
    \newcommand{\correctchoice}{%
        \item[\correctbubble{}]
    }

    \begin{itemize}[]
        \BODY
    \end{itemize}
}

\newcommand{\Tf}{
    \begin{choices}
        \correctchoice True
        \choice False
    \end{choices}
}

\newcommand{\tF}{
    \begin{choices}
        \choice True
        \correctchoice False
    \end{choices}
}
