#import "@preview/cetz:0.4.2": canvas, draw

#import "sns_colormap.typ": *

#figure(
  canvas(length: 1.1cm, {
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
      ("1","2"), ("1","3"), ("1","4"), ("1", "24"),
      ("2","3"), ("2","13"), ("2","14"),
      ("3","4"), ("3","5"), ("3","13"),
      ("4","5"), ("4","6"), ("4", "24"), ("4", "25"), ("4", "27"), ("4", "28"),
      ("5","13"), ("5","12"), ("5","6"), ("5","7"),
      ("6","7"), ("6","8"), ("6","11"), ("6","10"), ("6", "28"),
      ("7","8"), ("7","11"), ("7","10"),
      ("8","11"), ("8","10"), ("8", "28"),
      ("9","8"), ("9","10"), ("9", "22"), ("9", "26"),
      ("11","10"),
      ("14","13"), ("14","16"),
      ("13","16"), ("13","12"),
      ("16","12"), ("16","15"), ("16","17"),
      ("12","7"), ("12","11"), ("12","15"),
      ("15","11"), ("15","18"), ("15","17"), ("15","19"),
      ("17","19"),
      ("18","11"), ("18","21"), ("18","20"), ("18","19"),
      ("19","20"),
      ("21","11"), ("21","10"), ("21","20"),
      ("22", "26"), ("22", "25"), ("22", "23"), ("22", "28"),
      ("23", "25"), ("23", "27"), ("23", "26"),
      ("24", "25"), ("24", "27"),
      ("25", "27"), ("25", "28"),
      ("28", "9")
    )

    let cliqueA = ("6", "7", "8", "10", "11")
    let cliqueB = ("4", "24", "25", "27")

    // Generazione degli spigoli
    for i in range(edges.len()) {
      let u = edges.at(i).at(0)
      let v = edges.at(i).at(1)
      let pos_u = nodes.at(u)
      let pos_v = nodes.at(v)

      if cliqueA.contains(u) and cliqueA.contains(v) {
        line(pos_u, pos_v, stroke: 2.5pt + red_sns)
      } else if cliqueB.contains(u) and cliqueB.contains(v) {
        line(pos_u, pos_v, stroke: 2.5pt + orange_sns)
      } else {
        line(pos_u, pos_v, stroke: 1.5pt + dark_blue_sns)
      }
    }

    // Generazione dei vertici
    for (id, pos) in nodes {
      if cliqueA.contains(id) {
        circle(pos, radius: 0.3, fill: red_sns, stroke: 2.5pt + red_sns)
      } else if cliqueB.contains(id) {
        circle(pos, radius: 0.3, fill: orange_sns, stroke: 2.5pt + orange_sns)
      } else {
        circle(pos, radius: 0.3, fill: dark_blue_sns, stroke: 1.5pt + dark_blue_sns)
      }
    }

    let pos_bersaglio = (-2.4, 8.1)
    let pos_testo_B = (-4, 8.5)

    line(pos_testo_B, pos_bersaglio, mark: (end: ">", fill: black), stroke: 1.5pt + black)

    content(pos_testo_B, anchor: "south-east", padding: 0.1cm)[
      #text(fill: black, size: 1em)[
        $4/5$-approx of $omega(G)$
      ]
    ]

    // Contrappeso geometrico invisibile per calibrare il bounding box
    line((15.0, 8.0), (15.0, 8.0), stroke: none)
  })
)
