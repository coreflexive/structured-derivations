#import "../lib.typ": *

// Deliberately short pages make the continuation behaviour easy to inspect.
#set page(
  width: 105mm,
  height: 115mm,
  margin: 12mm,
)

#set text(size: 11pt)

#centred-theory(
  "Theory spanning pages",

  section("Parameters"),
  declare($A$, $"Set"$),
  declare($R$, $A tilde A$),

  section("Observations"),
  observe("1.", $R subset.eq R$),
  observe("2.", $R union R = R$),
  observe("3.", $R inter R = R$),
  observe("4.", $R union bot = R$),
  observe("5.", $R inter top = R$),
  observe("6.", $R subset.eq top$),
  observe("7.", $bot subset.eq R$),
  observe("8.", $R union top = top$),
  observe("9.", $R inter bot = bot$),
  observe("10.", $R = R$),
  observe("11.", $R subset.eq R$),
  observe("12.", $R union R = R$),
)
