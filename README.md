# ORCA_Creationism
Initialize ORCA-project with scripts


Puuttuuuuuu

- kysyy basis setin ja käyttää sitä olennaisin osin tiedostojen nimeämiseen.. :O

- Output-scripti:
  - jos muisti on loppunu kesken nii ei sitä tartte ilmottaa siinä mahollisten tulosten puoolivälissä ku vaikka jälkee tai loppuun ja vaikka jollai hienolla merkinnällä ja mielellää vielä samalla rivillä.. LOL

- xyz-filen käsittely:
  - hakee vain olennaisen eli koordinaatit ja lisää ne inp-tiedostoon   DONE?
  - hakee wc -l rivien määrän ja siitä atomien määrän 
    - käyttää automaattista resurssienjakoa atomien määrän perusteella

- ne inp ja job txt:t vois vaa olla olemassa as such eikä tarttis scriptillä luoda joka kerta
  - säästyis tilaa import-scriptistä


MUUTOKSET vanhasta versiosta (A_New_Era)
- rcts luetaan jo master-scriptissä
- kansioiden ja tiedostojen polut eksakteja
- $base tarjoillaan parametrina kaikkiin
- Joka kansioon tehdään Jobit-kansio, johon txt-fileet menee
- mem-per-cpu spesifioituna
- create_input -setti on nyt init-masterissa sisällä
- eri kokoisille eri input-file (mol123jne)
- eri toiminnallisuudet Q ja T
- eri toiminnallisuudet HF ja DFT
- 
