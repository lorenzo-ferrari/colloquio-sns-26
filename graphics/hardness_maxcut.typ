#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  canvas(length: 2cm, {
    import draw: *
    let w = 12
    let h = 1.2
    let tick_len = 0.2

    // Scala lineare dove x=0 è alpha=0.5 e x=12 è alpha=1.0
    // step = 0.5 / 12 = 0.0416 per unità
    
    let pos_05 = 0.0
    let pos_gw = 9.07  // (0.878 - 0.5) / 0.5 * 12
    let pos_1617 = 10.58 // (0.941 - 0.5) / 0.5 * 12
    let pos_one = w

    // --- Definizione delle aree colorate ---

    // Facile / SDP (Verde): da 0.5 a alpha_GW
    rect((pos_05, 0), (pos_gw, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")

    // Delicato / Gap UGC (Arancione): da alpha_GW a 16/17
    rect((pos_gw, 0), (pos_1617, h), fill: rgb("#ffe5cc"), stroke: none, name: "delicato")

    // NP-Hard (Rosso): da 16/17 a 1
    rect((pos_1617, 0), (pos_one, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")

    // --- Testi all'interno delle aree ---

    content("facile.center", [
      #set align(center)
      // *#text(fill: rgb("#008000"), size: 1.1em)[SDP]*
      #text(fill: rgb("#008000"), size: 1.1em)[*Goemans-Williamson's SDP*]
    ])

    content("delicato.center", [
      #set align(center)
      *#text(fill: rgb("#cc6600"), size: 0.9em)[UGC-Hard]*
    ])

    content("hard.center", [
      #set align(center)
      *#text(fill: rgb("#990000"), size: 0.9em)[NP-Hard]*
    ])

    // --- Asse orizzontale ---

    line((-0.5, 0), (pos_one + 0.5, 0), mark: (end: ">"), stroke: 1pt)
    content((pos_one + 0.8, 0), $alpha$)

    // --- Griglia e Etichette ---

    let ticks = (
      (pos_05, "0.5"),
      (pos_gw, $0.878...$),
      (pos_1617, $16\/17$),
      (pos_one, "1")
    )

    for (x, label) in ticks {
      line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
      content((x, -0.4), label)
    }

    // Annotazioni storiche
    content((pos_gw, -0.9), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Khot et al. (2004)
    ])

    content((pos_1617, -1.2), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Håstad (2001)
    ])
    
    content((pos_05, -1.0), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Random/Greedy
    ])
  })
)
