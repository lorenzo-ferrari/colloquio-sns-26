#import "@preview/cetz:0.4.2": canvas, draw

#figure(
  canvas(length: 1.7cm, {
    import draw: *
    let w = 12
    let h = 1.2
    let tick_len = 0.2
    
    // Calcolo posizioni relative per le soglie
    // Scala lineare dove x=0 è 1.0 e x=12 è 2.0 (quindi step = 0.1 per unità)
    // alpha = 1.0 -> x = 0
    // alpha = sqrt(2) approx 1.414 -> x = (0.414 / 1.0) * 12 = 4.97
    // alpha = 2.0 -> x = 12
    let pos_sqrt2 = 4.97
    let pos_two = 12
    let pos_76 = 2

    // --- Definizione delle aree colorate ---
    
    // Impossibile / NP-Hard (Rosso): da 1 a sqrt(2)
    rect((0, 0), (pos_sqrt2, h), fill: rgb("#ffcccc"), stroke: none, name: "hard")
    
    // Delicato / Gap (Arancione): da sqrt(2) a 2
    rect((pos_sqrt2, 0), (pos_two, h), fill: rgb("#ffe5cc"), stroke: none, name: "delicato")
    
    // Facile (Verde): da 2 in su
    rect((pos_two, 0), (pos_two + 3, h), fill: rgb("#d4ffcf"), stroke: none, name: "facile")

    // --- Testi all'interno delle aree ---
    
    content("hard.center", [
      #set align(center)
      *#text(fill: rgb("#990000"), size: 1.1em)[NP-Hard]*

      // #text(fill: rgb("#990000"), size: 0.8em)[Inapprossimabile ($< sqrt(2)$)]
    ])

    content("delicato.center", [
      #set align(center)
      *#text(fill: rgb("#cc6600"), size: 1.1em)[UGC-Hard]*

      // #text(fill: rgb("#cc6600"), size: 0.8em)[Focus: UGC conjecture]
    ])

    content("facile.center", [
      #set align(center)
      *#text(fill: rgb("#008000"), size: 1.1em)[Greedy]*

      // #text(fill: rgb("#008000"), size: 0.8em)[2-appr. greedy]
    ])

    // --- Asse orizzontale ---
    
    line((-0.2, 0), (pos_two + 3.5, 0), mark: (end: ">"), stroke: 1pt)
    content((pos_two + 3.8, 0), $alpha$)

    // --- Griglia e Etichette ---
    
    let ticks = (
      (0, "1"),
      (pos_76, $7\/6$),
      (pos_sqrt2, $sqrt(2)$),
      (pos_two, "2")
    )

    for (x, label) in ticks {
      line((x, -tick_len/2), (x, tick_len/2), stroke: 1pt)
      content((x, -0.4), label)
    }
    
    // Annotazione specifica Risultato 2018
    // line((pos_sqrt2, -0.8), (pos_sqrt2, -0.1), stroke: (dash: "dashed", paint: gray, thickness: 0.5pt))
    content((pos_sqrt2, -1.0), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Dinur, Khot, Kindler, \ Minzer, Safra (2018)
    ])

    // greedy 2 approximation
    // line((pos_two, -0.8), (pos_two, -0.1), stroke: (dash: "dashed", paint: gray, thickness: 0.5pt))
    // content((pos_two, -1.0), [
    //  #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
    //  greedy
    // ])

    content((pos_76, -1), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Håstad (2001)
    ])

    content((pos_two, -1), [
      #set text(size: 0.7em, style: "italic", fill: gray.darken(20%))
      Khot, Regev (2003)
    ])
  })
)
