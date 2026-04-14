#import "@preview/polylux:0.4.0": *
// #import "@preview/sns-polylux-template:0.2.0": *
#import "sns-polylux-template.typ": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2": canvas, draw
#import "graphics/sns_colormap.typ": *

#let custom-box(title: "", color: navy, body) = showybox(
  title: title,
  title-style: (
    weight: "bold",
  ),
  frame: (
    border-color: color.darken(20%),
    title-color: color.darken(10%),
    body-color: color.lighten(90%),
    body-inset: (y: 1em, x: 0.5em),
    radius: 5pt,
    thickness: 1.5pt,
  ),
  shadow: (offset: 3pt, color: gray.lighten(50%)),
  body
)

#let bluebox(title: "", body) = custom-box(title: title, color: dark_blue_sns, body)
#let greenbox(title: "", body) = custom-box(title: title, color: green_sns, body)
#let redbox(title: "", body) = custom-box(title: title, color: red_sns, body)

#let stickybox(rotation: 0deg, width: 100%, fill: rgb(255, 240, 172), tape: true, body) = {
  return rotate(rotation)[
    #block(width: width)[
      #layout(size => {
        let height = measure(image("./pics/background.svg", width: size.width)).height
        place(
          bottom + center,
          dy: 0.6 * height,
        )[
          #image("./pics/background.svg", width: size.width)
        ]
        box(
          fill: fill,
          width: width,
          inset: (top: if tape { 12pt } else { 8pt }, x: 8pt, bottom: 8pt),
        )[
          #body
          #if tape {
            place(
              top + center,
              // dy: -2mm - 12pt,
              dy: -8mm,
            )[
              #image(
                "./pics/tape.svg",
                // width: if type(width) == ratio { calc.clamp(width * 0.35cm / 1cm, 1, 4) * 1cm } else { calc.clamp(width * 0.35 / 1cm, 1, 4) * 1cm },
                width: 3cm, // if type(width) == ratio { calc.clamp(width * 0.35cm / 1cm, 1, 4) * 1cm } else { calc.clamp(width * 0.35 / 1cm, 1, 4) * 1cm },
                height: 1cm,
              )
            ]
          }
        ]
      })
    ]
  ]
}

#set text(lang: "en", size: 20pt)
#show: sns-polylux-template.with(
  aspect-ratio    : "16-9",
  title           : [The PCP Theorem],
  subtitle        : [and its consequences for the approximation of hard problems],
  event           : [Scuola Normale Superiore -- 28 Aprile 2026], // lo tengo?
  short-title     : [],
  short-event     : [], // Scuola Normale Superiore — 04/2026],
  logo-1          : image("pics/solo_logo_SNS_bianco.svg"),
  // logo-2          : image("pics/logo_SNS_blu.svg"),
  authors         : (
    {
      set text(top-edge: 0pt, bottom-edge: 0pt)
      grid(gutter: 1.3em, columns: (1fr, 1.2fr),
        align(right,[]),
        align(left, [Lorenzo Ferrari]),
        align(right,[Supervised by:]),
        align(left, [Alessandro Panconesi (La Sapienza)]),
        align(right,[]),
        align(left, [Alessandra Caraceni (SNS)]),
      )
    },
  )
)

// definirò in maniera informale ma accurata la questione P vs NP
// queste definizioni diventano rigorose in termini di MdT

#title-slide()
#sns-polylux-template_logo-1.update(image("pics/logo_SNS_bianco.svg"))

#new-section-slide([P vs NP])

#slide(
  title: [P: 2-Colorability]
)[


  #bluebox(title: [Problem (2-Colorability)])[
    #set text(size: 9mm)
    #align(center)[
      Given a graph $G(V, E)$, decide whether it is $2$-colorable.
    ]
  ]
]

#slide(
  title: [P: 2-Colorability]
)[
  #grid(columns:(0.5fr, 0.5fr), [
    #align(center)[
      #only(1)[ #include "./graphics/two_colorable_graph.typ" ]
      #only((2, 3))[ #include "./graphics/two_colored_graph.typ" ]
    ]
  ],
  [
    #align(center)[
      #only((1, 2))[ #include "./graphics/non_two_colorable_graph.typ" ]
      #only((3))[ #include "./graphics/non_two_colored_graph.typ" ]
    ]
  ])
]

#slide(
  title: [What does _efficient_ mean?]
)[
  #align(center)[
    #set text(size: 50pt)

    *efficient* $arrow.l.r.double$ *polynomial time*.

    #set text(size: 30pt)
    #uncover(2)[
      $2$-Colorability can be solved efficiently in $O(|V| + |E|)$.
    ]
  ]
]

#slide(
  title: [NP: 3-Colorability]
)[
  #bluebox(title: [Problem (3-Colorability)])[
    #set text(size: 9mm)
    #align(center)[
      Given a graph $G(V, E)$, determine whether it is $3$-colorable.
    ]
  ]

  #uncover(2)[
    #align(center)[
      #set text(size: 3em, red)
      *DRASTIC CHANGE!*
    ]
  ]
]


#slide(
  title: [NP: 3-Colorability]
)[
  #grid(columns: (0.4fr, 0.6fr),[
    #set align(center)
    #only((1, 2, 3))[#include "./graphics/three_colorable_graph.typ"]
    #only(4)[
      #figure(
        image("./pics/kurt-godel.jpg", width: 80%)
      )
    ]
  ],
  [
    #v(1em)
    #set list(marker: (none, [•]))
    #list(
      uncover((2, 3, 4))[- No efficient algorithm is known. ],
      uncover((3, 4))[- It is conjectured it doesn't exist ($"P"$ vs $"NP"$). ],
      uncover(4)[- If it did, mathematical proofs could be _found_ efficiently. ], // with respect to the length of the proof
    )
  ])
]

#slide(
  title: [What can we say about 3-Colorability?]
)[
  #grid(columns: (0.4fr, 0.6fr), [
    #set align(center)
    #include "./graphics/wrong_three_coloring.typ"
  ],[
    #set align(center)
    #set text(2em)
    Correctness can be efficiently *verified*.
  ])
]

#slide(
  title: [P vs NP]
)[
  #grid(columns: (0.45fr, 0.04fr, 0.45fr), [
    #greenbox(title: [#text(30pt)[P]])[
      #set align(center)
      #set text(size:9mm)
      Decision problems \ whose solution \ can be *found* efficiently.
    ]
    ],[
    ],[
    #greenbox(title: [#text(30pt)[NP]])[
      #set align(center)
      #set text(size:9mm)
      Decision problems \ whose solution \ can be *verified* efficiently.
    ]
  ])
]

#slide(
  title: [Millenium Problem]
)[
  #bluebox(title: [#text(30pt)[P vs NP]])[
    #set align(center)
    #set text(size:15mm)
    #v(.5em)
    Is $"P"$ a proper subset of $"NP"$?
    #v(.5em)
  ]

  #align(center)[
    #uncover(2)[ Is it true that $3$-$"Colorability"$ and thousands of other \ problems *cannot* be solved efficiently? ]
  ]
]

#slide(
  title: [Why care about 3-Colorability?]
)[
  #redbox(title: [Karp (1972); Lovász (1973)])[
    #set align(center)
    #set text(size:9mm)
    Every problem in $"NP"$ can be formulated in terms of $3$-Colorability.
  ]
]


// parlerò del PCP, che è un altro teorema che parla di dimostrazioni
// racconto che ha varie ramificazioni, io mi concentro sui problemi di ottimizzazione
// immaginiamo di avere la dimostrazione di un problema e di adottare la seguente procedura di verifica piuttosto sbrigativa
#new-section-slide([The PCP Theorem])

#slide()[
  #grid(columns: (0.5fr, 0.5fr), [
    #uncover((3, 4, 5, 6))[
      The PCP Theorem gives a different and surprising characterization of $"NP"$.

      Informally,
  ]
    #set list(marker: (none, [•]))
    - #uncover((4, 5, 6))[ - you are handed a proof _in a certain format_; ]
    - #uncover((5, 6))[ - you select, say, 100 lines at random; ]
    - #uncover(6)[ - you consider the proof valid $arrow.double.r.l$ you do not find mistakes. ]
  ],
  [
    #only(1)[
      #figure(
        image("./pics/nyt_page.jpg") // width: 80%)
      )
    ]
    #only((2, 3, 4, 5, 6))[
      #figure(
        image("./pics/nyt.jpg") // width: 80%)
      )
    ]
  ])
]

#slide(
  title: [The class $"PCP"(O(log n), O(1))$],
)[
  Let $c, q in ZZ^+$ be constants and $V$ be an efficient probabilistic verifier. On input #box[$x in {0, 1}^n$], to verify a proof #box[$Pi: ZZ^+ -> {0, 1}$]:
  #set list(marker: (none, [•]))
  - #uncover((2,3,4))[ - $V$ reads a random string $R$ of up to $c log n$ bits; ]
  - #uncover((3,4))[ - based on $R$, $V$ chooses $q$ locations $i_1, ..., i_q$ of the proof and reads the corresponding bits $Pi(i_1), ..., Pi(i_q)$; ]
  - #uncover(4)[ - based on $R$ and $Pi(i_1), ..., Pi(i_q)$, $V$ decides whether to accept or reject. ]
]

#slide()[
  #set align(center)
  #include "./graphics/pcp_verification.typ"
]

#slide(
  title: [Probabilistic verification of 3-Colorability]
)[
  #grid(columns: (0.5fr, 0.5fr), [
    #v(1.5em)
    #set align(center)
    #include "./graphics/unknown_three_coloring.typ"

    #box(height: 1em)[
      #only(4)[ #text(size: 30pt, green)[*ACCEPT*] ]
      #only(8)[ #text(size: 30pt, red)[*REJECT*] ]
    ]
  ],
  [
    // - $x = $ input graph;
    - $Pi = $ coloring;
    - $V$ chooses at random ($R$) a constant number of constraints;
    - accept $arrow.double.r.l.long$ all of them are satisfied.
  ])
]

#slide(
  title: [Issue]
)[
  #grid(columns: (0.5fr, 0.5fr), [
    #set align(center)
    #include "./graphics/almost_three_colorable_graph.typ"
  ],
  [
    #set align(center)
    #set text(size: 9mm)

    Colorings could violate only \
    a fraction $1 / m$ of the constraints.

    #v(.2em)
    #rotate(90deg)[#text(size: 40pt)[$ => $]]

    Very unlikely to catch \ the unsatisfied edge...
  ])
]

#slide(
  title: [The class $"PCP"(O(log n), O(1))$],
)[
    #set text(size:9mm)
    A decision problem belongs to the class $"PCP"(O(log n), O(1))$ if there exists a verifier $V$ as above s.t.:

  #grid(columns: (0.45fr, 0.04fr, 0.45fr), [
    #greenbox(title: [on a YES instance])[
      #set align(center)
      #set text(size:9mm)
      There is a #box[$Pi : ZZ^+ -> {0, 1}$] s.t. $Pr[V "accepts"] = 1$.
    ]
    ],[
    ],[
    #greenbox(title: [on a NO instance])[
      #set align(center)
      #set text(size:9mm)
      For any $Pi : ZZ^+ -> {0, 1}$ it holds $Pr[V "accepts"] <= 1 / 2$.
    ]
  ])

  #uncover(2)[
    *Observation:* by $(c, q) mapsto (k c, k q)$, we can make $Pr[V "is wrong"] <= 1 / 2^k$.
  ]
]


#slide(
  title: [So, is 3-Colorability in $"PCP"(O(log n), O(1))$?],
)[
  #grid(rows: (0.3fr, 0.7fr),[
    #v(10mm)
    #uncover((2,3))[
      #align(center + horizon)[
        #set text(size: 20mm, green)
        *YES!*
      ]
    ]
  ],
  [
    #uncover(3)[
      #bluebox(title: "Key")[
        #set text(size: 9mm)
          There exists an efficient transformation $G mapsto G'$ such that
          - $G$ $3$-colorable $arrow.double$ $G'$ $3$-colorable;
          // at least?
          - $G$ not $3$-colorable $arrow.double$ every coloring of $G'$ violates at least a constant fraction of constraints.
      ]
    ]
  ]
  )
]


#slide(
  title: [The PCP Theorem],
)[
    #redbox(title:"Arora, Safra (1992); Arora, Lund, Motwani, Sudan, Szegedy (1992); Dinur (2006)")[
    #set align(center)
    #set text(size:15mm)
    #v(.5em)
    $ "NP" = "PCP"(O(log n), O(1)). $
    #v(.5em)
  ]
]

#new-section-slide([Hardness of Approximation])

#slide(
  title: [Max-Clique],
)[
    #greenbox(title:"Definition (Clique)")[
    #set align(center)
    #set text(size: 9mm)
    A _clique_ in a graph $G(V, E)$ is a complete subgraph of $G$, \ i.e. a subset of pairwise adjacent nodes.
  ]

  #uncover(2)[
    #bluebox(title:"Problem (Max-Clique)")[
      #set align(center)
      #set text(size: 9mm)
      Given $G$, determine $omega(G) := max{|K| : K subset.eq G$ is a clique$}.$
    ]
  ]
]

#slide(
  title: [Max-Clique]
)[
  #set align(center)
  #include "./graphics/max_clique.typ"
]

#slide(
  title: [Max-Clique is Hard],
)[
    #figure(
      image("./pics/clique-karp.png") // width: 80%)
    )
    #redbox(title:"Karp (1972)")[
    #set align(center)
    #set text(size:9mm)
    If there is an efficient algorithm for $"Max-Clique"$, then $"P" = "NP"$.
  ]
]

#slide(
  title: [Can we approximate it?]
)[
  #set align(center)
  #include "./graphics/max_clique_approx.typ"
]

#slide(
  title: [Hardness of approximating Max-Clique],
)[
  #redbox(title: "Feige, Goldwasser, Lovász, Safra, Szegedy (1991)")[
    #set align(center)
    #set text(size:9mm)
    If there is an efficient $epsilon$-approximation of $"Max-Clique"$ \ for some $epsilon > 0$, then $"P" = "NP"$.
    // For any $epsilon > 0$, it is $"NP"$-Hard to $epsilon$-approximate $"Max-Clique"$.
  ]
]

#slide(
  title: [Proof],
)[
  // Enfatizza che qui 3-Col non ha nessun ruolo particolare
  We will show how to use an efficient $macron(epsilon)$-approximation of $"Max-Clique"$ to decide $3"-Colorability"$ efficiently.

  #uncover(2)[
  #bluebox(title: "Fundamental reduction")[
    #set text(size:9mm)
    There is an efficient transformation of graphs $G mapsto G'$ s.t.:
    - $G$ is $3$-colorable $arrow.double omega(G') = M$;
    - $G$ is not $3$-colorable $arrow.double omega(G') < macron(epsilon) M$.
  ]
]
]

#slide(
  title: [Decision procedure],
)[
  Let $|K|$ be an $macron(epsilon)$-approximation of $omega(G')$.
  #align(center)[
  #table(
    columns: (0.5fr, 0.5fr),
    rows: (5em, 3em, 3em),
    stroke: none,
    align: center + horizon,
    fill: (x, y) => if y == 0 { none } else { none },
    table.header(
      [
        #scale(40%)[ #include "./graphics/three_colorable_graph.typ" ]
      ],
      [
        #scale(60%)[ #include "./graphics/four_clique.typ" ]
      ]
    ),
    [$omega(G') = M$], [$omega(G') < macron(epsilon) M$],
    [
      #uncover((2, 3, 4))[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $|K| >= macron(epsilon)M$ ~~~ #v(1em)
        ]
      ]
    ],
    [
      #uncover((3, 4))[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $|K| < macron(epsilon) M$ ~~~ #v(1em)
        ]
      ]
    ]
  )

  #set text(size: 30pt) 
  #uncover(4)[ $G$ is $3$-colorable $arrow.r.l.double$ $|K| >= macron(epsilon)M$. ]
  ]
]

#slide(
  title: [Building $G'$],
)[
  #grid(
    columns: (0.6fr, 0.4fr), gutter: 0.05fr,
    [
      Fix a $"PCP"$-verifier for $3"-Colorability"$ with probability error bounded by some $delta < macron(epsilon)$, reading:
      - an input graph $G$;
      - $c log n$ random bits;
      - $q$ bits from the proof.
    ],
    [
      #uncover(2)[
        #stickybox(
          rotation: 3deg,
          tape: true,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          *Reminder*

          Fixed $G$, the verifier accepts or rejects based solely on \ $R$ and $Pi(i_1), ..., Pi(i_q)$.
          #v(.5em)
        ]
      ]
    ]
  )
]

#slide(
  title: [Nodes of $G'$],
)[
  #grid(columns: (0.6fr, 0.4fr),
    [
      The information $chevron.l R; Pi(i_1)...Pi(i_q) chevron.r$ is an _accepting transcript_ if:
      - on the random string $R$, the verifier reads the bits at positions $i_1, ..., i_q$ and
      - reading the bits $Pi(i_1), ..., Pi(i_q)$ causes the verifier to accept.

      #uncover((2, 3))[
        Nodes of $G' = $ $\{ chevron.l R; Pi(i_1)...Pi(i_q) chevron.r : V$ accepts$\}$
      ]
    ],
    [
      #only((1, 2))[ #include "./graphics/transcripts.typ" ]
      #only(3)[ #include "./graphics/accepting_transcripts.typ" ]
    ]
  )
]

#slide(
  title: [Edges of $G'$],
)[
  #grid(columns: (0.6fr, 0.4fr),
    [
      Two accepting transcripts $chevron.l R_1; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2; Pi(j_1)...Pi(j_q) chevron.r$ are _consistent_ if they do not disagree on any bit of the proof, i.e. $i_a = j_b$ implies $Pi(i_a) = Pi(j_b)$.
      
      #v(1em)

      #set align(center)
      #uncover((2, 3))[
        #set text(size: 25pt)
        Two accepting transcripts are \ adjacent in $G'$
        $arrow.l.r.double$
        they are consistent.
      ]
    ],
    [
      #only((1, 2))[ #include "./graphics/accepting_transcripts.typ" ]
      #only(3)[ #include "./graphics/accepting_transcripts_with_edges.typ" ]
    ]
  )
]

#slide(
  title: [Cliques $arrow.r.l.double$ Proofs],
)[
  #grid(columns: (0.55fr, 0.05fr, 0.4fr),
    [
      #set align(center)
      #set text(size: 25pt)
      Cliques $K$ in $G'$ correspond to \
      partial proofs $tilde(Pi)_K : S subset.eq ZZ^+ -> {0, 1}$,\
      where for every $Pi_K$ extending $tilde(Pi)_K$

      $ "Pr"[V "accepts" Pi_K] >= (|K|)/n^c. $
    ],
    [
    ],
    [
      #only(1)[#include "./graphics/accepting_transcripts_with_edges.typ"]
      #only(2)[#include "./graphics/accepting_transcripts_with_clique.typ"]
    ]
  )
]

#slide(
  title: [Cliques $arrow.r.l.double$ Proofs],
)[
  #set align(center)
  #include "./graphics/clique_pcp_verification.typ"
]

#slide(
  title: [Putting all pieces together],
)[
  #align(center + horizon)[
  #table(
    columns: (0.5fr, 0.5fr),
    rows: (8em, 4em, 4em, auto),
    stroke: none,
    align: center + horizon,
    fill: (x, y) => if y == 0 { none } else { none },
    table.header(
      [
        #scale(50%)[ #include "./graphics/three_colorable_graph.typ" ]
      ],
      [
        #scale(70%)[ #include "./graphics/four_clique.typ" ]
      ]
    ),
    [There is a \ valid proof $Pi$], [Every $Pi$ is accepted at most \ $delta n^c$ out of $n^c$ times],
    [
      #uncover((2, 3))[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $omega(G') = n^c$ ~~~ #v(1em)
        ]
      ]
    ],
    [
      #uncover(3)[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $omega(G') <= delta n^c < macron(epsilon) n^c$ ~~~ #v(1em)
        ]
      ]
    ],
    [
    ],
    [
      #uncover(3)[ #align(right)[$qed$] ]
    ]
  )
  ]
]

#slide(
  title: [Even stronger inapproximability results],
)[
  #set align(center)
  #table(
    columns: (0.3fr, 0.3fr, 0.3fr),
    rows: (5em, 3em),
    stroke: 2pt,
    align: center + horizon,
    fill: (x, y) => if y == 0 { none } else { none },
    table.header(
      [
        Our proof...
      ],
      [
        ...with a pinch of \ expander graphs
      ],
      [
        A stronger $"PCP"$ + ...
      ],
    ),
    [
      $epsilon$ for any $epsilon > 0$
    ],
    [
      $1 / (n^c)$ for some $c > 0$
    ],
    [
      $1 / (n ^ (1 - epsilon))$ for any $epsilon > 0$
    ],
  )

  #uncover(2)[
    One among hundreds of results unlocked by the PCP.

    #set text(size: 9mm)
    *The PCP Theorem changed an era in approximation theory.*

  ]
]

/*
#new-section-slide([Further Results])

#slide(
  title: [Stronger PCPs: Håstad's 3-bit PCP],
)[
  #redbox(title: "Theorem (Håstad, 2001)")[
    #set text(size:9mm)
    For any $delta > 0$, $L in "NP"$, there exists a $"PCP"$-verifier that reads $O(log n)$ random bits, queries exactly *3 bits* of the proof $Pi$, and:
    - accepts valid proofs with probability $>= 1 - delta$;
    - accepts invalid proofs with probability $<= 1/2 + delta$.

    Moreover, the accepting condition is a parity test.
  ]
]

#slide(
  title: [Håstad's verifier],
)[
  // [da pensare come visualizzarlo]

  The verifier:
  - reads up to $c log n$ random bits;
  - chooses positions $i_1, i_2, i_3 in ZZ^+$ and a bit $b in {0, 1}$;
  - accepts $arrow.double.r.l.long$ $Pi(i_1) plus.o Pi(i_2) plus.o Pi(i_3) = b$
]

#slide(
  title: [MAX-2LIN],
)[
  #bluebox(title: "Problem (MAX-2LIN)")[
    #set text(size:9mm)
    Given a system of linear equations over $FF_2$, maximize the number of satisfied equations.
  ]

  #v(1em)
  #uncover(2)[
    *Observation:* A random assigments gives a $1/2$-approximation.
  ]
]

#slide(
  title: [Inapproximability of MAX-2LIN]
)[
  #redbox(title: "Theorem (Håstad)")[
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $(1/2 + epsilon)$-approximate $"MAX-2LIN"$.
  ]
]

#slide(
  title: [Proof]
)[
  Fix a $"PCP"$ verifier as the above with a small enough $delta$ for $3"-Colorability"$. On input $G$, to decide whether $G$ is $3$-colorable, consider the system of equation
  $
  S := 
    cases(
      X_(i_1 (R_1)) plus.o X_(i_2 (R_1)) plus.o X_(i_3 (R_1)) = b(R_1),
      X_(i_1 (R_2)) plus.o X_(i_2 (R_2)) plus.o X_(i_3 (R_2)) = b(R_2),
      ...,
      X_(i_1 (R_(n^c))) plus.o X_(i_2 (R_(n^c))) plus.o X_(i_3 (R_(n^c))) = b(R_(n^c)),
    )
  $
  where $i_1 (R), i_2 (R), i_3 (R)$ are the positions queried by the verifier on random string $R$.
]

#slide(
  title: [Proof],
)[
  #grid(rows: (0.35fr, 0.4fr, 0.25fr),
  [
    #grid(columns: (0.5fr, 0.5fr), [
      #set align(center)
      #scale(40%)[
          #include "./graphics/three_colorable_graph.typ"
      ]
    ],
    [
      #set align(center)
      #scale(60%)[
        #include "./graphics/four_clique.typ"
      ]
    ])
  ],
  [
    #grid(columns: (0.5fr, 0.5fr), [
      #set align(left + top)
      $G$ is $3$-colorable
      #set list(marker: ([$arrow.double$],))
      - there exist a valid proof;
      - $"MAX-2LIN"(S) >= (1 - delta)|S|$;
    ],
    [
      #set align(left + top)
      #set list(marker: ([$arrow.double$],))
      $G$ is not $3$-colorable
      #set list(marker: ([$arrow.double$],))
      - every proof is accepted with probability at most $1/2 + delta$
      - $"MAX-2LIN"(S) <= (1/2 + delta)|S|$
    ])
  ],
  [
    #v(1em)
    #uncover(2)[
      #set align(center)
      If $(1 - delta)(1/2 + epsilon) > 1/2 + delta$, the scenarios can be told apart.
      #align(right)[$qed$]
    ]
  ])
]


#slide(
  title: [Inapproximability of MAX-3SAT],
)[
  #redbox(title: "Theorem (Håstad)")[
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $(7/8 + epsilon)$-approximate $"MAX-3SAT"$.
    #v(1em)
  ]
]

#slide(
  title: [Proof]
)[
  Gap-preserving reduction (both ways!) between $"MAX-2LIN"$ and $"MAX-3SAT"$.
]
*/

#slide(
  title: [(Partial) history of the PCP Theorem],
)[
  - (1971) Cook -- _The complexity of theorem-proving procedures_
  - (1972) Karp -- _Reducibility among combinatorial problems_
  - (1973) Levin -- _Universal Sequential Search Problems_
  - (1991) Feige, Goldwasser, Lovász, Safra, Szegedy -- _Interactive Proofs and the Hardness of Approximating Cliques_
  - (1992) Arora, Safra -- _Probabilistic Checking of Proofs: A New Characterization of NP_
  - (1992) Arora, Lung, Motwani, Sudan, Szegedy -- _Proof Verification and the Hardness of Approximation Problems_
  - (2001) Håstad -- _Some Optimal Inapproximability Results_
  - (2006) Dinur -- _The PCP Theorem by Gap Amplification_
]

#slide(
  title: [Some more bibliography]
)[
  - (1989) Impagliazzo, Zuckerman -- _How to Recycle Random Bits_
  - (1995) Buss -- _On Gödel's theorems on lengths of proofs II: Lower bounds for recognizing $k$ symbol provability_
  - (2004) Trevisan -- _Inapproximability of Combinatorial Optimization Problems_
  - (2006) Radhakrishnan, Sudan -- _On Dinur’s Proof of the PCP Theorem_
  - (2012) Arora, Barak -- _Computational Complexity: A Modern Approach_
]

// Main papers
// https://people.csail.mit.edu/madhu/papers/1992/almss-journ.pdf
// https://www.cs.umd.edu/~gasarch/TOPICS/pcp/fglss.pdf
// https://kam.mff.cuni.cz/~matousek/cla/dinur-pcp-combinatorial-proof.pdf
// https://people.csail.mit.edu/dmoshkov/courses/pcp/pcp-history.pdf

#empty-slide()[
  _Time for your questions!_

  #curve(
  stroke: white + 0.5pt,
  fill: white,
  curve.quad(relative: true, (75pt, 15pt), (150pt, -1pt)),
  curve.quad(relative: true, (75pt, -15pt), (150pt, 1pt)),
  curve.line(relative: true, (-10pt, -2.5pt)),
  curve.quad(relative: true, (-75pt, -15pt), (-150pt, 1pt)),
  curve.quad(relative: true, (-75pt, 15pt), (-150pt, -1pt)),
  curve.line(relative: true, (10pt, 2.5pt)),
  //curve.close()
)
]

#slide(
  hide-section: true,
  title: [More topics we could talk about]
)[
  #grid(columns:(.3fr, .3fr, .3fr), gutter: 1em,
    [
        #stickybox(
          tape: true,
          rotation: 2deg,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          What expanders \ have to do with \ the PCP Theorem
          #v(.5em)
        ]
    ],
    [
        #stickybox(
          tape: true,
          rotation: -1deg,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          A stronger PCP and optimal inapproximability results
          #v(.5em)
        ]
    ],
    [
        #stickybox(
          tape: true,
          rotation: -2deg,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          The class $"APX"$ and why $"PTAS" subset.neq "APX"$, \ unless $"P" = "NP"$
          #v(.5em)
        ]
    ],
  )

  #grid(columns:(.15fr, .3fr, .3fr, .15fr), gutter: 1em,
    [
    ],
    [
        #stickybox(
          tape: true,
          rotation: 1.5deg,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          \
          Zero-knowledge proofs \
          \
          #v(.5em)
        ]
    ],
    [
        #stickybox(
          tape: true,
          rotation: -1deg,
        )[
          #v(1em)
          #set align(center)
          #set text(black.lighten(20%))
          Inapproximability results for other optimization problems // (vd. Trevisan, 2004).
          // esempio: impossibile approssimare set cover meglio di O(log n)
          // -> l'algoritmo greedy è ottimo
          #v(.5em)
        ]
    ],
    [
    ],
  )
]
