#import "../lib.typ": *

#set text(size: 15pt)

#theory(
  "Arithmetic in a commutative ring",
  stroke: none,
  inset: 0pt,

  section("Imports"),

  import-theory(
    [$"Commutative ring"$],
    subst: subs(
      sub($A$, $R$),
    ),
  ),

  section("Parameters"),

  declare(
    $a$,
    $R$,
  ),

  declare(
    $b$,
    $R$,
  ),

  declare(
    $c$,
    $R$,
  ),

  section("Assumptions"),

  assume(
    "A1.",
    $a + b = c$,
  ),

  section("Observations"),

  observe(
    "T1.",
    $a = c - b$,
  ),

  observe(
    "T2.",
    $b = c - a$,
  ),

  observe(
    "T3.",
    $a + b = b + a$,
  ),

  observe(
    "T4.",
    $a dot (b + c) = a dot b + a dot c$,
  ),

  observe(
    "T5.",
    $a dot 0 = 0$,
  ),

  observe(
    "T6.",
    $(-a) dot b = -(a dot b)$,
  ),

  observe(
    "T7.",
    $(-a) dot (-b) = a dot b$,
  ),
)