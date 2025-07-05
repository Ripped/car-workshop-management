# car-workshop-management

## FIT-RS2-2023
Seminarski rad RS2

## Kredencijali za pristup aplikacijama

### Desktop Aplikacija
- Korisničko ime: admin
- Lozinka: test

### Mobile Aplikacija
- Korisničko ime: employee
- Lozinka: test

### Mobile Aplikacija
- Korisničko ime: user
- Lozinka: test

### Mobile Aplikacija (Stripe Payment)
Za uspješno plaćanje putem stripe-a potrebno se prijaviti na stripe račun koristeči sljedeće kredencijale za prijavu:
- publishable key: pk_test_51RaEN4CERLEaA45XZsnGTWz6PqNaWXNfAI1Cg4M6kph1WA0diRVGE52WBiKYbaIgWIV0ll2Yx5wAdyuvijf54PIH004WfANWu2
- secret key: sk_test_51RaEN4CERLEaA45XImvBDVnyJcRZouXruiPbqGuaMsY0ZWwqH5j79v7IkcYvZZCfxKx42MzPKwXB9da0nIEnTsNo00iLbmNPGh

Za praćenje i pregled transakcija potrebno se prijaviti na stripe račun koristeči sljedeće kredencijale za prijavu:
- Email: belmin.ibric@edu.fit.ba
- Password: rs2TestRs2Test

### Recommender sistem
Funkcionalnost je dostupna korisnicima desktop i mobile aplikacije i predstavlja implementaciju Content-based filtering. ML algoritam radi na osnovu podataka prikupljenih od narudžbi klijenata, ocjene proizvoda i usluge će biti pohranjene te na osnovu ocjene klijentu će se preporučiti usluga ili proizvod slični onima kojima je dao dobru ocjenu.

### Obavijesti
Obavijesti se prikazuju ako nema recommended proizvoda za korisnika, uposlenik uvijek ima pregled obavijestima. Korisnik moze pregledati obavijesti u gornjem desnom uglu ekrana.
### Rezervacija termina
Kako bi rezervacija termina bila uspješna potrebno je odabrati datum te unijeti trazene podatke, zatim termin mora biti odobren ili odbijen nakon čega korisnik dobiva email ukoliko je rezervacija uspješna ili odbijena.

### Email za provjeru rada mikroservisa i slanja e-maila korisniku 
Za pregled poslanih email poruka ulogovati se na rs2cwm@gmail.com
- Email: rs2cwm@gmail.com
- Lozinka: rs2TestRs2Test
