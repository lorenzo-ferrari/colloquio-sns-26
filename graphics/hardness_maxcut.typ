#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  for j in range(4) {
    only(j + 1)[
      #canvas(length: 2cm, {
        import draw: *
        let w = 12
        let h = 1.2
        let tick_len = 0.2
        
        let pos_05 = 0.0
        let pos_gw = 9.07  // (0.878 - 0.5) / 0.5 * 12
        let pos_1617 = 10.58 // (0.941 - 0.5) / 0.5 * 12
        let pos_one = w

        // --- Definizione delle aree colorate ---

        // Gradiente iniziale: dall'inizio dell'asse fino a 0.5
        rect((-0.5, 0), (pos_05, h), fill: gradient.linear(white, rgb("#d4ffcf")), stroke: none)

        // Area ignota (Grigio con ?)
        if j == 0 {
          rect((pos_05, 0), (pos_one, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        } else if j == 1 {
          rect((pos_gw, 0), (pos_one, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        } else if j == 2 {
          rect((pos_gw, 0), (pos_1617, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        }

        // Facile / SDP (Verde): da 0.5 a alpha_GW
        if j >= 1 {
          rect((pos_05, 0), (pos_gw, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")
          content("facile.center", [
            #set align(center)
            #text(fill: rgb("#008000"), size: 1.1em)[*Goemans-Williamson's SDP*]
          ])
        }

        // NP-Hard (Rosso): da 16/17 a 1
        if j >= 2 {
          rect((pos_1617, 0), (pos_one, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")
          content("hard.center", [
            #set align(center)
            *#text(fill: rgb("#990000"), size: 0.9em)[NP-Hard]*
          ])
        }

        // Delicato / Gap UGC (Arancione): da alpha_GW a 16/17
        if j >= 3 {
          rect((pos_gw, 0), (pos_1617, h), fill: rgb("#ffe5cc"), stroke: none, name: "delicato")
          content("delicato.center", [
            #set align(center)
            *#text(fill: rgb("#cc6600"), size: 0.9em)[UGC-Hard]*
          ])
        }

        // --- Asse orizzontale ---

        line((-0.5, 0), (pos_one + 0.5, 0), mark: (end: ">"), stroke: 1pt)
        content((pos_one + 0.8, 0), $alpha$)

        // --- Griglia e Etichette ---

        let ticks = ()
        if j == 0 {
          ticks = (
            (pos_05, "0.5"),
            (pos_one, "1")
          )
        } else if j == 1 {
          ticks = (
            (pos_05, "0.5"),
            (pos_gw, $0.878...$),
            (pos_one, "1")
          )
        } else {
          ticks = (
            (pos_05, $1\/2$),
            (pos_gw, $0.878...$),
            (pos_1617, $16\/17$),
            (pos_one, "1")
          )
        }

        for (x, label) in ticks {
          line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
          content((x, -0.4), label)
        }

        // Annotazioni storiche
        if j >= 3 {
          content((pos_gw, -0.9), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1em)[Khot et al. (2004)]
          ])
        }

        if j >= 2 {
          content((pos_1617, -1.2), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1.2em)[Håstad (2001)]
          ])
        } else {
          content((pos_1617, -1.2), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1.2em)[]
          ])
        }
      })
    ]
  }
)
