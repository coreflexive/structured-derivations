// ------------------------------------------------------------
// Calculation machinery
// ------------------------------------------------------------

#import "style.typ": shared-hint-fill, shared-warn-fill

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

// Row-producing constructors return arrays of grid cells.
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

#let boxed(
  body,
  width: auto,
  inset: 1em,
  stroke: 0.6pt,
  radius: 3pt,
) = {
  align(center)[
    #box(
      width: width,
      inset: inset,
      stroke: stroke,
      radius: radius,
    )[
      #align(left)[
        #body
      ]
    ]
  ]
}
