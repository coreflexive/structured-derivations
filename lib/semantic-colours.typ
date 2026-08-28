#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#let arithmetic = theory(
  "Arithmetic in a commutative ring",
  stroke: none,
  inset: 0pt,

  section("Parameters"),

  declare($a$, $R$),
  declare($b$, $R$),
  declare($c$, $R$),

  section("Assumptions"),

  assume(
    "A1.",
    $a + b = c$,
    accent($a = c - b$),
    contrast($b = c - a$),
  ),

  section("Observations"),

  observe(
    "T1.",
    $a + b = b + a$,
    mute([This continuation is deliberately de-emphasised.]),
  ),
)

#arithmetic

#v(1.5em)

#calc(
  calc-start($a + b$),

  step(
    $=$,
    hint([Commutativity]),
    accent($b + a$),
  ),

  step(
    $=$,
    hint([Undischarged side-condition]),
    warn($c$),
  ),

  calc-finish,
)
