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

#set text(lang: "en", size: 20pt)
#show: sns-polylux-template.with(
  aspect-ratio    : "16-9",
  title           : [Hard Approximations],
  subtitle        : [PCPs and why it is NP-Hard to $epsilon$-approximate MAX-CLIQUE],
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

#toc-slide( title: [Table of Contents] )

#new-section-slide([P vs NP])

// slide P: 2-col
// slide con due disegnoni: grafo 2-colorabile e grafo non 2-colorabile
// vai avanti -> 2-colori quello a sx
// vai avanti -> evidenzi un ciclo dispari in quello a dx

#slide(
  title: [P: 2-Coloring]
)[
  #set align(center)
  #include "./graphics/big_two_colored_graph.typ"
]

#slide(
  title: [P: 2-Coloring]
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
  title: [NP: 3-Coloring]
)[
  #grid(columns: (0.4fr, 0.6fr),[
    #set align(center)
    #include "./graphics/three_colorable_graph.typ"
  ],
  [
    #item-by-item[
      - No _efficient_ (= polynomial-time) algorithm is known.
      - It is conjectured it doesn't exist ($"P"$ vs $"NP"$).
      - If it did, the existence of mathematical proofs could be decided efficiently. // with respect to the length of the proof
    ]
  ])
]

#slide(
  title: [What can we say about 3-Coloring?]
)[
  #grid(columns: (0.4fr, 0.6fr), [
    #set align(center)
    #include "./graphics/wrong_three_coloring.typ"
  ],[
    Correctness can be efficiently _verified_.
  ])
]

#slide(
  title: [P vs NP]
)[
  #colorbox(color :"green", title: [Definition (P)])[
    #set align(center)
    #set text(size:9mm)
    Decision problems whose solution can be found efficiently.

    #v(1em)
  ]
  #colorbox(color :"green", title: [Definition (NP)])[
    #set align(center)
    #set text(size:9mm)
    Decision problems whose solution can be verified efficiently.

    #v(1em)
  ]
]

#slide(
  title: [Millenium Problem]
)[
  #colorbox(color :"blue", title: [P vs NP])[
    #set align(center)
    #set text(size:15mm)
    #v(0.8em)
    Is $"P"$ a proper subset of $"NP"$?
    #v(1.5em)
  ]
]

// parlerò del PCP, che è un altro teorema che parla di dimostrazioni

// def di PCP
// Teoremone, lapidario
// specifico giusto un pochino che 1/2 è arbitrario e posso sostituirlo con delta a piacere
// racconto che ha varie ramificazioni, io mi concentro sui problemi di ottimizzazione

// immaginiamo di avere la dimostrazione di un problema e di adottare la seguente procedura di verifica piuttosto sbrigativa
#new-section-slide([The PCP Theorem])

#slide(
  title: [The class $"PCP"(c log n, q)$],
)[
  Let $c, q in ZZ^+$ be constants. Given a proof $Pi : ZZ^+ -> {0, 1}$ and an efficient probabilistic verifier $V$:
  - on input $x in {0, 1}^n$, $V$ reads a random string $R$ of up to $c log n$ bits;
  - based on $R$, $V$ chooses $q$ locations $i_1, ..., i_q$ of the proof and reads the corresponding bits $Pi(i_1), ..., Pi(i_q)$;
  - based on $R$ and $Pi(i_1), ..., Pi(i_q)$, $V$ decides whether to accept or reject.
]

#slide()[
  #colorbox(color :"green", title: [Definition ($"PCP"_(1/2) (c log n, q)$)])[
    #set text(size:9mm)
    A language $L subset.eq {0, 1}^*$ belongs to the class $"PCP"_(1/2) (c log n, q)$ if there exists a verifier $V$ as above s.t., on input $x$:
    - if $x in L$, there exists a valid proof $Pi : ZZ^+ -> {0, 1}$ s.t. $Pr[V "accepts"] = 1$;
    - if $x in.not L$, for any $Pi : ZZ^+ -> {0, 1}$ it holds $Pr[V "accepts"] <= 1 / 2$.

    #v(1em)
  ]

  #uncover(2)[
    *Observation:* by $(c, q) mapsto (k c, k q)$, we can make $Pr[V "is wrong"] <= 1 / 2^k$.
  ]
]

#slide(
  title: [...back to 3-Coloring]
)[
  #grid(columns: (0.5fr, 0.5fr), [
    #set align(center)
    #include "./graphics/unknown_three_coloring.typ"

    #box(height: 1em)[
      #only(4)[ *ACCEPT*]
      #only(8)[ *REJECT*]
    ]
  ],
  [
    - $Pi = $ coloring;
    - $V$ chooses at random a constant number of constraints;
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

    $arrow.double$ The naïve proof system is not good enough.
  ])
]

#slide()[
  #colorbox(color: "blue", title: "Fact")[
    #set text(size: 9mm)
      There exists a transformation $G mapsto G'$ such that
      - $G$ $3$-Colorable $arrow.double$ $G'$ $3$-Colorable;
      - $G$ not $3$-Colorable $arrow.double$ every coloring of $G'$ violates a constant fraction of constraints.
    #v(1em)
  ]
]


#focus-slide(
//  title: [The PCP Theorem],
)[
    #colorbox(color:"red", title:"Theorem (ALMSS, '92)")[
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

#new-section-slide([MAX-CLIQUE])

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
    $"MAX-CLIQUE"$: given $G$, determine $omega(G)$, where
    $ omega: G mapsto max{|K| : K subset.eq G "is a clique"}. $
  ]
]

#slide(
  title: [MAX-CLIQUE is Hard],
)[
    #colorbox(color :"blue", title:"Fact")[
    #set align(center)
    #set text(size:9mm)
    $"MAX-CLIQUE"$ is $"NP"$-Hard.
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
  #colorbox(color: "red", title:"Theorem")[
    #set align(center)
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $epsilon$-approximate $"MAX-CLIQUE"$.

    #v(1em)
  ]
]

// #slide(
//   title: [Proof],
// )[
//   *Goal:* If an efficient algorithm $epsilon$-approximates $"MAX-CLIQUE"$, then $"P" = "NP"$.
// 
//   Let $L in "NP"$ be any problem.
// 
//   #colorbox(color: "blue", title: "Fundamental reduction")[
//     #set text(size:9mm)
//     For any $epsilon > 0$, there exists a transformation $x mapsto G$ from instances of $L$ to graphs s.t.:
//     - $x in L arrow.double omega(G) = M$;
//     - $x in.not L arrow.double omega(G) < epsilon M$.
//     #v(1em)
//   ]
// ]
// 
// #slide()[
//   To decide whether $x in L$:
//   - build the graph $G$;
//   - let $|K|$ be an $epsilon$-approximation of $omega(G)$;
//     - if $|K| >= epsilon M$, then $x in L$; 
//     - otherwise, $x in.not L$.
// ]

#slide(
  title: [Proof],
)[
  *Goal:* If an efficient algorithm $epsilon$-approximates $"MAX-CLIQUE"$, then $"P" = "NP"$.

 Let $L in "NP"$ be any problem. Fix a $"PCP"$-verifier for $L$ with probability error bounded by some $delta < epsilon$, reading:
 - $c log n$ random bits;
 - $q$ bits from the certificate.

 Consider the $n^c 2^q$ possible runs of the algorithm.
]

#slide()[
  #grid(columns: (0.6fr, 0.4fr), [
    We call the information $chevron.l R; Pi(i_1)...Pi(i_q) chevron.r$ an _accepting transcript_ if:
    - on the random string $R$, the verifier reads the bits at positions $i_1, ..., i_q$ and
    - reading the bits $Pi(i_1), ..., Pi(i_q)$ causes the verifier to accept.
  ], [
    #include "./graphics/accepting_transcripts.typ"
  ]
  )
]

#slide()[
  Two transcripts $chevron.l R_1; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2; Pi(j_1)...Pi(j_q) chevron.r$ are _consistent_ if they do not disagree on any bit of the certificate, i.e. $i_a = j_b$ implies $Pi(i_a) = Pi(j_b)$.
  
  Consider the graph $G$ on all the accepting transcripts, where

  #set align(center)
  $chevron.l R_1; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2; Pi(j_1)...Pi(j_q) chevron.r$ are connected
  $arrow.l.r.double.long$
  they are consistent.

  #v(1em)
  #set align(left)
  #uncover(2)[
    *Key idea:* cliques $K$ in $G$ correspond to a partial certificates $tilde(Pi)_K : S subset.eq ZZ^+ -> {0, 1}$, where every $Pi$ extending $tilde(Pi)_K$ is accepted with probability at least $(|K|) / n^c$.
  ]
]

#slide()[
  To decide whether an input $x$ is in $L$:
  - simulate the $n^c 2^q$ possible runs of the algorithm and build the graph $G$ as above;
  - let $K$ be the clique found by the $epsilon$-approximation of $"MAX-CLIQUE"$;
    - if $|K| > delta n^c$, then $x in L$;
    - otherwise, $x in.not L$.

  The former implication follows from the error probability of the $"PCP"$-verifier being bounded by $delta$. The latter from the fact that, if $x in L$, then there exists a valid certificate and a corresponding clique of size $n^c$, hence the approximation returns clique of size $|K| >= epsilon n^c > delta n^c$.
  #align(right)[$qed$]
]

#new-section-slide([Further Results])

#slide(
  title: [Stronger PCPs: Håstad's 3 bits],
)[
  ...or maybe not.
]

#slide(
  title: [Hardness of $(1\/2 + epsilon)$-approximating MAX-E2LIN],
)[
  Follows from Håstad's result.
  
  This also implies the hardness of $(7/8 + epsilon)$-approximating $"MAX-3SAT"$.
]

#slide(
  title: [Bibliography],
)[
  - (1971) Cook -- _The complexity of theorem-proving procedures_
  - (1972) Karp -- _Reducibility among combinatorial problems_
  - (1973) Levin -- _Universal Sequential Search Problems_
  - (1992) Arora, Lung, Motwani, Sudan, Szegedy -- _Proof Verification and the Hardness of Approximation Problems_
  - (1996) Feige, Goldwasser, Lovasz, Safra, Szegedy -- _Interactive Proofs and the Hardness of Approximating Cliques_
  - (2006) Dinur -- _The PCP Theorem by Gap Amplification_
  - (2006) Radhakrishnan, Sudan -- _On Dinur’s Proof of the PCP Theorem_
]

// https://people.csail.mit.edu/madhu/papers/1992/almss-journ.pdf
// https://www.cs.umd.edu/~gasarch/TOPICS/pcp/fglss.pdf
// https://kam.mff.cuni.cz/~matousek/cla/dinur-pcp-combinatorial-proof.pdf


#empty-slide()[
  Thank you! Questions?
]
