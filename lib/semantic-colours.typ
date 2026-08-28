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
    focus($a = c - b$),
    tentative($b = c - a$),
  ),

  section("Observations"),

  observe(
    "T1.",
    $a + b = b + a$,
    confirmed($(-a) (-b) = a b$),
    meta([$T1$ is available as a named law.]),
    mute([This continuation is deliberately de-emphasised.]),
  ),
)

#arithmetic

#v(1.5em)

#calc(
  calc-start($a + b$),

  step(
    $=$,
    [Commutativity],
    focus($b + a$),
  ),

  step(
    $=$,
    [Undischarged side-condition],
    warn($c$),
  ),

  calc-finish,
)
