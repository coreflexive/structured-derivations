// ------------------------------------------------------------
// Surrounding document helpers
// ------------------------------------------------------------

#import "style.typ": shared-primary-fill, shared-secondary-fill

#let doc-title(body) = align(center)[
  #pad(bottom: 1em)[
    #text(
      size: 1.25em,
      weight: "bold",
      fill: shared-primary-fill,
    )[#body]
  ]
]

#let artefact-title(body) = align(center)[
  #pad(top: 0.9em, bottom: 0.45em)[
    #text(
      size: 1em,
      weight: "semibold",
      fill: shared-secondary-fill,
    )[#body]
  ]
]

#let artefact(title, body) = align(center)[
  #block(
    breakable: false,
  )[
    #artefact-title(title)

    #body
  ]
]

#let artefact-gap = v(1.2em)
