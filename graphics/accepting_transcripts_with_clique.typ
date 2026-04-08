#import "@preview/cetz:0.4.2": canvas, draw
#let punto-verde = (fill: rgb("#00EE90"), stroke: none, radius: 0.15)
#figure(
  canvas(length: 1.3cm, {
    import draw: *

    line((0, 0), (0, 5.5), mark: (end: ">", fill: black), name: "y-axis")
    line((0, 0), (5.5, 0), mark: (end: ">", fill: black), name: "x-axis")

    content((0, 5.8), [$2^q$], anchor: "east")
    content((5.8, 0), [$n^c$], anchor: "north-west")
    content((-0.6, 2.5), [$Pi(i_1)...Pi(i_q) $], size: 1.5em, angle: 90deg)
    content((2.5, -0.6), [$R$], size: 1.5em)

    for i in range(1, 6) {
      line((i, 0.2), (i, 5.3), stroke: 0.5pt + black)
      line((0.2, i), (5.3, i), stroke: 0.5pt + black)
    }

    line((1, 2), (3, 3), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((1, 2), (3, 2), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((1, 4), (5, 5), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((1, 4), (2, 5), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((1, 4), (3, 3), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((2, 1), (3, 2), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((2, 1), (5, 1), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((2, 5), (5, 5), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((3, 3), (4, 4), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((3, 3), (5, 1), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((4, 3), (5, 1), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((4, 3), (5, 5), stroke: (paint: red, dash: "dashed", thickness: 2pt))
    line((4, 4), (2, 5), stroke: (paint: red, dash: "dashed", thickness: 2pt))

    line(
      (1, 4), (2, 5), (5, 5),
      stroke: (paint: blue, thickness: 2pt, cap: "round", join: "round"),
      close: true,
      fill: blue.lighten(50%).transparentize(50%)
    )

    circle((1, 2), ..punto-verde)
    circle((1, 4), ..punto-verde)
    circle((2, 1), ..punto-verde)
    circle((2, 5), ..punto-verde)
    circle((3, 2), ..punto-verde)
    circle((3, 3), ..punto-verde)
    circle((4, 3), ..punto-verde)
    circle((4, 4), ..punto-verde)
    circle((5, 1), ..punto-verde)
    circle((5, 5), ..punto-verde)

  })
)
