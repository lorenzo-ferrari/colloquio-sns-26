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
  title           : [Hardness of Approximation],
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

#title-slide()

// NO! Non voglio perdere il pubbico perché non sa cosa vuol dire NP-Hard, eps-approssimare e MAX-CLIQUE
#slide()[
  We will introduce $"NP"$-hardness, Probabilistically Checkable Proofs and, via the PCP Theorem, establish the following
  #colorbox(color:"red", title:"Theorem")[
    #set align(center)
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $epsilon$-approximate $"MAX-CLIQUE"$.

    #v(1em)
  ]
]

#toc-slide( title: [Table of Contents] )

#new-section-slide([P vs NP])

// slide P: 2-col
// slide con due disegnoni: grafo 2-colorabile e grafo non 2-colorabile
// vai avanti -> 2-colori quello a sx
// vai avanti -> evidenzi un ciclo dispari in quello a dx

#slide(
  title: [$"P"$: 2-$"Coloring"$]
)[
  
]

// poi... generalizziamo! 3-colorazione... cambio drastico!
// I) Nessuno ha mai trovato un algoritmo efficiente (per noi efficiente = polinomiale)
// II) 1M $ per trovarne uno o dire che non esiste
// III) Se esistesse, esisterebbe un algoritmo efficiente per dimostrare tutto ciò che è dimostrabile

// def informale di P vs NP
// P: si risolve in tempo polinomiale
// NP: si può verificare in tempo polinomiale

// parlerò del PCP, che è un altro teorema che parla di dimostrazioni

#slide(
  title: [P versus NP],
)[  
  #colorbox(color :"blue", title:[Problem ($k"-Colorability"$)])[
    #set align(center)
    #set text(size:9mm)
    Given a graph $G(V, E)$, is it $k$-colorable?

    #v(1em)
  ]

  For a fixed $k$, how hard is the problem? What does _hard_ even mean?

  From now on, "efficient" = "polynomial-time".
]

#slide()[
  #colorbox(color :"green", title: [Definition ($"P"$)])[
    #set align(center)
    #set text(size:9mm)
    A language $L subset.eq {0, 1}^*$ belongs to the class $"P"$ if there exists an efficient algorithm deciding whether any $x in {0, 1}^*$ is in $L$.
    #v(1em)
  ]
  #colorbox(color :"green", title: [Definition ($"NP"$)])[
    #set align(center)
    #set text(size:9mm)
    A language $L subset.eq {0, 1}^*$ belongs to the class $"NP"$ if, given a proof of $x in L$, it can be efficiently verified that $x in L$.

    #v(1em)
  ]
]

#slide()[
  #grid(columns:(0.6fr,0.4fr),[
    Note $"P" subset.eq "NP"$ (ignore the proof!).
    The millennium problem "$"P"$ vs $"NP"$" asks whether $"P" subset.neq "NP"$ or $"P"= "NP"$.

    Most people believe $"P" eq.not "NP"$, though the problem is still open.

    A problem is said to be *NP-Hard* if the existence of a polynomial solution implies $"P" = "NP"$.

    Curiously, there exists $"NP"$-Hard problems, even in $"NP"$ (Cook, '71; Levin, '73).
  ],
  [
    #align(center)[
     #image("pics/PvsNP.png", width: 80%) 
  ]
  ])
]

#slide()[
  ...back to our example:
  - it can be efficiently verified whether an assignment $V -> {0, ..., k - 1}$ is a $k$-coloring, hence $k"-Colorability" in "NP"$; 
  - it holds $2"-Colorability" in "P"$: it can be solved in linear time;
  - for $k >= 3$, $k"-Colorability"$ is *NP-Hard*: there is a sudden complexity jump at $k = 3$.

  // pause
  By definition, the class $"NP"$ consists of the problems admitting a proof in the canonical sense, which is not the only possible proof protocol.

]

// def di PCP
// Teoremone, lapidario
// specifico giusto un pochino che 1/2 è arbitrario e posso sostituirlo con delta a piacere
// racconto che ha varie ramificazioni, io mi concentro sui problemi di ottimizzazione

#new-section-slide([The PCP Theorem])

#slide(
  title: [The class $"PCP"(c log n, q)$],
)[
  We restrict out attention to Probabilistically Checkable Proofs, in particular to the class $"PCP"(O(log n), O(1))$.

  Let $c, q in ZZ^+$ be constants and consider the following proof system. Given a proof $Pi : ZZ^+ -> {0, 1}$ and an efficient probabilistic verifier $V$:
  - on input $x in {0, 1}^n$, $V$ reads a random string $R$ of up to $c log n$ bits;
  - based on $R$, $V$ chooses $q$ locations $i_1, ..., i_q$ of the proof and reads the corresponding bits $Pi(i_1), ..., Pi(i_q)$;
  - based on $R$ and $Pi(i_1), ..., Pi(i_q)$, $V$ decides whether to accept or reject.
]

#slide()[
  #colorbox(color :"green", title: [Definition ($"PCP"_(1/2) (c log n, q)$)])[
    #set text(size:9mm)
    A language $L subset.eq {0, 1}^*$ belongs to the class $"PCP"_(1/2) (c log n, q)$ if there exists a verifier $V$ as above s.t., on input $x$:
    - if $x in L$, there exists a valid proof $Pi : ZZ^+ -> {0, 1}$ s.t. $Pr[V "accepts"] = 1$;
    - if $x in.not L$, for any $Pi : ZZ^+ -> {0, 1}$ it holds $Pr[V "accepts"] < 1 / 2$.

    #v(1em)
  ]

  // pause
  Observe that by repeating the test several times, the error probability can be made arbitrarily small.
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
]

#slide(title: [The PCP Theorem])[
  // NOTA: è importante l'unione su c! È vero, posso scegliere una c_0 che va bene per 3-SAT, ma c'è la riduzione polinomiale da L a 3-SAT di mezzo.
  In particular, there exists a constant $q$ s.t. $ "NP" = union.big_(c > 0) "PCP"_(1/2)(c log n, q)$, where $1 / 2$ here can be any $delta > 0$.
  
  In other words, canonical proofs and PCPs possess the same expressing power.
  
  Though fascinating on its own, the PCP theorem has unexpected consequences in seemingly unrelated areas.
  
  // The proof is complex (and will be the main topic of my thesis).
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
  // title: [MAX-CLIQUE]
)[
  #include "./graphics/max_clique.typ"
]

#slide(
  title: [MAX-CLIQUE],
)[
    #colorbox(color :"green", title:"Definition (Clique)")[
    #set align(center)
    #set text(size:9mm)
    A _clique_ in a graph $G(V, E)$ is a complete subgraph of $G$, i.e. a subset of pairwise adjacent nodes.
    \
    \
  ]
  Given a graph $G(V, E)$, the problem $"MAX-CLIQUE"$ asks for the maximum cardinality among all cliques of $G$.
]


#slide(
  title: [MAX-CLIQUE],
)[
    #colorbox(color :"blue", title:"Fact")[
    #set align(center)
    #set text(size:9mm)
    $"MAX-CLIQUE"$ is $"NP"$-Hard.
    \
    \
  ]
  Unless $"P" = "NP"$, we cannot solve efficiently $"MAX-CLIQUE"$. Can we at least approximate it? For example, can we efficiently find a clique of size at least $1/2, 1/3$ or $1/1000000$ of the maximum clique?
]


#slide(
  title: [Hardness of approximating MAX-CLIQUE],
)[
  #colorbox(color:"red", title:"Theorem")[
    #set align(center)
    #set text(size:9mm)
    For any $epsilon > 0$, it is $"NP"$-Hard to $epsilon$-approximate $"MAX-CLIQUE"$.

    #v(1em)
  ]

  We will prove it via the PCP Theorem.
]

#slide(
  title: [Proof],
)[
  We will show that if an efficient algorithm approximates $"MAX-CLIQUE"$ within a factor $epsilon > 0$, then $"P" = "NP"$.

  Let $L in "NP"$ be any problem and fix a $"PCP"$-verifier for $L$ with probability error bounded by some $delta < epsilon$, reading $c log n$ random bits and $q$ bits from the certificate. Consider the $n^c 2^q$ possible runs of the algorithm.
]

#slide()[
  #grid(columns: (0.6fr, 0.4fr), [
    We call the information $chevron.l R; Pi(i_1)...Pi(i_q) chevron.r$ an _accepting transcript_ if:
    - on the random string $R$, the verifier reads the bits at positions $i_1, ..., i_q$ and
    - reading the bits $Pi(i_1), ..., Pi(i_q)$ cause the verifier to accept.
  ], [
    #include "./graphics/accepting_transcripts.typ"
  ]
  )
]

// domanda: riesco a non andare a capo solo per una parola molto breve? LaTeX per esempio stretcha righe diverse

#slide()[
  Two transcripts $chevron.l R_i; Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_j; Pi(j_1)...Pi(j_q) chevron.r$ are _consistent_ if they do not disagree on any bit of the certificate, i.e. $i_a = j_b$ implies $Pi(i_a) = Pi(j_b)$.
  
  Consider the graph $G$ on all the accepting transcripts, where

    #set align(center)
    $chevron.l R_1, Pi(i_1)...Pi(i_q) chevron.r$ and $chevron.l R_2, Pi(j_1)...Pi(j_q) chevron.r$ are connected
    $arrow.l.r.double.long$
    they are consistent.

  // #underline[The graph $G$ contains an $n^c$-clique iff there exists a valid certificate $Pi$.]
  
  #colorbox(color:"blue")[
    #set text(size:9mm)
    #v(1em)
    The following holds:
    - if $x in L$, then $G$ contains a clique of size $n^c$;
    - if $x in.not L$, then cliques of $G$ are of size at most $delta n^c$.
    #v(1em)
  ]
]

#slide()[
  *Key idea:* Any clique $K$ in $G$ corresponds to a partial certificate $tilde(Pi)_K : S subset.eq ZZ^+ -> {0, 1}$, where any $Pi$ extending $tilde(Pi)_K$ is accepted with probability at least $(|K|) / n^c$.

  In particular, any valid certificate corresponds to an $n^c$-clique in $G$.
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
