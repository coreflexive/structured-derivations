#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#let parameters = (
  section("Parameters"),

  declare(
    $A$,
    $"Set"$,
  ),

  declare(
    $R$,
    $A tilde A$,
  ),

  declare(
    $X$,
    $"Set"$,
  ),
)

#let assumptions = (
  section("Assumptions"),

  assume(
    "a.",
    $X subset.eq A$,
  ),

  assume(
    "b.",
    $(forall a,b | a "R" b and b in X : a in X)$,
  ),
)

#let observations = (
  section("Observations"),

  observe(
    "1.",
    $X = R[X] arrow.double "Left closed" R space X$,
  ),

  observe(
    "2.",
    $("Left closed" R space X arrow.double X = R[X])
      arrow.double.l "Reflexive" R$,
  ),
)

#let left-closed = centred-theory(
  "Left closed",

  parameters,
  assumptions,
  observations,
)

#left-closed
