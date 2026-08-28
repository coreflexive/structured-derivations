// ------------------------------------------------------------
// Relation-specific notation
// ------------------------------------------------------------
// Keep this module deliberately small: generic theory/calculation machinery
// must not depend on relation algebra notation.
//
// The compact names below are deliberately math-callable.  Typst treats a
// hyphen as subtraction in math mode, so `$rel-id(A)$` cannot be the pleasant
// mathematical interface we want.  The kebab-case aliases are retained for
// ordinary code-mode use and backwards compatibility.

// Relation type A ~ B.
#let reltype(A, B) = $#A tilde #B$

// Typed identity, universal, and empty relations.
#let relid(A) = $op("id")_#A$
#let reltop(A, B) = $top_(#A#B)$
#let relbot(A, B) = $bot_(#A#B)$

// Converse and complement.
#let relconverse(R) = $breve(#R)$
#let relcomplement(R) = $overline(#R)$

// Direct image notation R[X].
#let relimage(R, X) = $R[#X]$

// Code-mode aliases.
#let rel-type = reltype
#let rel-id = relid
#let rel-top = reltop
#let rel-bot = relbot
#let rel-converse = relconverse
#let rel-complement = relcomplement
#let rel-image = relimage
