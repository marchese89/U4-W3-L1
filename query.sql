-- query 1
-- tutti i clienti che si chiamano 'Mario'
SELECT * 
FROM clienti
WHERE clienti.nome = 'Mario' 

-- query 2
-- Nome e cognome dei clienti nati nel 1982
SELECT nome,cognome
FROM clienti
WHERE anno_di_nascita = '1982'

-- query 3
-- numero delle fatture con iva al 20%
SELECT COUNT(iva)
FROM fatture
WHERE iva = '20'

-- query 4
-- prodotti attivati nel 2017 e che sono in produzione oppure in commercio
SELECT *
FROM prodotti
WHERE (data_attivazione BETWEEN '2017-01-01' AND '2017-12-31') AND (in_produzione = TRUE OR in_commercio = TRUE)

-- query 5
-- estrarre le fatture con importo inferiore a 1000 e i dati dei clienti ad esse collegate
SELECT *
FROM fatture JOIN clienti ON fatture.id_cliente = clienti.numero_cliente
WHERE fatture.importo < 1000

-- query 6
-- riportare l'elenco delle fatture (numero,importo,iva e data) con in aggiunta il nomer del fornitore

SELECT fatture.numero_fattura, fatture.importo, fatture.iva, fatture.data_fattura, fornitori.denominazione
FROM fatture JOIN fornitori ON fatture.numero_fornitore = fornitori.numero_fornitore

-- query 7
-- considerando soltanto le fatture con iva al 20 per cento, estrarre il numero di fatture per ogni anno 
-- (per estrarre l'anno da una data si può usara EXTRACT(YEAR FROM data))

SELECT COUNT(numero_fattura)
FROM fatture
WHERE iva = 20
GROUP BY EXTRACT(YEAR FROM data_fattura)

-- query 8 
-- riportare il numero di fatture e la somma dei relativi importi divisi per anno di fatturazione
SELECT COUNT(numero_fattura) AS numero_fatture,SUM(importo) AS importo_totale
FROM fatture
GROUP BY EXTRACT(YEAR FROM data_fattura) 

-- query 9 
-- estrarre gli anni in cui sono state registrate più di 2 fatture con tipologia 'A'
SELECT EXTRACT(YEAR FROM data_fattura)
FROM fatture
WHERE tipologia = 'A'
GROUP BY EXTRACT(YEAR FROM data_fattura)
HAVING COUNT(tipologia) > 2

-- query 10
-- estrarre il totale degli importi delle fatture divisi per residenza dei clienti

SELECT SUM(fatture.importo) AS totale_importi,clienti.regione_residenza
FROM fatture JOIN clienti ON fatture.id_cliente = clienti.numero_cliente
GROUP BY clienti.regione_residenza

-- query 11
-- estrarre il numero dei clienti nati nel 1980 che hanno almeno una fattura superiore a 50 euro

SELECT COUNT(c.numero_cliente) AS num_clienti
FROM clienti c
WHERE c.anno_di_nascita = 1980 AND 
EXISTS(
	SELECT * FROM fatture 
	WHERE c.numero_cliente = fatture.id_cliente AND fatture.importo > 50
) 