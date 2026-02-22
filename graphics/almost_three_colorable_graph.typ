#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *


#figure(
  canvas(length: 1.1cm, {
    import draw: *
    let nodes = (
      "0": (5.0, 9.0),
      "1": (7.8, 7.8),
      "2": (9.0, 5.0),
      "3": (7.8, 2.2),
      "4": (5.0, 1.0),
      "5": (2.2, 2.2),
      "6": (1.0, 5.0),
      "7": (2.2, 7.8),
      "8": (5.0, 7.0),
      "9": (6.4, 6.4),
      "10": (7.0, 5.0),
      "11": (6.4, 3.6),
      "12": (5.0, 3.0),
      "13": (3.6, 3.6),
      "14": (3.0, 5.0),
      "15": (3.6, 6.4),
    )

    let edges = (
      ("0", "1"), ("1", "2"), ("2", "3"), ("3", "4"),
      ("4", "5"), ("5", "6"), ("6", "7"), ("7", "0"),
      ("8", "9"), ("9", "10"), ("10", "11"), ("11", "12"),
      ("12", "13"), ("13", "14"), ("14", "15"), ("15", "8"),
      ("0", "8"), ("1", "9"), ("2", "10"), ("3", "11"),
      ("4", "12"), ("5", "13"), ("6", "14"), ("7", "15"),
      ("0", "15"), ("1", "8"), ("2", "9"), ("3", "10"),
      ("4", "11"), ("5", "12"), ("6", "13"), ("7", "14"),
    )
      let A = ("0", "3", "6", "9", "12", "15") // ("0", "3", "6", "7")
      let B = ("2", "5", "8", "11", "14") // ("2", "8", "9")
      let C = ("1", "4", "7", "10", "13") // ("1", "4", "5")

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
        // content(pos, text(fill: black, size: 12pt)[#id])
      } else if B.contains(id) {
        circle(pos, radius: 0.3, fill: orange_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      } else if C.contains(id) {
        circle(pos, radius: 0.3, fill: pale_blue_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      } else {
        circle(pos, radius: 0.3, fill: white_sns, stroke: 1.5pt + dark_blue_sns)
        // content(pos, text(fill: black, size: 12pt)[#id])
      }
    }
  })
)
