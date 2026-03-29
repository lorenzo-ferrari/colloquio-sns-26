#import "@preview/polylux:0.4.0": *
#import "@preview/sns-polylux-template:0.2.0": *
#import "@preview/colorful-boxes:1.4.2": *
#import "@preview/cetz:0.4.2": canvas, draw

/*
  ACHTUNG: You should seriously consider downloading
  the recommended fonts for this package.
  Make sure to install the static versions, because
  Typst does not support variable fonts yet.
  You can find the fonts here:
    https://fonts.google.com/share?selection.family=Roboto+Condensed
    https://fonts.google.com/share?selection.family=Raleway
  You can find the installation guide here:
    https://typst.app/docs/reference/text/text/#parameters-font
*/

#let inline-problem-box(title: "Problem", body) = block(
  width: 100%,
  fill: rgb("#eef8fc"),
  stroke: 2pt + rgb("#1a8cbd"),
  grid(
    columns: (auto, 1fr),
    align: (center + horizon, left + horizon),
    block(
      fill: rgb("#1a8cbd"),
      inset: (x: 12pt, y: 10pt),
      text(fill: white, weight: "bold", title)
    ),
    block(
      inset: 10pt,
      body
    )
  )
)

#set text(lang: "en", size: 20pt)
#show: sns-polylux-template.with(
  aspect-ratio    : "16-9",
  title           : [The PCP Theorem],
  subtitle        : [and its consequences for the approximation of hard problems],
  event           : [Scuola Normale Superiore - Aprile 2026], // lo tengo?
  short-title     : [],
  short-event     : [], // Scuola Normale Superiore — 04/2026],
  logo-1          : image("pics/solo_logo_SNS_bianco.svg"),
//  logo-2          : image("pics/logo_SNS_blu.png"),
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

#new-section-slide([P vs NP])

// slide P: 2-col
// slide con due disegnoni: grafo 2-colorabile e grafo non 2-colorabile
// vai avanti -> 2-colori quello a sx
// vai avanti -> evidenzi un ciclo dispari in quello a dx

#slide(
  title: [P: 2-Colorability]
)[
  #colorbox(color: "blue", title: [Problem])[
    #set text(size: 9mm)
    #align(center)[
      Given a graph $G(V, E)$, decide whether it is $2$-colorable.
    ]
    #v(1em)
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
  #colorbox(color: "blue", title: [Problem])[
    #set text(size: 9mm)
    #align(center)[
      Given a graph $G(V, E)$, determine whether it is $3$-colorable.
    ]
    #v(1em)
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
    /*
    #align(center)[
      #set text(size: 16mm, red)
      *DRASTIC CHANGE!*
    ]
    */
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
    #colorbox(color :"green", title: [#text(30pt)[P ~~]])[
      #set align(center)
      #set text(size:9mm)
      Decision problems \ whose solution \ can be *found* efficiently.

      #v(1em)
    ]
    ],[
    ],[
    #colorbox(color :"green", title: [#text(30pt)[NP]])[
      #set align(center)
      #set text(size:9mm)
      Decision problems \ whose solution \ can be *verified* efficiently.

      #v(1em)
    ]
  ])
]

#slide(
  title: [Millenium Problem]
)[
  #colorbox(color :"blue", title: [#text(30pt)[P vs NP]])[
    #set align(center)
    #set text(size:15mm)
    #v(0.8em)
    Is $"P"$ a proper subset of $"NP"$?
    #v(1.5em)
  ]

  #align(center)[
    #uncover(2)[ Is it true that whenever solutions to an algorithmic problem can be \ verified efficiently, they can also be computed efficiently? ]
  ]
]

// parlerò del PCP, che è un altro teorema che parla di dimostrazioni

// def di PCP
// Teoremone, lapidario
// specifico giusto un pochino che 1/2 è arbitrario e posso sostituirlo con delta a piacere
// racconto che ha varie ramificazioni, io mi concentro sui problemi di ottimizzazione

// immaginiamo di avere la dimostrazione di un problema e di adottare la seguente procedura di verifica piuttosto sbrigativa
#new-section-slide([The PCP Theorem])

#slide()[
  #grid(columns: (0.5fr, 0.5fr), [
    The PCP Theorem gives a different and surprising characterization of $"NP"$.

    Informally,
    #set list(marker: (none, [•]))
    - #uncover((2, 3, 4))[ - you are handed a proof in a certain format; ]
    - #uncover((3, 4))[ - you select, say, 100 lines at random; ]
    - #uncover(4)[ - you consider the proof valid $arrow.double.r.l$ you do not find mistakes. ]
  ],
  [
      #figure(
        image("./pics/nyt.jpg") // width: 80%)
      )
  ])
]

#slide(
  title: [The class $"PCP"(c log n, q)$],
)[
  // forse ci va davvero il disegno
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
    #set align(center)
    #include "./graphics/unknown_three_coloring.typ"

    #box(height: 1em)[
      #only(4)[ #text(size: 30pt, green)[*ACCEPT*] ]
      #only(8)[ #text(size: 30pt, red)[*REJECT*] ]
    ]
  ],
  [
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
    Colorings could violate only a fraction $1 / m$ of the constraints.

    // $arrow.double$ The naïve proof system is not good enough.
    $arrow.double$ Very unlikely to catch the unsatisfied edge...
  ])
]

#slide(
  title: [The class $"PCP"(c log n, q)$],
)[
    #set text(size:9mm)
    A decision problem belongs to the class $"PCP"(c log n, q)$ if there exists a verifier $V$ as above s.t.:

  #grid(columns: (0.45fr, 0.04fr, 0.45fr), [
    #colorbox(color :"green", title: [on a YES instance])[
      #set align(center)
      #set text(size:9mm)
      There is a #box[$Pi : ZZ^+ -> {0, 1}$] s.t. $Pr[V "accepts"] = 1$.
      #v(1em)
    ]
    ],[
    ],[
    #colorbox(color :"green", title: [on a NO instance])[
      #set align(center)
      #set text(size:9mm)
      For any $Pi : ZZ^+ -> {0, 1}$ it holds $Pr[V "accepts"] <= 1 / 2$.
      #v(1em)
    ]
  ])

    #v(1em)

  #uncover(2)[
    *Observation:* by $(c, q) mapsto (k c, k q)$, we can make $Pr[V "is wrong"] <= 1 / 2^k$.
  ]
]


#slide(
  title: [So, is 3-Colorability in $"PCP"(O(log n), O(1))$?],
)[
  #v(25mm)
  #uncover((2,3))[
    #align(center)[
      #set text(size: 20mm, green)
      *YES!*
    ]
  ]
  #uncover(3)[
    #colorbox(color: "blue", title: "Key")[
      #set text(size: 9mm)
        There exists a transformation $G mapsto G'$ such that
        - $G$ $3$-colorable $arrow.double$ $G'$ $3$-colorable;
        - $G$ not $3$-colorable $arrow.double$ every coloring of $G'$ violates a constant fraction of constraints.
      #v(1em)
    ]
  ]
]


#slide(
//  title: [The PCP Theorem],
)[
  // che faccio? 
    // #colorbox(color:"red", title:"Theorem (AS, '92, ALMSS, '92)")[
    #colorbox(color:"red", title:"Arora and Safra (1992); Arora, Lund, Motwani, Sudan and Szegedy (1992)")[
    #set align(center)
    #set text(size:15mm)
    #v(1em)
    $ "NP" = "PCP"(O(log n), O(1)). $

    #v(1.5em)
  ]
  // ci sta dicendo che le dimostrazioni in senso classico e le dimostrazioni "sbrigative" hanno lo stesso potere espressivo
  // conseguenze soprendenti:
  // (in)approssimabilità
]

#new-section-slide([Hardness of Approximation])

// DISEGNONE
// Problema molto importante, Input: G, Output: dimensione della cricca massima
// è un problema NP-Hard, come tanti problemi combinatorici
// Se P != NP, allora non esiste algo polinomiale per
// MAX-CLIQUE (disegnone)
// vado avanti -> TSP
// vado avanti -> Chromatic Number

#slide(
  title: [MAX-CLIQUE]
)[
  #set align(center)
  #include "./graphics/max_clique.typ"
]

#slide(
  title: [MAX-CLIQUE],
)[
    #colorbox(color :"green", title:"Definition (Clique)")[
    #set align(center)
    #set text(size:9mm)
    A _clique_ in a graph $G(V, E)$ is a complete subgraph of $G$, i.e. a subset of pairwise adjacent nodes.
    #v(1em)
  ]

  #uncover(2)[
    $"MAX-CLIQUE"$: given $G$, determine $omega(G) := max{|K| : K subset.eq G "is a clique"}.$
  ]
]

#slide(
  title: [MAX-CLIQUE is Hard],
)[
    #figure(
      image("./pics/clique-karp.png") // width: 80%)
    )
    #colorbox(color :"red", title:"Karp (1972)")[
    #set align(center)
    #set text(size:9mm)
    If there is an efficient algorithm for $"MAX-CLIQUE"$, then $"P" = "NP"$.
    #v(1em)
  ]
]

#slide(
  title: [Can we approximate it?]
)[
  #set align(center)
  #include "./graphics/max_clique_approx.typ"
]

#slide(
  title: [Hardness of approximating MAX-CLIQUE],
)[
  #colorbox(color: "red", title:"Feige, Goldwasser, Lovasz, Safra, Szegedy (1991)")[
    #set align(center)
    #set text(size:9mm)
    If there is an efficient $epsilon$-approximation of $"MAX-CLIQUE"$ \ for some $epsilon > 0$, then $"P" = "NP"$.
    // For any $epsilon > 0$, it is $"NP"$-Hard to $epsilon$-approximate $"MAX-CLIQUE"$.

    #v(1em)
  ]
]

// TODO: corrispondenza 1-1 con algoritmo di verifica per 3-col

#slide(
  title: [Proof],
)[
  // *Goal:* If an efficient algorithm $epsilon$-approximates $"MAX-CLIQUE"$, then $"P" = "NP"$.
  Let $L in "NP"$ be any problem, (wlog) $L = 3"-Colorability"$.

  // *Goal:* Deciding if a given $G$ is $3$-colorable $#box[$<=$]_"P"$ $macron(epsilon)$-approximating $"MAX-CLIQUE"$.

  *Goal:* efficient $macron(epsilon)$-approximation of $"MAX-CLIQUE"$ $arrow.double.r$ efficient decision of $3"-Colorability"$.

  #uncover(2)[
  #colorbox(color: "blue", title: "Fundamental reduction")[
    #set text(size:9mm)
    There is a transformation of graphs $G mapsto G'$ s.t.:
    - $G$ is $3$-colorable $arrow.double omega(G') = M$;
    - $G$ is not $3$-colorable $arrow.double omega(G') < macron(epsilon) M$.
    #v(1em)
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
      #uncover((2, 3))[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $|K| >= macron(epsilon)M$ ~~~ #v(1em)
        ]
      ]
    ],
    [
      #uncover((2, 3))[
        #box(stroke: 2pt + red)[
          #v(1em) ~~~ $|K| < macron(epsilon) M$ ~~~ #v(1em)
        ]
      ]
    ]
  )

  #set text(size: 30pt) 
  #uncover(3)[$G$ is 3-colorable $arrow.r.l.double$ $|K| >= macron(epsilon)M$. ]
  ]
]

#slide(
  title: [Building $G'$],
)[
 Fix a $"PCP"$-verifier for $3"-Colorability"$ with probability error bounded by some $delta < macron(epsilon)$, reading:
 - $c log n$ random bits;
 - $q$ bits from the certificate.

 #uncover(2)[
   *Observation:*
    Suppose on random string $R$ the verifier reads the bits at positions $i_1, ..., i_q$. Then, whether the verifier accepts or not only depends on $R$ and $Pi(i_1), ..., Pi(i_q)$.
 ]
 // On input $G$, consider the $n^c 2^q$ possible runs of the algorithm.
]

#slide(
  title: [Nodes of $G'$],
)[
  #grid(columns: (0.6fr, 0.4fr), [
    The information $chevron.l R; Pi(i_1)...Pi(i_q) chevron.r$ is an _accepting transcript_ if:
    - on the random string $R$, the verifier reads the bits at positions $i_1, ..., i_q$ and
    - reading the bits $Pi(i_1), ..., Pi(i_q)$ causes the verifier to accept.
  ], [
    #include "./graphics/accepting_transcripts.typ"
  ]
  )
]

#slide(
  title: [Edges of $G'$],
)[
  Two accepting transcripts $chevron.l R_1; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2; Pi(j_1)...Pi(j_q) chevron.r$ are _consistent_ if they do not disagree on any bit of the certificate, i.e. $i_a = j_b$ implies $Pi(i_a) = Pi(j_b)$.
  
  Consider the graph $G'$ on all the accepting transcripts, where

  #set align(center)
  $chevron.l R_1; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2; Pi(j_1)...Pi(j_q) chevron.r$ are connected
  $arrow.l.r.double.long$
  they are consistent.

  #v(1em)
  #set align(left)
  #uncover(2)[
    *Key idea:* cliques $K$ in $G'$ $arrow.double$ partial certificates $tilde(Pi)_K : S subset.eq ZZ^+ -> {0, 1}$, where every $Pi$ extending $tilde(Pi)_K$ is accepted with probability at least $(|K|) / n^c$.
  ]
]

#slide(
  title: [Proof],
)[
  #grid(columns: (0.5fr, 0.5fr), rows: (0.5fr, 0.4fr, 0.1fr),
  [
    #set align(center)
    #scale(55%)[
        #include "./graphics/three_colorable_graph.typ"
    ]
  ],
  [
    #set align(center)
    #scale(70%)[
      #include "./graphics/four_clique.typ"
    ]
  ],
  [
    #set align(left + top)
    $G$ is $3$-colorable
    #set list(marker: ([$arrow.double$],))
      - valid certificate $Pi$;
      - $n^c$-clique in $G'$.
  ],
  [
    #set align(left + top)
    #set list(marker: ([$arrow.double$],))
    $G$ is not $3$-colorable
    #set list(marker: ([$arrow.double$],))
    - every certificate is accepted at most $delta n^c$ out of $n^c$ times;
    - cliques of $G'$ are bounded by $delta n^c < macron(epsilon) n^c$.
  ],
  [
  ],
  [
    #align(right)[$qed$]
  ])
]

/*
#new-section-slide([Further Results])

#slide(
  title: [Stronger PCPs: Håstad's 3-bit PCP],
)[
  #colorbox(color: "red", title: "Theorem (Håstad, 2001)")[
    #set text(size:9mm)
    For any $delta > 0$, $L in "NP"$, there exists a $"PCP"$-verifier that reads $O(log n)$ random bits, queries exactly *3 bits* of the proof $Pi$, and:
    - accepts valid proofs with probability $>= 1 - delta$;
    - accepts invalid proofs with probability $<= 1/2 + delta$.

    Moreover, the accepting condition is a parity test.
    #v(1em)
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
  #colorbox(color: "blue", title: "Problem (MAX-2LIN)")[
    #set text(size:9mm)
    Given a system of linear equations over $FF_2$, maximize the number of satisfied equations.
    #v(1em)
  ]

  #v(1em)
  #uncover(2)[
    *Observation:* A random assigments gives a $1/2$-approximation.
  ]
]

#slide(
  title: [Inapproximability of MAX-2LIN]
)[
  #colorbox(color: "red", title: "Theorem (Håstad)")[
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $(1/2 + epsilon)$-approximate $"MAX-2LIN"$.
    #v(1em)
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
      - there exist a valid certificate;
      - $"MAX-2LIN"(S) >= (1 - delta)|S|$;
    ],
    [
      #set align(left + top)
      #set list(marker: ([$arrow.double$],))
      $G$ is not $3$-colorable
      #set list(marker: ([$arrow.double$],))
      - every certificate is accepted with probability at most $1/2 + delta$
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
*/

// #slide(
//   title: [Inapproximability of MAX-3SAT],
// )[
//   #colorbox(color: "red", title: "Theorem (Håstad)")[
//     #set text(size:9mm)
//     For any $epsilon > 0$, it is $"NP"$-Hard to $(7/8 + epsilon)$-approximate $"MAX-3SAT"$.
//     #v(1em)
//   ]
// ]
// 
// #slide(
//   title: [Proof]
// )[
//   Gap-preserving reduction (both ways!) between $"MAX-2LIN"$ and $"MAX-3SAT"$.
// ]

#slide(
  title: [(Partial) history of the PCP Theorem],
)[
  - (1971) Cook -- _The complexity of theorem-proving procedures_
  - (1972) Karp -- _Reducibility among combinatorial problems_
  - (1973) Levin -- _Universal Sequential Search Problems_
  - (1991) Feige, Goldwasser, Lovasz, Safra, Szegedy -- _Interactive Proofs and the Hardness of Approximating Cliques_
  - (1992) Arora, Safra -- _Probabilistic Checking of Proofs: A New Characterization of NP_
  - (1992) Arora, Lung, Motwani, Sudan, Szegedy -- _Proof Verification and the Hardness of Approximation Problems_
  - (2001) Håstad -- _Some Optimal Inapproximability Results_
  - (2006) Dinur -- _The PCP Theorem by Gap Amplification_
]

#slide(
  title: [Some more bibliography]
)[
// TODO: leggere
//  - (1990) Panconesi, Ranjan -- _Quantifiers and approximation_
  - (1995) Buss -- _On Gödel's theorems on lengths of proofs II: Lower bounds for recognizing $k$ symbol provability_
  - (2004) Trevisan -- _Inapproximability of Combinatorial Optimization Problems_
  - (2006) Radhakrishnan, Sudan -- _On Dinur’s Proof of the PCP Theorem_
  - (2012) Arora, Barak -- _Computational Caomplexity: A Modern Approach_
]

// https://people.csail.mit.edu/madhu/papers/1992/almss-journ.pdf
// https://www.cs.umd.edu/~gasarch/TOPICS/pcp/fglss.pdf
// https://kam.mff.cuni.cz/~matousek/cla/dinur-pcp-combinatorial-proof.pdf
// https://people.csail.mit.edu/dmoshkov/courses/pcp/pcp-history.pdf

#empty-slide()[
  Thank you! Questions?
]
