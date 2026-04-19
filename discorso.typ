#set text(lang: "it", region: "IT", size: 12pt)
#set par(justify: true)
#set smartquote(alternative: true)

Bene, io vi parlo del Teorema PCP, che è un teorema molto importante dimostrato nel '92.


La prima sezione è introduttiva e necessaria: parla di dimostrazioni. Nella seconda parlo del Teorema PCP, con un'idea di dimostrazione. Nella terza sezione invece dimostro, dall'inizio alla fine, una conseguenza sorprendente del Teorema PCP.

Per prima cosa, introduco informalmente le classi P e NP con dei problemi di esempio.

Problema prototipo in P: decidere la $2$-colorabilità di un grafo $G$, cioè determinare se è possibile colorare i nodi di $G$ con blu e arancio, in modo tale che gli archi connettano nodi blu a nodi arancio.

Questo problema si risolve efficientemente, nel senso che esiste un algoritmo efficiente che trova
- una dimostrazione (a volte dirò _certificato_) del fatto che il grafo è $2$-colorabile, nel caso in cui $G$ è $2$-colorabile;
- una dimostrazione di impossibilità, nel caso in cui $G$ #emph[non] è $2$-colorabile.
Quindi la $2$-colorabilità, come tutti i problemi in P, si decide efficientemente.

...dove efficientemente vuol dire in un numero polinomiale di operazioni rispetto alla dimensione dell'input. D'ora in poi, "tempo polinomiale".
A volte dirò "facilmente".
Nel caso della #box[$2$-colorabilità], l'algoritmo impiega tempo lineare nella dimensione del grafo.

Estendiamo leggermente il problema! Chiediamoci ora se un grafo $G$ è $3$-colorabile?
Qui la situazione cambia drasticamente, nel senso che
- non conosciamo algoritmi efficienti per decidere la $3$-Colorabilità;
- si congettura che non esistano;
- se ne esistesse uno, allora esisterebbe un algoritmo efficiente per trovare dimostrazioni matematiche;
In una lettera a Von Neumann, Gödel specula su questa possibilità. Parafrasando, dice: "chiaramente si può costruire un algoritmo che verifica le dimostrazioni. Se ce ne fosse uno efficiente -- che per lui vuol dire lineare o quadratico -- che le dimostrazioni le trova, questo avrebbe conseguenze importantissime."

Tornando a noi, io non so trovare $3$-colorazioni efficientemente, ma...

...se il Prof. Panconesi mi fornisce una $3$-colorazione, per me è facile verificarne la validità: semplicemente guardo se ogni arco collega nodi di colori distinti.
Lo stesso vale per tutti i problemi in NP, che sta per nondeterministico-polinomiale (il motivo se volete ve lo racconto dopo).

Questo ci porta alla definizione (qui un po' informale, ma si formalizza tutto) di due importanti classi di problemi:
- la classe P, cioè i problemi che si #emph[decidono] efficientemente e
- la classe NP, cioè i problemi che si #emph[verificano] efficientemente.
È facile dimostrare che se un problema si decide efficientemente, allora si verifica anche efficientemente.

Il problema del millenio P vs NP chiede se vale il viceversa, cioè se è vero che ogni qual volta una soluzione a un problema algoritmico si può verificare efficientemente, allora la si può anche trovare efficientemente.

Va bene. Abbiamo scelto come problema prototipo in NP la $3$-Colorabilità e questo non è un caso, nel senso che ogni problema in NP si può formulare in termini di colorazioni di grafi. Quindi, con i dovuti asterischi che se vi interessa sono ben contento di approfondire, tutto ciò che dimostriamo per la $3$-colorabilità è quasi in automatico dimostrato per tutti i problemi in NP.


#align(center)[
	_RESPIRO_
]

Bene, finalmente possiamo parlare del Teorema PCP. Innanzitutto PCP sta per Probabilistically Checkable Proofs, infatti anche questo teorema parla di dimostrazioni e quando venne dimostrato destò un certo scalpore.

Questa è la prima pagina della sezione scientifica del New York Times e se zoomiamo qui leggiamo: "Trovata scorciatoia per lunghe dimostrazioni matematiche". In questa sezione vediamo il perché di questo titolo.

Il Teorema PCP dà una caratterizzazione soprendente di NP. Dice che c'è un modo di scrivere dimostrazioni che si possono verificare in maniera molto sbrigativa.
Informalmente:
- voi mi date una dimostrazione di un teorema molto complicato scritta in un certo formato. Magari sono 1000 pagine;
- non ho tempo di leggermela tutta e decido di verificarla così: scelgo 100 righe a caso e controllo che non ci siano errori;
- se non trovo errori, accetto la dimostrazione come valida, altrimenti la rifiuto.
Capite bene che questo protocollo di verifica non funziona per le dimostrazioni a cui siamo abituati: nel plico di fogli che mi avete dato potrebbe esserci un singolo minore o uguale che doveva essere un minore e questo magari invalida l'intera dimostrazione. 
Quindi buona fortuna ad accorgersene controllando 100 righe scelte a caso.

Ora formalizziamo il protocollo di verifica.
Fissiamo delle costanti e un algoritmo di verifica $V$. Una dimostrazione di solito è una sequenza di parole, altre volte è una colorazione, nel caso #emph[più generale possibile] è una sequenza di bit. Per verificarla:
- il verificatore tira $c log n$ monetine;
- sulla base di queste monetine, legge $q$ posizioni della dimostrazione;
- decide se accettare o rifiutare la dimostrazione.

Graficamente, il processo è questo.
A volte accetta.
Altre volte, con altre stringhe random, rifiuta.

Vediamo un caso concreto.
Vogliamo verificare probabilisticamente la $3$-colorabilità di un grafo. La dimostrazione $Pi$ corrisponde a una colorazione, ma non la leggiamo tutta.
Scelgo a caso giusto un paio d'archi,
questi vincoli sono tutti soddisfatti,
quindi accetto.
Se invece trovo un errore,
rifiuto la dimostrazione.

Però questa procedura di verifica naïve ha un problema: lo stesso delle dimostrazioni matematiche, ci sono casi in cui è estremamente improbabile riconoscere dimostrazioni scorrette.
Nello specifico, esistono grafi arbitrariamente grandi non $3$-colorabili per un solo arco.
Capite bene che in casi come questo ho troppe poche garanzie sull'esito della verifica probabilistica.

Allora definiamo la classe di problemi $"PCP"(O(log n), O(1))$ per cui una verifica probabilistica funziona abbastanza bene. Dove abbastanza bene vuol dire:
	- per gli enunciati veri, esiste una dimostrazione valida, cioè accettata sempre;
	- per gli enunciati falsi, non c'è dimostrazione che tenga, e ogni tentativo di dimostrazione si riconosce come sbagliato con probabilità almeno $1/2$.

Osserviamo anche che $1/2$ qui è una #emph[costante] arbitraria e semplicemente ripetendo la procedura di verifica più volte ottengo una probabilità di errore piccola a piacere.

Va bene. Quindi la $3$-Colorabilità di grafi è in $"PCP"(O(log n), O(1))$?
Parrebbe di no, ma la risposta invece è un grande e verde sì! Perché? -- e ora vi enuncio un fatto di difficile dimostrazione, che dimostrerò nella tesi -- esiste una trasformazione di grafi che PRESERVA la $3$-colorabilità, e che inoltre mappa grafi non $3$-colorabili in grafi per cui ogni tentativo di colorazione viola almeno una frazione COSTANTE dei vincoli.

Quindi che faccio? Dato un grafo, la $3$-colorabilità si può controllare sul grafo trasformato, dove la procedura di verifica naïve funziona bene, proprio in virtù del fatto che se il grafo non è $3$-colorabile, allora con alta probabilità si trovano archi violati.

Ma allora, sapendo che ogni problema in NP si può formulare in termini di $3$-Colorabilità, abbiamo dimostrato che tutti i problemi in NP si possono verificare in questo modo! Quindi anche le dimostrazioni di cui parlava il New York Times.

Questo è un risultato notevole e si chiama Teorema PCP e oltre ad essere soprendente di per sé, il PCP ha tantissime conseguenze inaspettate in ambiti apparentemente scorrelati.

#align(center)[
  _RESPIRO_
]

Io in particolare vi parlo e vi dimostro un risultato di inapprossimabilità. Cosa vuol dire? Partiamo anche questa volta da un problema.

Il problema della cricca massima. Innanzitutto, una cricca in un grafo $G$ è un sottografo completo, cioè un sottoinsieme di nodi tutti adiacenti l'uno all'altro.

Il problema della cricca massima chiede, dato un grafo, di trovare la massima cardinalità di una cricca in quel grafo.

Graficamente, se questo è il grafo, vogliamo trovare la cricca in rosso.

Ahimé, questo problema, come il problema della $3$-Colorabilità, è difficile almeno quanto tutti i problemi in NP. Quindi abbiamo poche speranze di risolverlo efficientemente.

Proviamo ad approssimare la soluzione ottima!
Per esempio, se la cricca massima è grande $5$ e il nostro algoritmo ne trova una grande $4$, chiamiamo questa una $4/5$-approssimazione.
Ciò che intendo dire è che Max-Clique è difficile, ma se avessimo un'approssimazione efficiente abbastanza buona di Max-Clique, potremmo anche metterci l'anima in pace, che è ciò che succede per tantissimi problemi pratici.

Quindi ci chiediamo se possiamo trovare cricche grandi almeno $4/5$, la metà, o $1/1000000$ della cricca massima.

Pessime notizie: trovare una cricca grande un milionesimo della cricca massima è difficile tanto quanto il problema originale.

Dimostriamolo!

Vogliamo usare una $1/1000000$-approssimazione efficiente di Max-Clique per decidere efficientemente la $3$-Colorabilità. Diciamo $3$-Colorabilità per fissare le idee, ma qui la $3$-colorabilità non ha nessun ruolo particolare e potrebbe essere un qualunque problema in NP.

La riduzione fondamentale è la seguente: esiste una trasformazione efficiente di grafi $G$ in $G'$ t.c.
	- se $G$ è $3$-colorabile, allora in $G'$ esiste una cricca molto grande;
	- se $G$ non è $3$-colorabile, allora tutte le cricche di $G'$ sono piccolissime.

La chiave è che data una trasformazione con questo gap, il nostro fattore di approssimazione è sufficiente a separare i due scenari.

Nello specifico,
	- se $G$ è $3$-colorabile, allora in $G'$ esiste una cricca grande $M$,
      - quindi la nostra $1/1000000$-approssimazione trova una cricca grande almeno almeno $M / 1000000$;
	- se $G$ non è $3$-colorabile, allora tutte le cricche in $G'$ sono piccolissime,
      - quindi anche l'approssimazione, per bene che funzioni, trova una cricca non più grande della cricca massima, che è più piccola di $M/1000000$.
Ma allora il grafo originale è $3$-colorabile sse la nostra $1/1000000$-approssimazione restituisce una cricca abbastanza grande. E così abbiamo DECISO la $3$-Colorabilità.
Con questo l'obiettivo è ufficialmente diventato costruire $G'$ dato $G$.

Come lo facciamo? Con il Teorema PCP!

Fissiamo un verificatore PCP per la $3$-Colorabilità che sbaglia pochissime volte.
Questo legge il grafo $G$, tira un numero logaritmico di monetine e legge un numero costante di bit della dimostrazione.
Ora ci ricordiamo che fissato l'input $G$, il verificatore accetta o rifiuta basandosi esclusivamente sulle altre variabili, cioè gli esiti delle monetine (quindi la stringa random $R$) e i pezzi di dimostrazione che legge.

Chiamiamo una coppia (stringa random, bit della dimostrazione) #emph[scenario accettante], se il verificatore accetta quando legge quella stringa random e quelle parole della dimostrazione.

Notiamo che c'è un numero polinomiale di possibili scenari, perché ci sono
	- un numero polinomiale di possibili valori per la stringa random, $2^(c log n) = n^c$;
	- un numero costante $2^q$ di possibili valori valori per i bit della dimostrazione letti dal verificatore.
Non solo, il verificatore è per ipotesi efficiente, quindi può controllare se uno scenario è accettante oppure no in tempo polinomiale.
Ora polinomiale per costante per polinomiale è ancora polinomiale, quindi possiamo calcolare efficientemente gli scenari accettanti.
Facciamolo.

Abbiamo i nodi, mancano gli archi.

Diciamo che due scenari accettanti sono #emph[consistenti] se questi non si contraddicono su nessun bit della dimostrazione. O equivalentemente se entrambi sono possibilmente scenari relativi a una stessa dimostrazione.

Poniamo un arco tra due scenari accettanti se e solo se questi sono consistenti.

L'idea fondamentale è che cricche $K$ in $G'$ corrispondono a dimostrazioni, e più la cricca è grande, tanto più probabile è che una corrispondente dimostrazione sia accettata.

Il succo è che una cricca in $G'$ dà un'opinione su alcuni bit della dimostrazione e questa opinione è data dall'unione di $|K|$ opinioni consistenti.

Vediamo questa corrispondenza. Per esempio, data questa $3$-cricca, vogliamo costruire una dimostrazione accettata per almeno tre stringhe random.

Dunque, abbiamo questi tre scenari accettanti che per ipotesi sono consistenti. Vogliamo un certificato che venga accettanto almeno almeno sulle stringhe random $R_1, R_2, R_3$. Come facciamo?
	- Nelle posizioni che legge il verificatore quando la stringa random è $R_1$, ci mettiamo... i bit indicati dal primo scenario accettante;
		- quindi se la stringa random è $R_1$, il verificatore accetta qualunque certificato che in queste posizioni ha questi bit;
	- Facciamo lo stesso per $R_2$. In questo caso vorrei impostare un bit che è già impostato, ma questo non dà problemi, proprio perché gli scenari sono tutti consistenti;
		- quindi, anche se la stringa random è $R_2$, il verificatore accetta;
	- Facciamo lo stesso per $R_3$. Anche in questo caso non ci sono problemi;
		- e con questo abbiamo ottenuto un certificato accettato per almeno almeno tre stringhe random.

Ma allora abbiamo finito!
Perché
	- se il grafo originale è $3$-colorabile, allora esiste un certificato valido,
      - questa dimostrazione viene accettata per tutte le $n^c$ stringhe random, quindi in $G'$ esiste una corrispondente cricca grande $n^c$;
	- se invece non è $3$-colorabile, allora, per ipotesi sul verificatore PCP, ogni certificato viene accettato per al più $delta n^c$ stringhe random,
      - quindi le cricche di $G'$ sono tutte molto piccole.

Prima abbiamo visto che un algoritmo di $1/1000000$-approssimazione distingue questi due casi, quindi possiamo usarlo per decidere la $3$-Colorabilità.

Così abbiamo concluso la dimostrazione e mostrato che non possiamo neanche trovare cricche grandi $1/1000000$ la cricca massima, a meno che P = NP.

Qui trovate una storia parziale del Teorema PCP.
Qui dell'altra bibliografia.

E con questo concludo.
