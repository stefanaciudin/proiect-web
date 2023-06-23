create database if not exists database_web;

use database_web;

drop table products;
drop table rankings;
drop table users;
drop table brands;
drop table product_types;
drop table skintypes;

create table brands
(
    brand_id    int           not null auto_increment,
    name        varchar(255)  not null,
    description varchar(5000) not null,
    primary key (brand_id)
);

create table skintypes
(
    skintype_id int          not null auto_increment,
    skin_type   varchar(255) not null, -- uscat gras etc
    primary key (skintype_id)
);

create table product_types
(
    type_id      int          not null auto_increment,
    product_type varchar(255) not null, -- de fata de ochi etc
    usage_time   enum ('zi','seara','oricand'),
    usage_type   varchar(255),
    primary key (type_id)
);

create table products
(
    product_id  int            not null auto_increment,
    name        varchar(255)   not null,
    price       decimal(10, 2) not null,
    image_path  varchar(255),
    is_makeup   bool,
    age         int            not null,
    brand_id    int            not null,
    skintype_id int            not null,
    type_id     int            not null,
    ingredients varchar(4000),
    description varchar(2000),
    how_to_use  varchar(1000),
    primary key (product_id),
    foreign key (brand_id) references brands (brand_id),
    foreign key (skintype_id) references skintypes (skintype_id),
    foreign key (type_id) references product_types (type_id)
);

create table users
(
    user_id       int                  not null auto_increment,
    name          varchar(255)         not null,
    surname       varchar(255)         not null,
    username      varchar(255)         not null,
    email         varchar(255)         not null,
    password      varchar(255)         not null,
    age           int       default 18 not null,
    skintype_id   int       default 2  not null,
    gender        enum ('m','f','n'),
    location      varchar(255),
    creation_time timestamp default current_timestamp,
    primary key (user_id),
    unique (username),
    unique (email),
    foreign key (skintype_id) references skintypes (skintype_id)
);

create table rankings
(
    ranking_id int not null auto_increment,
    age_min    int not null,
    age_max    int not null,
    gender     enum ('m','f','n'),
    location   varchar(255),
    type_id    int not null,
    primary key (ranking_id),
    foreign key (type_id) references product_types (type_id)
);


INSERT INTO product_types (product_type, usage_type, usage_time) -- id 1
VALUES ('ten', 'gel de curatare', 'oricand'),    -- 1
       ('ten', 'crema hidratare', 'oricand'),    -- 2
       ('ten', 'exfoliant', 'oricand'),          -- 3
       ('ten', 'ser', 'oricand'),                -- 4
       ('ten', 'ser', 'zi'),                     -- 5
       ('ten', 'ser', 'seara'),                  -- 6
       ('ten', 'crema antirid', 'seara'),        -- 7
       ('ten', 'spf', 'zi'),                     -- 8
       ('ochi', 'crema de ochi', 'oricand'),     -- 9
       ('buze', 'crema de buze', 'oricand'),     -- 10
       ('buze', 'exfoliant de buze', 'oricand'), -- 11
       ('ten', 'fond de ten', 'oricand'),        -- 12
       ('ten', 'pudra', 'oricand'),              -- 13
       ('ten', 'corector', 'oricand'),           -- 14
       ('ten', 'iluminator', 'oricand'),         -- 15
       ('ten', 'bronzer', 'oricand'),            -- 16
       ('ochi', 'paleta farduri', 'oricand'),    -- 17
       ('ochi', 'mascara', 'oricand'),           -- 18
       ('ochi', 'gel sprancene', 'oricand'),     -- 19
       ('ochi', 'creion sprancene', 'oricand'),  -- 20
       ('ochi', 'eyeliner', 'oricand'),          -- 21
       ('buze', 'ruj', 'oricand'),               -- 22
       ('buze', 'creion de buze', 'oricand'),    -- 23
       ('buze', 'gloss', 'oricand'),             -- 24
       ('buze', 'ruj lichid', 'oricand'),        -- 25
       ('buze', 'balsam de buze', 'oricand'),    -- 26
       ('ten', 'demachiant', 'seara'); -- 27


INSERT INTO skintypes (skin_type)
VALUES ('gras'),   -- 1
       ('normal'), -- 2
       ('mixt'),   -- 3
       ('uscat'),  -- 4
       ('oricare'); -- 5

INSERT INTO brands (name, description)
VALUES ('The Ordinary', ''),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           -- 1
       ('Cerave', 'De peste un deceniu, brandul CeraVe este lider în domeniul îngrijirii pielii, în Statele Unite. Compania dezvoltă, în colaborare cu medicii dermatologi, produse care completează, optimizează și regenerează funcția de barieră naturală a pielii.

Cheia succesului dermato-cosmeticelor CeraVe constă în compoziția unică, cu un complex de 3 ceramide naturale. Ceramidele sunt lipide care refac bariera naturală a pielii, asigurându-i o hidratare durabilă. Pielea uscată și sensibilă necesită un aport de ceramide crescut. Cosmeticele CeraVe cu tehnologia MVE® eliberează ceramidele treptat, pentru a asigura eficiența continuă a produselor, pe tot parcursul zilei.

Toate produsele CeraVe sunt foarte neagresive, non-comedogenice, neparfumate și cu o compoziție simplă. În afară de ceramide, cosmeticele CeraVe mai conțin substanțe active precum acidul hialuronic, glicerina sau colesterolul. Răsfață-ți tenul și corpul cu un demachiant, cu o loțiune sau cu o cremă hidratantă de la CeraVe - și vei vedea diferența.'),                                                                                                                                                                                                                                                                                     -- 2
       ('Neutrogena', 'De aproape un secol, Neutrogena oferă produse eficiente pentru îngrijirea tenului și a pielii. Istoria brandului datează din anul 1930, când Manny Stolaroff a început să furnizeze produse saloanelor de frumusețe. Momentul crucial a venit în 1954, când a aflat despre proprietățile săpunului produs de nepotul medicului personal al lui Napoleon. Săpunul nu irita pielea și se spăla ușor. Stolaroff a fost atât de fascinat de produs, încât a început să-l distribuie sub numele de Neutrogena.

Apoi mersul evenimentelor s-a accelerat. În anii 60, a fondat compania Neutrogena, următorul reper major fiind brevetarea Rețetei Norvegiene, o compoziție unică, care să răspundă cerințelor pielii expuse celor mai vitrege condiții climatice.

Astăzi, printre produsele emblematice ale brandului se numără nu numai colecția Neutrogena Visibly Renew cu Rețeta Norvegiană, ci și gama de îngrijire a pielii Neutrogena Visibly Clear sau cremele pentru mâini Neutrogena. Utilizarea unor ingrediente active și colaborarea cu dermatologi de top au permis crearea unor produse cosmetice care reflectă fidel cerințele pielii și asigură îngrijirea sa eficientă.'),                                                                                                                                                                                                                       -- 3
       ('Barry M', 'Faceți cunoștință cu Barry M, un brand britanic jucăuș, care vă cucerește cu produsele sale pline de imaginație și de culoare. Cu ele creați în joacă orice machiaj, iar ambalajele vesele vă luminează ziua. Sunteți pregătită pentru o veritabilă avalanșă de culoare?

Brandul Barry M a revoluționat literalmente industria cosmetică. A fost fondat în 1982, dar istoria sa a început să se scrie cu mult timp înainte - mai precis, de când, în curtea din fața casei părinților săi, tânărul Barry Mero vindea lacuri de unghii. Jucăușe, strălucitoare și viu colorate. Exact cele care lipseau de pe piață. Ani mai târziu, Barry fondează brandul care îi poartă numele și cucerește lumea cosmeticelor cu lacurile sale colorate. Brandul Barry M se mândrește și cu primele creioane dermatografe albe sau cu ojele fosforescente, cum nu mai vânduse nimeni până atunci.

Portofoliul acestui brand britanic conține toate cele necesare pentru un machiaj perfect - rimel, rujuri, iluminatoare și superbe palete de farduri pentru ochi. În plus, compoziția cosmeticelor Barry M mulțumește și iubitorii de animale - brandul și-a luat angajamentul ca, din anul 2020, să aibă un portofoliu compus 100 % din produse vegane.'),                                                                                                                                                                                                                                                                                          -- 4
       ('Loreal Paris',
        'Cosmetice Loreal Paris | Loréal Paris este probabil cea mai faimoasa companie franceza de cosmetice din lume. Marca dateaza din 1907, atunci cand un tanar chimist Schueller Eugène a descoperit un produs de colorare a părului. Acest produs discret a dat un impuls suplimentar la inceput, iar prin testele de laborator s-a ajuns la o gama completa de produse noi si imbunatatite, care ar putea fi aplicate si pe corpul feminin. Loréal Paris a extins centrele de cercetare in doar cateva orase mari din lume. Astazi puteti regasi sub brandul Loréal Paris creme de fata, produse pentru par, parfumuri, dar si produse de make-up si altele.'), -- 5
       ('Vichy', 'Produsele dermato-cosmetice Vichy sunt sinonime cu calitatea în domeniul îngrijirii pielii. Sunt concepute pentru îngrijirea tuturor tipurilor de piele și de tenuri, chiar și a celor mai sensibile. Produsele din gama Vichy oferă rezultate vizibile, datorită combinației dintre substanțele active și apa termală Vichy, renumită pentru conținutul ridicat al mineralelor cu proprietăți calmante, fortifiante și regenerative.

Marca Vichy este un reprezentant tipic al convergenței de maxim succes între cosmetică și medicină. Tolerabilitatea excelentă, eficiența dovedită, formulele bazate pe cele mai noi studii, respectarea normelor etice în producție - acestea sunt atributele caracteristice produselor dermato-cosmetice Vichy.

Vichy ajută cu succes femeile din întreaga lume, la îngrijirea zilnică a pielii și a tenului. Misiunea laboratoarelor Vichy este de a dezvolta o linie completă de produse cosmetice, pentru absolut toate tipurile de piele. Portofoliul acestui brand de dermato-cosmetice oferă totul pentru o îngrijire zilnică perfectă a întregii familii. Oricare ar fi cerințele pielii tale, Vichy îți oferă soluția.'),                                                                                                                                                                                                                                     -- 6
       ('Garnier', 'De peste un secol, cosmeticele Garnier influențează stilul de viață al bărbaților și al femeilor din întreaga lume. A apărut în Franța și, treptat, a devenit unul dintre cele mai respectate branduri de produse cosmetice.

Povestea sa a debutat în 1904, când coaforul Alfred Amour Garnier a creat primul tonic din plante pentru înfrumusețarea părului, primul produs Garnier care a devenit rapid un bestseller. În anul 1960 a apărut prima vopsea de păr Garnier aplicabilă acasă, femeile începând să-și privească părul ca pe un accesoriu de modă. Printre produsele care au fost îndrăgite instantaneu se numără Garnier Micellar Water, gelul purificator Garnier Pure Active Gel și vopselele Garnier Nutrisse.

Brandul Garnier este atent la dorințele clienților săi, iar produsele reflectă nevoile acestora în ceea ce privește îngrijirea tenului și a părului. Creează produse care sunt cu adevărat eficiente, ușor accesibile și facilitează ritualurile zilnice de îngrijire a frumuseții. De aceea, cosmeticele Garnier înregistrează un uriaș succes mondial, fiind disponibile în peste 120 de țări din întreaga lume.'),                                                                                                                                                                                                                               -- 7
       ('Bioderma', 'Dermato-cosmeticele Bioderma sunt bazate pe cunoașterea pielii și a mecanismelor sale biologice. Această abordare științifică garantează obținerea unor produse a căror compoziție țintește precis diverse tipuri de piele sau problemele specifice acestora. Cosmeticele Bioderma nu conțin ingrediente dermatologice nocive, precum parabeni, ftalați sau formaldehide. Toate produsele conțin numai ingrediente active pure, care se găsesc normal în piele și, de aceea, Bioderma garantează o toleranță perfectă a preparatelor sale. Toate produsele de îngrijire a tenului și a pielii au fost testate clinic și au apărut sub supravegherea experților în dermatologie, alergologie și toxicologie.

De la debutul său în anul 1970, brandul deține numeroase brevete. De exemplu, apa micelară Bioderma Sensibio este prima apă de curățare din istorie, menținându-se și astăzi printre cele mai populare. La rândul său, gama Bioderma Sébium conține complexul brevetat Fluidactiv, care luptă eficient împotriva simptomelor tenului gras și problematic.

Portofoliul brandului cuprinde și tratamente sofisticate pentru corp. Dar, mai ales, Bioderma nu oferă doar un ajutor temporar, ci rezolvă întotdeauna direct cauza reală a problemei. Și tu poți oferi tenului și pielii tale îngrijirea ideală!'),                                                                                                                                                                                                                                                                                                                                                                                               -- 8
       ('La Roche-Posay', 'Brandul francez de dermato-cosmetice La Roche-Posay este cunoscut pentru colaborarea intensă cu medicii dermatologi și pentru angajamentul de a face îngrijirea pielii mai plăcută, pentru persoanele cu pielea sensibilă. De aceea, preparatele La Roche-Posay au o compoziție minimalistă și sunt produse în condiții de control strict.

Gamele de produse La Roche-Posay sunt adaptate la cerințele specifice ale fiecărui tip de piele sensibilă și oferă soluții pentru persoanele care suferă din cauza pielii intolerante, reactive, atopice sau predispuse la acnee. Baza indispensabilă pentru fiecare preparat este apa termală din La Roche-Posay, care are proprietăți antioxidante și terapeutice și calmează instantaneu pielea sensibilă și iritată.

Calitatea produselor dermato-cosmetice La Roche-Posay este demonstrată nu numai de rezultatele documentate ale studiilor clinice, ci și de numeroasele recomandări ale dermatologilor de top.'),                                                                                                                                                                                                                                                                                                                                                                                                                                             -- 9
       ('NYX Proffesional Makeup', 'Brandul de cosmetice decorative NYX Professional Makeup a fost fondat în 1999, în Los Angeles, de către artista în machiaj Toni Ko. NYX Professional Makeup reflectă cele mai recente tendinţe din machiaj. Portofoliul mărcii este cuprinzător: de la ruj şi produse pentru machiaj, până la pensule cosmetice profesionale.
NYX Professional Makeup sunt produse de înaltă calitate, la preţuri competitive, care se bucură de popularitate în rândul artiştilor în machiaj profesionişti. NYX Professional Makeup oferă nu numai un machiaj frumos, ci şi ambalaje elegante. Ambalajele deosebite completează imaginea brandului NYX Professional Makeup, care este popular în întreaga lume.
Produsele NYX Professional Makeup sunt bogate în pigmenţi, asigură un machiaj rezistent şi permit o abordare amuzantă a jocului de culori. Găsiţi-vă machiajul perfect şi deveniţi un profesionist în machiaj. NYX Professional Makeup nu testează produsele pe animale.'),                                                                                                                                                                                                                                                                                                                                                         -- 10
       ('MUA Makeup Academy', ''),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     -- 11
       ('DIOR',
        'Atunci cand Christian Dior a creat casa de moda in 1946, el si-a imaginat o noua feminitate, o feminitate absoluta. Astazi, de la rochii la accesorii, de la parfumuri la rujuri si pana la produse de ingrijire a tenului, Casa Dior ofera femeilor o frumusete sublima, stralucitoare si moderna.'),                                                                                                                                                                                                                                                                                                                                                        -- 12
       ('Catrice', 'Întotdeauna trendy, de bună calitate și accesibile ca preț. Acestea sunt cosmeticele Catrice, mereu în tendințe. Astfel, puteți fi sigură că produsele Catrice vă ajută să realizați un look ca de la cele mai recente prezentări de modă.

Brandul Catrice a fost fondat de Christina Oster-Daum, o lady cu o viziune clară. Aceea de a realiza cosmetice de calitate, pe care să și le poată permite absolut orice femeie. Pentru că fiecare dintre noi merită să se simtă frumoasă. Și astfel, în anul 2004, au apărut primul fond de ten, primul rimel, prima pudră Catrice și alte produse necesare unui machiaj fără cusur.

Tipic pentru cosmeticele Catrice sunt calitatea de primă clasă și urmărirea celor mai noi tendințe din lumea frumuseții. Printre produsele emblematice ale acestui brand german se numără fondul de ten Catrice HD Liquid Coverage, opac dar cu efect natural, corectorul Catrice Liquid Camouflage, care camuflează toate imperfecțiunile, sau pudra cu efect matifiant Catrice All Matt Plus. Merită menționate și baza de machiaj cu efect nuanțator lejer Catrice 1 Minute Face Perfector, popularul lac de unghii Catrice More Than Nude și rujul de buze Catrice, în cele mai diverse nuanțe.'),                                              -- 13
       ('Maybelline', 'Povestea brand-ului Maybelline începe în anul 1915, când tânăra americancă Mabel Williams a preparat un produs original pentru fardarea ochilor. Fratele său Thomas a fost atât de încântat de această descoperire, încât a fondat compania Maybell Laboratories şi a început vânzarea rimelurilor. Nu a durat mult şi femeile din toate statele americane au început să solicite produsele Maybelline. La mijlocul anilor ‘90, Maybelline a devenit parte integrantă din gigantul L’Oreal Group. Scopul său a rămas însă acelaşi: de a le oferi clienţilor cosmetice decorative de calitate şi la preţuri accesibile
În prezent, Maybelline se poate mândri prin colaborarea cu creatori de top din lumea modei, pentru a determina noi trenduri în domeniul frumuseţii. Acest brand se străduieşte neîncetat să-şi înnoiască portofoliul. Fardurile de ochi, lacurile de unghii, luciurile de buze, ca şi toate celelalte produse Maybelline se aplică uşor şi au o acţiune de lungă durată. Sunt de efect şi, nu în ultimul rând, sigure. Datorită acestor proprietăţi se bucură de o mare popularitate printre stiliştii profesionişti.
Cosmetica Maybelline este simbolul machiajului perfect. Mărturie a calităţilor sale excepţionale stă şi faptul că este utilizată de multe modele faimoase – cum ar fi Miranda Kerr, Gigi Hadid sau Adriana Lima. Marca Maybelline le va atrage cu siguranţă pe toate clientele care doresc să-şi sublinieze stilul personal, iubesc fardurile şi doresc să fie atrăgătoare pentru sexul opus.'),                                                                                                                                                                                                                                                 -- 14
       ('Makeup Revolution', 'Cosmeticele decorative Makeup Revolution reprezintă o adevărată revoluție în domeniul machiajului. Brandul londonez deține în portofoliu o gamă largă de produse de înaltă calitate, dar la prețuri accesibile, care te vor încânta.

Deosebit de populare sunt paletele de farduri de lux, care se disting prin pigmentarea intensă și prin combinațiile inovative de culori. Din arsenalul tău nu trebuie să lipsească măcar una dintre acestea. Oferta brandului conține însă și alte bijuterii cosmetice. De exemplu, nu trebuie să ratezi fondul de ten Makeup Revolution sau emblematicul corector Makeup Revolution, disponibil în mai multe variante, pentru aproape fiecare nuanță de ten.

Nu în ultimul rând, brandul atrage prin designul original și jucăuș, dar și practic, al produselor sale. Conferă machiajului tău stil și originalitate, cu Makeup Revolution London!'),                                                                                                                                                                                                                                                                                                                                                                                                                                                   -- 15
       ('MAC Cosmetics', 'Cosmetica decorativă profesională M·A·C dictează, de mulți ani, tendințele globale în culisele modei. Colaborează cu personalități proeminente ale artei, ale modei și ale culturii pop și își asumă motto-ul „Toate vârstele, toate rasele, toate genurile". Pentru milioane de oameni, a devenit mult mai mult decât un simplu brand de beauty.

Make-up Art Cosmetics s-a născut la Toronto, în Canada. Impulsul pentru apariția sa l-a constituit calitatea insuficientă a produselor de machiaj disponibile în acel moment în magazine. Artistul de machiaj și fotograful Frank Toskan, împreună cu Frank Angelo, proprietarul unui salon de coafură, au creat o colecție proprie de cosmetice decorative. Aceasta îndeplinea cele mai exigente cerințe ale fotografiei de modă și ale machiajului de artă, având în industria cosmetică efectul unui cutremur.

Bogăția unică a gamei de farduri, combinația de glamour și eleganță cu caracterul practic și „street style“, artiști de machiaj în locul vânzătorilor clasici și puțin spirit rebel - toate aceste atuuri au creat admirație și imaginea calității inovatoare pentru cosmeticele MAC. Astăzi, brandul este reprezentat în 90 de țări și lansează în fiecare an peste 50 de colecții.'),                                                                                                                                                                                                                                                       -- 16
       ('Estee Lauder', 'Cosmeticele Estée Lauder poartă numele fondatoarei, care, în secolul al XX-lea, a revoluționat lumea frumuseții. Ca nepoată de farmacist, Estée era familiarizată cu producția cosmeticelor încă din copilărire, așa că prima ei cremă nu s-a lăsat prea mult așteptată. În 1946, Estée Lauder a demarat vânzarea propriilor produse.

Brandul Estée Lauder a fost construit pe principiile pasiunii, ale dăruirii și ale perseverenței. Estée vizita adesea saloanele de frumusețe din întreg orașul New York, brandul a prosperat datorită recomandărilor clienților direcți, iar tratamentele pentru ten Estée Lauder au devenit faimoase.

Mica firmă s-a dezvoltat treptat într-un brand de calitate, de talie internațională. Emblematicul fond de ten de la Estée Lauder este, pentru multe femei, o parte integrantă a arsenalului cosmetic, iar crema de față Estée Lauder este, datorită ingredientelor luxoase și abordării științifice, cel mai eficient răsfăț pentru pielea ta. Filosofia brandului Estée Lauder este simplă: fiecare femeie poate fi frumoasă, indiferent de vârstă.'); -- 17


INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (1, 'Salicylic Acid 2% Solution', 41.00, 'src/img/product1.webp', 0, 0, 1, 5, 6,
        'AQUA (WATER). SACCHARIDE ISOMERATE. COCAMIDOPROPYL DIMETHYLAMINE. SALICYLIC ACID. HYDROXYETHYLCELLULOSE. POLYSORBATE 20. CITRIC ACID. SODIUM CITRATE. SODIUM HYDROXIDE. PHENOXYETHANOL. CHLORPHENESIN.',
        'Serul facial The Ordinary Salicylic Acid 2% Solution este un produs cu un conÈ›inut de substanÈ›e active ridicat. De aceea, oferÄƒ tenului cea mai luxoasÄƒ Ã®ngrijire.',
        'Cu vÃ¢rfurile degetelor, se tapoteazÄƒ o cantitate adecvatÄƒ de ser, pe tenul curat.',
        'https://www.notino.ro/the-ordinary/salicylic-acid-2-solution-ser-cu-acid-salicilic/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (2, 'Hyaluronic Acid 2% + B5', 51.00, 'src/img/product2.webp', 0, 0, 1, 5, 4,
        'AQUA (WATER), SODIUM HYALURONATE, SODIUM HYALURONATE CROSSPOLYMER, PANTHENOL, AHNFELTIA CONCINNA EXTRACT, GLYCERIN, PENTYLENE GLYCOL, PROPANEDIOL, POLYACRYLATE CROSSPOLYMER-6, PPG-26-BUTETH-26, PEG-40 HYDROGENATED CASTOR OIL, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, CITRIC ACID, ETHOXYDIGLYCOL, CAPRYLYL GLYCOL, HEXYLENE GLYCOL, ETHYLHEXYLGLYCERIN, PHENOXYETHANOL, CHLORPHENESIN.',
        'EliminaÈ›i aspectul uscat al tenului, asperitÄƒÈ›ile È™i ridurile. VÄƒ va ajuta Ã®n acest sens Ã®ngrijirea cu acid hialuronic The Ordinary Hyaluronic Acid 2% + B5 Hydration Support Formula care asigurÄƒ atÃ¢t o hidratare instantanee, cÃ¢t È™i menÈ›inerea nivelului ideal de hidratare a tenului pe termen lung. DatoritÄƒ hidratÄƒrii intense, tenul va avea un aspect plin, textura neuniformÄƒ va fi netezitÄƒ È™i ridurile vor fi reduse.',
        'FolosiÈ›i Ã®ngrijirea hidratantÄƒ cu acid hialuronic The Ordinary Hyaluronic Acid 2% + B5 Hydration Support Formula dimineaÈ›a È™i seara, dupÄƒ curÄƒÈ›area tenului È™i Ã®nainte de aplicarea cremei hidratante. FolosiÈ›i o pipetÄƒ pentru a aplica cÃ¢teva picÄƒturi pe faÈ›Äƒ È™i estompaÈ›i. ÃŽn caz de iritaÈ›ie, spÄƒlaÈ›i imediat, Ã®ntrerupeÈ›i utilizarea È™i consultaÈ›i medicul. AplicaÈ›i numai pe tenul sÄƒnÄƒtos. EfectuaÈ›i la Ã®nceput un test de toleranÈ›Äƒ.',
        'https://www.notino.ro/the-ordinary/hyaluronic-acid-2-b5-hydration-support-formula-ingrijire-hidratanta-cu-acid-hialuronic/#:~:text=asigur%C4%83%20o%20hidratare%20pe%20termen,ten%20uscat%2C%20fortific%C4%83%20bariera%20protectoare');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (3, 'AHA 30% + BHA 2% Peeling Solution', 50.00, 'src/img/product3.webp', 0, 0, 1, 5, 6,
        'GLYCOLIC ACID. AQUA (WATER). ALOE BARBADENSIS LEAF WATER. SODIUM HYDROXIDE. DAUCUS CAROTA SATIVA EXTRACT. PROPANEDIOL. COCAMIDOPROPYL DIMETHYLAMINE. SALICYLIC ACID. LACTIC ACID. TARTARIC ACID. CITRIC ACID. PANTHENOL. SODIUM HYALURONATE CROSSPOLYMER. TASMANNIA LANCEOLATA FRUIT/LEAF EXTRACT. GLYCERIN. PENTYLENE GLYCOL. XANTHAN GUM. POLYSORBATE 20. TRISODIUM ETHYLENEDIAMINE DISUCCINATE. POTASSIUM SORBATE. SODIUM BENZOATE. ETHYLHEXYLGLYCERIN. 1.2-HEXANEDIOL. CAPRYLYL GLYCOL.',
        'Peelingul chimic The Ordinary AHA 30% + BHA 2% Peeling Solution asigurÄƒ o exfoliere atÃ¢t la suprafaÈ›Äƒ, cÃ¢t È™i Ã®n profunzimea tenului. AcÈ›ioneazÄƒ cu o intensitate deosebit de ridicatÄƒ, Ã®nsÄƒ, datoritÄƒ ingredientelor hidratante pe care le conÈ›ine È™i a faptului cÄƒ valorile pKa È™i pH sunt echilibrate, riscul iritaÈ›iilor este minimizat. Peelingul ajutÄƒ la deblocarea porilor colmataÈ›i È™i la netezirea texturii neuniforme de la suprafaÈ›Äƒ, conferind tenului un aspect mai luminos È™i o nuanÈ›Äƒ mai uniformÄƒ.',
        'AplicaÈ›i peelingul The Ordinary AHA 30% + BHA 2% Peeling Solution 1â€“2Ã— pe sÄƒptÄƒmÃ¢nÄƒ, de preferinÈ›Äƒ seara, pe tenul curÄƒÈ›at bine È™i uscat. Nu se utilizeazÄƒ pe tenul umed. Cu ajutorul vÃ¢rfurilor degetelor, Ã®ntindeÈ›i uniform pe faÈ›Äƒ È™i pe gÃ¢t. Nu aplicaÈ›i pe tenul sensibil, descuamat sau deteriorat, evitaÈ›i conturul ochilor È™i contactul direct cu ochii. Se lasÄƒ sÄƒ acÈ›ioneze timp de maximum 10 minute, nu mai mult, apoi se clÄƒteÈ™te bine cu apÄƒ cÄƒlduÈ›Äƒ.',
        'https://www.notino.ro/the-ordinary/aha-30-bha-2-peeling-solution-peelingul-chimic/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (4, 'Cleansers emulsie pentru curatare cu efect de hidratare', 54.00, 'src/img/product4.webp', 0, 0, 2, 2, 1,
        'AQUA / WATER, GLYCERIN, CETEARYL ALCOHOL, PHENOXYETHANOL, STEARYL ALCOHOL, CETYL ALCOHOL, PEG-40 STEARATE, BEHENTRIMONIUM METHOSULFATE, GLYCERYL STEARATE, POLYSORBATE 20, ETHYLHEXYLGLYCERIN, POTASSIUM PHOSPHATE, DISODIUM EDTA, DIPOTASSIUM PHOSPHATE, SODIUM LAUROYL LACTYLATE, CERAMIDE NP, CERAMIDE AP, PHYTOSPHINGOSINE, CHOLESTEROL, SODIUM HYALURONATE, XANTHAN GUM, CARBOMER, TOCOPHEROL, CERAMIDE EOP (F.I.L. D214629/3).',
        'Demachiere delicatÄƒ fÄƒrÄƒ iritare? Emulsia de curÄƒÈ›are CeraVe Hydrating Cleanser cu efect de hidratare eliminÄƒ eficient fondul de ten È™i impuritÄƒÈ›ile de pe faÈ›Äƒ È™i decolteu, fÄƒrÄƒ a perturba bariera naturalÄƒ È™i umiditatea pielii. Textura uÈ™oarÄƒ È™i cremoasÄƒ lasÄƒ tenul absolut curat È™i hidratat.',
        'Se maseazÄƒ o cantitate adecvatÄƒ de produs pe pielea umezitÄƒ, È™i cu miÈ™cÄƒri circulare se Ã®nlÄƒturÄƒ fondul de ten È™i impuritÄƒÈ›ile. Se clÄƒteÈ™te foarte bine cu apÄƒ.',
        'https://www.notino.ro/cerave/cleansers-emulsie-pentru-curatare-cu-efect-de-hidratare/p-15738710/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_aUJ3I44If2EkvavFdsorqaIvXnz_mbuajJgZvvj8soEI136iHTUExoCnVQQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (5, 'Moisturizers loÈ›iune hidratantÄƒ pentru corp È™i faÈ›Äƒ pentru pielea uscata sau foarte uscata', 110.00,
        'src/img/product5.webp', 0, 0, 2, 4, 2,
        'AQUA / WATER, GLYCERIN, CAPRYLIC/CAPRIC TRIGLYCERIDE, CETEARYL ALCOHOL, CETYL ALCOHOL, DIMETHICONE, PHENOXYETHANOL, POLYSORBATE 20, CETEARETH-20, BEHENTRIMONIUM METHOSULFATE, POLYGLYCERYL-3 DIISOSTEARATE, SODIUM LAUROYL LACTYLATE, ETHYLHEXYLGLYCERIN, POTASSIUM PHOSPHATE, DISODIUM EDTA, DIPOTASSIUM PHOSPHATE, CERAMIDE NP, CERAMIDE AP, PHYTOSPHINGOSINE, CHOLESTEROL, XANTHAN GUM, CARBOMER, SODIUM HYALURONATE, TOCOPHEROL, CERAMIDE EOP (F.I.L. D213778/1).',
        'DoriÈ›i o Ã®ngrijire pentru pielea uscatÄƒ, eficientÄƒ Ã®ntreaga zi? LoÈ›iunea pentru faÈ›Äƒ È™i corp CeraVe Moisturizing Lotion hidrateazÄƒ intens È™i promoveazÄƒ activ regenerarea barierei cutanate de protecÈ›ie naturalÄƒ.',
        'Se aplicÄƒ uniform È™i se maseazÄƒ Ã®n pielea feÈ›ei sau a corpului. Se repetÄƒ dupÄƒ dorinÈ›Äƒ.',
        'https://www.notino.ro/cerave/moisturizers-lotiune-hidratanta-pentru-corp-si-fata-pentru-pielea-uscata-sau-foarte-uscata/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (6, 'Hydro BoostÂ® Face exfoliant facial pentru netezirea pielii', 31.00, 'src/img/product6.webp', 0, 0, 3, 5, 3,
        'AQUA, SODIUM C14-16 OLEFIN SULFONATE, COCAMIDOPROPYL HYDROXYSULTAINE, GLYCERIN, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, ACRYLATES CROSSPOLYMER-4, CELLULOSE, CARICA PAPAYA FRUIT EXTRACT, HYDROLYZED HYALURONIC ACID, SODIUM CHLORIDE, POLYSORBATE 20, DISODIUM TETRAPROPENYL SUCCINATE, DISODIUM EDTA, CITRIC ACID, GLYCOLIC ACID, LACTIC ACID, SODIUM HYDROXIDE, PHENOXYETHANOL, SODIUM BENZOATE, PARFUM.',
        'Exfoliantul pentru faÈ›Äƒ Neutrogena Hydro BoostÂ®, cu conÈ›inut mare de microparticule, netezeÈ™te vizibil pielea, Ã®ndepÄƒrteazÄƒ impuritÄƒÈ›ile È™i hidrateazÄƒ intens.',
        'Peelingul se aplicÄƒ Ã®n fiecare dimineaÈ›Äƒ pe tenul umezit È™i se maseazÄƒ uÈ™or, cu miÈ™cÄƒri circulare. Apoi se clÄƒteÈ™te atent cu apÄƒ. Se va evita zona ochilor.',
        'https://www.notino.ro/neutrogena/hydro-boost-face-exfoliant-facial-pentru-netezirea-pielii/p-15666844/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_UusSMhrxjaye1Q_i-oSBGoSTt1sZq1ZOrzoC7F5dkhKO_isFn23OxoCe5kQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (7, 'Clear & Defend exfoliant facial pentru netezirea pielii', 38.00, 'src/img/product7.webp', 0, 0, 3, 5, 3,
        'AQUA, SODIUM C14-16 OLEFIN SULFONATE, COCAMIDOPROPYL HYDROXYSULTAINE, SORBITOL, CELLULOSE, SALICYLIC ACID, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, ACRYLATES CROSSPOLYMER-4, C12-15 ALKYL LACTATE, PANTHENOL, COCAMIDOPROPYL PG-DIMONIUM CHLORIDE PHOSPHATE, TALC, DISODIUM TETRAPROPENYL SUCCINATE, CERA MICROCRISTALLINA, SODIUM CHLORIDE, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, BENZALKONIUM CHLORIDE, PARFUM, CI 19140, CI 73360.',
        'Pentru o piele sÄƒnÄƒtoasÄƒ, fÄƒrÄƒ pete È™i fÄƒrÄƒ probleme, NEUTROGENA vine cu un exfoliant excepÈ›ional Clear & Defend Facial Scrub care curÄƒÈ›Äƒ cu grijÄƒ È™i protejeazÄƒ pielea. Rezultate vizibile Ã®ncÄƒ de la prima utilizare.',
        'A se aplica o datÄƒ pe zi. MasaÈ›i pe faÈ›a umedÄƒ, apoi clÄƒtiÈ›i bine.',
        'https://www.notino.ro/neutrogena/visibly-clear-spot-proofing-exfoliant-facial-pentru-netezirea-pielii/p-623264/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_ZPpq4CZX6j_eqgzfYJWa1tmPcaRbPr6uXCcc_lQyLai0q3YfXqozBoC-HAQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (8, 'Clear & Radiant exfoliant facial revigorant', 29.00, 'src/img/product8.webp', 0, 0, 3, 2, 3,
        'AQUA, GLYCERIN, SODIUM LAURETH SULFATE, CELLULOSE, LAURYL GLUCOSIDE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CITRUS GRANDIS FRUIT EXTRACT, PROPYLENE GLYCOL, SODIUM BENZOTRIAZOLYL BUTYLPHENOL SULFONATE, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, SODIUM ASCORBYL PHOSPHATE, SODIUM BENZOATE, PARFUM, CI 16035, CI 60725.',
        'Exfoliatorul pentru ten Neutrogena Clear & Radiant curÄƒÈ›Äƒ tenul Ã®n profunzime, Ã®l netezeÈ™te È™i eliminÄƒ toate impuritÄƒÈ›ile.',
        'Se aplicÄƒ pe faÈ›a umedÄƒ, prin masaj delicat È™i se clÄƒteÈ™te atent cu apÄƒ. Se utilizeazÄƒ 1- 3x sÄƒptÄƒmÃ¢nal.',
        'https://www.notino.ro/neutrogena/clear-radiant-exfoliant-facial-revigorant/p-16177941/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_Y7zkWFqCMomr8XMK9s7tMVCEHiS7aey3ZtARsv_bnmVCMZW0DcRMRoCnfIQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (9, 'Lip Scrub Watermelon Exfoliant pentru buze', 41.00, 'src/img/product9.webp', 0, 0, 4, 5, 11,
        'SUCROSE, OLEA EUROPAEA (OLIVE) FRUIT OIL, TOCOPHERYL ACETATE, PARFUM, SIMMONDSIA CHINENSIS (JOJOBA) SEED OIL, PERSEA GRATISSIMA (AVOCADO) OIL, CRAMBE ABYSSINICA SEED OIL, LINALOOL, RED 7 LAKE (CI 15850), RED 27 LAKE (CI 45410).',
        'Exfoliantul de buze Barry M Lip Scrub Watermelon vÄƒ va oferi buze perfect catifelate Ã®n cel mai scurt timp. Particulele fine Ã®ndepÄƒrteazÄƒ delicat, dar eficient, pielea uscatÄƒ È™i moartÄƒ. Uleiurile naturale È™i vitamina E conÈ›inute Ã®n exfoliant conferÄƒ hidratare È™i lasÄƒ buzele minunat de delicate. Mirosul dulce È™i suculent al pepenelui va face ca procedura de exfoliere sÄƒ fie cÃ¢t se poate de plÄƒcutÄƒ. ',
        'AplicaÈ›i exfoliantul de buze Barry M Lip Peel pe buzele uscate, masaÈ›i uÈ™or È™i apoi clÄƒtiÈ›i. Se utilizeazÄƒ Ã®n funcÈ›ie de necesitate. ',
        'https://www.notino.ro/barry-m/lip-scrub-watermelon-exfoliant-pentru-buze/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (10, 'Lip Scrub Exfoliant pentru buze', 35.00, 'src/img/product10.webp', 0, 0, 4, 5, 11,
        'SUCROSE, OLEA EUROPAEA (OLIVE) FRUIT OIL, TOCOPHERYL ACETATE, FLAVOUR, SIMMONDSIA CHINENSIS (JOJOBA) SEED OIL, PERSEA GRATISSIMA (AVOCADO) OIL, CRAMBE ABYSSINICA SEED OIL, RED 40 (CI 16035), RED 28 (CI 45410).',
        'Exfoliantul de buze Barry M este Ã®mbogÄƒÈ›it cu vitamina E, ulei de avocado È™i ulei de jojoba pentru hidratare È™i catifelare maximÄƒ. AveÈ›i grijÄƒ de buzele dvs. Ã®n mod regulat, acestea vÄƒ vor rÄƒsplÄƒti cu un aspect frumos, neted È™i luxuriant. ',
        'DimineaÈ›a È™i seara, aplicaÈ›i o cantitate micÄƒ de exfoliant pe buze, masaÈ›i uÈ™or È™i apoi clÄƒtiÈ›i. ',
        'https://www.notino.ro/burts-bees/lip-scrub-exfoliant-pentru-buze-cu-efect-de-nutritiv/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (11, 'Retinol Boost crema anti rid pentru ochi', 81.00, 'src/img/product11.webp', 0, 35, 3, 5, 9,
        'AQUA, PENTAERYTHRITYL TETRAETHYLHEXANOATE, DIMETHICONE, GLYCERIN, PPG-15 STEARYL ETHER, STEARYL ALCOHOL, CETEARYL ALCOHOL, BUTYLENE GLYCOL, CETEARETH-20, ISOHEXADECANE, RETINOL, HYDROLYZED MYRTUS COMMUNIS LEAF EXTRACT, CAPRYLIC/CAPRIC TRIGLYCERIDE, ETHYLHEXYLGLYCERIN, SODIUM HYALURONATE, CAPRYLYL GLYCOL, POLYACRYLAMIDE, CELLULOSE, C13-14 ISOPARAFFIN, LAURETH-7, DIMETHICONE CROSSPOLYMER, AMMONIUM ACRYLOYLDIMETHYLTAURATE/VP COPOLYMER, DISODIUM EDTA, SODIUM HYDROXIDE, BHT, ASCORBIC ACID, PHENOXYETHANOL, CHLORPHENESIN.',
        'CÄƒutaÈ›i o cremÄƒ realmente eficientÄƒ, cu rezultate confirmate È™tiinÈ›ific? OferiÈ›i tenului dvs. un aspect mai tÃ¢nÄƒr È™i mai sÄƒnÄƒtos â€’ eficacitatea este confirmatÄƒ de dermatologi la 100 % dintre cei testaÈ›i*. Crema anti-Ã®mbÄƒtrÃ¢nire pentru ochi, Neutrogena Retinol Boost, nu conÈ›ine parfum; se absoarbe foarte repede dupÄƒ aplicare, eliberÃ¢nd retinolul pur direct Ã®n straturile superioare ale tenului. ',
        'O datÄƒ pe zi, aplicaÈ›i trei picÄƒturi mici de cremÄƒ pe zona de sub ochi, tapotÃ¢nd uÈ™or conturul ochilor. EvitaÈ›i contactul direct cu ochii.',
        'https://www.notino.ro/neutrogena/retinol-boost-crema-anti-rid-pentru-ochi/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (12, 'Liftactiv Collagen Specialist crema anti-rid intensiva', 185.00, 'src/img/product12.webp', 0, 35, 6, 5, 9,
        'AQUA / WATER / EAU â€¢ GLYCERIN â€¢ DIMETHICONE â€¢ SILICA â€¢ ISOHEXADECANE â€¢ ALCOHOL DENAT. â€¢ HYDROXYETHYLPIPERAZINE ETHANE SULFONIC ACID â€¢ NIACINAMIDE â€¢ PROPANEDIOL â€¢ SYNTHETIC WAX â€¢ PEG-10 DIMETHICONE â€¢ HYDROLYZED RICE PROTEIN â€¢ SODIUM PHYTATE â€¢ ADENOSINE â€¢ HYDROXYACETOPHENONE â€¢ PALMITOYL TETRAPEPTIDE-7 â€¢ PALMITOYL TRIPEPTIDE-1 â€¢ SODIUM HYDROXIDE â€¢ ASCORBYL GLUCOSIDE â€¢ DISTEARDIMONIUM HECTORITE â€¢ BUTYLENE GLYCOL â€¢ CAPRYLIC/CAPRIC TRIGLYCERIDE â€¢ CAPRYLYL GLYCOL â€¢ CARBOMER â€¢ CETEARETH-6 â€¢ CI 77891 / TITANIUM DIOXIDE â€¢ PEG-30 DIPOLYHYDROXYSTEARATE â€¢ PENTYLENE GLYCOL â€¢ POLYSORBATE 20 â€¢ PROPYLENE CARBONATE â€¢ SODIUM ACRYLATES COPOLYMER â€¢ SODIUM CITRATE â€¢ SODIUM LACTATE â€¢ SORBITAN OLEATE â€¢ STEARYL ALCOHOL â€¢ SYNTHETIC FLUORPHLOGOPITE â€¢ TOCOPHEROL â€¢ ZEA MAYS STARCH / CORN STARCH â€¢ DIMETHICONE/PEG-10/15 CROSSPOLYMER â€¢ DIMETHICONE/POLYGLYCERIN-3 CROSSPOLYMER â€¢ CI 15985 / YELLOW 6 â€¢ DIPROPYLENE GLYCOL â€¢ PARFUM / FRAGRANCE (F.I.L. N284487/1).',
        'OdatÄƒ cu vÃ¢rsta, fibrele de colagen de la nivelul tenului se degradeazÄƒ. Crema intensivÄƒ antirid Vichy Liftactiv Collagen Specialist va Ã®mpiedica acest lucru, oferind astfel fermitate tenului. Va corecta orice semne de pierdere de colagen datoritÄƒ peptidelor pro-colagen, care sunt de 3 ori mai abundente decÃ¢t Ã®n produsele obiÈ™nuite. Va lÄƒsa tenul neted, hidratat È™i cu mai puÈ›ine riduri vizibile.',
        'AplicaÈ›i crema antirid Vichy Liftactiv Collagen Specialist dimineaÈ›a, pe tenul curat È™i uscat, singurÄƒ sau dupÄƒ aplicarea serului cu vitamina C Vichy Liftactiv. EvitaÈ›i zona din jurul ochilor.',
        'https://www.notino.ro/vichy/liftactiv-collagen-specialist-crema-pentru-intinerire-cu-efect-de-lifting-antirid/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (13, 'Age Specialist 35+ crema de noapte antirid', 47.00, 'src/img/product13.webp', 0, 35, 5, 5, 9,
        'AQUA / WATER, GLYCERIN, ISOHEXADECANE, DIMETHICONE, ALUMINUM STARCH OCTENYLSUCCINATE, ISOPROPYL ISOSTEARATE, PROPYLENE GLYCOL, OXIDIZED STARCH ACETATE, OCTYLDODECANOL, CETYL ALCOHOL, BEHENYL ALCOHOL, ADENOSINE, ATELOCOLLAGEN, CAPRYLOYL SALICYLIC ACID, PENTAERYTHRITYL TETRAISOSTEARATE, SODIUM CHONDROITIN SULFATE, SODIUM HYALURONATE, TRIETHANOLAMINE, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, CAMELLIA OLEIFERA SEED OIL, BUTYLENE GLYCOL, CAPRYLYL GLYCOL, CETEARYL ALCOHOL, CETEARYL GLUCOSIDE, MYRISTIC ACID, PALMITIC ACID, PEG-100 STEARATE, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, SODIUM POLYACRYLATE, SODIUM STEAROYL GLUTAMATE, SOLUBLE COLLAGEN, STEARIC ACID, TOCOPHEROL, TRISODIUM EDTA, XANTHAN GUM, ALPHA-ISOMETHYL IONONE, BENZYL ALCOHOL, BENZYL SALICYLATE, CITRONELLOL, HEXYL CINNAMAL, LINALOOL, HEXYLENE GLYCOL, PHENOXYETHANOL, POTASSIUM SORBATE, PARFUM / FRAGRANCE (F.I.L. Z284743/1).',
        'PrevenÈ›ia este esenÈ›ialÄƒ Ã®n lupta Ã®mpotriva ridurilor. Crema de noapte antirid Lâ€™OrÃ©al Paris Age Specialist 35+ oferÄƒ o acÈ›iune intensÄƒ anti-Ã®mbÄƒtrÃ¢nire ce ajutÄƒ la netezirea ridurilor È™i liniilor fine. Formula bogatÄƒ tonificÄƒ È™i hidrateazÄƒ tenul 24 de ore, conferindu-i o strÄƒlucire sÄƒnÄƒtoasÄƒ cu efect de lungÄƒ duratÄƒ. Cu o utilizare continuÄƒ celulele pielii sunt hrÄƒnite, astfel Ã®ncÃ¢t sÄƒ nu Ã®ncetineascÄƒ procesul natural de regenerare, odatÄƒ cu Ã®naintarea Ã®n vÃ¢rstÄƒ.',
        'AplicaÈ›i crema Lâ€™OrÃ©al Paris Age Specialist 35+ Ã®n fiecare searÄƒ pe tenul curat È™i uscat, apoi masaÈ›i cu miÈ™cÄƒri delicate.',
        'https://www.notino.ro/loreal-paris/age-specialist-35-crema-de-zi-produse-anti-rid/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (14, 'Skin Naturals Vitamin C crema de ochi iluminatoare cu vitamina C', 47.00, 'src/img/product14.webp', 0, 0,
        7, 5, 9,
        '919144 30 - INGREDIENTS: AQUA / WATER â€¢ GLYCERIN â€¢ DIMETHICONE â€¢ PRUNUS ARMENIACA KERNEL OIL / APRICOT KERNEL OIL â€¢ NIACINAMIDE â€¢ ACRYLAMIDE/SODIUM ACRYLOYLDIMETHYLTAURATE COPOLYMER â€¢ SILICA â€¢ CI 77891 / TITANIUM DIOXIDE â€¢ ISOHEXADECANE â€¢ DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER â€¢ HYDROXYPROPYL TETRAHYDROPYRANTRIOL â€¢ CAFFEINE â€¢ SYNTHETIC FLUORPHLOGOPITE â€¢ PROPYLENE GLYCOL â€¢ PHENOXYETHANOL â€¢ ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER â€¢ TOCOPHEROL â€¢ CHLORPHENESIN â€¢ POLYSORBATE 80 â€¢ ASCORBYL GLUCOSIDE â€¢ TRIETHANOLAMINE â€¢ CI 77492 / IRON OXIDES â€¢ TRISODIUM ETHYLENEDIAMINE DISUCCINATE â€¢ MUSA SAPIENTUM FRUIT EXTRACT / BANANA FRUIT EXTRACT â€¢ ADENOSINE â€¢ HYDROLYZED HYALURONIC ACID â€¢ HYDROXYETHYLPIPERAZINE ETHANE SULFONIC ACID â€¢ MICA â€¢ SORBITAN OLEATE â€¢ MUSA PARADISIACA FRUIT JUICE / BANANA FRUIT JUICE â€¢ ANANAS SATIVUS FRUIT EXTRACT / PINEAPPLE FRUIT EXTRACT â€¢ CITRIC ACID â€¢ SODIUM BENZOATE â€¢ DISODIUM STEAROYL GLUTAMATE â€¢ LACTIC ACID â€¢ TIN OXIDE â€¢ POTASSIUM SORBATE â€¢ ALUMINUM HYDROXIDE (F.I.L. Z70015852/1).',
        'Tratamentul pentru ochi Garnier Skin Naturals Vitamin C Ã®ngrijeÈ™te pielea din jurul ochilor, oferindu-i nutriÈ›ia È™i hidratarea necesare.',
        'Produsul se aplicÄƒ Ã®n jurul ochilor dimineaÈ›a È™i/sau seara, prin tapotare cu degetele, pÃ¢nÄƒ la absorbÈ›ie.',
        'https://www.notino.ro/garnier/skin-naturals-vitamin-c-crema-de-ochi-iluminatoare-cu-vitamina-c/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (15, 'SÃ©bium Gel Moussant gel de curÄƒÈ›are pentru ten gras È™i mixt', 76.00, 'src/img/product15.webp', 0, 0, 8,
        1, 1, '',
        'Gelul de curÄƒÈ›are Bioderma SÃ©bium Gel Moussant este destinat curÄƒÈ›Äƒrii minuÈ›ioase È™i blÃ¢nde a tenurilor grase È™i mixte. Gelul este compus din substanÈ›e non-iritante È™i nu conÈ›ine sÄƒpun, fiind, prin urmare, foarte bine tolerat de piele. DupÄƒ utilizarea gelului de curÄƒÈ›are Bioderma SÃ©bium Gel Moussant, tenul va fi perfect curat, fÄƒrÄƒ pori astupaÈ›i È™i sebum Ã®n exces.',
        'FolosiÈ›i gelul de spÄƒlat dimineaÈ›a È™i seara, pe faÈ›a umedÄƒ, spumaÈ›i, clÄƒtiÈ›i bine È™i uscaÈ›i.',
        'https://www.notino.ro/bioderma/sebium-gel-moussant-gel-de-curatare-pentru-ten-mixt-si-gras/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (16, 'Effaclar gel de curatare pentru ten sensibil', 65.00, 'src/img/product16.webp', 0, 0, 9, 1, 1,
        'AQUA / WATER, SODIUM LAURETH SULFATE, PEG-8, COCO-BETAINE, HEXYLENE GLYCOL, SODIUM CHLORIDE, PEG-120 METHYL GLUCOSE DIOLEATE, ZINC PCA, SODIUM HYDROXIDE, CAPRYLYL GLYCOL, CITRIC ACID, SODIUM BENZOATE, PHENOXYETHANOL, PARFUM / FRAGRANCE (F.I.L. B193153/1).',
        'VÄƒ deranjeazÄƒ acneea È™i problemele cu pielea? ÃŽn acest caz, din baie nu trebuie sÄƒ vÄƒ lipseascÄƒ gelul pentru curÄƒÈ›are profundÄƒ La Roche-Posay Effaclar. Gelul curÄƒÈ›Äƒ toate impuritÄƒÈ›ile È™i sebumul Ã®n exces, fÄƒrÄƒ a usca tenul. LasÄƒ faÈ›a curatÄƒ È™i fresh.',
        'SpÄƒlaÈ›i-vÄƒ foarte bine pe mÃ¢ini È™i pe unghii, Ã®nainte de a atinge faÈ›a. FolosiÈ›i apÄƒ cÄƒlduÈ›Äƒ, care dilateazÄƒ porii. SpumaÈ›i gelul Ã®n mÃ¢ini cu puÈ›inÄƒ apÄƒ È™i aplicaÈ›i-l pe faÈ›Äƒ, masÃ¢nd uÈ™or. ConcentraÈ›i-vÄƒ asupra zonei T È™i a gÃ¢tului. ClÄƒtiÈ›i faÈ›a cu apÄƒ rece, pentru a contracta porii. Apoi uscaÈ›i tenul cu un prosop curat, prin apÄƒsarea sa uÈ™oarÄƒ pe faÈ›Äƒ, fÄƒrÄƒ a freca.',
        'https://www.notino.ro/la-roche-posay/effaclar-gel-de-curatare-pentru-ten-gras/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (17, 'Hydro BoostÂ® Face gel de curatare facial', 35.00, 'src/img/product17.webp', 0, 0, 3, 5, 1,
        'AQUA, GLYCERIN, COCAMIDOPROPYL HYDROXYSULTAINE, SODIUM COCOYL ISETHIONATE, SODIUM METHYL COCOYL TAURATE, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, HYDROLYZED HYALURONIC ACID, ETHYLHEXYLGLYCERIN, LINOLEAMIDOPROPYL PG-DIMONIUM CHLORIDE PHOSPHATE, POLYQUATERNIUM-10, POLYSORBATE 20, SODIUM ISETHIONATE, SODIUM LAURYL SULFATE, SODIUM C14-16 OLEFIN SULFONATE, POTASSIUM ACRYLATES COPOLYMER, SODIUM CHLORIDE, PROPYLENE GLYCOL, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, HYDROXYACETOPHENONE, TOCOPHERYL ACETATE, PHENOXYETHANOL, PARFUM.',
        'Gelul de curÄƒÈ›are Neutrogena Hydro BoostÂ® oferÄƒ tenului o Ã®ngrijire complexÄƒ. DemachiazÄƒ tenul È™i Ã®ndepÄƒrteazÄƒ toate impuritÄƒÈ›ile, lÄƒsÃ¢ndu-l curat È™i intens hidratat.',
        'Gelul se aplicÄƒ pe faÈ›a umedÄƒ È™i se maseazÄƒ circular, pentru a forma o spumÄƒ. Se lasÄƒ sÄƒ acÈ›ioneze scurt timp È™i se clÄƒteÈ™te bine cu apÄƒ.',
        'https://www.notino.ro/neutrogena/hydro-boost-face-exfoliant-facial-pentru-netezirea-pielii/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_SuHamvanGxHe2Wpu-dLrWI7xAht871QDyojzfXP7MXFhOc4Bzx3BxoCTl8QAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (18, 'Natural Moisturizing Factors + HA crema de fata hidratanta', 78.00, 'src/img/product18.webp', 0, 0, 1, 5,
        2,
        'AQUA (WATER). CAPRYLIC/CAPRIC TRIGLYCERIDE. CETYL ALCOHOL. PROPANEDIOL. STEARYL ALCOHOL. GLYCERIN. SODIUM HYALURONATE. ARGININE. ASPARTIC ACID. GLYCINE. ALANINE. SERINE. VALINE. ISOLEUCINE. PROLINE. THREONINE. HISTIDINE. PHENYLALANINE. GLUCOSE. MALTOSE. FRUCTOSE. TREHALOSE. SODIUM PCA. PCA. SODIUM LACTATE. UREA. ALLANTOIN. LINOLEIC ACID. OLEIC ACID. PHYTOSTERYL CANOLA GLYCERIDES. PALMITIC ACID. STEARIC ACID. LECITHIN. TRIOLEIN. TOCOPHEROL. CARBOMER. ISOCETETH-20. POLYSORBATE 60. SODIUM CHLORIDE. CITRIC ACID. TRISODIUM ETHYLENEDIAMINE DISUCCINATE. PENTYLENE GLYCOL. TRIETHANOLAMINE. SODIUM HYDROXIDE. PHENOXYETHANOL. CHLORPHENESIN.',
        'Crema de faÈ›Äƒ The Ordinary Natural Moisturizing Factors + HA oferÄƒ tenului Ã®ngrijirea pe care o meritÄƒ.',
        'Se aplicÄƒ pe pielea curatÄƒ È™i se maseazÄƒ cu miÈ™cÄƒri circulare. Se utilizeazÄƒ Ã®n fiecare dimineaÈ›Äƒ È™i/sau searÄƒ.',
        'https://www.notino.ro/the-ordinary/natural-moisturizing-factors-ha-crema-de-fata-hidratanta/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (19, 'MinÃ©ral 89 crema de fata hidratanta 72 ore', 109.00, 'src/img/product19.webp', 0, 0, 6, 5, 2,
        'AQUA / WATER / EAU, GLYCERIN, DICAPRYLYL ETHER, PENTYLENE GLYCOL, POLYGLYCERYL-6 DISTEARATE, NIACINAMIDE, PROPANEDIOL, CETYL ESTERS, JOJOBA ESTERS, CETEARYL ISONONANOATE, SQUALANE, BEHENYL ALCOHOL, ADENOSINE, CAPRYLOYL SALICYLIC ACID, HYDROXYACETOPHENONE, MINERAL SALTS, SODIUM HYALURONATE, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, VITREOSCILLA FERMENT, TOCOPHEROL, ACACIA DECURRENS FLOWER CERA / ACACIA DECURRENS FLOWER WAX, ACRYLAMIDE/SODIUM ACRYLOYLDIMETHYLTAURATE COPOLYMER, CETYL ALCOHOL, HELIANTHUS ANNUUS SEED CERA / SUNFLOWER SEED WAX, HYDROXYPROPYL STARCH PHOSPHATE, ISOHEXADECANE, POLYGLYCERIN-3, POLYGLYCERYL-3 BEESWAX, POLYSORBATE 80, SODIUM STEAROYL GLUTAMATE, SORBITAN OLEATE, PARFUM / FRAGRANCE (F.I.L. N70017704/1).',
        'Crema de faÈ›ÄƒVichy MinÃ©ral 89 oferÄƒ tenului Ã®ngrijirea pe care o meritÄƒ.',
        'Se aplicÄƒ pe pielea curatÄƒ, cu miÈ™cÄƒri circulare È™i se maseazÄƒ uÈ™or.',
        'https://www.notino.ro/vichy/mineral-89-booster-hialuronic-fortifiant-de-umplere-dermica/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_cJGizdawA2A7NxENmLc3jjpWA7aUyFKveTsFKULt0lRqAnPlJ556xoCCoAQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (20, 'Photoderm Aquafluid crema protectoare pentru fata SPF 50+', 107.00, 'src/img/product20.webp', 0, 0, 8, 5,
        8, '',
        'DacÄƒ folosiÈ›i crema facialÄƒ protectoare, Bioderma Photoderm Aquafluid, cu SPF 50+, Ã®naintea fiecÄƒrei expuneri la soare, nu va fi cazul sÄƒ vÄƒ temeÈ›i de efectele negative ale radiaÈ›iilor UVA È™i UVB. ÃŽn plus, tehnologia folositÄƒ, Sun Active Defence, mÄƒreÈ™te capacitatea de autoapÄƒrare a tenului. AceastÄƒ cremÄƒ are o texturÄƒ rÄƒcoritoare, pe bazÄƒ de apÄƒ. DupÄƒ uscare, lasÄƒ un finisaj mat; tenul capÄƒtÄƒ un aspect natural, matifiat È™i pregÄƒtit pentru aplicarea oricÄƒrui fond de ten.',
        'ÃŽntindeÈ›i uniform o cantitate generoasÄƒ de cremÄƒ solarÄƒ pentru faÈ›Äƒ, Bioderma Photoderm Aquafluid, pe faÈ›Äƒ È™i pe gÃ¢t. AplicaÈ›i crema Ã®nainte de expunerea la soare È™i repetaÈ›i aplicarea dupÄƒ fiecare baie, dacÄƒ aÈ›i transpirat sau dacÄƒ v-aÈ›i È™ters cu prosopul.',
        'https://www.notino.ro/bioderma/photoderm-max-aquafluid-crema-protectoare-pentru-fata-spf-50/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (21, 'Ambre Solaire Super UV crema protectoare pentru fata antirid', 47.00, 'src/img/product21.webp', 0, 35, 7,
        5, 8, '', 'Produsul oferÄƒ feÈ›ei o protecÈ›ie fiabilÄƒ Ã®mpotriva radiaÈ›iilor solare.',
        'Se aplicÄƒ cu miÈ™cÄƒri circulare, pe faÈ›a curatÄƒ È™i pe gÃ¢t È™i se maseazÄƒ uÈ™or. Se repetÄƒ dacÄƒ este necesar, Ã®n special dupÄƒ Ã®mbÄƒiere, dupÄƒ uscarea cu prosopul sau Ã®n caz de transpiraÈ›ie excesivÄƒ. A se evita expunerea Ã®ndelungatÄƒ la soare, chiar dacÄƒ pielea este protejatÄƒ Ã®mpotriva razelor solare.',
        'https://www.notino.ro/garnier/ambre-solaire-super-uv-crema-protectoare-pentru-fata-antirid/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (22, 'Photoderm AKN Mat fluid protector mat pentru fata SPF 30', 100.00, 'src/img/product22.webp', 0, 0, 8, 5, 8,
        'AQUA, OCTOCRYLENE, METHYLENE BISBENZOTRIAZOLYL TETRAMETHYLBUTYLPHENOL, BUTYLMETHOXYDIBENZOYLMETHANE, TRIDECYL SALICYLATE, TOCOPHERYL ACETATE, ECTOIN, MANNITOL, XYLITOL, RHAMNOSE, FRUCTO-OLIGO-SACHARIDES, LAMINARIAOCHROLEUCA EXTRACT, GLYCOLIC ACID, GINKGO BILOBA LEAF EXTRACT, DODECYL GALLATE, DECYL GLUCOSIDE, C 20-22 ALKYL PHOSPHATE, C 20-22 ALCOHOLS, XANTHAN GUM, PROPYLENE GLYCOL, CITRIC ACID, CAPRYLIC/CAPRIC TRI-GLYCERIDE, SODIUM HYDROXIDE, DISODIUM EDTA, CHLORPHENESIN, PHENOXYETHANOL, PARFUM.',
        '', '', 'https://www.notino.ro/bioderma/photoderm-akn-fluid/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (23, 'Bio Graceful Lavandin crema anti-imbatranire pentru ochi si buze', 37.00, 'src/img/product23.webp', 0, 35,
        7, 5, 10,
        'Tratamentul pentru ochi Garnier Bio Graceful Lavandin Ã®ngrijeÈ™te pielea din jurul ochilor, oferindu-i nutriÈ›ia È™i hidratarea necesare.',
        '',
        'Produsul se aplicÄƒ Ã®n jurul ochilor dimineaÈ›a È™i/sau seara, prin tapotare cu degetele, pÃ¢nÄƒ la absorbÈ›ie. Se poate folosi È™i Ã®n zona buzelor.',
        'https://www.notino.ro/garnier/bio-graceful-lavandin-crema-anti-imbatranire-pentru-ochi-si-buze/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (24, 'Slim Lip Pencil creion de buze cu trasare precisÄƒ', 24.00, 'src/img/product24.webp', 1, 0, 10, 5, 23,
        'SORBITAN ISOSTEARATE, ISOCETYL STEARATE,PHENYL TRIMETHICONE, POLYETHYLENE, EUPHORBIA CERIFERA (CANDELILLA) WAX,BUTYROSPERMUM PARKII (SHEA BUTTER) UNSAPONIFIABLES, BEESWAX, SIMMONDSIACHINENSIS (JOJOBA) SEED OIL, CAPRYLIC/CAPRI TRIGLYCERIDE, NYLON-12,OCTYLDODECANOL, POLYGLYCERYL-2 DIISOSTEARATE, SILICA, COPERNICIACERIFERA (CARNAUBA) WAX, HYDROGENATED, COCONUT OIL, TOCOPHEROL,VP/HEXADECENE COPOLYMER, STEARALKONIUM HECTORITE, STEARYLGLYCYRRHETINATE, PROPYLPARABEN, PROLYLENE CARBONATE.',
        'PreveniÈ›i È™tergerea inesteticÄƒ a rujului. Creionul de buze cu trasare precisÄƒ NYX Professional Makeup Slim Lip Pencil are grijÄƒ ca machiajul dvs. sÄƒ arate absolut perfect. VÄƒ permite sÄƒ definiÈ›i contururile buzelor È™i are o texturÄƒ persistentÄƒ, dar moale, care Ã®l face uÈ™or de utilizat. Buzele sunt mai pline, aplicarea rujului este precisÄƒ, iar zÃ¢mbetul dvs. Ã®nfloreÈ™te Ã®n toatÄƒ splendoarea sa.',
        'Se aplicÄƒ pe buzele curate, Ã®n mod ideal dupÄƒ exfoliere. ConturaÈ›i buzele din centru spre colÈ›uri, folosind un creion suficient de ascuÈ›it. Apoi aplicaÈ›i rujul sau glossul preferat.',
        'https://www.notino.ro/nyx-professional-makeup/slim-lip-pencil/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (25, 'Intense Colour creion de buze cu trasare precisÄƒ', 8.00, 'src/img/product25.webp', 1, 0, 11, 5, 23,
        'RICINUS COMMUNIS SEED OIL, CERA MICROCRISTALLINA, PARAFFIN, ISOPROPYL MYRISTATE, PETROLATUM, SYNTHETIC WAX, MICA, TRIDECYL TRIMELLITATE, SILICA, PHENOXYETHANOL, CI 77891, CI 77491, CI 77492, CI 77499, CI 15850.',
        'Creionul de buze MUA Makeup Academy Intense Colour previne migrarea neintenÈ›ionatÄƒ a rujului È™i ajutÄƒ la crearea formei perfecte a buzelor.',
        'Se contureazÄƒ buzele cu creionul, apoi se aplicÄƒ rujul sau luciul de buze.',
        'https://www.notino.ro/mua-makeup-academy/intense-colour-creion-intensiv-de-buze/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (26, 'Dior Addict Lip Glow Oil ulei pentru buze', 187.00, 'src/img/product26.webp', 1, 0, 12, 5, 24, '', 'Devenit indispensabil pentru makeup artists, Dior Lip Glow este disponibil sub forma unui ulei de buze, care le protejeaza in profunzime si le accentueaza, scotand la iveala culoarea lor naturala in mod durabil.

        Cu tehnologia sa Color Reviver, Lip Glow Oil reactioneaza direct cu buzele fiecarei femei, pentru o culoare personalizata, asigurand in acelasi timp o hidratare continua.
        Buzele sunt mai frumoase, chiar si nemachiate, dupa 5 zile de aplicare. Textura non-grasa si non-lipicioasa a uleiului combina stralucirea de oglinda a unui luciu de buze cu confortul unui produs de ingrijire intensiva. Imbogatita cu ulei de cirese, formula rasfata buzele si creeaza o pelicula protectoare impotriva factorilor de stres si a uscaciunii.
        Buzele sunt impregnate cu substante nutritive si revitalizate, efectul fiind imediat si de durata.

        Noile nuante Lip Glow Oil se asorteaza cu nuantele proaspete de Lip Glow disponibile in acest moment:

        001 Pink: roz deschis
        004 Coral: corai aprins
        006 Berry: rosu-purpuriu
        007 Raspberry: roz de culoarea zmeurei', '',
        'https://www.sephora.ro/p/dior-lip-glow-oil---ulei-de-buze-P3966089.html');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (27, 'Fat Oil Lip Drip ulei pentru buze', 49.00, 'src/img/product27.webp', 1, 0, 10, 5, 24,
        '2061220 1 INGREDIENTS:POLYISOBUTENE, HYDROGENATED POLYISOBUTENE, PENTAERYTHRITLY TETRAISOSTEARATE, PARAFFINUM LIQUIDUM / MINERAL OIL Ë›HUILE MINERALE, DIISOSTEARYL MALATE, POLYGYCERYL-3 DIISOSTEARATE, ROSA CANINA FRUIT OIL, RUBUS CHAMAEMORUS SEED OIL, RUBUS IDAEUS SEED OIL / RASPBERRY SEED OIL, SQUALANE, BARIUM SULFATE, AROMA /FLAVOUR, ALUMINA, ALUMINIUM HYDROXIDE, CAPRYLIC TRIGLYCERIDE, DIBUTYL ETHYLHEXANOLY GLUTAMIDE, ETHYLHEXGLYCERIN, TOCOPHEROL, TOCOPHERYL ACETATE DIETHYLHEXLY SYRINGYLIDENEMALONATE, SORBIC ACID, PHENOXYETHANOL, CI 15850 / RED 7 LAKE, CI 77891 / TITANIUM DIOXIDE, CI 42090 / BLUE 1 LAKE, BENZYL ALCOHOL.',
        'Luciul de buze NYX Professional Makeup Fat Oil Lip Drip dÄƒ buzelor un aspect minunat.',
        'Se aplicÄƒ pe buze un strat uniform, cu aplicatorul.',
        'https://www.notino.ro/nyx-professional-makeup/fat-oil-lip-drip-ulei-pentru-buze/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (28, 'Dior Addict Lip Maximizer luciu de buze pentru un volum suplimentar', 187.00, 'src/img/product28.webp', 1,
        0, 12, 5, 24,
        '#17379 METHYL HYDROGENATED ROSINATE â€¢ DIMER DILINOLEYL DIMER DILINOLEATE â€¢ POLYGLYCERYL-2 TRIISOSTEARATE â€¢ POLYGLYCERYL-10 DECAISOSTEARATE â€¢ JOJOBA ESTERS â€¢ POLYGLYCERYL-3 BEESWAX â€¢ GLYCERYL BEHENATE/EICOSADIOATE â€¢ ETHYLHEXYL PALMITATE â€¢ DIPALMITOYL HYDROXYPROLINE â€¢ MENTHOXYPROPANEDIOL â€¢ PARFUM (FRAGRANCE) â€¢ PRUNUS AVIUM (SWEET CHERRY) SEED OIL â€¢ MICA â€¢ ETHYL VANILLIN â€¢ TOCOPHEROL â€¢ TRIHYDROXYSTEARIN â€¢ TRIMETHYLOLPROPANE TRIISOSTEARATE â€¢ SILICA â€¢ CAPSICUM FRUTESCENS FRUIT EXTRACT â€¢ SODIUM HYALURONATE â€¢ TIN OXIDE â€¢ PROPYL GALLATE â€¢ GLUCOMANNAN â€¢ [+/- CI 77891 (TITANIUM DIOXIDE) â€¢ CI 77491 (IRON OXIDES) â€¢ CI 45410 (RED 28 LAKE) â€¢ CI 19140 (YELLOW 5 LAKE)]', 'DescoperiÈ›i Dior Addict Lip Maximizer, luciul de buze Dior cu efect de volum, Ã®ntr-o formulÄƒ de Ã®ngrijire a buzelor compusÄƒ Ã®n proporÈ›ie de 90%* din ingrediente de origine naturalÄƒ. Infuzat cu ulei de cireÈ™e È™i acid hialuronic, acesta le oferÄƒ buzelor hidratare timp de 24h**.

        Luciul Dior Addict Lip Maximizer a fost reconceput Ã®ntr-o varietate de nuanÈ›e È™i efecte cu strÄƒlucire de oglindÄƒ: transparent, intens, sidefat È™i hologafic. Buzele sunt netezite, hidratate È™i par mai pline imediat È™i pe termen lung.

        Cutia Dior Addict Lip Maximizer primeÈ™te un nou design, decorat cu literele DIOR Ã®n relief, Ã®n spiritul logomaniei.',
        '', 'https://www.notino.ro/dior/dior-addict-lip-maximizer-luciu-de-buze-pentru-un-volum-suplimentar/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (29, 'Lip Lingerie XXL ruj de buze lichid, cu finisaj matifiant', 45.00, 'src/img/product29.webp', 1, 0, 10, 5,
        25,
        'DIMETHICONE, ISODODECANE, TRIMETHYLSILOXYSILICATE, NYLON-611/DIMETHICONE COPOLYMER, DIMETHICONE CROSSPOLYMER, C30-45 ALKYLDIMETHYLSILYL POLYPROPYLSILSESQUIOXANE, LAUROYL LYSINE, TRIETHOXYSILYLETHYL POLYDIMETHYLSILOXYETHYL DIMETHICONE, SILICA SILYLATE, ISOPROPYL TITANIUM TRIISOSTEARATE, SORBIC ACID, PHENOXYETHANOL, PARFUM / FRAGRANCE',
        'SubliniaÈ›i frumuseÈ›ea naturalÄƒ a buzelor dvs., printr-o culoare saturatÄƒ, cu finisaj mat. Asemenea lenjeriei modelatoare preferate, rujul lichid NYX Professional Makeup Lip Lingerie XXL se adapteazÄƒ complet contururilor dvs. È™i le accentueazÄƒ atuurile. CatifeleazÄƒ buzele, oferindu-le o definiÈ›ie clarÄƒ È™i un aspect mai plin. DupÄƒ aplicarea simplÄƒ, datoritÄƒ formei speciale a aplicatorului, rujul este complet uscat Ã®n 60 de secunde, iar culoarea matÄƒ nu migreazÄƒ de pe buze timp de 16 ore.',
        'Rujul lichid NYX Professional Makeup Lip Lingerie XXL se aplicÄƒ pe buzele curate, folosind aplicatorul inclus. Forma sa specialÄƒ, ascuÈ›itÄƒ, permite o aplicare precisÄƒ. Mai Ã®ntÃ¢i trasaÈ›i contururile cu vÃ¢rful â€“ Ã®ncepeÈ›i din centrul buzelor È™i continuaÈ›i spre colÈ›uri. Apoi umpleÈ›i complet spaÈ›iul dintre contururi cu ruj. LÄƒsaÈ›i sÄƒ se usuce aproximativ 60 de secunde.',
        'https://www.notino.ro/nyx-professional-makeup/lip-lingerie-xxl-ruj-lichid-cu-finisaj-matifiant/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (30, 'Dior Addict Lip Tint ruj de buze lichid', 186.00, 'src/img/product30.webp', 1, 0, 12, 5, 25,
        '#16283 AQUA (WATER), GLYCERIN, METHYL HYDROGENATED ROSINATE, BUTYLENE GLYCOL, POLYGLYCERYL-2 TRIISOSTEARATE, ALCOHOL, POLYGLYCERIN-3, HYDROXYETHYL ACRYLATE/SODIUM ACRYLOYLDIMETHYL TAURATE COPOLYMER, SQUALANE, POLYURETHANE-35, 1,2-HEXANEDIOL, LECITHIN, MENTHOXYPROPANEDIOL, TRIMETHYLOLPROPANE TRIISOSTEARATE, PARFUM (FRAGRANCE), SODIUM HYALURONATE, POLYSORBATE 60, HYDROXYACETOPHENONE, SODIUM BENZOATE, PRUNUS AVIUM (SWEET CHERRY) SEED OIL, AMMONIUM GLYCYRRHIZATE, SORBITAN ISOSTEARATE, TOCOPHEROL, METHYLPROPANEDIOL, ETHYL VANILLIN, CITRIC ACID, ALUMINUM HYDROXIDE, CAPRYLYL GLYCOL, PROPYL GALLATE, CAPSICUM FRUTESCENS FRUIT EXTRACT, PHENYLPROPANOL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, [+/- CI 77891 (TITANIUM DIOXIDE), CI 17200 (RED 33), CI 15985 (YELLOW 6), CI 15850 (RED 7), CI 77491, CI 77499 (IRON OXIDES), CI 19140 (YELLOW 5, YELLOW 5 LAKE), CI 42090 (BLUE 1)].', 'Antitransfer, 12 ore* de rezistenÈ›Äƒ, 24 de ore** de hidratare È™i o formulÄƒ bazatÄƒ Ã®n proporÈ›ie de 95%*** pe ingrediente de origine naturalÄƒ: Dior prezintÄƒ Dior Addict Lip Tint, rujul lichid cu efect cromatic semimat.

        Aplicatoul Dior Addict Lip Tint se manevreazÄƒ intuitiv È™i cu mare precizie, permiÈ›Ã¢nd aplicarea optimÄƒ a rujului lichid. Buzele sunt Ã®nvÄƒluite Ã®ntr-o culoare proaspÄƒtÄƒ È™i naturalÄƒ.', '1. ÃŽncepeÈ›i prin a aplicÄƒ nuanÈ›Äƒ Diornatural de balsam de buze Dior Addict Lip Glow cÄƒ baza de machiaj hidratantÄƒ, apoi tamponati excesul de produs cu un È™erveÈ›el.
        2. AplicaÈ›i apoi Dior Addict Lip Tint plasÃ¢nd aplicatorul Ã®n centrul buzelor, chiar sub arcul lui Cupidon, È™i colorÃ¢ndu-le de la dreapta la stÃ¢nga.',
        'https://www.sephora.ro/p/dior-addict-lip-tint---ruj-lichid-cu-efect-cromatic-semimat-P10025188.html');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (31, 'Color Riche Intense Volume Matte Colors of Worth ruj buze mat hidratant editie limitata', 55.00,
        'src/img/product31.webp', 1, 0, 5, 5, 22, '',
        'Rujul Lâ€™OrÃ©al Paris Color Riche Intense Volume Matte Colors of Worth accentueazÄƒ frumos buzele È™i subliniazÄƒ perfect fondul de ten de zi È™i de searÄƒ.',
        'Rujul se aplicÄƒ pe buze cu tuÈ™e delicate, dinspre centru spre colÈ›uri.',
        'https://www.notino.ro/loreal-paris/color-riche-intense-volume-matte-colors-of-worth-ruj-buze-mat-hidratant-editie-limitata/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (32, 'Creamy Matte ruj crema cu efect matifiant', 15.00, 'src/img/product32.webp', 1, 0, 11, 5, 22,
        'HYDROGENATED POLYDECENE, POLYISOBUTENE, CERA MICROCRISTALLINA, ETHYLHEXYL PALMITATE, SILICA, ACRYLATES CROSSPOLYMER, OZOKERITE, BIS-DIGLYCERYL POLYACYLADIPATE-2, DIMETHICONE, SYNTHETIC WAX, POLYETHYLENE, TRIDECYL TRIMELLITATE, DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER, PHENOXYETHANOL, HYDROGENATED VEGETABLE OIL, PARFUM, ALUMINUM HYDROXIDE, STEARYL STEARATE, STEARIC ACID, LECITHIN, POLYHYDROXYSTEARIC ACID, ISOPROPYL MYRISTATE, ETHYLHEXYL PALMITATE, ISOSTEARIC ACID, POLYGLYCERYL-3 POLYRICINOLEATE, ETHYLHEXYLGLYCERIN, BENZYL ALCOHOL, BENZYL SALICYLATE, HEXYL CINNAMAL, HYDROXYCITRONELLAL, CI 77891, CI 77491, CI 77492, CI 77499, CI 15850.',
        'Rujul MUA Makeup Academy Creamy Matte accentueazÄƒ frumos buzele È™i subliniazÄƒ perfect fondul de ten de zi È™i de searÄƒ.',
        'Rujul se aplicÄƒ pe buze cu tuÈ™e delicate, dinspre centru spre colÈ›uri.',
        'https://www.notino.ro/mua-makeup-academy/creamy-matte-ruj-crema-cu-efect-matifiant/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (33, 'Full Satin Nude ruj satinat', 22.00, 'src/img/product33.webp', 1, 0, 13, 5, 22,
        'HYDROGENATED POLYDECENE, HYDROGENATED POLYISOBUTENE, POLYGLYCERYL-2 TRIISOSTEARATE, EUPHORBIA CERIFERA CERA (EUPHORBIA CERIFERA (CANDELILLA) WAX), SILICA, ETHYLHEXYL PALMITATE, SYNTHETIC WAX, KAOLIN, OZOKERITE, TOCOPHEROL, ASCORBYL DIPALMITATE, ASCORBYL TETRAISOPALMITATE, ROSA CANINA FRUIT OIL, POLYHYDROXYSTEARIC ACID, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, MICA, TIN OXIDE, BENZYL ALCOHOL, PARFUM (FRAGRANCE), CI 15850 (RED 7), CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).', 'DacÄƒ vÄƒ doriÈ›i un ruj care sÄƒ se potriveascÄƒ la orice È›inutÄƒ, nu rataÈ›i rujul satinat Catrice Full Satin Nude. Se mÃ¢ndreÈ™te cu o compoziÈ›ie care hidrateazÄƒ buzele, iar textura sa cremoasÄƒ asigurÄƒ o aplicare uÈ™oarÄƒ.

        Cel mai mult vÄƒ va Ã®ncÃ¢nta datoritÄƒ pigmentÄƒrii sale intense, care creeazÄƒ buze perfecte la o singurÄƒ trecere. Catrice Full Satin Nude va deveni sigur rujul dvs. de bazÄƒ.',
        'Rujul se aplicÄƒ mai Ã®ntÃ¢i pe buza de sus È™i apoi pe cea de jos. La buza de sus Ã®ncepeÈ›i de la arcul lui Cupidon È™i continuaÈ›i de-a lungul contururilor, spre colÈ›uri.',
        'https://www.notino.ro/catrice/full-satin-nude-ruj-satinat/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (34, 'False Lash Bambi Oversized Eye mascara pentru volum, alungire si separarea genelor', 65.00,
        'src/img/product34.webp', 1, 0, 5, 5, 18,
        'AQUA / WATER, PARAFFIN, POTASSIUM CETYL PHOSPHATE, ACRYLATES COPOLYMER, CERA ALBA / BEESWAX, COPERNICIA CERIFERA CERA / CARNAUBA WAX, ETHYLENE/ACRYLIC ACID COPOLYMER, STEARETH-2, CETYL ALCOHOL, PHENOXYETHANOL, HYDROXYETHYLCELLULOSE, ACACIA SENEGAL GUM, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, SODIUM DEHYDROACETATE, CAPRYLYL GLYCOL, HYDROGENATED JOJOBA OIL, HYDROGENATED PALM OIL, PROPYLENE GLYCOL, DISODIUM EDTA, PENTAERYTHRITYL TETRAISOSTEARATE, SODIUM HYALURONATE, 2-OLEAMIDO-1,3-OCTADECANEDIOL, RAYON, PANTHENOL, LAURETH-21, SOLUBLE COLLAGEN, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, TRISODIUM EDTA, BUTYLENE GLYCOL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, POTASSIUM SORBATE, SODIUM CHONDROITIN SULFATE, ATELOCOLLAGEN, BHT, HEXYLENE GLYCOL, [+/- MAY CONTAIN: CI 77499 / IRON OXIDES]. (F.I.L. B259419/1).',
        'Rimelul pentru volum, alungire È™i separarea genelor, Loreal Paris False Lash Bambi Oversized Eye, creeazÄƒ gene atÃ¢t de frumoase, Ã®ncÃ¢t par ireale. AccentueazÄƒ la maxim genele, le separÄƒ È™i creeazÄƒ un efect 3D dramatic. Toate acestea fÄƒrÄƒ Ã®mpovÄƒrare È™i, Ã®n plus, aproape imediat, datoritÄƒ periei unice. Nimeni nu va rezista farmecului privirii dvs. extrem de pÄƒtrunzÄƒtoare.',
        'PlasaÈ›i periuÈ›a rimelului Bambi Oversized Eye la rÄƒdÄƒcina genelor È™i periaÈ›i spre vÃ¢rfuri. Pentru o separare cÃ¢t mai bunÄƒ a genelor, efectuaÈ›i miÈ™carea Ã®n zig-zag. AplicaÈ›i mai multe straturi, pÃ¢nÄƒ cÃ¢nd obÈ›ineÈ›i rezultatul dorit.',
        'https://www.notino.ro/loreal-paris/false-lash-bambi-oversized-eye-mascara-pentru-volum-alungire-si-separarea-genelor/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (35, 'False Lash Bambi Eye rimel cu efect de gene false', 58.00, 'src/img/product35.webp', 1, 0, 5, 5, 18,
        'G2004361, AQUA / WATER, PARAFFIN, POTASSIUM CETYL PHOSPHATE, ACRYLATES COPOLYMER, CERA ALBA / BEESWAX, COPERNICIA CERIFERA CERA / CARNAUBA WAX, ETHYLENE/ACRYLIC ACID COPOLYMER, CETYL ALCOHOL, STEARETH-2, PHENOXYETHANOL, HYDROXYETHYLCELLULOSE, ACACIA SENEGAL GUM, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, SYNTHETIC BEESWAX, BIS-DIGLYCERYL POLYACYLADIPATE-2, POLYBUTENE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, SODIUM DEHYDROACETATE, CAPRYLYL GLYCOL, HYDROGENATED JOJOBA OIL, HYDROGENATED PALM OIL, STEARETH-20, GLYCERYL DIBEHENATE, DISODIUM EDTA, PROPYLENE GLYCOL, PENTAERYTHRITYL TETRAISOSTEARATE, TRIBEHENIN, GLYCERYL BEHENATE, SODIUM HYALURONATE, 2-OLEAMIDO-1,3-OCTADECANEDIOL, RAYON, PANTHENOL, BUTYLENE GLYCOL, LAURETH-21, SOLUBLE COLLAGEN, SODIUM LAURETH SULFATE, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, TETRASODIUM EDTA, POTASSIUM SORBATE, TRISODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SODIUM CHONDROITIN SULFATE, BHT, ATELOCOLLAGEN, HEXYLENE GLYCOL [+/- MAY CONTAIN: CI 77499 / IRON OXIDES]. (F.I.L. B233767/3). ,',
        'Nimeni nu rezistÄƒ privirii dvs. de cÄƒprioarÄƒ sfioasÄƒ. Rimelul cu efect de gene false Loreal Paris False Lash Bambi Eye are o perie inovatoare, cu fire scurte È™i lungi, pentru gene perfect Ã®ntoarse, cu volum È™i lungime maxime.',
        'Rimelul se aplicÄƒ pe gene, prin tuÈ™e delicate, de la rÄƒdÄƒcini la vÃ¢rfuri. Pentru un plus de intensitate, se aplicÄƒ mai multe straturi. Se Ã®nlÄƒturÄƒ simplu, cu apÄƒ È™i sÄƒpun.',
        'https://www.notino.ro/loreal-paris/false-lash-bambi-eye-mascara-cu-efect-de-gene-false/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (36, 'Lash Sensational mascara pentru gene lungi È™i dese', 37.00, 'src/img/product36.webp', 1, 0, 14, 5, 18,
        'AQUA/WATER, PROPYLENE GLYCOL, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, POLYURETHANE-25, CERA ALBA/BEESWAX, SYNTHETIC FLUORPHLOGOPITE, GLYCERYL STEARATE, CETYL ALCOHOL, PEG-200 GLYCERYL STEARATE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, COPERNICIA CERIFERA CERA/CARNAUBA WAX, STEARIC ACID, PALMITIC ACID, ETHYLENE/VA COPOLYMER, ALCOHOL DENAT., PARAFFIN, AMINOMETHYL PROPANEDIOL, GLYCERIN, HYDROXYETHYLCELLULOSE, PHENOXYETHANOL, CAPRYLYL GLYCOL, BUTYLENE GLYCOL, XANTHAN GUM, SODIUM LAURETH SULFATE, DISODIUM EDTA, TETRASODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SILICA, )+/- MAY CONTAIN CI 77491, CI 77492, CI 77499/IRON OXIDES, CI 77007/ULTRAMARINES, CI 77891/TITANIUM DIOXIDE, MICA, CI 75470/CARMINE, CI 77288/CHROMIUM OXIDE GREENS, CI 77742/MANGANESE VIOLET, CI 77510/FERRIC FERROCYANIDE).',
        'Gene lungi È™i dese cu efect de evantai, asigurate de emblematicul rimel Maybelline Lash Sensational! Peria specialÄƒ, cu zece rÃ¢nduri de peri capteazÄƒ realmente fiecare geanÄƒ, o Ã®ntoarce È™i o alungeÈ™te vizibil.',
        'PlasaÈ›i peria la rÄƒdÄƒcina genelor È™i periaÈ›i-le Ã®n sus. UtilizaÈ›i vÃ¢rful periei pentru genele din colÈ›ul intern al ochilor.',
        'https://www.notino.ro/maybelline/lash-sensational-rimel-pentru-gene-lungi-si-voluminoase/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (37, 'Lash Sensational Sky High Mascara pentru volum si lungire', 61.00, 'src/img/product37.webp', 1, 0, 14, 5,
        18,
        'AQUA / WATER, PROPYLENE GLYCOL, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, POLYURETHANE-35, CERA ALBA / BEESWAX, SYNTHETIC FLUORPHLOGOPITE, GLYCERYL STEARATE, CETYL ALCOHOL, PEG-200 GLYCERYL STEARATE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, COPERNICIA CERIFERA CERA / CARNAUBA WAX, STEARIC ACID, PALMITIC ACID, ETHYLENE/VA COPOLYMER, ALCOHOL DENAT., PARAFFIN, AMINOMETHYL PROPANEDIOL, PHENOXYETHANOL, CAPRYLYL GLYCOL, GLYCERIN, HYDROXYETHYLCELLULOSE, BUTYLENE GLYCOL, METHYLPROPANEDIOL, RAYON, XANTHAN GUM, CAPRYLIC/CAPRIC TRIGLYCERIDE, SODIUM LAURETH SULFATE, MYRISTIC ACID, TETRASODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, POTASSIUM SORBATE, SILICA, PHENYLPROPANOL, BAMBUSA VULGARIS EXTRACT, [+/- MAY CONTAIN: CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 77007 / ULTRAMARINES, MICA, CI 77891 / TITANIUM DIOXIDE, CI 75470 / CARMINE, CI 77288 / CHROMIUM OXIDE GREENS, CI 77742 / MANGANESE VIOLET, CI 77510 / FERRIC FERROCYANIDE]. (F.I.L. D268569/1).', 'Cerul este limita! Acest motto este adevÄƒrat mai ales pentru genele dvs. Dovada este rimelul pentru volum È™i alungire Maybelline Lash Sensational Sky High. Acest rimel nu doar cÄƒ vÄƒ va oferi o alungire maximÄƒ, ci va È™i lungi genele Ã®ntr-un mod nemaipomenit â€“ toate acestea Ã®n cÃ¢teva miÈ™cÄƒri!

        La fel de uÈ™or ca È™i aplicarea acestuia va fi È™i demachierea, deoarece rimelul se demachiazÄƒ doar cu apÄƒ! Maybelline Lash Sensational Sky High vÄƒ oferÄƒ tot ce v-aÈ›i putea dori de la un rimel.',
        'ApropiaÈ›i aplicatorul de gene È™i Ã®ntindeÈ›i rimelul de la rÄƒdÄƒcini, pÃ¢nÄƒ la vÃ¢rfuri. RepetaÈ›i procesul, pÃ¢nÄƒ cÃ¢nd veÈ›i obÈ›ine rezultatul dorit.',
        'https://www.notino.ro/maybelline/lash-sensational-sky-high-mascara-pentru-volum-si-lungire/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (38, 'Calligraph Pro Precise 24h Matt dermatograf rezistent la apÄƒ', 20.00, 'src/img/product38.webp', 1, 0, 13,
        5, 21,
        'AQUA (WATER), METHYLPROPANEDIOL, STYRENE/ACRYLATES COPOLYMER, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, CELLULOSE, PEG-60 HYDROGENATED CASTOR OIL, COCO-GLUCOSIDE, POLOXAMER 407, PHENYLPROPANOL, CAPRYLYL GLYCOL, SODIUM LAURETH-12 SULFATE, SODIUM LAURYL SULFATE, BHT, CITRIC ACID, PHENOXYETHANOL, POTASSIUM SORBATE, SODIUM BENZOATE, SODIUM DEHYDROACETATE, CI 77266 (BLACK 2) (NANO).',
        'ObÈ›ine linia de tuÈ™ perfectÄƒ cu Catrice Calligraph Pro Precise 24h Matt! OferÄƒ un negru intens, acoperire puternicÄƒ È™i precizie, datoriÄƒ vÃ¢rfului ultra fin ca de stilou. Practic, dar cu o formulÄƒ rezistentÄƒ la apÄƒ, tuÈ™ul are o durabilitate de pÃ¢nÄƒ la 24 de ore.',
        'FolosiÈ›i vÃ¢rful fin pentru a trasa linia de tuÈ™ pe conturul ochiilor, Ã®n funcÈ›ie de rezultatul dorit.',
        'https://www.notino.ro/catrice/catrice-calligraph-pro-precise-24h-matt-dermatograf-rezistent-la-apa-culoare-010-intense-black-waterproof/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_ffYVGJEEw524-Z5iKKDrhxOgH-sF5Y-TIiBnALe9qj8IOKxZFc4dxoCFo8QAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (39, 'Epic Ink contur de precizie, rezistent la apÄƒ', 52.00, 'src/img/product39.webp', 1, 0, 10, 5, 21,
        'AQUA / WATER, CI 77266 [NANO] / BLACK 2, PROPYLENE GLYCOL, ACRYLATES/ETHYLHEXYL ACRYLATE COPOLYMER, LAURETH-21, ACRYLATES/DIMETHYLAMINOETHYL METHACRYLATE COPOLYMER, C11-15 PARETH-7, PEG-40 HYDROGENATED CASTOR OIL, SODIUM LAURETH-12 SULFATE, SODIUM LAURYL SULFATE, AMMONIUM ACRYLATES COPOLYMER, DISODIUM LAURETH SULFOSUCCINATE, CAPRYLYL GLYCOL, BUTYLENE GLYCOL, POTASSIUM SORBATE, SODIUM DEHYDROACETATE, PHENOXYETHANOL (F.I.L. D193551/1).',
        'Pentru o privire seducÄƒtoare, cÄƒreia nimeni nu-i rezistÄƒ. TuÈ™ul contur de ochi rezistent la apÄƒ NYX Professional Makeup Epic Ink are o culoare intensÄƒ È™i saturatÄƒ, cu care subliniazÄƒ È™i evidenÈ›iazÄƒ orice machiaj. Este foarte uÈ™or de aplicat È™i rezistÄƒ perfect. PuteÈ›i opta pentru seducÄƒtorii ochi de pisicÄƒ - sau doar pentru un contur discret.',
        'Se traseazÄƒ uÈ™or linia pe pleoapÄƒ. Se lasÄƒ sÄƒ se usuce.',
        'https://www.notino.ro/nyx-professional-makeup/epic-ink-contur-de-precizie-rezistent-la-apa/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (40, 'Hyper Precise creion pentru conturul ochilor', 28.00, 'src/img/product40.webp', 1, 0, 14, 5, 21,
        'AQUA / WATER, METHYLPROPANEDIOL, STYRENE/ACRYLATES COPOLYMER, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, CELLULOSE, PEG-60 HYDROGENATED CASTOR OIL, COCO-GLUCOSIDE, POLOXAMER 407, CITRIC ACID, PHENOXYETHANOL, POTASSIUM SORBATE, PHENYLPROPANOL, SODIUM BENZOATE, CAPRYLYL GLYCOL, SODIUM DEHYDROACETATE, SODIUM LAURETH SULFATE, SODIUM LAURYL SULFATE, BHT, [+/- MAY CONTAIN: CI 77266 [NANO] / BLACK 2]. (F.I.L. D218002/1).',
        'Aplicare uÈ™oarÄƒ È™i precisÄƒ, persistenÈ›Äƒ Ã®ndelungatÄƒ È™i fÄƒrÄƒ migrare â€“ tuÈ™ul de ochi Maybelline Hyper Precise Ã®mplineÈ™te toate aÈ™teptÄƒrile pe care le-aÈ›i putea avea de la un contur de ochi. VÃ¢rful ultrasubÈ›ire vÄƒ ajutÄƒ sÄƒ trasaÈ›i atÃ¢t linii foarte subÈ›iri, cÃ¢t È™i groase. DatoritÄƒ compoziÈ›iei rezistente la apÄƒ, face faÈ›Äƒ cu brio chiar È™i unor condiÈ›ii solicitante, pentru siguranÈ›a ochilor perfect machiaÈ›i Ã®n orice situaÈ›ie. CÃ¢È™tigÄƒtor, Ã®n 2013, al concursului Allure Best of Beauty Award, vÄƒ va cÃ¢È™tiga È™i pe dvs.',
        'TrasaÈ›i o linie subÈ›ire cu vÃ¢rful aplicatorului, din colÈ›ul intern al ochiului spre cel extern. Se demachiazÄƒ cu un produs pentru machiaj rezistent la apÄƒ.',
        'https://www.notino.ro/maybelline/hyper-precise-creion-pentru-conturul-ochilor/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (41, 'Epic Black Mousse Liner eyeliner rezistent la apÄƒ', 46.00, 'src/img/product41.webp', 1, 0, 10, 5, 21,
        'ISODODECANE, TRIMETHYLSILOXYSILICATE, POLYETHYLENE, PHENOXYETHANOL, TOCOPHERYL ACETATE, LECITHIN, BHT. MAY CONTAIN / PEUT CONTENIR (+/-)BLACK 2 (CI 77266)[NANO].',
        'Pentru o linie perfectÄƒ È™i rezistentÄƒ de tuÈ™, Nyx Professional Makeup Epic Black Mousse este produsul ideal! Cu o texturÄƒ uimitor de cremoasÄƒ, Ã®n ambalajul inovator ca un borcÄƒnaÈ™, tuÈ™ul este rezistent la apÄƒ È™i oferÄƒ un aspect mat.',
        'UtilizaÈ›i cu o pensulÄƒ specialÄƒ pentru tuÈ™, aplicaÈ›i Ã®ntr-un strat subÈ›ire pe conturul ochiilor Ã®n funcÈ›ie de efectul dorit.',
        'https://www.notino.ro/nyx-professional-makeup/epic-black-mousse-liner/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (42, 'Brow Artist Plump and Set gel pentru sprancene', 39.00, 'src/img/product42.webp', 1, 0, 5, 5, 19, '',
        'DescoperiÈ›i gelul ideal pentru sprÃ¢ncene mai pline Lâ€™OrÃ©al Paris Brow Artist Plump and Set Eyebrow Gel! PeriuÈ›a faciliteazÄƒ aplicarea iar formula modeleazÄƒ È™i seteazÄƒ firele de pÄƒr, oferind un aspect natural. Produsul are o durabilitate de pÃ¢nÄƒ la 24 de ore È™i este rezistent la apÄƒ.',
        'AplicaÈ›i gelul singur sau pentru a seta un alt produs pentru sprÃ¢ncene. PeriaÈ›i sprÃ¢ncenele cu miÈ™cÄƒri ascendente.',
        'https://www.notino.ro/loreal-paris/brow-artist-plump-and-set-gel-pentru-sprancene/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (43, 'Tattoo Brow 36H gel de sprancene de lungÄƒ duratÄƒ', 48.00, 'src/img/product43.webp', 1, 0, 14, 5, 19, '',
        'SprÃ¢ncenele elegant modelate evidenÈ›iazÄƒ imediat frumuseÈ›ea naturalÄƒ, deoarece Ã®ncadreazÄƒ Ã®ntreaga faÈ›Äƒ. Pentru un chip perfect, un simplu gest este suficient. Rimelul pentru sprÃ¢ncene Maybelline Tattoo Brow 36H accentueazÄƒ È™i fixeazÄƒ genele, Ã®ntr-un singur pas.',
        'PeriaÈ›i de mai multe ori firele sprÃ¢ncenelor, modelÃ¢ndu-le totodatÄƒ Ã®n forma doritÄƒ.',
        'https://www.notino.ro/maybelline/tattoo-brow-36h-gel-de-sprancene-de-lunga-durata/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (44, 'Lash Brow Designer gel mascara a genelor si a sprancenelor', 11.00, 'src/img/product44.webp', 1, 0, 13, 5,
        19,
        'AQUA (WATER), GLYCERIN, PROPYLENE GLYCOL, PANTHENOL, CARBOMER, ACRYLATES COPOLYMER, ETHYLHEXYLGLYCERIN, SODIUM HYDROXIDE, PHENOXYETHANOL.',
        'SprÃ¢ncenele pot transforma incredibil aspectul feÈ›ei dvs. De gene nici nu mai pomenim. Trebuie sÄƒ fie perfect aranjate. Rimelul transparent pentru gene È™i sprÃ¢ncene Catrice Lash Brow Designer are grijÄƒ de ambele. SculpteazÄƒ sprÃ¢ncenele È™i rimeleazÄƒ genele È™i le oferÄƒ fermitate, luciu È™i Ã®ngrijire, pentru o ameliorare durabilÄƒ a stÄƒrii acestora.',
        'ModelaÈ›i sprÃ¢ncenele cu peria Ã®ntr-o formÄƒ Ã®ngrijitÄƒ. PeriaÈ›i genele pe Ã®ntreaga lungime, de la rÄƒdÄƒcini la vÃ¢rfuri.',
        'https://www.notino.ro/catrice/lash-brow-designer-gel-mascara-a-genelor-si-a-sprancenelor/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (45, 'Brow Ultra Slim creion pentru sprancene', 29.00, 'src/img/product45.webp', 1, 0, 14, 5, 20, '',
        'Nimic nu oferÄƒ atÃ¢t farmec privirii ca sprÃ¢ncenele Ã®ngrijite. Creionul automat pentru sprÃ¢ncene Maybelline Brow Ultra Slim are vÃ¢rful lat de numai 1,5 mm, care imitÄƒ perfect pÄƒrul natural. CompoziÈ›ia cremoasÄƒ nu lasÄƒ pete, are o persistenÈ›Äƒ de lungÄƒ duratÄƒ È™i previne ruperea creionului. Iar pensula practicÄƒ vÄƒ ajutÄƒ sÄƒ modelaÈ›i sprÃ¢ncenele È™i sÄƒ le sculptaÈ›i Ã®ntr-o formÄƒ perfectÄƒ.',
        'CompletaÈ›i sprÃ¢ncenele pe toatÄƒ lungimea, cu tuÈ™e subÈ›iri, care imitÄƒ firele naturale. Apoi, folosind peria, pieptÄƒnaÈ›i firele de pÄƒr Ã®n sus È™i apoi Ã®n lateral.',
        'https://www.notino.ro/maybelline/brow-ultra-slim-creion-pentru-sprancene/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (46, 'Lift&Snatch Brow Tint Pen creion pentru sprancene', 57.00, 'src/img/product46.webp', 1, 0, 10, 5, 20,
        'AQUA / WATER / EAU, GLYCERIN, ALCOHOL, PEG/PPG-14/4 DIMETHICONE, PVP, PEG-40 HYDROGENATED CASTOR OIL, TRIISOPROPANOLAMINE, PROPYLENE GLYCOL, CAPRYLYL GLYCOL, LAURETH-21, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SODIUM DEHYDROACETATE, PHENOXYETHANOL. MAY CONTAIN / PEUT CONTENIR (+/-)CI 77266 [NANO] / BLACK 2, CI 16035 / RED 40, CI 19140 / YELLOW 5, CI 42090 / BLUE 1.',
        'SprÃ¢ncene perfect definite cu aspect natural È™i o rezistenÈ›Äƒ Ã®ndelungatÄƒ. Creionul de sprÃ¢ncene NYX Professional Makeup Lift&Snatch Brow Tint Pen este produsul potrivit pentru umplerea È™i definirea sprÃ¢ncenelor, oferind un aspect instant de lifting. AvÃ¢nd un vÃ¢rf foarte subÈ›ire, creionul ajusteazÄƒ sprÃ¢ncenele È™i le asigurÄƒ un aspect natural care rezistÄƒ pÃ¢nÄƒ la 16 ore.',
        'AgitaÈ›i produsul Ã®nainte de folosire. Prin miÈ™cÄƒri ascendente trasaÈ›i tuÈ™e delicate pentru a umple È™i defini sprÃ¢nceana. Poate fi folosit atÃ¢t singur, cÃ¢t È™i alÄƒturi de alte produse pentru sprÃ¢ncene.',
        'https://www.notino.ro/nyx-professional-makeup/liftsnatch-brow-tint-pen-creion-pentru-sprancene/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_XkA05TyxuPEQL3bvtlH8cW5guqMs5PY9yBVCUgw3dhX1Pc3cVlW9xoCB_QQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (47, 'Dear Universe paletÄƒ cu farduri de ochi', 49.00, 'src/img/product47.webp', 1, 0, 13, 5, 17, '',
        'Paleta pentru machiaj ochilor Catrice Dear Universe oferÄƒ posibilitatea creÄƒrii celor mai fantastice variante de farduri de pleoape.',
        'Se aplicÄƒ umbrele pe pleoape cu peria, cu buretele de fond de ten sau cu buricele degetelor.',
        'https://www.notino.ro/catrice/dear-universe-paleta-cu-farduri-de-ochi/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (48, 'Soph X Super Spice paletÄƒ cu farduri de ochi', 64.00, 'src/img/product48.webp', 1, 0, 15, 5, 17, '',
        'LÄƒsaÈ›i-vÄƒ liberÄƒ imaginaÈ›ia È™i creaÈ›i combinaÈ›ii surprinzÄƒtoare de make-up cu paleta de farduri pentru ochi Makeup Revolution Soph X Super Spice. Cele 18 nuanÈ›e sunt potrivite unei personalitÄƒÈ›i ce Ã®È™i doreÈ™te sÄƒ fie Ã®n centrul atenÈ›iei È™i sÄƒ Ã®ntoarcÄƒ toate privirile. Fardurile sunt pigmentate, uÈ™or de amestecat È™i demachiat È™i au o texturÄƒ cremoasÄƒ ce faciliteazÄƒ aplicarea. BucuraÈ›i-vÄƒ de zeci de Ã®nfÄƒÈ›iÈ™Äƒri, cu o singurÄƒ paletÄƒ.',
        'AplicaÈ›i fard cu ajutorul unei pensule speciale sau chiar cu vÃ¢rfurile degetelor pe pleoapa superioarÄƒ. Pentru a contura privirea, aplicaÈ›i fard Ã®n tuÈ™e fine È™i sub linia apei, Ã®n zona inferioarÄƒ.',
        'https://www.notino.ro/makeup-revolution/soph-x-super-spice-paleta-cu-farduri-de-ochi/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (49, 'Ultimate Shadow Palette paletÄƒ cu farduri de ochi', 78.00, 'src/img/product49.webp', 1, 0, 10, 5, 17, '',
        'Paleta de farduri de pleoape NYX Professional Makeup Ultimateâ„¢ Ã®È™i meritÄƒ numele - combinaÈ›ia a 16 nuanÈ›e de farduri de ochi È™i pigmenÈ›i presaÈ›i, de nivel profesional, vÄƒ vor cuceri, pur È™i simplu. NuanÈ›ele excelent combinate sunt inspirate de culorile curcubeului È™i oferÄƒ o texturÄƒ mÄƒtÄƒsoasÄƒ, cu diverse finisaje',
        'Fardurile Ã®n nuanÈ›ele dorite se aplicÄƒ pe pleoape folosind pensula, aplicatorul sau degetele. EstompaÈ›i zona de tranziÈ›ie Ã®ntre culori, pentru un efect natural. Nu ezitaÈ›i sÄƒ folosiÈ›i mai multe culori, atÃ¢t pe pleoapa de sus, cÃ¢t È™i pe cea de jos.',
        'https://www.notino.ro/nyx-professional-makeup/ultimate-shadow-paleta-cu-farduri-de-ochi/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (50, 'Ultimate Desire paletÄƒ cu farduri de ochi', 38.00, 'src/img/product50.webp', 1, 0, 15, 5, 17, '',
        'Paleta pentru machiaj ochilor Makeup Revolution Ultimate Desire oferÄƒ posibilitatea creÄƒrii celor mai fantastice variante de farduri de pleoape.',
        'Se aplicÄƒ umbrele pe pleoape cu peria, cu buretele de fond de ten sau cu buricele degetelor.',
        'https://www.notino.ro/makeup-revolution/ultimate-desire-paleta-cu-farduri-de-ochi/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (51, 'Studio Fix Fluid fond de ten matifiant SPF 15', 157.00, 'src/img/product51.webp', 1, 0, 16, 5, 12, '',
        'DescoperiÈ›i secretul unui ten de porÈ›elan! Fondul de ten matifiant MAC Studio Fix Fluid, asigurÄƒ un finisaj mat, natural, de lungÄƒ duratÄƒ È™i protejeazÄƒ Ã®mpotriva radiaÈ›iilor solare, SPF 15. DatoritÄƒ texturii fluide, este foarte uÈ™or de aplicat È™i acoperÄƒ eficient imperfecÈ›iunile tenului.',
        'Se aplicÄƒ pe ten cu buretele de machiaj sau cu o pensulÄƒ destinatÄƒ fondului de ten, prin tapotare.',
        'https://www.notino.ro/mac/studio-fix-fluid-fond-de-ten-matifiant-spf-15/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_ej2vgGti3HzRGHjICqFtcWkFn5lHsyYE6fC4Nik6-2vS2s9fERX_RoC-NYQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (52, 'Cant Stop Wont Stop Full Coverage Foundation fond de ten cu acoperire ridicatÄƒ', 85.00,
        'src/img/product52.webp', 1, 0, 10, 5, 12,
        'WATER/AQUA/EAU, DIMETHICONE, ISODODECANE, NYLON-12, ACRYLATES/POLYTRIMETHYLSILOXYMETHACRYLATE COPOLYMER, SILICA, BUTYLENE GLYCOL, PEG-10 DIMETHICONE, ISOHEXADECANE, ISONONYL ISONONANOATE, PENTYLENE GLYCOL, SYNTHETIC FLUORPHLOGOPITE, BIS-PEG/PPG-14/14 DIMETHICONE, MAGNESIUM SULFATE, PHENOXYETHANOL, CAPRYLYL GLYCOL, ACRYLONITRILE/METHYL METHACRYLATE/VINYLIDENE CHLORIDE COPOLYMER, DISODIUM STEAROYL GLUTAMATE, DISTEARDIMONIUM HECTORITE, CALCIUM GLUCONATE, PERLITE, MAGNESIUM GLUCONATE, TOCOPHEROL, ALUMINUM HYDROXIDE, ISOBUTANE. MAY CONTAIN / PEUT CONTENIR (+/-)TITANIUM DIOXIDE (CI 77891), IRON OXIDES (CI 77491, CI 77492, CI 77499).',
        'Un fond de ten care È›ine pasul cu dumneavoastrÄƒ pÃ¢nÄƒ la 24 de ore? AveÈ›i Ã®ncredere Ã®n fondul de ten Canâ€˜t Stop Wonâ€˜t Stop, de la NYX Professional Makeup. UniformizeazÄƒ perfect nuanÈ›a tenului, Ã®i conferÄƒ un aspect mat È™i rezistÄƒ Ã®n stare perfectÄƒ toatÄƒ ziua.',
        'Fondul de ten se Ã®ntinde pe faÈ›Äƒ cu ajutorul buretelui aplicator È™i se Ã®ntinde uniform, dinspre centrul feÈ›ei spre exterior.',
        'https://www.notino.ro/nyx-professional-makeup/cant-stop-wont-stop/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (53, 'Infaillible 32H Fresh Wear fard lichid de lunga durata', 77.00, 'src/img/product53.webp', 1, 0, 5, 5, 12,
        'AQUA / WATER, DIMETHICONE, ISODODECANE, ALCOHOL DENAT., ETHYLHEXYL METHOXYCINNAMATE, TRIMETHYLSILOXYSILICATE, BUTYLENE GLYCOL, TITANIUM DIOXIDE [NANO] / TITANIUM DIOXIDE, PEG-10 DIMETHICONE, PERLITE, SYNTHETIC FLUORPHLOGOPITE, NYLON-12, ISOPROPYL LAUROYL SARCOSINATE, DIISOPROPYL SEBACATE, HDI/TRIMETHYLOL HEXYLLACTONE CROSSPOLYMER, DISTEARDIMONIUM HECTORITE, BIS-PEG/PPG-14/14 DIMETHICONE, MAGNESIUM SULFATE, ALUMINUM HYDROXIDE, PHENOXYETHANOL, DISODIUM STEAROYL GLUTAMATE, HYDROGEN DIMETHICONE, CELLULOSE, DIPENTAERYTHRITYL TETRAHYDROXYSTEARATE/TETRAISOSTEARATE, ASCORBYL GLUCOSIDE, SILICA SILYLATE, PARFUM / FRAGRANCE, CALCIUM ALUMINUM BOROSILICATE, TOCOPHEROL, SILICA, HEXYL CINNAMAL, BENZYL SALICYLATE, BHT, LINALOOL, ALPHA-ISOMETHYL IONONE, BENZYL ALCOHOL, CITRONELLOL, [+/- MAY CONTAIN: CI 77891 / TITANIUM DIOXIDE, CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 77163 / BISMUTH OXYCHLORIDE, MICA]. (F.I.L. Z285169/1).',
        'BucuraÈ›i-vÄƒ de un ten fÄƒrÄƒ cusur. Loreal Paris prezintÄƒ Infaillible, inovatorul fond de ten care rezistÄƒ Ã®ntreaga zi fÄƒrÄƒ retuÈ™uri, permiÈ›Ã¢nd Ã®n acelaÈ™i timp tenului sÄƒ respire liber. Fondul de ten Loreal Paris Infaillible nu creeazÄƒ un efect de mascÄƒ, iar formula sa specialÄƒ rezistÄƒ la apÄƒ, la transpiraÈ›ie È™i la transfer. DatoritÄƒ consistenÈ›ei ultra-fine, Loreal Infaillible este uÈ™or de Ã®ntins, uniformizeazÄƒ tonul pielii È™i lasÄƒ o senzaÈ›ie durabilÄƒ, de prospeÈ›ime È™i confort.',
        'Fondul de ten Infaillible, de la Loreal, se aplicÄƒ pe faÈ›Äƒ folosind degetele, peria sau buretele de machiaj È™i se Ã®ntinde uniform.',
        'https://www.notino.ro/loreal-paris/infaillible-fard-lichid-de-lunga-durata/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (54, 'Nude Drop Tinted Serum Foundation', 48.00, 'src/img/product33.webp', 1, 0, 13, 5, 12,
        'AQUA (WATER), ISODODECANE, DIMETHICONE, HYDROGENATED POLYDECENE, GLYCERIN, C12-15 ALKYL BENZOATE, PEG-10 DIMETHICONE, DIMETHICONE CROSSPOLYMER, BUTYLENE GLYCOL, CETYL PEG/PPG-10/1 DIMETHICONE, SILICA, TRIMETHYLSILOXYSILICATE, SODIUM HYALURONATE, TOCOPHEROL, SODIUM CHLORIDE, MAGNESIUM SULFATE, TOCOPHERYL ACETATE, TRIETHOXYCAPRYLYLSILANE, DISTEARDIMONIUM HECTORITE, METHICONE, PROPYLENE CARBONATE, ETHYLHEXYLGLYCERIN, ALUMINUM HYDROXIDE, PHENOXYETHANOL, SODIUM BENZOATE, SODIUM DEHYDROACETATE, BENZOIC ACID, DEHYDROACETIC ACID, CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
        'Fondul de ten Catrice Nude Drop Tinted Serum Foundation uniformizeazÄƒ nuanÈ›a pielii, acoperind micile imperfecÈ›iuni.',
        'Se aplicÄƒ fondul de ten pe punctele de bazÄƒ ale feÈ›ei, È™i anume fruntea, obrajii È™i bÄƒrbia. A se agita, Ã®nainte de utilizare.',
        'https://www.notino.fr/catrice/nude-drop-tinted-serum-foundation-base-serum/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (55, 'Mineral Finishing Powder', 48.00, 'src/img/product55.webp', 1, 0, 10, 5, 13,
        'SILICA, TALC, DIMETHICONE, METHYLPARABEN, PROPYLPARABEN.MAY CONTAIN / PEUT CONTENIR (+/-)IRON OXIDES (CI 77491, 77492, 77499).',
        'Este aproape invizibilÄƒ pe piele È™i, totuÈ™i, reuÈ™eÈ™te lucruri uimitoare. Pudra mineralÄƒ NYX Professional Makeup Mineral Finishing Powder oferÄƒ feÈ›ei un aspect mat, prelungeÈ™te persistenÈ›a machiajului È™i acoperÄƒ imperfecÈ›iunile minore. Are un finisaj catifelat, este incredibil de uÈ™oarÄƒ È™i aratÄƒ foarte natural.',
        'AplicaÈ›i pudra pe faÈ›Äƒ, cu peria sau cu puful. Poate fi aplicatÄƒ atÃ¢t peste un fond de ten, cÃ¢t È™i individual, pe tenul hidratat È™i nemachiat.',
        'https://www.notino.ro/nyx-professional-makeup/mineral-finishing-powder-pudra-cu-minerale/p-15798950/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_dTtrS_m4U2ZSpyUhWfKtSrvEiPVhOUSO-MEjkYFrNtZDQtuxg8W5hoC0uEQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (56, 'All Matt Plus', 18.00, 'src/img/product56.webp', 1, 0, 13, 5, 13,
        'TALC, ZINC STEARATE, ETHYLHEXYL PALMITATE, DIMETHYLIMIDAZOLIDINONE RICE STARCH, PHENYL TRIMETHICONE, OCTYLDODECYL STEAROYL STEARATE, GLYCERYL CAPRYLATE, p-ANISIC ACID, TOCOPHERYL ACETATE, SODIUM POTASSIUM ALUMINUM SILICATE, SILICA, PARFUM (FRAGRANCE), CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
        'Un ten perfect uniform È™i matifiat este baza oricÄƒrui machiaj - indiferent dacÄƒ doriÈ›i sÄƒ creaÈ›i un look fin È™i natural sau un machiaj intens de searÄƒ. Pudra matifiantÄƒ Catrice All Matt Plus matifiazÄƒ tenul timp de pÃ¢nÄƒ la 12 ore, fixeazÄƒ machiajul È™i, datoritÄƒ pigmenÈ›ilor care reflectÄƒ lumina, conferÄƒ tenului un aspect natural fresh.',
        'AplicaÈ›i pudra pe faÈ›Äƒ, cu peria sau buretele. Poate fi aplicatÄƒ atÃ¢t pe tenul hidratat È™i nemachiat, cÃ¢t È™i peste un fond de ten.',
        'https://www.notino.ro/catrice/all-matt-plus-pudra-matuire/p-15667174/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_Q4XTRboB-b8wQRjtdbqcYEpAZ4yHAviyp9jcdYO_RJU1vQHBemSSxoCG5UQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (57, 'Mineralize Skinfinish Natural', 164.00, 'src/img/product57.webp', 1, 0, 16, 5, 13, '',
        'ReprezintÄƒ cireaÈ™a de pe tort a oricÄƒrui machiaj È™i va fixa fondul de ten, astfel Ã®ncÃ¢t dvs. sÄƒ vÄƒ puteÈ›i bucura de un aspect perfect o zi Ã®ntreagÄƒ. Despre ce este vorba? Desigur, despre pudra MAC Cosmetics Mineralize Skinfinish Natural, cu pigmenÈ›i strÄƒlucitori delicaÈ›i È™i un finisaj catifelat. DatoritÄƒ conÈ›inutului de vitamina E È™i a unui complex mineral, tenul dvs. va fi iluminat È™i vÄƒ veÈ›i putea bucura de senzaÈ›ia de confort È™i de un aspect natural.',
        'AplicaÈ›i pudra MAC Cosmetics Mineralize Skinfinish Natural pe faÈ›Äƒ, cu ajutorul unei pensule mari pentru pudrÄƒ, È™i estompaÈ›i-o din centrul feÈ›ei Ã®nspre exterior.',
        'https://www.notino.ro/mac/mineralize-skinfinish-natural-pudra/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (58, 'Cheek Kit', 24.00, 'src/img/product58.webp', 1, 0, 16, 5, 15,
        'SHADES 1,2: MICA, MAGNESIUM ALUMINUM SILICATE, NYLON-12, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDE ( CI 77491). SHADE 3: MICA, NYLON-12, MAGNESIUM ALUMINUM SILICATE, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDES ( CI 77491, 77492, 77499). SHADE 4: MICA, SYNTHETIC FLUORPHLOGOPITE, MAGNESIUM ALUMINUM SILICATE, NYLON-12, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDE ( CI 77491).',
        'Paleta Makeup Revolution Cheek Kit cu nuanÈ›e calde È™i reci, evidenÈ›iazÄƒ contururile chipului, lumineazÄƒ faÈ›a, acoperÄƒ imperfecÈ›iunile datoritÄƒ pigmentÄƒrii intense È™i dÄƒ un aspect profesional.',
        'Cu Makeup Revolution Cheek Kit se poate atinge un look de Ã®naltÄƒ calitate È™i fÄƒrÄƒ mari cunoÈ™tinÈ›e Ã®n ale make-up-ului profesional. Se aplicÄƒ nuanÈ›ele mai Ã®nchise Ã®n adÃ¢ncituri (precum se aplicÄƒ bronzerul), iar nuanÈ›ele mai aprinse pe porÈ›iunile care doriÈ›i sÄƒ fie evidenÈ›iate.',
        'https://www.notino.ro/makeup-revolution/cheek-kit/p-15924556/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_bvdosfAm0KWwSDcbTR_3ULd8dMnxn-2IcrDqYTy8z-Le9jLMb-y6BoCSDYQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (59, 'Dior Forever Couture Luminizer', 222.00, 'src/img/product59.webp', 1, 0, 12, 5, 15, '', 'Iluminatorul Dior Forever Couture Luminizer ii confera tenului un efect irizat spectaculos si ii amplifica luminozitatea.
        Cu o concentratie ridicata de pigmenti sidefati cu stralucire multidimensionala, compusi din 95%** pigmenti de origine naturala, pudra iluminatoare fuzioneaza impecabil cu pielea, oferindu-i machiajului o rezistenta optima de dimineata pana seara.
        Infuzat cu extract de pansea salbatica, iluminatorul protejeaza hidratarea naturala a pielii: pe toata durata zilei, confortul este garantat.', '1. Cu ajutorul pensulei Dior Backstage Blush Brush NÂ° 16, se aplica tuse de pudra iluminatoare Dior Forever Couture Luminizer pe contururile faciale.
        2. Se incheie cu o tusa pe arcul lui Cupidon, pentru un efect de stralucire.

        1. Efect sidefat surprinzator fara niciun compromis, datorita combinatiei de rezistenta si confort oferite de pudra iluminatoare Dior.
        2. O pudra delicata, imbogatita cu extract floral si compusa din 95%* pigmenti de origine naturala, pentru a proteja hidratarea pielii.
        3. Luminozitate intr-un format practic si ultrasubtire, couture .',
        'https://www.notino.ro/dior/dior-forever-couture-luminizer-iluminator/p-16084320/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=12d1f822025711ee819a00730a18b8fa&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (60, 'Bubble Balm', 25.00, 'src/img/product60.webp', 1, 0, 15, 5, 15,
        'MICA, TALC, DIMETHICONE, MAGNESIUM STEARATE, CALCIUM ALUMINUM BOROSILICATE, METHYLPARABEN, PROPYLPARABEN, TIN OXIDE, CI 77891 (TITANIUM DIOXIDE), CI 77491 (IRON OXIDES).',
        'Iluminatorul Makeup Revolution Bubble Balm conferÄƒ chipului un aspect sÄƒnÄƒtos È™i plin de vitalitate.',
        'Se aplicÄƒ pe zonele feÈ›ei care necesitÄƒ accentuare È™i iluminare.',
        'https://www.notino.ro/makeup-revolution/bubble-balm-iluminator-din-gel/p-16181458/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=30e9b0ae025711ee82b700750a18b8fc&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (61, 'Rue Royale Limited Edition', 73.00, 'src/img/product61.webp', 1, 0, 5, 5, 16, '',
        'Bronzerul Lâ€™OrÃ©al Paris Rue Royale Limited Edition Ã®mbunÄƒtÄƒÈ›eÈ™te aspectul tenului È™i Ã®i conferÄƒ un efect de bronz lejer.',
        'Pentru un efect de bronz, se aplicÄƒ o cantitate micÄƒ pe Ã®ntreaga faÈ›Äƒ. Pentru definirea feÈ›ei È™i evidenÈ›ierea contururilor, se va aplica pe pÄƒrÈ›ile laterale ale frunÈ›ii, sub pomeÈ›i, Ã®n josul bÄƒrbiei È™i pe marginile nasului.',
        'https://www.notino.co.uk/loreal-paris/rue-royale-limited-edition-bronzer-and-contour-powder/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (62, 'Matte Bronzer', 53.00, 'src/img/product62.webp', 1, 0, 10, 5, 16, '',
        'DescoperiÈ›i produsul ideal pentru un aspect impecabil, care nu vÄƒ Ã®ngreuneazÄƒ geanta nici Ã®n cea mai lungÄƒ cÄƒlÄƒtorie! Bronzerul NYX Professional Makeup Matte Bronzer lasÄƒ tenul neted È™i catifelat asigurÃ¢nd un efect de bronz confortabil care rezistÄƒ mult timp. DatoritÄƒ texturii lejere puteÈ›i obÈ›ine rapid È™i uÈ™or un ten ca â€žsÄƒrutat de soareâ€ fÄƒrÄƒ ca mÄƒcar sÄƒ petreceÈ›i timp pe plajÄƒ.',
        'Pentru un efect de bronz lejer, aplicaÈ›i o cantitate micÄƒ de pudrÄƒ pe Ã®ntreaga faÈ›Äƒ. Pentru definirea feÈ›ei È™i evidenÈ›ierea contururilor, se va aplica pe pÄƒrÈ›ile laterale ale frunÈ›ii, sub pomeÈ›i, Ã®n josul bÄƒrbiei È™i pe marginile nasului.',
        'https://www.notino.ro/nyx-cosmetics/matte-bronzer-autobronzant/p-15797432/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=543aaf36025711ee83a500880a18ba74&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (63, 'Mega Bronzer', 24.00, 'src/img/product63.webp', 1, 0, 15, 5, 16,
        'TALC, MICA, MAGNESIUM STEARATE, KAOLIN, ETHYLHEXYL PALMITATE, PARAFFINUM LIQUIDUM (MINERAL OIL, HUILE MINERALE), DIMETHICONE, POLYBUTENE, METHYLPARABEN, PROPYLPARABEN. I+/- MAY CDNTAIN EUT CONTENIR: IRON OXIDES (CL 77491, CL 77492, CL 77499)',
        'OferiÈ›i tenului dumneavoastrÄƒ un aspect sÄƒrutat de soare cu pudra bronzantÄƒ  Makeup Revolution Mega Bronzer! Formula pudratÄƒ, compactÄƒ, cu finisaj mat oferÄƒ un aspect natural, bronzat al pielii conturÃ¢nd perfect forma feÈ›ei.',
        'FolosiÈ›i o pensulÄƒ destinatÄƒ pudrei bronzante È™i aplicaÈ›i foarte delicat pe Ã®ntreaga faÈ›Äƒ pentru un ten sÄƒrutat de soare sau utilizaÈ›i pe pomeÈ›i, deasupra frunÈ›ii, nasului È™i a bÄƒrbiei pentru a vÄƒ contura trÄƒsÄƒturile.',
        'https://www.notino.ro/makeup-revolution/mega-bronzer-autobronzant/p-15869392/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_Zn0tETZcoDsPNdLOx8H9yabvybfl42fy5ARGksk7kmp_2vvux84KxoCA3kQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (64, 'Instant Anti Age Eraser', 47.00, 'src/img/product64.webp', 1, 0, 14, 5, 14,
        'AQUA / WATER, DIMETHICONE, ISODODECANE, GLYCERIN, PEG-9 POLYDIMETHYLSILOXYETHYL DIMETHICONE, PROPYLENE GLYCOL, DISTEARDIMONIUM HECTORITE, SILICA, DIMETHICONE CROSSPOLYMER, PEG-10 DIMETHICONE, CETYL PEG/PPG-10/1 DIMETHICONE, PHENOXYETHANOL, SODIUM CHLORIDE, POLYGLYCERYL-4 ISOSTEARATE, CAPRYLYL GLYCOL, DISODIUM STEAROYL GLUTAMATE, ETHYLHEXYLGLYCERIN, CHLORPHENESIN, ALUMINUM HYDROXIDE, STEARETH-20, LYCIUM BARBARUM FRUIT EXTRACT, CHLORHEXIDINE DIGLUCONATE, SODIUM BENZOATE, N-HYDROXYSUCCINIMIDE, LACTIC ACID, POTASSIUM SORBATE, TOCOPHEROL, SODIUM CITRATE, PALMITOYL TRIPEPTIDE-1, CHRYSIN, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE',
        'Pentru un look proaspÄƒt È™i strÄƒlucitor, instantaneu. Corectorul lichid Maybelline Age Rewind camufleazÄƒ eficient cearcÄƒnele, iluminÃ¢nd vizibil zona din jurul ochilor.',
        'Pasul 1: RÄƒsuciÈ›i partea inferioarÄƒ a aplicatorului È™i corectorul Ã®mbibÄƒ buretele. Pasul 2: AplicaÈ›i o cantitate micÄƒ de corector sub ochi, pentru camuflarea cearcÄƒnelor. Pasul 3: Pentru iluminarea Ã®ntregii zone perioculare, aplicaÈ›i produsul Ã®n triunghi, sub ochi È™i de-a lungul marginilor nasului.',
        'https://www.notino.ro/maybelline/age-rewind-corector-lichid/p-638287/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=76084b1a025711ee826521b80a18b8f9&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (65, 'Can\'t Stop Won\'t Stop', 47.00, 'src/img/product65.webp', 1, 0, 10, 5, 14,
        'WATER/AQUA/EAU, CYCLOPENTASILOXANE, METHYL METHACRYLATE CROSSPOLYMER, CYCLOHEXASILOXANE, BUTYLENE GLYCOL, PEG-10 DIMETHICONE, TRIMETHYLSILOXYSILICATE, POLYGLYCERYL-3 POLYDIMETHYLSILOXYETHYL DIMETHICONE, SILICA DIMETHYL SILYLATE [NANO], SODIUM CHLORIDE, TRIETHOXYCAPRYLYLSILANE, DIMETHICONE, DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER, ALUMINUM HYDROXIDE, DISODIUM EDTA, PROPYLENE CARBONATE, DISTEARDIMONIUM HECTORITE, ETHYLHEXYLGLYCERIN, CETYL PEG/PPG-10/1 DIMETHICONE, TOCOPHEROL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, PHENOXYETHANOL. MAY CONTAIN / PEUT CONTENIR (+/-)IRON OXIDES (CI 77491, CI 77492, CI 77499), TITANIUM DIOXIDE (CI 77891).', 'AcoperÄƒ imperfecÈ›iunile, accentueazÄƒ atuurile È™i trÄƒsÄƒturile naturale ale feÈ›ei È™i ilumineazÄƒ tenul - toate acestea sunt atributele corectorului lichid NYX Professional Makeup Canâ€˜t Stop Wonâ€˜t Stop. Este foarte pigmentat, de aceea acoperÄƒ excelent coÈ™urile È™i alte imperfecÈ›iuni. Este minunat È™i la iluminarea zonei obosite de sub ochi È™i, Ã®n plus, se usucÄƒ producÃ¢nd un finisaj mat, deci aratÄƒ mereu natural.

        Corectorul multifuncÈ›ional Canâ€˜t Stop Wonâ€˜t Stop este disponibil Ã®ntr-o gamÄƒ largÄƒ de nuanÈ›e, pe care le puteÈ›i combina dupÄƒ dorinÈ›Äƒ, pentru a crea o nuanÈ›Äƒ personalizatÄƒ, specialÄƒ pentru dvs. RezistÄƒ pe piele pÃ¢nÄƒ la 24 de ore, iar dvs. vÄƒ puteÈ›i bucura de un aspect perfect Ã®ntreaga zi.',
        'TapotaÈ›i uÈ™or sub ochi, pe coÈ™uri È™i pe celelalte imperfecÈ›iuni ale tenului È™i Ã®ntindeÈ›i folosind buretele sau pensula pentru corector.',
        'https://www.notino.ro/nyx-professional-makeup/cant-stop-wont-stop-corector-lichid/p-15828658/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=881df79e025711ee826521b80a18b8f9&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (66, 'True Skin', 24.00, 'src/img/product66.webp', 1, 0, 13, 5, 14,
        'AQUA (WATER), TALC, DIMETHICONE, DICAPRYLYL ETHER, CETYL PEG/PPG-10/1 DIMETHICONE, GLYCERIN, ISODODECANE, TRIMETHYLSILOXYSILICATE, SODIUM HYALURONATE, TOCOPHEROL, HYDROGEN DIMETHICONE, SODIUM CHLORIDE, MAGNESIUM SULFATE, POLYSILICONE-11, DISTEARDIMONIUM HECTORITE, STEVIA REBAUDIANA EXTRACT, PROPYLENE CARBONATE, ETHYLHEXYLGLYCERIN, LAURETH-12, ALUMINUM HYDROXIDE, PHENOXYETHANOL, SODIUM DEHYDROACETATE, POTASSIUM SORBATE, BENZOIC ACID, DEHYDROACETIC ACID, SORBIC ACID, PARFUM (FRAGRANCE), CI 77491, CI 77492, CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
        'AscundeÈ›i imperfecÈ›iunile È™i hidrataÈ›i tenul cu corectorul lichid Catrice True Skin. Are o formulÄƒ uÈ™oarÄƒ care nu Ã®ncarcÄƒ tenul È™i Ã®i oferÄƒ lejeritate Ã®n purtare. Puterea sa de acoperire este una medie spre mare, cu o rezistenÈ›Äƒ de pÃ¢nÄƒ la 18 ore. Micile imperfecÈ›iuni nu mai sunt o bÄƒtaie de cap!',
        'AplicaÈ›i corectorul pe umbrele nedorite, roÈ™eaÈ›Äƒ sau imperfecÈ›iuni. ÃŽmpingeÈ›i produsul Ã®n piele cu ajutorul bureÈ›elului de machiaj sau a degetelor.',
        'https://www.notino.ro/catrice/true-skin-machiaj-hidratant-si-natural-de-acoperire/p-16062475/?gclid=CjwKCAjwyeujBhA5EiwA5WD7_XuYMy1TnFTcSuRJwIIko7BaEUqjDvkWNBFcsCcGrH2CZSYWqm1w5BoCneEQAvD_BwE');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (67, 'Wild Hibiscus', 28.00, 'src/img/product67.webp', 1, 0, 13, 5, 26,
        'RICINUS COMMUNIS (CASTOR) SEED OIL, BIS-DIGLYCERYL POLYACYLADIPATE-1, OCTYLDODECANOL, CAPRYLIC/CAPRIC TRIGLYCERIDE, EUPHORBIA CERIFERA (CANDELILLA) WAX, SYNTHETIC WAX, CETYL ALCOHOL, COPERNICIA CERIFERA (CARNAUBA) WAX, HIBISCUS SABDARIFFA SEED OIL, BUTYROSPERMUM PARKII (SHEA) BUTTER, SILICA, TOCOPHEROL, HELIANTHUS ANNUUS (SUNFLOWER) SEED OIL, VACCINIUM MACROCARPON (CRANBERRY) SEED OIL, CAPRYLYL GLYCOL, HEXYLENE GLYCOL, LECITHIN, ASCORBYL PALMITATE, ROSMARINUS OFFICINALIS (ROSEMARY) FLOWER EXTRACT, PHENOXYETHANOL, PARFUM (FRAGRANCE), CI 15850 (RED 7 LAKE), CI 45380 (RED 21), CI 77492 (IRON OXIDES).',
        'Tratamentul special pentru buze Catrice Wild Hibiscus asigurÄƒ buze È™i mai frumoase.',
        'AplicaÈ›i o cantitate micÄƒ pe buzele curate È™i Ã®mprejurul acestora, apoi lÄƒsaÈ›i sÄƒ se absoarbÄƒ.',
        'https://www.notino.co.uk/catrice/wild-hibiscus-lip-balm/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (68, 'Hemp & Mint Glow', 28.00, 'src/img/product68.webp', 1, 0, 13, 5, 26,
        'POLYISOBUTENE, CAPRYLIC/CAPRIC TRIGLYCERIDE, CERA MICROCRISTALLINA (MICROCRYSTALLINE WAX), EUPHORBIA CERIFERA (CANDELILLA) WAX, ETHOXYDIGLYCOL, PRUNUS AMYGDALUS DULCIS (SWEET ALMOND) OIL, CANNABIS SATIVA SEED OIL, MENTHOL, TOCOPHERYL ACETATE, GLYCINE SOJA (SOYBEAN) OIL, TOCOPHEROL, CAPRYLYL GLYCOL, ETHYLHEXYL PALMITATE, GLYCERIN, CAPRYLHYDROXAMIC ACID, BETA-SITOSTEROL, SQUALENE, RICINUS COMMUNIS (CASTOR) SEED OIL, CITRIC ACID, CI 19140 (YELLOW 5 LAKE), CI 45410 (RED 27 LAKE), CI 61565 (GREEN 6). THC 0 %.',
        'TÃ¢njiÈ›i dupÄƒ buze cu aspect mai plin? FolosiÈ›i balsamul de buze Catrice Hemp & Mint Glow, cu care buzele devin instantaneu mai pline È™i mai hidratate. AccentueazÄƒ culoarea naturalÄƒ a buzelor, lÄƒsÃ¢ndu-le fine È™i moi. Mentolul are un efect plÄƒcut rÄƒcoritor.',
        'AplicaÈ›i pe buze Ã®n orice moment al zilei, dupÄƒ cum este necesar.',
        'https://www.notino.ro/catrice/hemp-mint-glow-balsam-de-buze/p-16016807/?utm_source=cj&utm_medium=affiliate&utm_campaign=4023395&utm_term=8280252&cjevent=b7313886025711ee826521b90a18b8f9&cjdata=MXxZfDB8WXww');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (69, 'Glow Play Lip Balm', 112.00, 'src/img/product69.webp', 1, 0, 16, 5, 26, '',
        'DacÄƒ tÃ¢njiÈ›i dupÄƒ efectele balsamului, dar nu vÄƒ puteÈ›i lipsi nici de ruj, alegeÈ›i un balsam nuanÈ›ator lucios, care hrÄƒneÈ™te È™i coloreazÄƒ uÈ™or buzele. Balsamul de buze nutritiv, Glow Play Lip Balm MAC Cosmetics, conÈ›ine ingrediente benefice pentru buzele dvs., precum untul de shea È™i uleiurile din seminÈ›e de mango È™i de jojoba. BucuraÈ›i-vÄƒ de buze lucioase È™i hidratate, cu o aurÄƒ de culoare seducÄƒtoare.',
        'AplicaÈ›i balsamul de buze Glow Play Lip Balm direct pe buze.',
        'https://www.notino.ro/mac-cosmetics/valentines-day-glow-play-lip-balm-balsam-de-buze-nutritiv/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (70, 'Green Edition', 51.00, 'src/img/product70.webp', 1, 0, 14, 5, 26,
        'CANOLA OIL, SQUALANE, PENTAERYTHRITYL TETRAISOSTEARATE, BIS-BEHENYL/ISOSTEARYL/PHYTOSTERYL DIMER DILINOLEYL DIMER DILINOLEATE, HELIANTHUS ANNUUS SEED CERA / SUNFLOWER SEED WAX, CAPRYLIC/CAPRIC TRIGLYCERIDE, CANDELILLA CERA / CANDELILLA WAX, TOCOPHEROL, ALUMINA, GLYCINE SOJA OIL / SOYBEAN OIL, LINALOOL, ALUMINUM HYDROXIDE, LIMONENE, HELIANTHUS ANNUUS SEED OIL / SUNFLOWER SEED OIL, MANGIFERA INDICA SEED OIL / MANGO SEED OIL, SILICA, BENZYL ALCOHOL, CITRAL, BENZYL SALICYLATE, CITRIC ACID, BARIUM SULFATE, COLOPHONIUM / ROSIN, PARFUM / FRAGRANCE, [+/- MAY CONTAIN: MICA, CI 77891 / TITANIUM DIOXIDE, CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 15850 / RED 7, CI 45380 / RED 22 LAKE, CI 45410 / RED 28 LAKE, CI 15985 / YELLOW 6 LAKE, CI 19140 / YELLOW 5 LAKE, CI 42090 / BLUE 1 LAKE, CI 15850 / RED 7 LAKE]. (F.I.L. Z281006/3).',
        'Tratamentul special pentru buze Maybelline Green Edition asigurÄƒ buze È™i mai frumoase.',
        'Se aplicÄƒ un strat uniform de culoare pe buze, folosind aplicatorul.',
        'https://www.notino.ro/maybelline/green-edition-ruj-crema-cu-efect-de-hidratare/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (71, 'Skin Naturals apa micelara', 29.00, 'src/img/product76.webp', 0, 0, 7, 5, 27,
        'AQUA/WATER, HEXYLENE GLYCOL, GLYCERIN, DISODIUM COCOAMPHODIACETATE, DISODIUM EDTA, POLOXAMER 184, POLYAMINOPROPYL BIGUANIDE (B162919/4).',
        'Apa micelara pentru ten Garnier Skin Cleansing este destinata curatarii delicate a tenului si a zonei din jurul ochilor.',
        'Apa se aplica pe un tampon de vata, cu care se curata fata.',
        'https://www.notino.ro/garnier/skin-care-apa-cu-particule-micele-pentru-piele-sensibila/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (72, 'Sensibio Gel Moussant', 63.00, 'src/img/product77.webp', 0, 0, 8, 5, 27, 'AQUA/WATER/EAU,SODIUM COCOAMPHOACETATE, PROPANEDIOL, SODIUM LAUROYL SARCOSINATE, CITRIC ACID, COCO-GLUCOSIDE,GLYCERYL OLEATE, SODIUM CITRATE,PEG-90 GLYCERYL ISOSTEARATE,MANNITOL,XYLITOL,LAURETH-2,RHAMNOSE,FRUCTOOLIGOSACCHARIDES,TOCOPHEROL,HYDROGENATED PALM GLYCERIDES CITRATELECITHINASCORBYL PALMITATE. [BI 722]
', 'Un produs bland si delicat, menit persoanelor cu pielea sensibila si atopica.',
        'Aplicati produsul pe tenul umezit si masati bland. Perfect pentru a demachia pielea sensibila.',
        'https://www.notino.ro/bioderma/sensibio/');
INSERT INTO database_web.products (product_id, name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id,
                                   ingredients, description, how_to_use, link)
VALUES (73, 'Eye & Lip Makeup Remover', 151.00, 'src/img/product78.webp', 0, 0, 12, 5, 27,
        '#16898 AQUA (WATER), PROPANEDIOL, C15-19 ALKANE, COCO-CAPRYLATE/CAPRATE, SIMMONDSIA CHINENSIS (JOJOBA) SEED OIL, CENTAUREA CYANUS FLOWER WATER, DICAPRYLYL CARBONATE, 1,2-HEXANEDIOL, LIMNANTHES ALBA (MEADOWFOAM) SEED OIL, NYMPHAEA ALBA ROOT EXTRACT, SODIUM CHLORIDE, SODIUM BENZOATE, PARFUM (FRAGRANCE), GLYCERIN, TOCOPHEROL, CITRIC ACID, POTASSIUM SORBATE.',
        'Eye and Lip Makeup Remover indeparteaza si cel mai dificil machiaj, din cele mai delicate zone, ingrijind pielea. Produsul contine extract de nufar purificator din Franta si ulei de jojoba calmant.',
        'Agitati produsul asa incat cele doua faze sa se amestece. Aplicati pe o discheta demachianta si apoi curatati pleoapele si buzele cu aceasta.',
        'https://www.notino.ro/dior/eye-lip-makeup-remover-doua-faze-pentru-indepartarea-machiajului-de-pe-ochi-si-buze/');