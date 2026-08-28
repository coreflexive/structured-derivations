#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#let transitivity = centred-theory(
  "Transitivity",

  section("Parameters"),

  declare(
    $A$,
    $"Set"$,
  ),

  declare(
    $R$,
    $A tilde A$,
  ),

  section("Assumptions"),

  assume(
    "a.",
    $x in A$,
    $y in A$,
    $z in A$,
  ),

  assume(
    "b.",
    $x "R" y$,
    $y "R" z$,
  ),

  section("Observations"),

  observe(
    "1.",
    $x "R" y$,
    $y "R" z$,
    $x "R" z$,
  ),

  remark(
    [Only the first row of each marked item carries its marker.],
    [Every continuation remains in the body column.],
  ),
)

#transitivity
