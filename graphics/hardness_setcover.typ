#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  for j in range(3) {
    only(j + 1)[
      #canvas(length: 2cm, {
        import draw: *
        let w = 12
        let h = 1.2
        let tick_len = 0.2

        // Calcolo posizioni relative per le soglie
        // x = 0 corrisponde ad alpha = 1
        // x = 10 corrisponde ad alpha = ln(n)
        // x = 12 corrisponde ad alpha > ln(n)
        let pos_start = 0
        let pos_ln = 8
        let pos_end = 12

        // --- Definizione delle aree colorate ---

        // phantom rectangle, placeholder
        rect((pos_start, 0), (pos_start, h), fill: red.lighten(100%), stroke: none, name: "hard")

        // Impossibile / NP-Hard (Rosso): da 1 a ln(n)
        if j == 2 {
          rect((pos_start, 0), (pos_ln, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")
        }

        // Facile / Greedy (Verde): da ln(n) in poi
        if j >= 1 {
          rect((pos_ln, 0), (pos_end, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")
        }

        // --- Testi all'interno delle aree ---

        if j == 2 {
          content("hard.center", [
            #set align(center)
            *#text(fill: rgb("#990000"), size: 1.1em)[NP-Hard]*
          ])
        }

        if j >= 1 {
          content("facile.center", [
            #set align(center)
            *#text(fill: rgb("#008000"), size: 1.1em)[Greedy]*
          ])
        }

        // --- Asse orizzontale ---

        line((-0.2, 0), (pos_end + 0.5, 0), mark: (end: ">"), stroke: 1pt)
        content((pos_end + 0.8, 0), $alpha$)

        // --- Griglia e Etichette ---

        let ticks = (
          (pos_start, "1"),
          (pos_ln, $ln n$)
        )

        for (x, label) in ticks {
          line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
          content((x, -0.4), label)
        }

        // Annotazione specifica inapprossimabilità
        if j == 2 {
          content((pos_ln, -1.0), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #set align(center)
            #box(height: 2em)[
              Feige (1998) \
              Dinur & Steurer (2014)
            ]
          ])
        } else {
          content((pos_ln, -1.0), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #set align(center)
            #box(height: 2em)[]
          ])
        }
      })
    ]
  }
)
