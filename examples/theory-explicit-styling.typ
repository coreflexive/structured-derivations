#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#centred-theory(
  "Explicit theory styling",

  section("Observations"),

  // Typographic contrast need not imply colour.
  observe(
    "L1",
    text(weight: "semibold", [Meet commutativity]),
    $rho inter sigma = sigma inter rho$,
  ),

  // Colour is attached only where the source asks for it.
  observe(
    "L2",
    accent(text(weight: "semibold", [Join commutativity])),
    $rho union sigma = sigma union rho$,
  ),

  // Continuations are ordinary content unless explicitly styled.
  observe(
    "L3",
    text(weight: "semibold", [Meet associativity]),
    $(rho inter sigma) inter tau = rho inter (sigma inter tau)$,
    mute([Recorded here for reference; deliberately de-emphasised.]),
  ),
)
