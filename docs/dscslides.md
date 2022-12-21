# dscslides.sty

A style file for lecture slides.

## Basic Use

Use this class by writing `\documentclass{dscslides}` at the top of your document.

The class provides a `\parttitle` command for generating title slides at the
beginning of each of the presentation's parts. To use this command, two things
must be configured: the course title, and the lecture number, done with
`\coursetitle{}` and `\lecturenumber`, respectively.

Beamer's "handout" mode is useful for generating a version of a presentation
that is suitable for printing (namely, animations are "squashed" into one
slide). To facilitate a way of specifying whether or not handout mode should be
used at the command-line, this class checks to see if a `\handout` macro has
been defined; this can be done with most latex compilers using the CLI option
`-usepretex=\def\handout{1}`. If this macro is defined, handout mode is used
and frame numbers are displayed; if it is not defined, handout mode is not
used.

The class defines a new conditional, `\ifhandout`, which is true if and only if
we are in handout mode.

## Example

```tex
\documentclass{dscslides}

\begin{document}

% set what is displayed for the course title on part title slides
\coursetitle{
    \Huge DSC 40B%
    \vspace{.5em}
}

% set the lecture number
\lecturenumber{1}

% displays the course title, lecture number, part number, and part title
\parttitle{
    Introduction
}

\begin{frame}
    \centertitle{dscslides.sty}

    \begin{itemize}
        \item This is an example of slides created with \textit{dscslides.sty}
    \end{itemize}
\end{frame}

\begin{frame}
    \begin{exercise}
        This is a \term{exercise}, and practice makes \good{perfect}.
    \end{exercise}
\end{frame}

\end{document}
```

## Commands

### `\coursetitle{}`

Sets the content that should be displayed for the course's title on title slides.

Example: `\coursetitle{\Large DSC 40B}`

### `\lecturenumber{}`

Sets the lecture number. This will be shown in title slides.

### `\parttitle{}`

Generate a title slide for a part of the lecture. Numbering is done
automatically with the `lecturepartnum` counter.

Example: `\parttitle{Introduction}`

### `\centertitle{}`

Format a frame's title (centered and bolded).

Example: `\centertitle{Welcome to DSC 40B}`

### `\writinglines{}`

Display `n` blank lines for writing.

Example: `\writinglines{3}`

### `\term{}`

Format a word that is being defined.

Example: `An \term{undirected graph} is...`

### `\good{}`

Format something that is good.

Example: `This algorithm is \good{fast}...`

### `\bad{}`

Format something that is bad.

Example: `This algorithm is \bad{slow}...`

### `\highlight{}`

Format text that should be emphasized

Example: `This algorithm is \highlight{very} slow`

## Environments

The following environments are defined. They appear as a color box with the
environment contents within.

- `exercise`
- `funfact`
- `mainidea`
- `warning`
- `defn`
- `thm`

Example:

```
\begin{exercise}
    What is 3 + 5?
\end{exercise}
```

## Colors

The following colors are defined. They can be used by writing, e.g., `\color{pastelblue}{text to color}`.

- `pastelred`
- `pastelblue`
- `pastelpurple`
- `pastelyellow`
- `pastelgreen`
- `darkblue`
- `darkgreen`
- `faded`
