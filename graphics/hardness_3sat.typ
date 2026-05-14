#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  for j in range(2) {
    only(j + 1)[
      #canvas(length: 2.0cm, {
        import draw: *
        let w = 12
        let h = 1.2
        let tick_len = 0.2

        // Calcolo posizioni relative per le soglie
        // Scala lineare dove x=0 corrisponde a 0 e x=12 corrisponde a 1.0
        // alpha = 0.0 -> x = 0
        // alpha = 7/8 = 0.875 -> x = 12 * 0.875 = 10.5
        // alpha = 1.0 -> x = 12
        let pos_start = 0
        let pos_78 = 10
        let pos_end = 12

        // --- Definizione delle aree colorate ---

        // Facile (Verde): da 0 a 7/8
        rect((pos_start, 0), (pos_78, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")

        // Impossibile / NP-Hard (Rosso): da 7/8 a 1
        if j == 1 {
          rect((pos_78, 0), (pos_end, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")
        }

        // --- Testi all'interno delle aree ---

        content("facile.center", [
          #set align(center)
          *#text(fill: rgb("#008000"), size: 1.1em)[Random assignment]*
        ])

        if j == 1 {
          content("hard.center", [
            #set align(center)
            *#text(fill: rgb("#990000"), size: 1.1em)[NP-Hard]*
          ])
        }

        // --- Asse orizzontale ---

        line((-0.2, 0), (pos_end + 0.5, 0), mark: (end: ">"), stroke: 1pt)
        content((pos_end + 0.8, 0), $alpha$)

        // --- Griglia e Etichette ---

        let ticks = (
          (pos_start, "0"),
          (pos_78, $7\/8$),
          (pos_end, "1")
        )

        for (x, label) in ticks {
          line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
          content((x, -0.4), label)
        }

        // Annotazione specifica Håstad
        if j == 1 {
          content((pos_78, -0.8), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1em)[Håstad (2001)]
          ])
        } else {
          content((pos_78, -0.8), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1em)[]
          ])
        }
      })
    ]
  }
)
