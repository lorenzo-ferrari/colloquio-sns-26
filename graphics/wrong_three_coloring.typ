#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *


#figure(
  canvas(length: 1.1cm, {
    import draw: *
      let nodes = (
        "0": (5.0, 9.0),
        "1": (8.8, 6.2),
        "2": (7.4, 1.8),
        "3": (2.6, 1.8),
        "4": (1.2, 6.2),
        "5": (5.0, 7.0),
        "6": (6.9, 5.6),
        "7": (6.2, 3.4),
        "8": (3.8, 3.4),
        "9": (3.1, 5.6),
      )

      let edges = (
        ("0", "1"), ("1", "2"), ("2", "3"), ("3", "4"), ("4", "0"),
        ("0", "5"), ("1", "6"), ("2", "7"), ("3", "8"), ("4", "9"),
        ("5", "7"), ("7", "9"), ("6", "8"), ("8", "5"), ("9", "6"), 
      )

      let A = ("1", "0", "3", "7")
      let B = ("2", "8", "4")
      let C = ("6", "9", "5")

      // Generazione degli spigoli
      for i in range(edges.len()) {
        let u = edges.at(i).at(0)
        let v = edges.at(i).at(1)
        let pos_u = nodes.at(u)
        let pos_v = nodes.at(v)

        if A.contains(u) and A.contains(v) {
          line(pos_u, pos_v, stroke: 2.5pt + purple_sns)
        } else if B.contains(u) and B.contains(v) {
          line(pos_u, pos_v, stroke: 2.5pt + orange_sns)
        } else if C.contains(u) and C.contains(v) {
          line(pos_u, pos_v, stroke: 2.5pt + pale_blue_sns)
        } else {
          line(pos_u, pos_v, stroke: 1.5pt + dark_blue_sns)
        }
    }

    // Generazione dei vertici
    for (id, pos) in nodes {
      if A.contains(id) {
        circle(pos, radius: 0.3, fill: purple_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, weight: "bold", size: 12pt)[#id])
      } else if B.contains(id) {
        circle(pos, radius: 0.3, fill: orange_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      } else {
        circle(pos, radius: 0.3, fill: pale_blue_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      }
    }
  })
)
