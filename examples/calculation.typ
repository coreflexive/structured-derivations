#import "../lib.typ": *

#set page(
  width: auto,
  height: auto,
  margin: 4pt,
)

#set text(size: 11pt)

#let obs-01 = calc(
  calc-start(
    $X = R[X]$
  ),

  step(
    $equiv$,
    [Extensionality],
    $(forall a | : a in X equiv a in R[X])$,
  ),

  step(
    $arrow.double$,
    [Predicate calculus],
    $(forall a | a in R[X] : a in X)$
  ),

  step(
    $equiv$,
    [Direct image],
    $(forall a | (exists x | x in X : a "R" x) : a in X)$
  ),

  step(
    $equiv$,
    [Splitting],
    $(forall x | x in X : (forall a | a "R" x : a in X))$
  ),

  step(
    $equiv$,
    [Nesting],
    $(forall a,x | x in X and a "R" x : a in X)$
  ),

  step(
    $equiv$,
    [Definition of Left closed],
    $"Left closed" R space X$
  ),

  calc-finish
)

#centred-boxed(obs-01)
