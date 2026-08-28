#import "../lib/calc.typ": *
#import "../lib/annotations.typ": *
#import "../lib/doc.typ": *

#set page(
  margin: 2.5cm,
)

#set text(
  size: 11pt,
)

#doc-title[Nested derivations]

This example isolates the nesting mechanism used by structured derivations.

#artefact(
  [Outer derivation with an open subtask],
  centred-boxed[
    #calc(
      calc-row(
        start,
        $E_0$,
      ),

      step(
        $equiv$,
        hint([Outer law]),
        $E_1$,
      ),

      step(
        $equiv$,
        hint([Law producing a proof obligation]),
        calc(
          calc-row(
            start,
            warn($P$),
          ),
        ),
      ),

      calc-row(
        gap,
        $E_2$,
      ),

      step(
        $equiv$,
        hint([Outer law]),
        $E_3$,
      ),

      calc-row(
        finish,
        [],
      ),
    )
  ],
)

#artefact(
  [The same subtask expanded],
  centred-boxed[
    #calc(
      calc-row(
        start,
        $E_0$,
      ),

      step(
        $equiv$,
        hint([Outer law]),
        $E_1$,
      ),

      step(
        $equiv$,
        hint([Law producing a proof obligation]),
        calc(
          calc-row(
            start,
            warn($P$),
          ),

          step(
            $equiv$,
            hint([Nested law]),
            $Q$,
          ),

          step(
            $equiv$,
            hint([Nested law]),
            $R$,
          ),

          calc-row(
            finish,
            [],
          ),
        ),
      ),

      calc-row(
        gap,
        $E_2$,
      ),

      step(
        $equiv$,
        hint([Outer law]),
        $E_3$,
      ),

      calc-row(
        finish,
        [],
      ),
    )
  ],
)
