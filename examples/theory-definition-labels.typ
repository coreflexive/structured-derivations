#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#centred-theory(
  "Definition labels",

  section("Definitions"),

  // No reference available: preserve the traditional `+` marker.
  define(
    $x colon.eq y$,
  ),

  // A definition with a reference label uses the marker column.
  define(
    $op("Atom")(a)$,
    $a != bot and (forall Q | Q subset.eq a => (Q = bot or Q = a))$,
    label: "D1",
  ),
)
