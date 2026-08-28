#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

// Give the concept a fully explicit name and parameter list first, then
// license a compact notation for that already-defined concept.
#let twice = centred-theory(
  "Twice",

  section("Parameters"),

  declare($A$, $"Type"$),
  declare($f$, $A arrow A$),
  declare($x$, $A$),

  section("Definitions"),

  define(
    $op("Twice")(f, x) colon.eq f(f(x))$,
    label: "D1",
  ),

  section("Notation"),

  notation(
    $f^2(x) colon.eq op("Twice")(f, x)$,
  ),
)

// In the importing context, f is already a parameter. The short name t is
// useful only here, so it is recorded as a contextual abbreviation rather
// than as exported notation for the concept itself.
#let fixed-twice = centred-theory(
  "Fixed twice",

  section("Imports"),

  import-theory([Twice]),

  section("Abbreviations"),

  abbrev(
    $t(x) colon.eq f^2(x)$,
  ),
)

#twice

#v(1.5em)

#fixed-twice
