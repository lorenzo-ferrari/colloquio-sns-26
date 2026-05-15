#import "@preview/polylux:0.4.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  for j in range(5) {
    only(j + 1)[
      #canvas(length: 1.7cm, {
        import draw: *
        let w = 12
        let h = 1.2
        let tick_len = 0.2
        
        // Calcolo posizioni relative per le soglie
        // Scala lineare dove x=0 è 1.0 e x=12 è 2.0 (quindi step = 0.1 per unità)
        let pos_one = 0
        let pos_76 = 2
        let pos_136 = 0.3606 * 12
        let pos_sqrt2 = 4.97
        let pos_two = 12
        let pos_max = 15

        // --- Definizione delle aree colorate ---
        
        // Facile (Verde): sempre presente
        rect((pos_two, 0), (pos_max, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")
        content("facile.center", [
          #set align(center)
          *#text(fill: rgb("#008000"), size: 1.1em)[Greedy]*
        ])

        // Area ignota (Grigio con ?)
        if j == 0 {
          rect((pos_one, 0), (pos_two, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        } else if j == 1 {
          rect((pos_76, 0), (pos_two, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        } else if j == 2 {
          rect((pos_136, 0), (pos_two, h), fill: gray.lighten(80%), stroke: none, name: "unknown")
          content("unknown.center", [*?*])
        }

        // Impossibile / NP-Hard (Rosso)
        if j >= 1 {
          let end_hard = if j == 1 { pos_76 } else if j <= 3 { pos_136 } else { pos_sqrt2 }
          rect((pos_one, 0), (end_hard, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")
          content("hard.center", [
            #set align(center)
            *#text(fill: rgb("#990000"), size: 1.1em)[NP-Hard]*
          ])
        }

        // Delicato / Gap (Arancione)
        if j == 3 {
          // UGC-Hard da 1.3606 a 2 (Khot-Regev 2003)
          rect((pos_136, 0), (pos_two, h), fill: rgb("#ffe5cc"), stroke: none, name: "delicato")
          content("delicato.center", [
            #set align(center)
            *#text(fill: rgb("#cc6600"), size: 1.1em)[UGC-Hard]*
          ])
        } else if j >= 4 {
          // UGC-Hard ridotto: da sqrt(2) a 2 (dopo Dinur et al. 2018)
          rect((pos_sqrt2, 0), (pos_two, h), fill: rgb("#ffe5cc"), stroke: none, name: "delicato")
          content("delicato.center", [
            #set align(center)
            *#text(fill: rgb("#cc6600"), size: 1.1em)[UGC-Hard]*
          ])
        }

        // --- Asse orizzontale ---
        
        line((-0.2, 0), (pos_max + 0.5, 0), mark: (end: ">"), stroke: 1pt)
        content((pos_max + 0.8, 0), $alpha$)

        // --- Griglia e Etichette ---
        
        let ticks = ()
        if j == 0 {
          ticks = ((pos_one, "1"), (pos_two, $2$))
        } else if j == 1 {
          ticks = ((pos_one, "1"), (pos_76, $7\/6$), (pos_two, $2$))
        } else if j <= 3 {
          ticks = ((pos_one, "1"), (pos_76, $7\/6$), (pos_136, $1.360...$), (pos_two, $2$))
        } else {
          ticks = ((pos_one, "1"), (pos_76, $7\/6$), (pos_136, ""), (pos_sqrt2, $sqrt(2)$), (pos_two, $2$))
        }

        for (x, label) in ticks {
          line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
          content((x, -0.4), label)
        }
        
        // Annotazioni storiche
        if j >= 1 {
          content((pos_76, -1), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1em)[ Håstad (2001) ]
          ])
        } else {
          content((pos_76, -1), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #box(height: 1em)[]
          ])
        }

        if 2 <= j and j <= 3 {
          content((pos_136, -1.0), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            Dinur, Safra (2002)
          ])
        }

        if j >= 4 {
          content((pos_sqrt2, -1.0), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            #set align(center)
            Khot, Minzer, Safra (2018)
          ])
        }

        if j >= 3 {
          content((pos_two, -1.0), [
            #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
            Khot, Regev (2003)
          ])
        }
      })
    ]
  }
)
