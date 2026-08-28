// ------------------------------------------------------------
// Calculation machinery
// ------------------------------------------------------------

#import "style.typ": shared-hint-fill, shared-warn-fill
#import "style.typ": shared-focus-fill, shared-tentative-fill, shared-confirmed-fill
#import "style.typ": shared-meta-fill, shared-muted-fill

#let start = $diamond.small.filled$
#let finish = $square.small.filled$
#let gap = $dots$

#let colour(fill, body) = {
  if fill == none {
    body
  } else {
    text(fill: fill, body)
  }
}

#let hint(body) = text(
  fill: shared-hint-fill,
  size: 0.95em,
  body,
)

#let warn(body) = text(
  fill: shared-warn-fill,
  size: 0.95em,
  body,
)

// Semantic colour annotations.  These are intentionally presentation-only:
// they may wrap any individual piece of content accepted by a theory or
// calculation constructor.
#let focus(body) = colour(shared-focus-fill, body)
#let tentative(body) = colour(shared-tentative-fill, body)
#let confirmed(body) = colour(shared-confirmed-fill, body)
#let meta(body) = colour(shared-meta-fill, body)
#let mute(body) = colour(shared-muted-fill, body)

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

#let calc-row(marker, body) = (
  marker,
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
#let step(relation, reason, body) = (
  relation,
  hint(reason),
  [],
  body,
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
