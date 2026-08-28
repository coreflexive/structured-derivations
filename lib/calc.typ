// ------------------------------------------------------------
// Calculation machinery
// ------------------------------------------------------------
//
// STRUCTURAL COLOUR INVARIANT
// ---------------------------
// The first grid column is calculation notation: start/end markers,
// relation signs, gap markers, and blank continuation cells. Content in
// that marker column receives the shared structural marker colour.
//
// The body column is never coloured merely because of its position.
// Reasons and mathematical bodies are rendered exactly as supplied; use
// explicit helpers such as `hint(...)`, `accent(...)`, etc. when colour
// is wanted there.

#import "style.typ": shared-marker-fill

#let start = $diamond.small.filled$
#let finish = $square.small.filled$
#let gap = $dots$

// Row-producing constructors return arrays of grid cells.
// `calc` itself has no frame and no centring: it is the naked calculation.
#let calc(
  column-gutter: 1em,
  row-gutter: 1em,
  ..rows,
) = {
  grid(
    columns: (auto, auto),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    align: left,
    ..rows.pos().flatten()
  )
}

#let calc-marker(body) = text(fill: shared-marker-fill, body)

#let calc-row(marker, body) = (
  calc-marker(marker),
  body,
)

#let calc-start(body) = calc-row(
  start,
  body,
)

#let calc-finish = calc-row(
  finish,
  [],
)

// A calculation step occupies two grid rows:
// relation | reason
//          | body
//
// IMPORTANT: `reason` is rendered exactly as supplied. In particular, it is
// not coloured merely because it is the second argument. Write `hint(reason)`
// explicitly when the quiet blue reason style is wanted.
#let step(relation, reason, body) = (
  ..calc-row(relation, reason),
  ..calc-row([], body),
)

#let lines(
  row-gutter: 1em,
  ..xs,
) = {
  grid(
    columns: (auto,),
    row-gutter: row-gutter,
    align: left,
    ..xs.pos()
  )
}

// A frame with no imposed horizontal alignment.
// This is the boxed + uncentred presentation.
#let uncentred-boxed(
  body,
  width: auto,
  inset: 1em,
  stroke: 0.6pt,
  radius: 3pt,
) = box(
  width: width,
  inset: inset,
  stroke: stroke,
  radius: radius,
)[
  #align(left)[
    #body
  ]
]

// The explicitly centred framed presentation.
#let centred-boxed(
  body,
  width: auto,
  inset: 1em,
  stroke: 0.6pt,
  radius: 3pt,
) = align(center)[
  #uncentred-boxed(
    body,
    width: width,
    inset: inset,
    stroke: stroke,
    radius: radius,
  )
]

// Backwards-compatible name: historically `boxed` also centred its body.
#let boxed(
  body,
  width: auto,
  inset: 1em,
  stroke: 0.6pt,
  radius: 3pt,
) = centred-boxed(
  body,
  width: width,
  inset: inset,
  stroke: stroke,
  radius: radius,
)
