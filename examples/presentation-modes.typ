#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 12pt,
)

#set text(size: 11pt)

#let theory-rows = (
  section("Parameters"),
  declare($A$, $"Set"$),
  declare($R$, reltype($A$, $A$)),
  section("Observations"),
  observe("1.", $relid(A) subset.eq R$),
)

#let tiny-calc = calc(
  calc-start($rho inter sigma$),
  step(
    $equiv$,
    [Commutativity],
    $sigma inter rho$,
  ),
  calc-finish,
)

#unboxed-theory(
  "Unboxed + uncentred theory",
  theory-rows,
)

#separator()

#theory(
  "Boxed + uncentred theory",
  theory-rows,
)

#separator()

#centred-theory(
  "Boxed + centred theory",
  theory-rows,
)

#separator()

#tiny-calc

#separator()

#uncentred-boxed(tiny-calc)

#separator()

#centred-boxed(tiny-calc)
