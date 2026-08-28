#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#let wide-labels = centred-theory(
  "Wide labels",

  section("Assumptions"),

  assume(
    "A2.6.",
    [Complemented meet],
    $rho = rho$,
  ),

  assume(
    "b.",
    [Complemented join],
    $rho = rho$,
  ),

  section("Observations"),

  observe(
    "Law-12.",
    [A still wider marker],
    [Continuation rows remain aligned in the body column.],
  ),
)

#wide-labels
