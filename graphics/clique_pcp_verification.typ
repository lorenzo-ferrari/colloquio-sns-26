#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *

#let canvas_length = 1.5cm

#let cell_side = 0.8
#let proof_bottom_y = 4.5
#let proof_top_y = proof_bottom_y + cell_side
#let proof_mid_y = proof_bottom_y + cell_side / 2
#let verifier_width = 3
#let verifier_height = 3
#let r_height = 0.7
#let verifier_left_x = 7.0
#let verifier_right_x = verifier_left_x + verifier_width
#let verifier_mid_x = verifier_left_x + verifier_width / 2
#let verifier_top_y = 2.5
#let verifier_bottom_y = verifier_top_y - verifier_height
#let first_line_y = verifier_bottom_y + r_height
#let second_line_y = verifier_bottom_y + 2 * r_height
#let verifier_mid_y = (verifier_top_y + second_line_y) / 2
#let r_mid_y = verifier_bottom_y + r_height / 2
#let x_mid_y = first_line_y + r_height / 2
#let x_transcripts = verifier_left_x - 6
#let y_transcripts = first_line_y

#let color_v_bg = rgb("EFE9E3")
#let color_x_bg = rgb("D9CFC7")
#let color_r_bg = rgb("C9B59C")
#let color_v_stroke = black
#let color_pi_empty = rgb("fafafa")
#let color_pi_active = rgb("EFE9E3")
#let color_pi_stroke = black // rgb("9e9e9e")
#let color_arrow = black // rgb("1565c0")
#let color_accept = green // rgb("2e7d32")
#let color_reject = red // rgb("c62828")

#let queries = (
  (1, 4, 7, 12),
  (2, 4, 9, 13),
  (2, 5, 7, 12),
)

#figure(
  for j in (0, 1, 2) {
    only(1 + 4 * j)[
      #canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let is_set = i in queries.slice(0, j).flatten()
          let cx = 2.5 + i * cell_side
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y), fill: color_pi_empty, stroke: color_pi_stroke)
          if is_set {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, first_line_y), radius: 0.1, stroke: none)

        // Sfondi separati per le tre sezioni del Verificatore
        rect((verifier_left_x, second_line_y), (verifier_right_x, verifier_top_y), radius: (top: 0.2), fill: color_v_bg, stroke: none)
        rect((verifier_left_x, first_line_y), (verifier_right_x, second_line_y), fill: color_x_bg, stroke: none)
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, first_line_y), radius: (bottom: 0.2), fill: color_r_bg, stroke: none)

        // Bordo esterno e linee divisorie interne
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2, stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, first_line_y), (verifier_right_x, first_line_y), stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, second_line_y), (verifier_right_x, second_line_y), stroke: 1.5pt + color_v_stroke)
        
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, x_mid_y), text(size: 20pt)[$x$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R_#(j+1)$])
      })
    ]

    only(2 + 4 * j)[
      #canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          let is_set = i in queries.slice(0, j).flatten()
          let is_active = i in queries.at(j)
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y), fill: if is_active { color_pi_active } else { color_pi_empty }, stroke: color_pi_stroke)
          if is_set {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, first_line_y), radius: 0.1, stroke: none)

        // Sfondi separati per le tre sezioni del Verificatore
        rect((verifier_left_x, second_line_y), (verifier_right_x, verifier_top_y), radius: (top: 0.2), fill: color_v_bg, stroke: none)
        rect((verifier_left_x, first_line_y), (verifier_right_x, second_line_y), fill: color_x_bg, stroke: none)
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, first_line_y), radius: (bottom: 0.2), fill: color_r_bg, stroke: none)

        // Bordo esterno e linee divisorie interne
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2, stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, first_line_y), (verifier_right_x, first_line_y), stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, second_line_y), (verifier_right_x, second_line_y), stroke: 1.5pt + color_v_stroke)
        
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, x_mid_y), text(size: 20pt)[$x$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R_#(j+1)$])

        // Frecce per le query agli indici specifici della prova
        for i in range(queries.at(j).len()) {
          let q = queries.at(j).at(i)
          let origin-x = verifier_left_x + verifier_width * (i + 1) / 6
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (origin-x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: color_arrow, stroke: color_arrow),
            stroke: 1pt + color_arrow
          )
        }
      })
    ]

    only(3 + 4 * j)[
      #canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          let is_set = i in queries.slice(0, j).flatten()
          let is_active = i in queries.at(j)
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y), fill: if is_active { color_pi_active } else { color_pi_empty }, stroke: color_pi_stroke)
          if is_set or is_active {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, first_line_y), radius: 0.1, stroke: none)

        // Sfondi separati per le tre sezioni del Verificatore
        rect((verifier_left_x, second_line_y), (verifier_right_x, verifier_top_y), radius: (top: 0.2), fill: color_v_bg, stroke: none)
        rect((verifier_left_x, first_line_y), (verifier_right_x, second_line_y), fill: color_x_bg, stroke: none)
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, first_line_y), radius: (bottom: 0.2), fill: color_r_bg, stroke: none)

        // Bordo esterno e linee divisorie interne
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2, stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, first_line_y), (verifier_right_x, first_line_y), stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, second_line_y), (verifier_right_x, second_line_y), stroke: 1.5pt + color_v_stroke)
        
        content((verifier_mid_x, verifier_mid_y), text(size: 20pt)[$V$])
        content((verifier_mid_x, x_mid_y), text(size: 20pt)[$x$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R_#(j+1)$])

        // Frecce per le query agli indici specifici della prova
        for i in range(queries.at(j).len()) {
          let q = queries.at(j).at(i)
          let origin-x = verifier_left_x + verifier_width * (i + 1) / 6
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (origin-x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: color_arrow, stroke: color_arrow),
            stroke: 1pt + color_arrow
          )
        }
      })
    ]

    only(4 + 4 * j)[
      #canvas(length: canvas_length, {
        import draw: *

        // Vettore della prova Pi (9 celle)
        content((1.5, proof_mid_y), text(fill: black, size: 30pt)[$Pi:$])
        for i in range(15) {
          let cx = 2.5 + i * cell_side
          let is_set = i in queries.slice(0, j).flatten()
          let is_active = i in queries.at(j)
          rect((cx, proof_bottom_y), (cx + cell_side, proof_top_y), fill: if is_active { color_pi_active } else { color_pi_empty }, stroke: color_pi_stroke)
          if is_set or is_active {
            content((cx + cell_side / 2, proof_mid_y), text(size: 18pt)[$#calc.rem(calc.rem(i * 17, 23), 2)$])
          } else {
            content((cx + cell_side / 2, proof_mid_y), text(size: 10pt)[$?$])
          }
        }

        // solo per l'allineamento
        rect((verifier_left_x - 4, verifier_bottom_y), (verifier_right_x - 4, first_line_y), radius: 0.1, stroke: none)

        // Sfondi separati per le tre sezioni del Verificatore
        rect((verifier_left_x, second_line_y), (verifier_right_x, verifier_top_y), radius: (top: 0.2), fill: color_v_bg, stroke: none)
        rect((verifier_left_x, first_line_y), (verifier_right_x, second_line_y), fill: color_x_bg, stroke: none)
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, first_line_y), radius: (bottom: 0.2), fill: color_r_bg, stroke: none)

        // Bordo esterno e linee divisorie interne
        rect((verifier_left_x, verifier_bottom_y), (verifier_right_x, verifier_top_y), radius: 0.2, stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, first_line_y), (verifier_right_x, first_line_y), stroke: 1.5pt + color_v_stroke)
        line((verifier_left_x, second_line_y), (verifier_right_x, second_line_y), stroke: 1.5pt + color_v_stroke)
        
        content((verifier_mid_x, verifier_mid_y), text(size: 25pt, fill: color_accept)[*ACCEPT*])
        content((verifier_mid_x, x_mid_y), text(size: 20pt)[$x$])
        content((verifier_mid_x, r_mid_y), text(size: 20pt)[$R_#(j+1)$])

        // Frecce per le query agli indici specifici della prova
        for i in range(queries.at(j).len()) {
          let q = queries.at(j).at(i)
          let origin-x = verifier_left_x + verifier_width * (i + 1) / 6
          let target-x = 2.5 + q * cell_side + cell_side / 2
          let target-y = proof_bottom_y
          line(
            (origin-x, verifier_top_y), // Punto di origine: centro-alto del Verificatore
            (target-x, target-y), // Punto di destinazione: base della cella
            mark: (end: "triangle", size: 0.2, fill: color_arrow, stroke: color_arrow),
            stroke: 1pt + color_arrow
          )
        }
      })
    ]
  }
)
