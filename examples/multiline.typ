#import "../lib.typ": *

#doc-title[Structured Derivations — Multiline Theory Entries]

#let rows = (
  section([A multiline entry]),

  theory-text-row([O1], [
    First line of the entry. \
    The marker belongs to the entry, not to this continuation line. \
    Nor to this one.
  ]),

  section([Mixed mathematical content]),

  theory-text-row([O2], [
    $x <= y$ \
    $y <= z$ \
    therefore $x <= z$
  ]),
).flatten()

#centred-theory(
  [Continuation rows stay in the body column],
  rows,
)
