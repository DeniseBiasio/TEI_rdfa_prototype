# TEI_rdfa_prototype

Questo repository contiene due piccoli esperimenti che ho realizzato per capire come collegare in modo semantico gli oggetti legati alle performance di Capitano Ulisse all’interno della mia edizione digitale.
L’obiettivo è capire come integrare metadati senza compromettere la struttura filologica del TEI, che rimane centrale per la trascrizione del testo teatrale. Queste prove servono a valutare quale approccio sia più adatto da utilizzare in futuro anche sul testo drammaturgico vero e proprio.

Il progetto è diviso in due cartelle, corrispondenti a due metodi diversi di gestione dei metadati:

1. Prova_TEI_RDFA

🔹 TEI con RDFa integrati + XSLT

Pipeline 1 - TEI con RDFa integrato + XSLT

In questa versione ho sperimentato l’inserimento diretto degli attributi RDFa dentro il TEI.

Quindi: 

👉 il file TEI contiene già le annotazioni semantiche (typeof, property, resource, ecc.);

👉 XSLT converte il TEI annotato in HTML preservando questi valori.

Questo approccio funziona bene per oggetti legati alla performance (video, immagini, etc) in quanto non richiedono un rigore filologico. Però ho notato che appesantisce la struttura TEI e rischia di rendere i file non più conformi o comunque meno leggibili quando si tratta delle trascrizioni filologica del testo teatrale. In altre parole, l’arricchimento semantico di rdfa altera il profilo formale del TEI, limitandone la riusabilità e la conformità in contesti filologici.


🔹 2. Prova_TEI_RDF

Pipeline 2 - TEI conforme + RDF esterno + XSLT

Qui ho provato la soluzione opposta:

👉 il file TEI rimane "pulito", senza attributi RDFa;

👉 la parte semantica è descritta in un file RDF esterno;

👉 XSLT mette insieme le due fonti e produce un HTML arricchito.

Questa strategia consente di mantenere il TEI formalmente corretto e non intrusivamente annotato, integrando la semantica solo in fase di trasformazione.



In sintesi:

Pipeline 1 → integrazione diretta, ma semantica strutturalmente invasiva.

Pipeline 2 → integrazione esterna, con TEI formalmente coerente e non alterato.
