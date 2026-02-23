#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *

#figure(
  canvas(length: 1.1cm, {
    import draw: *
    let nodes = (
      "0": (5.0, 5.0), // Baricentro
      "1": (5.0, 8.0), // Vertice superiore
      "2": (7.6, 3.5), // Vertice inferiore destro
      "3": (2.4, 3.5), // Vertice inferiore sinistro
    )

    let edges = (
      ("0", "1"), ("0", "2"), ("0", "3"), // Collegamenti dal centro ai vertici
      ("1", "2"), ("2", "3"), ("3", "1"), // Perimetro del triangolo equilatero
    )

    let A = ("0",)
    let B = ("1", "2")
    let C = ("3",)

    // Generazione degli spigoli
    for i in range(edges.len()) {
      let u = edges.at(i).at(0)
      let v = edges.at(i).at(1)
      let pos_u = nodes.at(u)
      let pos_v = nodes.at(v)

      line(pos_u, pos_v, stroke: 1.5pt + dark_blue_sns)
    }

    // Generazione dei vertici
    for (id, pos) in nodes {
      circle(pos, radius: 0.3, fill: dark_blue_sns, stroke: 1.5pt + dark_blue_sns)
    }
  })
)
