#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *


#figure(
  canvas(length: 1.0cm, {
    import draw: *
    let nodes = (
      "1": (1.5, 10.0),
      "2": (5.0, 10.0),
      "3": (3.2, 8.2),
      "14": (7.5, 8.5),
      "4": (0.7, 6.9),
      "5": (3.2, 6.5),
      "13": (5.5, 7.2),
      "16": (8.5, 6.5),
      "12": (6.3, 5.0),
      "6": (2.5, 4.5),
      "7": (4.5, 4.2),
      "15": (8.0, 3.8),
      "17": (10.0, 4.2),
      "8": (1.5, 2.5),
      "11": (6.0, 2.5),
      "18": (7.8, 2.0),
      "19": (9.8, 2.2),
      "9": (0.0, 0.9),
      "10": (3.5, 0.5),
      "21": (7.0, 0.8),
      "20": (9.2, -0.2),
      "22": (-1, 3.3),
      "23": (-4.0, 3.4),
      "24": (-1, 9),
      "25": (-2.2, 5.3),
      "26": (-2, 1.1),
      "27": (-3.7, 7),
      "28": (0.3, 5),
    )

    let edges = (
      ("1","2"), ("1","3"), ("1", "24"),
      ("2","14"),
      ("3","4"), ("3","13"), ("3", "14"),
      ("4","5"), ("4", "24"), ("4", "25"), ("4", "28"),
      ("5","13"), ("5","6"),
      ("6","7"), ("6","8"), ("6", "28"),
      ("7","10"),
      ("8","10"), ("8", "22"),
      ("9","10"), ("9", "22"), ("9", "26"),
      ("10", "11"),
      ("14","16"),
      ("13","16"),
      ("16","12"), ("16","17"),
      ("12","7"), ("12","11"), ("12","15"),
      ("15","18"), ("15","17"),
      ("17","19"),
      ("18","11"), ("18","21"), ("18","19"),
      ("19","20"),
      ("21","10"), ("21","20"),
      ("22", "25"), ("22", "23"), ("22", "28"),
      ("23", "27"), ("23", "26"),
      ("24", "27"),
      ("25", "27"),
    )

    let highlight = ("1", "4", "6", "10", "12", "13", "14", "17", "18", "20", "22", "26", "27")

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
        circle(pos, radius: 0.3, fill: orange_sns, stroke: 1.5pt + dark_blue_sns) // rgb("AB3502"))
        // content(pos, text(fill: dark_blue_sns, weight: "bold", size: 14pt)[#id])
      } else {
        circle(pos, radius: 0.3, fill: purple_sns, stroke: dark_blue_sns + 1.5pt)
        // content(pos, text(fill: black, size: 14pt)[#id])
      }
    }
  })
)
