import names
import random
import string
import datetime


def random_char(char_num):
       return ''.join(random.choice(string.ascii_letters) for _ in range(char_num))


plemena = """Afghánský chrt
Aidi
Airedale terier
Akbaš
Akita-Inu
Alapaha, buldok s modrou krví (Alapažský čistokrevný buldok)
Aljašský klee kai
Aljašský malamut
Alpský jezevčíkovitý brakýř
Americká akita (neboli velký japonský pes)
Americký bezsrstý teriér
Americký buldok
Americký eskymácký pes
Americký foxhound
Americký kokršpaněl
Americký stafordširský terier
Americký vodní španěl
Anatolský pastevecký pes
Anglický buldok
Anglický foxhound
Anglický chrt (Greyhound)
Anglický kokršpaněl
Anglický mastif
Anglický setr
Anglický špringršpaněl
Anglický toy terier
Anglo-francouzský honič de Petite Venerie
Appenzellský salašnický pes
Argentinská doga
Ariégois
Ariegský ohař krátkosrstý
Artésko-normandský baset
Artoisský basset
Artoisský honič
Australská kelpie
Australský honácký pes
Australský ovčák
Australský teriér
Auvergneský ohař krátkosrstý
Azavak
Barbet
Barzoj
Basenji
Baset
Bavorský barvář
Bearded kolie
Bedlington teriér
Belgický grifonek
Belgický ovčák
Belgický ovčák - Groenendael
Belgický ovčák - Laekenois
Belgický ovčák - Malinois
Belgický ovčák - Tervueren
Bergamský ovčák
Bernský salašnický pes
Beauceron
Bígl
Bígl-Harrier
Billy
Bišonek
Bílý švýcarský ovčák
Black and tan Coonhound
Bloodhound
Blue Lacy
Bobtail
Boloňský psík
Bordeauxská doga
Border kolie
Border teriér
Bosenský hrubosrstý honič
Bostonský teriér
Bourbonský ohař
Brabantík
Braque Dupuy
Brazilská fila
Brazilský teriér
Bretaňský ohař
Briard
Briquet Griffon Vendéen
Bruselský grifonek
Bullmastif
Bulteriér
Burgoský perdiquero
Cairn teriér
Cao de Castro Laboreiro
Clumber španěl
Coton de Tulear
Curly coated retrívr
Čau-čau
Černý teriér
Československý vlčák
Český fousek
Český horský pes
Český strakatý pes
Český teriér
Čínský chocholatý pes
Čivava
Dalmatin
Dandie dinmont teriér
Dánská doga
Dánsko-švédský farmářský pes
Dánský ohař krátkosrstý
Deerhound
Dlouhosrstý ohař z Pont-Audemer
Dobrman
Drentsche Patrisijshond
Drever
Dunker
Entlebušský salašnický pes
Estrelský pastevecký pes
Eurasier
Evropský saňový pes
Faraonský pes
Field španěl
Finský honič
Finský špic
Flanderský bouvier
Flat coated retrívr
Foxteriér drsnosrstý
Foxteriér hladkosrstý
Francouzský bílo-černý honič
Francouzský bílo-oranžový honič
Francouzský buldoček
Francouzský ohař dlouhosrstý
Francouzský ohař krátkosrstý gaskoňského typu
Francouzský ohař krátkosrstý pyrenejského typu
Francouzský trikolorní honič
Gaskoňsko-saintgeoiský honič
Gordonsetr
Grónský pes
Haldenův honič
Hamiltonův honič
Hannoverský barvář
Harrier
Havanský psík
Himálajský ovčák (Himálajský ovčácký pes)
Hokkaido-Ken
Holandský ovčácký pudl
Holandský ovčák
Holandský pinč
Hovawart
Hygenův honič
Chesapeake Bay retrívr
Chodský pes
Chortaja borzaja
Chorvatský ovčák
Ibizský podenco
Incký naháč
Irish Glen of Imaal terier
Irish Soft Coated Wheaten Terrier
Irský červenobílý setr
Irský setr
Irský teriér
Irský vlkodav
Irský vodní španěl
Islandský pes
Istrijský hrubosrstý honič
Istrijský krátkosrstý honič
Italský corso pes
Italský chrtík
Italský ohař
Italský segugio
Italský spinone
Italský volpino
Jack Russell teriér
Jakutská lajka
Jämthund
Japan-chin
Japonský špic
Japonský teriér
Jezevčík
Jihoruský ovčák
Jugoslávský planinský honič
Jugoslávský trikolorní honič
Kai-Inu
Kanaánský pes
Kanadský eskymácký pes
Kanárský podenco
Karelský medvědí pes
Katalánský ovčák
Kavalír King Charles španěl
Kavkazský pastevecký pes
Kerry bígl
Kerry blue teriér
King Charles španěl
Kishu-Inu
Knírač malý
Knírač střední
Knírač velký
Kolie dlouhosrstá
Kolie krátkosrstá
Komondor
Kontinentální buldok
Kooikerhondje
Korejský Jindo
Krašský pastevecký pes
Kromforländer
Krysí teriér
Kuvasz
Kyi Apso
Kyi Leo
Labradorský retrívr
Lagotto Romagnolo (Italský vodní pes)
Lakeland teriér
Lancashirský patař
Landseer
Lapinkoira
Lapinporokoira
Laponský špic
Leavittův buldok
Leonberger
Lhasa Apso
Louisianský leopardí pes
Lvíček
Manchester teriér
Maďarský chrt
Maďarský ohař drátosrstý
Maďarský ohař krátkosrstý
Malorská doga
Malorský krysařík
Malorský ovčák (Ca de Bestiar)
Maltézský psík
Malý gaskoňsko-saintgeoiský honič
Malý hrubosrstý modrý gaskoňský honič
Malý hrubosrstý vendéeský baset
Malý modrý gaskoňský honič
Malý münsterlandský ohař
Maremmansko-abruzzský pastevecký pes
Mexický naháč
Miniaturní bulteriér
Modrý coonhound
Modrý gaskoňský baset
Modrý pikardský ohař dlouhosrstý
Mops
Moskevský strážní pes
Mudi
Neapolský mastin
Německá doga
Německý boxer
Německý brakýř
Německý křepelák
Německý lovecký teriér
Německý ohař dlouhosrstý
Německý ohař drátosrstý
Německý ohař krátkosrstý
Německý ohař ostnosrstý
Německý ovčák
Německý pinč
Německý špic
Nivernaisský hrubosrstý honič
Norbotenský špic
Norfolk teriér (norfolský teriér)
Norský buhund
Norský losí pes černý
Norský losí pes šedý
Norský lundehund
Norwich teriér (norvičský teriér)
Nova Scotia duck tolling retrívr
Novofundlandský pes
Opičí pinč
Otterhound
Pachón navarro
Papillon
Parson Russell teriér
Patterdale teriér
Pekingský palácový psík
Peruánský naháč
Phalène
Pikardský ovčák
Plavý bretaňský baset
Plavý bretaňský honič
Plottův pes
Plummerův teriér
Podhalaňský ovčák
Pointer
Poitevin
Polský chrt
Polský ogar
Polský ovčák nížinný
Porcelaine
Portugalský ohař
Portugalský ovčák
Portugalský podengo
Portugalský vodní pes
Posávský honič
Pražský krysařík
Pudl střední
Pudl toy
Pudl trpasličí
Pudl velký
Pudlpointr
Puli
Pumi
Pyrenejský horský pes
Pyrenejský mastin
Pyrenejský ovčák
Rakouský krátkosrstý honič
Rakouský krátkosrstý pinč
Redbone Coonhound
Rhodéský ridgeback
Rotvajler
Ruskoevropská lajka
Řecký honič
Řecký ovčácký pes
Saarloosův vlčák
Saint-Germainský ohař krátkosrstý
Saluki
Samojed
Sealyham teriér
Sedmihradský honič
Sheltie
Shiba-Inu
Shih-tzu
Shikoku-Inu
Shilohský ovčák
Schillerův honič
Sibiřský husky
Sicilský chrt
Silky teriér
Skotský teriér
Skye teriér
Sloughi
Slovenský čuvač
Slovenský kopov
Slovenský ohař hrubosrstý
Smalandský honič
Srbský honič (neboli balkánský honič)
Stabyhoun
Stafordšírský bulteriér
Středoasijský pastevecký pes
Sussex španěl
Svatobernardský pes
Šarpej
Šarplaninský pastevecký pes
Šiperka
Španělský alano
Španělský galgo
Španělský mastin
Španělský sabueso
Španělský vodní pes
Štýrský brakýř
Švýcarský honič
Švýcarský honič - Bernský honič
Švýcarský honič - Jurský honič
Švýcarský honič - Luzernský honič
Švýcarský honič - Schwyzský honič
Švýcarský nízkonohý honič
Taigan
Taiwanský pes
Thai Bangkaew dog
Thajský ridgeback
Tibetská doga
Tibetský španěl
Tibetský teriér
Tornjak
Tosa-Inu
Toy foxteriér
Trpasličí pinč
Tyrolský honič
Uruguayský cimarron
Vaestgoetlandský špic (Vallhund)
Velký francouzsko-anglický bílo-oranžový honič
Velký francouzsko-anglický trikolorní honič
Velký francouzsko-anglický bílo-černý honič
Velký gaskoňsko-saintongeoisský honič
Velký hrubosrstý vendéeský baset
Velký modrý gaskoňský honič
Velký münsterlandský ohař
Velký švýcarský salašnický pes
Velký vendéeský hrubosrstý honič
Velšský ovčák
Velššpringršpaněl
Velšteriér
Východoevropský ovčák
Východosibiřská lajka
Výmarský ohař
Výmarský ohař dlouhosrstý
Výmarský ohař krátkosrstý
Welsh Corgi Cardigan
Welsh Corgi Pembroke
West Highland White teriér
Westfálský jezevčíkovitý honič
Wetterhound
Whippet
Yorkšírský teriér"""


"""ahoj """
countries = [
    ('US', 'United States'),
    ('AF', 'Afghanistan'),
    ('AL', 'Albania'),
    ('DZ', 'Algeria'),
    ('AS', 'American Samoa'),
    ('AD', 'Andorra'),
    ('AO', 'Angola'),
    ('AI', 'Anguilla'),
    ('AQ', 'Antarctica'),
    ('AG', 'Antigua And Barbuda'),
    ('AR', 'Argentina'),
    ('AM', 'Armenia'),
    ('AW', 'Aruba'),
    ('AU', 'Australia'),
    ('AT', 'Austria'),
    ('AZ', 'Azerbaijan'),
    ('BS', 'Bahamas'),
    ('BH', 'Bahrain'),
    ('BD', 'Bangladesh'),
    ('BB', 'Barbados'),
    ('BY', 'Belarus'),
    ('BE', 'Belgium'),
    ('BZ', 'Belize'),
    ('BJ', 'Benin'),
    ('BM', 'Bermuda'),
    ('BT', 'Bhutan'),
    ('BO', 'Bolivia'),
    ('BA', 'Bosnia And Herzegowina'),
    ('BW', 'Botswana'),
    ('BV', 'Bouvet Island'),
    ('BR', 'Brazil'),
    ('BN', 'Brunei Darussalam'),
    ('BG', 'Bulgaria'),
    ('BF', 'Burkina Faso'),
    ('BI', 'Burundi'),
    ('KH', 'Cambodia'),
    ('CM', 'Cameroon'),
    ('CA', 'Canada'),
    ('CV', 'Cape Verde'),
    ('KY', 'Cayman Islands'),
    ('CF', 'Central African Rep'),
    ('TD', 'Chad'),
    ('CL', 'Chile'),
    ('CN', 'China'),
    ('CX', 'Christmas Island'),
    ('CC', 'Cocos Islands'),
    ('CO', 'Colombia'),
    ('KM', 'Comoros'),
    ('CG', 'Congo'),
    ('CK', 'Cook Islands'),
    ('CR', 'Costa Rica'),
    ('CI', 'Cote D`ivoire'),
    ('HR', 'Croatia'),
    ('CU', 'Cuba'),
    ('CY', 'Cyprus'),
    ('CZ', 'Czech Republic'),
    ('DK', 'Denmark'),
    ('DJ', 'Djibouti'),
    ('DM', 'Dominica'),
    ('DO', 'Dominican Republic'),
    ('TP', 'East Timor'),
    ('EC', 'Ecuador'),
    ('EG', 'Egypt'),
    ('SV', 'El Salvador'),
    ('GQ', 'Equatorial Guinea'),
    ('ER', 'Eritrea'),
    ('EE', 'Estonia'),
    ('ET', 'Ethiopia'),
    ('FK', 'Falkland Islands (Malvinas)'),
    ('FO', 'Faroe Islands'),
    ('FJ', 'Fiji'),
    ('FI', 'Finland'),
    ('FR', 'France'),
    ('GF', 'French Guiana'),
    ('PF', 'French Polynesia'),
    ('TF', 'French S. Territories'),
    ('GA', 'Gabon'),
    ('GM', 'Gambia'),
    ('GE', 'Georgia'),
    ('DE', 'Germany'),
    ('GH', 'Ghana'),
    ('GI', 'Gibraltar'),
    ('GR', 'Greece'),
    ('GL', 'Greenland'),
    ('GD', 'Grenada'),
    ('GP', 'Guadeloupe'),
    ('GU', 'Guam'),
    ('GT', 'Guatemala'),
    ('GN', 'Guinea'),
    ('GW', 'Guinea-bissau'),
    ('GY', 'Guyana'),
    ('HT', 'Haiti'),
    ('HN', 'Honduras'),
    ('HK', 'Hong Kong'),
    ('HU', 'Hungary'),
    ('IS', 'Iceland'),
    ('IN', 'India'),
    ('ID', 'Indonesia'),
    ('IR', 'Iran'),
    ('IQ', 'Iraq'),
    ('IE', 'Ireland'),
    ('IL', 'Israel'),
    ('IT', 'Italy'),
    ('JM', 'Jamaica'),
    ('JP', 'Japan'),
    ('JO', 'Jordan'),
    ('KZ', 'Kazakhstan'),
    ('KE', 'Kenya'),
    ('KI', 'Kiribati'),
    ('KP', 'Korea (North)'),
    ('KR', 'Korea (South)'),
    ('KW', 'Kuwait'),
    ('KG', 'Kyrgyzstan'),
    ('LA', 'Laos'),
    ('LV', 'Latvia'),
    ('LB', 'Lebanon'),
    ('LS', 'Lesotho'),
    ('LR', 'Liberia'),
    ('LY', 'Libya'),
    ('LI', 'Liechtenstein'),
    ('LT', 'Lithuania'),
    ('LU', 'Luxembourg'),
    ('MO', 'Macau'),
    ('MK', 'Macedonia'),
    ('MG', 'Madagascar'),
    ('MW', 'Malawi'),
    ('MY', 'Malaysia'),
    ('MV', 'Maldives'),
    ('ML', 'Mali'),
    ('MT', 'Malta'),
    ('MH', 'Marshall Islands'),
    ('MQ', 'Martinique'),
    ('MR', 'Mauritania'),
    ('MU', 'Mauritius'),
    ('YT', 'Mayotte'),
    ('MX', 'Mexico'),
    ('FM', 'Micronesia'),
    ('MD', 'Moldova'),
    ('MC', 'Monaco'),
    ('MN', 'Mongolia'),
    ('MS', 'Montserrat'),
    ('MA', 'Morocco'),
    ('MZ', 'Mozambique'),
    ('MM', 'Myanmar'),
    ('NA', 'Namibia'),
    ('NR', 'Nauru'),
    ('NP', 'Nepal'),
    ('NL', 'Netherlands'),
    ('AN', 'Netherlands Antilles'),
    ('NC', 'New Caledonia'),
    ('NZ', 'New Zealand'),
    ('NI', 'Nicaragua'),
    ('NE', 'Niger'),
    ('NG', 'Nigeria'),
    ('NU', 'Niue'),
    ('NF', 'Norfolk Island'),
    ('MP', 'Northern Mariana Islands'),
    ('NO', 'Norway'),
    ('OM', 'Oman'),
    ('PK', 'Pakistan'),
    ('PW', 'Palau'),
    ('PA', 'Panama'),
    ('PG', 'Papua New Guinea'),
    ('PY', 'Paraguay'),
    ('PE', 'Peru'),
    ('PH', 'Philippines'),
    ('PN', 'Pitcairn'),
    ('PL', 'Poland'),
    ('PT', 'Portugal'),
    ('PR', 'Puerto Rico'),
    ('QA', 'Qatar'),
    ('RE', 'Reunion'),
    ('RO', 'Romania'),
    ('RU', 'Russian Federation'),
    ('RW', 'Rwanda'),
    ('KN', 'Saint Kitts And Nevis'),
    ('LC', 'Saint Lucia'),
    ('VC', 'St Vincent/Grenadines'),
    ('WS', 'Samoa'),
    ('SM', 'San Marino'),
    ('ST', 'Sao Tome'),
    ('SA', 'Saudi Arabia'),
    ('SN', 'Senegal'),
    ('SC', 'Seychelles'),
    ('SL', 'Sierra Leone'),
    ('SG', 'Singapore'),
    ('SK', 'Slovakia'),
    ('SI', 'Slovenia'),
    ('SB', 'Solomon Islands'),
    ('SO', 'Somalia'),
    ('ZA', 'South Africa'),
    ('ES', 'Spain'),
    ('LK', 'Sri Lanka'),
    ('SH', 'St. Helena'),
    ('PM', 'St.Pierre'),
    ('SD', 'Sudan'),
    ('SR', 'Suriname'),
    ('SZ', 'Swaziland'),
    ('SE', 'Sweden'),
    ('CH', 'Switzerland'),
    ('SY', 'Syrian Arab Republic'),
    ('TW', 'Taiwan'),
    ('TJ', 'Tajikistan'),
    ('TZ', 'Tanzania'),
    ('TH', 'Thailand'),
    ('TG', 'Togo'),
    ('TK', 'Tokelau'),
    ('TO', 'Tonga'),
    ('TT', 'Trinidad And Tobago'),
    ('TN', 'Tunisia'),
    ('TR', 'Turkey'),
    ('TM', 'Turkmenistan'),
    ('TV', 'Tuvalu'),
    ('UG', 'Uganda'),
    ('UA', 'Ukraine'),
    ('AE', 'United Arab Emirates'),
    ('UK', 'United Kingdom'),
    ('UY', 'Uruguay'),
    ('UZ', 'Uzbekistan'),
    ('VU', 'Vanuatu'),
    ('VA', 'Vatican City State'),
    ('VE', 'Venezuela'),
    ('VN', 'Viet Nam'),
    ('VG', 'Virgin Islands (British)'),
    ('VI', 'Virgin Islands (U.S.)'),
    ('YE', 'Yemen'),
    ('YU', 'Yugoslavia'),
    ('ZR', 'Zaire'),
    ('ZM', 'Zambia'),
    ('ZW', 'Zimbabwe')
]
continents =["Africa", "America", "Antarctica", "Asia", "Australia/Oceania","Europe"]
position=["vedoucí","uklízeč","ošetřovatel","účetní"]
sex=["pes","fena"]
rewards_names=["Pohár Mistra Maleniv","Psí závody 2021","Závody psích spřežení","Mushing závody","Hard Dog Race pravidla","Czech DOG race","Extreme Dog Race","Virtual 4ALL","STEEPLECHASE"]

sql = """
CREATE TABLE Pes (
cislo  INTEGER,
jmeno VARCHAR(20),
pohlavi VARCHAR(20),
cena DECIMAL(10,2),
datum_prodeje DATE,
je_predkem INTEGER,
pecovatel INTEGER,
majitel INTEGER,
plemeno INTEGER 
); 



CREATE TABLE Oceneni (
ID INTEGER,
nazev VARCHAR(200),
datum DATE,
ziskal INTEGER
);


CREATE TABLE Test (
ID INTEGER,
datum DATE,
hmotnost DECIMAL, 
cislo_psa INTEGER
);

CREATE TABLE Ockovani (
ID INTEGER,
datum_ockovani DATE,
datum_konce_ucinosti DATE,
cislo_psa INTEGER,
provedl INTEGER
);

CREATE TABLE Plemeno (
ID INTEGER,
nazev VARCHAR(100),
prumerna_vyska DECIMAL,
prumerna_hmotnost DECIMAL,
zeme_puvodu INTEGER
);

CREATE TABLE Zeme_puvodu (
ID INTEGER,
nazev VARCHAR(40),
kontinent VARCHAR(20)
);

CREATE TABLE Uzivatel (
ID INTEGER,
jmeno VARCHAR(300) NOT NULL,
prijmeni VARCHAR(300) NOT NULL,
telefon VARCHAR(22),
email VARCHAR(254) NOT NULL
);

CREATE TABLE Zamestnanec (
ID INTEGER,
datum_nastupu DATE NOT NULL,
pozice VARCHAR(20) NOT NULL,
plat DECIMAL(10,2) NOT NULL
);

CREATE TABLE Zakaznik (
ID INTEGER,
ICO INTEGER UNIQUE
);


"""
generated_size = 150
inserted = ""
piece = sql.split("CREATE TABLE")
piece = piece[1:]
for z in range(generated_size):
    for i in piece:
        if (z % 2) == 0:
            if "Zamestnanec" in i:
                continue
        else:
            if "Zakaznik" in i:
                continue
        row = i.split("\n")
        for q in range(len(row)):
            if q == 0:
                inserted = "INSERT INTO"+row[q][:-2]+"\nVALUES("
            else:
                if "VARCHAR" in row[q]:
                    if "nazev" in row[q] and "Oceneni" in row[0]:
                        inserted+=",'"+random.choice(rewards_names)+"'"
                    if "nazev" in row[q] and "Plemeno" in row[0]:
                        inserted+=",'"+random.choice(plemena.split("\n"))+"'"
                    if "pohlavi" in row[q]:
                        inserted+=",'"+random.choice(sex)+"'"
                    if "pozice" in row[q]:
                        inserted+=",'"+random.choice(position)+"'"
                    if "jmeno" in row[q]:
                        inserted+=",'"+names.get_first_name()+"'"
                    if "prijmeni" in row[q]:
                        inserted+=",'"+names.get_last_name()+"'"
                    if "mail" in row[q]:
                        inserted+=",'"+random_char(random.randrange(5,20))+"@gmail.com'"
                    if "tel" in row[q]:
                        end = ""
                        for _ in range(8):
                            end+=str(random.randrange(0,10))
                        inserted+=",'7"+end+"'"
                    if "nazev" in row[q] and "Zeme_puvodu" in row[0] :
                        inserted+=",'"+random.choice(countries)[1]+"'"
                    if "kontinent" in row[q]:
                        inserted+=",'"+random.choice(continents)+"'"
                if "DATE" in row[q]:
                    if "datum_konce_ucinosti" in row[q] :
                        startdate=datetime.date(int(inserted[-26:-22]),int(inserted[-21:-19]),int(inserted[-18:-16]))
                        date=startdate+datetime.timedelta(random.randint(1,3000))
                        date=str(date).replace("-",".")
                    else:
                        startdate=datetime.date(1990,1,1)
                        date=startdate+datetime.timedelta(random.randint(1,8000))
                        date=str(date).replace("-",".")
                    inserted+=","+"TO_DATE('"+date+"', 'yyyy.mm.dd')"
                if "plat" in row[q]:
                    inserted+=","+str(random.randint(14,30))+"000"
                if "cena" in row[q]:
                    inserted+=","+str(random.randint(5,70))+"000"
                if "hmotnost" in row[q]:
                    inserted+=","+str(random.randint(7,40))
                if "vyska" in row[q]:
                    inserted+=","+str(random.randint(20,90))
                if "INTEGER" in row[q]:
                    if "ID" in row[q]:
                        inserted+=str(z)
                    elif "cislo" in row[q] and "Pes" in row[0]:
                        inserted+=str(z)
                    elif "ICO" in row[q]:
                        end = ""
                        for _ in range(8):
                            end+=str(random.randrange(1,10))
                        inserted+=","+end
                    else:
                        rng = random.randint(-1,z-1)
                        if rng == 0 or rng == -1:
                            inserted+=",NULL"
                        else:
                            inserted+=","+str(rng)

            if q == len(row)-1:
                inserted += ");"
                print(inserted)
