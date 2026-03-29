#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *

#let canvas_length = 1.5cm

#let cell_side = 0.8
#let proof_bottom_y = 4.5
#let proof_top_y = proof_bottom_y + cell_side
#let proof_mid_y = proof_bottom_y + cell_side / 2
#let verifier_width = 3
#let verifier_height = 2
#let r_height = 0.7
#let verifier_left_x = 7.0
#let verifier_right_x = verifier_left_x + verifier_width
#let verifier_mid_x = verifier_left_x + verifier_width / 2
#let verifier_top_y = 2.5
#let verifier_bottom_y = verifier_top_y - verifier_height
#let line_y = verifier_bottom_y + r_height
#let verifier_mid_y = verifier_top_y - (verifier_height - r_height) / 2
#let r_mid_y = verifier_bottom_y + r_height / 2

#let queries = (
  (1, 3, 7, 8, 13),
  (2, 3, 6, 10, 11),
)

#for j in (0, 1) {
  only(1 + 5 * j)[
    #figure(
      canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y))
          content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
        }

        // Verificatore V (stato iniziale separato)
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2)
        line((verifier_left_x, line_y), (verifier_right_x, line_y))
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        // Stringa casuale R
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, line_y), radius: 0.1)
        content((verifier_mid_x - 4, r_mid_y), text(size: 20pt)[$R$])

        content((verifier_left_x - 3.3, line_y + 0.2), image("../pics/coin.svg", width: 1cm), anchor: "south")
        content((verifier_left_x - 2.5, line_y + 0.2), image("../pics/coin.svg", width: 1cm), anchor: "south")
        content((verifier_left_x - 1.7, line_y + 0.2), image("../pics/coin.svg", width: 1cm), anchor: "south")
      })
    )
  ]

  only(2 + 5 * j)[
    #figure(
      canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y))
          content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, line_y), radius: 0.1, stroke: none)

        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2)
        line((verifier_left_x, line_y), (verifier_right_x, line_y))
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R$])
      })
    )
  ]

  only(3 + 5 * j)[
    #figure(
      canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y))
          content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, line_y), radius: 0.1, stroke: none)

        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2)
        line((verifier_left_x, line_y), (verifier_right_x, line_y))
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R$])

        // Frecce per le query agli indici specifici della prova
        for q in queries.at(j) {
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (verifier_mid_x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: black),
            stroke: 0.8pt
          )
        }
      })
    )
  ]

  only(4 + 5 * j)[
    #figure(
      canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y))
          if i not in queries.at(j) {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, line_y), radius: 0.1, stroke: none)

        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2)
        line((verifier_left_x, line_y), (verifier_right_x, line_y))
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R$])

        // Frecce per le query agli indici specifici della prova
        for q in queries.at(j) {
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (verifier_mid_x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: black),
            stroke: 0.8pt
          )
        }
      })
    )
  ]

  only(5 + 5 * j)[
    #figure(
      canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y))
          if i not in queries.at(j) {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, line_y), radius: 0.1, stroke: none)

        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2)
        line((verifier_left_x, line_y), (verifier_right_x, line_y))
        if j == 0 {
          content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[*ACCEPT*])
        } else {
          content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[*REJECT*])
        }
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R$])

        // Frecce per le query agli indici specifici della prova
        for q in queries.at(j) {
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (verifier_mid_x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: black),
            stroke: 0.8pt
          )
        }
      })
    )
  ]
}
