#import "../lib/theory.typ": *
#import "../lib/calc.typ": *
#import "../lib/doc.typ": *

#set page(
  margin: 2.5cm,
)

#set text(
  size: 11pt,
)

#doc-title[Tour of structured derivations]

This example demonstrates the main presentation features provided by the
library: structured theory cards, reusable fragments, calculations, multiline
steps, and nested derivations.

The first card shows that a theory need not be presented all at once.
`centred-theory` accepts any sequence of theory rows, so a document can expose
only the part of a theory that is relevant at that point in the exposition.

#let left-closed-parms = centred-theory(
  "Left closed",
  (
    ..section("Parameters"),

    ..declare($A$, $"Set"$),

    ..declare($R$, $A tilde A$),

    ..declare($X$, $"Set"$),
  ),
)

#left-closed-parms

The row constructors are deliberately small.  `section` introduces a heading;
`declare` produces a two-column declaration row.  The marker occupies the first
column and the mathematical body occupies the second.

The same mechanism is used for assumptions.  Here the theory is given a
different fragment without repeating the parameter card above.

#let left-closed-assumptions = centred-theory(
  "Left closed",
  (
    ..section("Assumptions"),

    ..assume("a.", $X subset.eq A$),

    ..assume("b.", $(forall a,b | a "R" b and b in X : a in X)$),
  ),
)

#left-closed-assumptions

`assume` and `observe` use the same two-column layout as declarations.  Their
bodies are ordinary Typst content, so they are not restricted to a single
physical line; long formulae may wrap naturally while the marker remains in
its own column.

A third fragment demonstrates observations.

#let left-closed-observations = centred-theory(
  "Left closed",
  (
    ..section("Observations"),

    ..observe(
      "1.",
      $X = R[X] arrow.double "Left closed" R space X$,
    ),

    ..observe(
      "2.",
      $("Left closed" R space X arrow.double X = R[X]) arrow.double.l "Reflexive" R$,
    ),

    ..observe(
      "3.",
      $("Left closed" R space X equiv X = R[X]) arrow.double.l "Reflexive" R$,
    ),
  ),
)

#left-closed-observations

Nothing requires these fragments to remain separate.  A complete theory can be
assembled with exactly the same constructors.  This is useful when exposition
calls for a theory to be introduced incrementally and then collected in one
place for reference.

#let left-closed = centred-theory(
  "Left closed",
  (
    ..section("Parameters"),

    ..declare($A$, $"Set"$),

    ..declare($R$, $A tilde A$),

    ..declare($X$, $"Set"$),

    ..section("Assumptions"),

    ..assume("a.", $X subset.eq A$),

    ..assume("b.", $(forall a,b | a "R" b and b in X : a in X)$),

    ..section("Observations"),

    ..observe(
      "1.",
      $X = R[X] arrow.double "Left closed" R space X$,
    ),

    ..observe(
      "2.",
      $("Left closed" R space X arrow.double X = R[X]) arrow.double.l "Reflexive" R$,
    ),

    ..observe(
      "3.",
      $("Left closed" R space X equiv X = R[X]) arrow.double.l "Reflexive" R$,
    ),
  ),
)

#left-closed

The calculation below demonstrates the second half of the library.

`artefact` gives a derivation a captioned home in the surrounding document.
`centred-boxed` adds a centred visual frame, while `calc` lays out the derivation itself as a
sequence of rows.

A calculation normally begins with `calc-row(start, ...)`, proceeds through
`step(...)` entries, and ends with `calc-row(finish, [])`.  Each `step` has
three parts: the relation marker, the justification, and the resulting body.

The `lines` helper is used where one calculation body should contain several
aligned display lines while still occupying a single body position in the
outer calculation.

The most important feature shown here is nesting.  The body supplied to `step`
is arbitrary content, so it may itself be another `calc`.  In the
"Identity of conjunction" step, the nested calculation contains the open task
`Reflexive R`.  Because that inner `calc` is the *body of the outer step*, its
start marker is indented beneath the outer calculation rather than appearing as
another outer row.

After the nested task, `calc-row(gap, ...)` resumes the enclosing calculation.
This lets a derivation display subsidiary proof obligations exactly where they
arise without flattening the proof structure.

#artefact(
  [Example derivation],
  centred-boxed[
    #calc(
      calc-row(
        start,
        $X = R[X]$,
      ),

      step(
        $equiv$,
        [Extensionality],
        $(forall a | : a in X equiv a in R[X])$,
      ),

      step(
        $equiv$,
        [Mutual implication],
        $(forall a | : (a in X arrow.double a in R[X]) and (a in X arrow.double.l a in R[X]))$,
      ),

      step(
        $equiv$,
        [Distributivity; Trading],
        lines(
          $(forall a | a in X : a in R[X]) and$,
          $(forall a | a in R[X] : a in X)$,
        ),
      ),

      step(
        $equiv$,
        [Definition of direct image, twice],
        lines(
          $(forall a | a in X : (exists x | x in X : a "R" x)) and$,
          $(forall a | (exists x | x in X : a "R" x) : a in X)$,
        ),
      ),

      step(
        $equiv$,
        [Identity of conjunction],
        calc(
          calc-row(
            start,
            warn($"Reflexive" R$),
          ),
        ),
      ),

      calc-row(
        gap,
        $(forall a | (exists x | x in X : a "R" x) : a in X)$,
      ),

      step(
        $equiv$,
        [Splitting],
        $(forall x | x in X : (forall a | a "R" x : a in X))$,
      ),

      step(
        $equiv$,
        [Definition of Left Set],
        $"Left Set" R space X$,
      ),

      calc-row(
        finish,
        [],
      ),
    )
  ],
)
