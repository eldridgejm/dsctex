# dscproblemset.cls

A document class for creating problem sets (exams, homeworks, worksheets,
etc.). Defines commands and environments for writing problems, solutions (which
can be hidden or shown at the flip of a switch), and designated answer areas,
such as multiple choices and response boxes.

## Basic Usage

To use the class, write `\documentclass{dscproblemset}` at the top of your
document.

Within the document, write each problem within a `prob` environment, themselves
nested within a `probset` environment. Solutions to problems should be placed
in `soln` environments.

A minimal example:

```tex
\documentclass{dscproblemset}

\begin{document}

\begin{probset}
    \begin{prob}
        This is the first problem.

        \begin{soln}
            This is its solution.
        \end{soln}
    \end{prob}

    \begin{prob}
        This is the second problem.

        \begin{soln}
            This is its solution.
        \end{soln}
    \end{prob}
\end{probset}

\end{document}
```

## Homeworks vs. Exams

Homeworks and exams are both "problem sets", and this document class can be
used to create either.

### Homeworks

Not much special needs to be done for homeworks. Perhaps the main difference
between a homework and an exam is on the formatting of the title and
instructions. For a homework, a minimal title is preferable; this can be
created with `\pstitle`:

Signature: `\pstitle{<course name>}{<assignment name>}[<due date>]`

### Exams

The class provides functionality that is especially useful for exam writing,
including the ability to have multiple versions, formatting a title page, and
adding empty scratch pages.

Exams are also more likely to use designated response areas; these are described
in the [Designated Response Areas](#designated-response-areas) section below.

#### Versioning

The document class looks for the `\version` macro to determine the exam's
version. To set the exam version, write, e.g., `\def\version{A}` at the top of
the document, or during compilation with the `-usepretex` command line argument
to you LaTeX compiler.

The `\onlyversion` command can be used to execute code if and only if the
version matches.

```tex
\onlyversion{C}{
    % only displays if the exam version is "C"
    Hello world!
}
```

#### Formatting a Front Page

Use `\examfrontpage` to generate an exam front page. The full signature is:

```tex
\examfrontpage{<course name>}{<exam name>}{<date>}{<instructions>}
```

This will make areas for student name, signature, students sat next to, etc. if
the exam is versioned, the version will appear, as will a place to write the
exam version of the students seated on the left and right

#### Name Areas

`\nameoneverypage{}` can be used to display an area where students can write
their name on every page.

#### Scratch Pages

`\scratchpage{}` will generate an empty page (except for an instruction that says that
the page is intentionally empty).

`\scratchpagedetach{}` also generates an empty page for scratch work, but its message
says that the page is OK to remove from the exam.

## Problem Environments

### Problems

Groups of problems should be defined within a `probset` environment.
Individual problems are defined within `prob` environments within the `probset`.
For example:

```tex
\begin{probset}
    \begin{prob}
        This is the first problem.
    \end{prob}

    \begin{prob}
        This is the second.
    \end{prob}
\end{probset}
```

Problems are numbered automatically. An optional description can be provided:

```tex
\begin{prob}[(Extra credit!)]
    ...
\end{prob}
```

Programming problems can be defined with the `progprob` environment.
Programming problems are numbered on a different counter than normal problems.

### Subproblems

Multiple subproblems can be definined within a `subprobset` environment (itself
placed within a `prob` environment. The individual subproblems should be placed
within `subprob` environments. For example:

```tex
\begin{prob}
    This is a problem with several subparts.

    \begin{subprobset}
        \begin{subprob}
            Part One.
        \end{subprob}

        \begin{subprob}
            Part Two.
        \end{subprob}
    \end{subprobset}

\end{prob}
```

## Solutions

Solutions to a problem should be placed with a `soln` environment (itself
placed within a `prob` or `subprob`. Its contents can be hidden or shown by
writing either `\showsolntrue` or `\showsolnfalse` after
`\usepackage{dscproblemset}`.

Example:

```tex
\documentclass{article}
\usepackage{dscproblemset}

% solutions will be hidden unless this is changed to \showsolntrue
\showsolnfalse

\begin{document}
    \begin{probset}
        \begin{prob}
            \begin{soln}
                This is the secret answer.
            \end{soln}
        \end{prob}
    \end{probset}
\end{document}
```

You can do things conditioned on whether or not solutions are shown using `\ifshowsoln`.
For example, to force a new page, but only in the solution document, write:

```tex
\ifshownsoln
    \newpage
\fi
```

## Designated Response Areas

This package also provides tools for drawing designated response areas, such as
those on a quiz or exam that will be scanned and graded.

### Response Boxes

A blank response box can be drawn using the `responsebox` environment. The
single argument to this environment is a size determining the height of the
box. The contents of the environment are hidden when `\ifshowsoln` is false,
and are shown otherwise.

Example:
```tex
\begin{prob}
    What is the meaning of life?

    \begin{responsebox}{3in}
        This is the solution.
    \end{responsebox}
\end{prob}
```

### Inline Response Boxes

Inline response boxes for short answer questions can be drawn with `\inlineresponsebox`.
The signature is:

`\inlineresponsebox[<width>]{<solution>}`

Example:
```tex
\begin{prob}
    What is 3 + 5? \inlineresponsebox[1in]{8}
\end{prob}
```

### Multiple Choices

Multiple choice bubbles can be drawn with the `choices` environment:

```tex
\begin{prob}
    What is the capital of California?

    \begin{choices}
        \choice Los Angeles
        \choice San Francisco
        \correctchoice Sacramento
        \choice San Diego
    \end{choices}
\end{prob}
```

The correct bubble is shaded when `\ifshownsoln` is true, and is unmarked otherwise.

The shape of the choice bubble can be altered with an optional argument to the `choices` environment. The shape can be any valid TiKZ node shape:

```tex
Choose all that apply:

\begin{choices}[rectangle]
    \choice alpha
    \correctchoice beta
    \choice gamma
    \choice delta
\end{choices}
```

If desired, individual bubbles can be drawn outside of a `choices` environment using the
`\bubble{<text>}` and `\correctbubble{<text>}` commands.

### True/False

True/False response areas can be drawn with `\Tf` (if True is the correct
response) and `\tF` (if False is the correct response). Like with `choices`,
the correct choice is shaded if solutions are being shown.

## Other Commands

### `\inputproblem`

A helper function for including a problem located in a subdirectory. Assumes
that the problem is containing in a file names `problem.tex` within a directory
named after the problem, itself within a directory called `problems`.

Signature: `\inputproblem[<description>]{<problem name>}`

Example: to include the problem defined in
`problems/time-complexity/problem.tex`, write `\inputproblem{time-complexity}`.

## Compile-time Solution Hiding

As described above, showing or hiding the solutions can be done by setting
`\showsolntrue` or `\showsolnfalse` after `\usepackage{dscproblemset}`.
However, there are some cases in which we'd like to show or hide solutions at
compile time (e.g., in a `Makefile` that builds both the version with solutions
and that without).

To facilitate this, this package looks for a macro named `\hidesoln`. If this
name exists, `\showsolnfalse` is set. Otherwise, `\showsolntrue` is set by
default.

This mechanism facilitates compile-time automation because macros can be
defined at the command line with most LaTeX compilers using the `-usepretex`
argument. For example:

```
pdflatex -usepretex=`\def\hidesoln{1}`
```


## Configuration

The spacing between problems and subproblems can be changed by redefining the commands
`\probsep` and `\subprobsep`. Their default definitions are:

```tex
% separation between problems
\newcommand{\probsep}{0.5cm}

% separation between subproblems
\newcommand{\subprobsep}{.25cm}
```

By default, programming problems are labeled, e.g., "Problem 1.", and
programming problems are labeled "Programming Problem 1.". The text that
appears before the number can be controlled by redefining `\probtext` and
`\progprobtext`.

## Example

```tex
\documentclass{dscproblemset}

\usepackage[margin=1in]{geometry}

% change to \showsolntrue to show solutions
\showsolnfalse

% determine the exam's version
\def\version{Z}

\begin{document}

\examfrontpage{
    DSC 40B
}{
    Midterm 01
}{
    December 21, 2022
}{
    Instructions: do not cheat.
}

\nameoneverypage{}

\begin{probset}

    \begin{prob}
        This is the first problem in the homework.

        \begin{soln}
            This is the solution.
        \end{soln}

    \end{prob}

    \begin{prob}
        This is a problem with several subparts.

        \begin{subprobset}
            \begin{subprob}
                Part One.
            \end{subprob}

            \begin{subprob}
                Part Two.
            \end{subprob}
        \end{subprobset}

    \end{prob}

    \begin{prob}[(Optional descriptions can be provided)]
        Designated response areas can be drawn.

        \begin{responsebox}{2in}
            And solutions can be placed inside.
        \end{responsebox}
    \end{prob}

    \begin{prob}
        They can be inline response areas, too:

        First name: \inlineresponsebox[2in]{testing}

        Last name: \inlineresponsebox[2in]{this}
    \end{prob}

    \newpage

    \begin{prob}
        Multiple choice questions are supported.

        \begin{choices}
            \choice alpha
            \correctchoice beta
            \choice gamma
            \choice delta
        \end{choices}

        The choice bubble's shape can be changed to any valid
        TiKZ node shape, such as ``rectangle'':

        \begin{choices}[rectangle]
            \choice alpha
            \correctchoice beta
            \choice gamma
            \choice delta
        \end{choices}
    \end{prob}

    \begin{prob}
        As are True/False questions.

        \Tf{}

    \end{prob}

    % redefine the text that appears before the problem number
    \renewcommand{\progprobtext}{Coding Problem}

    \begin{progprob}
        This is a programming problem; it is numbered on a different counter.

        \bubble{test}
    \end{progprob}

\end{probset}

\scratchpage{}

\end{document}
```
