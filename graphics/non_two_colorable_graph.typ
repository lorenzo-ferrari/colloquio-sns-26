#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *


#figure(
  canvas(length: 1.1cm, {
    import draw: *
    let nodes = (
      "5": (3.2, 6.5),
      "6": (2.5, 4.5),
      "7": (4.5, 4.2),
      "8": (1.5, 2.5),
      "10": (3.5, 0.5),
      "11": (6.0, 2.5),
      "12": (6.3, 5.0),
      "13": (5.5, 7.2),
      "15": (8.0, 3.8),
      "16": (8.5, 6.5),
      "17": (10.0, 4.2),
      "18": (7.8, 2.0),
      "19": (9.8, 2.2),
      "20": (9.2, -0.2),
      "21": (7.0, 0.8),
    )

    let edges = (
      ("5","13"), ("5","6"),
      ("6","7"), ("6","8"),
      ("7", "11"), ("7", "12"),
      ("8","10"),
      ("10", "11"),
      ("12","15"),
      ("13","16"),
      ("16","12"), ("16","17"),
      ("15","18"), ("15","17"),
      ("17","19"),
      ("18","11"), ("18","21"), ("18","19"),
      ("19","20"),
      ("21","10"), ("21","20"),
    )

    let highlight = ()

    // Generazione degli spigoli
    for i in range(edges.len()) {
      let u = edges.at(i).at(0)
      let v = edges.at(i).at(1)
      let pos_u = nodes.at(u)
      let pos_v = nodes.at(v)

      if highlight.contains(u) and highlight.contains(v) {
        line(pos_u, pos_v, stroke: 2.5pt + red_sns)
      } else {
        line(pos_u, pos_v, stroke: 1.5pt + dark_blue_sns)
      }
    }

    // Generazione dei vertici
    for (id, pos) in nodes {
      if highlight.contains(id) {
        circle(pos, radius: 0.3, fill: orange_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, weight: "bold", size: 12pt)[#id])
      } else {
        circle(pos, radius: 0.3, fill: white_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      }
    }
  })
)
