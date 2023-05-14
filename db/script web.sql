create database database_web;

use database_web;

drop table products;
drop table rankings;
drop table users;
drop table brands;
drop table product_types;
drop table skintypes;

create table brands(
    brand_id int not null auto_increment,
    name varchar(255) not null,
    description varchar(5000) not null,
    primary key(brand_id));

create table skintypes(
    skintype_id int not null auto_increment,
    skin_type varchar(255) not null, -- uscat gras etc
    primary key (skintype_id));

create table product_types(
    type_id int not null auto_increment,
    product_type varchar(255) not null, -- de fata de ochi etc
    usage_time enum('zi','seara','oricand'),
    usage_type varchar(255),
    primary key(type_id));

create table products(
    product_id int not null auto_increment,
    name varchar(255) not null,
    price decimal(10,2) not null,
    image_path varchar(255),
    is_makeup bool,
    age int not null,
    brand_id int not null,
    skintype_id int not null,
    type_id int not null,
    ingredients varchar(4000),
    description varchar(2000),
    how_to_use varchar(1000),
    primary key (product_id),
    foreign key (brand_id) references brands(brand_id),
    foreign key (skintype_id) references skintypes(skintype_id),
    foreign key (type_id) references product_types(type_id));
    
create table users(
    user_id int not null auto_increment,
    name varchar(255) not null,
    username varchar(255) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    age int not null,
    skintype_id int not null,
    gender enum('m','f','n'),
    location varchar(255),
    creation_time timestamp default current_timestamp,
    primary key (user_id),
    unique (username),
    unique (email),
    foreign key (skintype_id) references skintypes(skintype_id));

create table rankings(
    ranking_id int not null auto_increment,
    age_min int not null,
    age_max int not null,
    gender enum('m','f','n'),
    location varchar(255),
    type_id int not null,
    primary key (ranking_id),
    foreign key (type_id) references product_types(type_id));


INSERT INTO product_types (product_type, usage_type, usage_time) -- id 1
VALUES  ('ten', 'gel de curatare', 'oricand'), -- 1
		('ten', 'crema hidratare', 'oricand'), -- 2
        ('ten', 'exfoliant', 'oricand'), -- 3
        ('ten', 'ser', 'oricand'), -- 4
		('ten', 'ser', 'zi'), -- 5
		('ten', 'ser', 'seara'), -- 6
        ('ten', 'crema antirid', 'seara'), -- 7
		('ten', 'spf', 'zi'), -- 8
		('ochi', 'crema de ochi', 'oricand'), -- 9
        ('buze', 'crema de buze', 'oricand'), -- 10
		('buze', 'exfoliant de buze', 'oricand'), -- 11
        ('ten', 'fond de ten', 'oricand'), -- 12
		('ten', 'pudra', 'oricand'), -- 13
		('ten', 'corector', 'oricand'), -- 14
		('ten', 'iluminator', 'oricand'), -- 15
        ('ten', 'bronzer', 'oricand'), -- 16
        ('ochi', 'paleta farduri', 'oricand'), -- 17
        ('ochi', 'mascara', 'oricand'), -- 18
		('ochi', 'gel sprancene', 'oricand'), -- 19
		('ochi', 'creion sprancene', 'oricand'), -- 20
		('ochi', 'eyeliner', 'oricand'), -- 21
        ('buze', 'ruj', 'oricand'), -- 22
        ('buze', 'creion de buze', 'oricand'), -- 23
        ('buze', 'gloss', 'oricand'), -- 24
		('buze', 'ruj lichid', 'oricand'), -- 25
		('buze', 'balsam de buze', 'oricand'); -- 26
        

INSERT INTO skintypes (skin_type) 
VALUES  ('gras'), -- 1
		('normal'), -- 2
		('mixt'), -- 3
		('uscat'), -- 4
		('oricare'); -- 5

INSERT INTO brands (name, description) 
VALUES ('The Ordinary',''), -- 1
	   ('Cerave','De peste un deceniu, brandul CeraVe este lider în domeniul îngrijirii pielii, în Statele Unite. Compania dezvoltă, în colaborare cu medicii dermatologi, produse care completează, optimizează și regenerează funcția de barieră naturală a pielii.

Cheia succesului dermato-cosmeticelor CeraVe constă în compoziția unică, cu un complex de 3 ceramide naturale. Ceramidele sunt lipide care refac bariera naturală a pielii, asigurându-i o hidratare durabilă. Pielea uscată și sensibilă necesită un aport de ceramide crescut. Cosmeticele CeraVe cu tehnologia MVE® eliberează ceramidele treptat, pentru a asigura eficiența continuă a produselor, pe tot parcursul zilei.

Toate produsele CeraVe sunt foarte neagresive, non-comedogenice, neparfumate și cu o compoziție simplă. În afară de ceramide, cosmeticele CeraVe mai conțin substanțe active precum acidul hialuronic, glicerina sau colesterolul. Răsfață-ți tenul și corpul cu un demachiant, cu o loțiune sau cu o cremă hidratantă de la CeraVe - și vei vedea diferența.'), -- 2
       ('Neutrogena', 'De aproape un secol, Neutrogena oferă produse eficiente pentru îngrijirea tenului și a pielii. Istoria brandului datează din anul 1930, când Manny Stolaroff a început să furnizeze produse saloanelor de frumusețe. Momentul crucial a venit în 1954, când a aflat despre proprietățile săpunului produs de nepotul medicului personal al lui Napoleon. Săpunul nu irita pielea și se spăla ușor. Stolaroff a fost atât de fascinat de produs, încât a început să-l distribuie sub numele de Neutrogena.

Apoi mersul evenimentelor s-a accelerat. În anii 60, a fondat compania Neutrogena, următorul reper major fiind brevetarea Rețetei Norvegiene, o compoziție unică, care să răspundă cerințelor pielii expuse celor mai vitrege condiții climatice.

Astăzi, printre produsele emblematice ale brandului se numără nu numai colecția Neutrogena Visibly Renew cu Rețeta Norvegiană, ci și gama de îngrijire a pielii Neutrogena Visibly Clear sau cremele pentru mâini Neutrogena. Utilizarea unor ingrediente active și colaborarea cu dermatologi de top au permis crearea unor produse cosmetice care reflectă fidel cerințele pielii și asigură îngrijirea sa eficientă.'), -- 3
       ('Barry M','Faceți cunoștință cu Barry M, un brand britanic jucăuș, care vă cucerește cu produsele sale pline de imaginație și de culoare. Cu ele creați în joacă orice machiaj, iar ambalajele vesele vă luminează ziua. Sunteți pregătită pentru o veritabilă avalanșă de culoare?

Brandul Barry M a revoluționat literalmente industria cosmetică. A fost fondat în 1982, dar istoria sa a început să se scrie cu mult timp înainte - mai precis, de când, în curtea din fața casei părinților săi, tânărul Barry Mero vindea lacuri de unghii. Jucăușe, strălucitoare și viu colorate. Exact cele care lipseau de pe piață. Ani mai târziu, Barry fondează brandul care îi poartă numele și cucerește lumea cosmeticelor cu lacurile sale colorate. Brandul Barry M se mândrește și cu primele creioane dermatografe albe sau cu ojele fosforescente, cum nu mai vânduse nimeni până atunci.

Portofoliul acestui brand britanic conține toate cele necesare pentru un machiaj perfect - rimel, rujuri, iluminatoare și superbe palete de farduri pentru ochi. În plus, compoziția cosmeticelor Barry M mulțumește și iubitorii de animale - brandul și-a luat angajamentul ca, din anul 2020, să aibă un portofoliu compus 100 % din produse vegane.'), -- 4
       ('Loreal Paris','Cosmetice Loreal Paris | Loréal Paris este probabil cea mai faimoasa companie franceza de cosmetice din lume. Marca dateaza din 1907, atunci cand un tanar chimist Schueller Eugène a descoperit un produs de colorare a părului. Acest produs discret a dat un impuls suplimentar la inceput, iar prin testele de laborator s-a ajuns la o gama completa de produse noi si imbunatatite, care ar putea fi aplicate si pe corpul feminin. Loréal Paris a extins centrele de cercetare in doar cateva orase mari din lume. Astazi puteti regasi sub brandul Loréal Paris creme de fata, produse pentru par, parfumuri, dar si produse de make-up si altele.'), -- 5
       ('Vichy','Produsele dermato-cosmetice Vichy sunt sinonime cu calitatea în domeniul îngrijirii pielii. Sunt concepute pentru îngrijirea tuturor tipurilor de piele și de tenuri, chiar și a celor mai sensibile. Produsele din gama Vichy oferă rezultate vizibile, datorită combinației dintre substanțele active și apa termală Vichy, renumită pentru conținutul ridicat al mineralelor cu proprietăți calmante, fortifiante și regenerative.

Marca Vichy este un reprezentant tipic al convergenței de maxim succes între cosmetică și medicină. Tolerabilitatea excelentă, eficiența dovedită, formulele bazate pe cele mai noi studii, respectarea normelor etice în producție - acestea sunt atributele caracteristice produselor dermato-cosmetice Vichy.

Vichy ajută cu succes femeile din întreaga lume, la îngrijirea zilnică a pielii și a tenului. Misiunea laboratoarelor Vichy este de a dezvolta o linie completă de produse cosmetice, pentru absolut toate tipurile de piele. Portofoliul acestui brand de dermato-cosmetice oferă totul pentru o îngrijire zilnică perfectă a întregii familii. Oricare ar fi cerințele pielii tale, Vichy îți oferă soluția.'), -- 6
       ('Garnier','De peste un secol, cosmeticele Garnier influențează stilul de viață al bărbaților și al femeilor din întreaga lume. A apărut în Franța și, treptat, a devenit unul dintre cele mai respectate branduri de produse cosmetice.

Povestea sa a debutat în 1904, când coaforul Alfred Amour Garnier a creat primul tonic din plante pentru înfrumusețarea părului, primul produs Garnier care a devenit rapid un bestseller. În anul 1960 a apărut prima vopsea de păr Garnier aplicabilă acasă, femeile începând să-și privească părul ca pe un accesoriu de modă. Printre produsele care au fost îndrăgite instantaneu se numără Garnier Micellar Water, gelul purificator Garnier Pure Active Gel și vopselele Garnier Nutrisse.

Brandul Garnier este atent la dorințele clienților săi, iar produsele reflectă nevoile acestora în ceea ce privește îngrijirea tenului și a părului. Creează produse care sunt cu adevărat eficiente, ușor accesibile și facilitează ritualurile zilnice de îngrijire a frumuseții. De aceea, cosmeticele Garnier înregistrează un uriaș succes mondial, fiind disponibile în peste 120 de țări din întreaga lume.'), -- 7
       ('Bioderma','Dermato-cosmeticele Bioderma sunt bazate pe cunoașterea pielii și a mecanismelor sale biologice. Această abordare științifică garantează obținerea unor produse a căror compoziție țintește precis diverse tipuri de piele sau problemele specifice acestora. Cosmeticele Bioderma nu conțin ingrediente dermatologice nocive, precum parabeni, ftalați sau formaldehide. Toate produsele conțin numai ingrediente active pure, care se găsesc normal în piele și, de aceea, Bioderma garantează o toleranță perfectă a preparatelor sale. Toate produsele de îngrijire a tenului și a pielii au fost testate clinic și au apărut sub supravegherea experților în dermatologie, alergologie și toxicologie.

De la debutul său în anul 1970, brandul deține numeroase brevete. De exemplu, apa micelară Bioderma Sensibio este prima apă de curățare din istorie, menținându-se și astăzi printre cele mai populare. La rândul său, gama Bioderma Sébium conține complexul brevetat Fluidactiv, care luptă eficient împotriva simptomelor tenului gras și problematic.

Portofoliul brandului cuprinde și tratamente sofisticate pentru corp. Dar, mai ales, Bioderma nu oferă doar un ajutor temporar, ci rezolvă întotdeauna direct cauza reală a problemei. Și tu poți oferi tenului și pielii tale îngrijirea ideală!'), -- 8
       ('La Roche-Posay', 'Brandul francez de dermato-cosmetice La Roche-Posay este cunoscut pentru colaborarea intensă cu medicii dermatologi și pentru angajamentul de a face îngrijirea pielii mai plăcută, pentru persoanele cu pielea sensibilă. De aceea, preparatele La Roche-Posay au o compoziție minimalistă și sunt produse în condiții de control strict.

Gamele de produse La Roche-Posay sunt adaptate la cerințele specifice ale fiecărui tip de piele sensibilă și oferă soluții pentru persoanele care suferă din cauza pielii intolerante, reactive, atopice sau predispuse la acnee. Baza indispensabilă pentru fiecare preparat este apa termală din La Roche-Posay, care are proprietăți antioxidante și terapeutice și calmează instantaneu pielea sensibilă și iritată.

Calitatea produselor dermato-cosmetice La Roche-Posay este demonstrată nu numai de rezultatele documentate ale studiilor clinice, ci și de numeroasele recomandări ale dermatologilor de top.'), -- 9
       ('NYX Proffesional Makeup','Brandul de cosmetice decorative NYX Professional Makeup a fost fondat în 1999, în Los Angeles, de către artista în machiaj Toni Ko. NYX Professional Makeup reflectă cele mai recente tendinţe din machiaj. Portofoliul mărcii este cuprinzător: de la ruj şi produse pentru machiaj, până la pensule cosmetice profesionale.
NYX Professional Makeup sunt produse de înaltă calitate, la preţuri competitive, care se bucură de popularitate în rândul artiştilor în machiaj profesionişti. NYX Professional Makeup oferă nu numai un machiaj frumos, ci şi ambalaje elegante. Ambalajele deosebite completează imaginea brandului NYX Professional Makeup, care este popular în întreaga lume.
Produsele NYX Professional Makeup sunt bogate în pigmenţi, asigură un machiaj rezistent şi permit o abordare amuzantă a jocului de culori. Găsiţi-vă machiajul perfect şi deveniţi un profesionist în machiaj. NYX Professional Makeup nu testează produsele pe animale.'), -- 10
       ('MUA Makeup Academy',''), -- 11
       ('DIOR','Atunci cand Christian Dior a creat casa de moda in 1946, el si-a imaginat o noua feminitate, o feminitate absoluta. Astazi, de la rochii la accesorii, de la parfumuri la rujuri si pana la produse de ingrijire a tenului, Casa Dior ofera femeilor o frumusete sublima, stralucitoare si moderna.'), -- 12
       ('Catrice', 'Întotdeauna trendy, de bună calitate și accesibile ca preț. Acestea sunt cosmeticele Catrice, mereu în tendințe. Astfel, puteți fi sigură că produsele Catrice vă ajută să realizați un look ca de la cele mai recente prezentări de modă.  

Brandul Catrice a fost fondat de Christina Oster-Daum, o lady cu o viziune clară. Aceea de a realiza cosmetice de calitate, pe care să și le poată permite absolut orice femeie. Pentru că fiecare dintre noi merită să se simtă frumoasă. Și astfel, în anul 2004, au apărut primul fond de ten, primul rimel, prima pudră Catrice și alte produse necesare unui machiaj fără cusur. 

Tipic pentru cosmeticele Catrice sunt calitatea de primă clasă și urmărirea celor mai noi tendințe din lumea frumuseții. Printre produsele emblematice ale acestui brand german se numără fondul de ten Catrice HD Liquid Coverage, opac dar cu efect natural, corectorul Catrice Liquid Camouflage, care camuflează toate imperfecțiunile, sau pudra cu efect matifiant Catrice All Matt Plus. Merită menționate și baza de machiaj cu efect nuanțator lejer Catrice 1 Minute Face Perfector, popularul lac de unghii Catrice More Than Nude și rujul de buze Catrice, în cele mai diverse nuanțe.'), -- 13
       ('Maybelline', 'Povestea brand-ului Maybelline începe în anul 1915, când tânăra americancă Mabel Williams a preparat un produs original pentru fardarea ochilor. Fratele său Thomas a fost atât de încântat de această descoperire, încât a fondat compania Maybell Laboratories şi a început vânzarea rimelurilor. Nu a durat mult şi femeile din toate statele americane au început să solicite produsele Maybelline. La mijlocul anilor ‘90, Maybelline a devenit parte integrantă din gigantul L’Oreal Group. Scopul său a rămas însă acelaşi: de a le oferi clienţilor cosmetice decorative de calitate şi la preţuri accesibile
În prezent, Maybelline se poate mândri prin colaborarea cu creatori de top din lumea modei, pentru a determina noi trenduri în domeniul frumuseţii. Acest brand se străduieşte neîncetat să-şi înnoiască portofoliul. Fardurile de ochi, lacurile de unghii, luciurile de buze, ca şi toate celelalte produse Maybelline se aplică uşor şi au o acţiune de lungă durată. Sunt de efect şi, nu în ultimul rând, sigure. Datorită acestor proprietăţi se bucură de o mare popularitate printre stiliştii profesionişti.
Cosmetica Maybelline este simbolul machiajului perfect. Mărturie a calităţilor sale excepţionale stă şi faptul că este utilizată de multe modele faimoase – cum ar fi Miranda Kerr, Gigi Hadid sau Adriana Lima. Marca Maybelline le va atrage cu siguranţă pe toate clientele care doresc să-şi sublinieze stilul personal, iubesc fardurile şi doresc să fie atrăgătoare pentru sexul opus.'), -- 14
       ('Makeup Revolution', 'Cosmeticele decorative Makeup Revolution reprezintă o adevărată revoluție în domeniul machiajului. Brandul londonez deține în portofoliu o gamă largă de produse de înaltă calitate, dar la prețuri accesibile, care te vor încânta.

Deosebit de populare sunt paletele de farduri de lux, care se disting prin pigmentarea intensă și prin combinațiile inovative de culori. Din arsenalul tău nu trebuie să lipsească măcar una dintre acestea. Oferta brandului conține însă și alte bijuterii cosmetice. De exemplu, nu trebuie să ratezi fondul de ten Makeup Revolution sau emblematicul corector Makeup Revolution, disponibil în mai multe variante, pentru aproape fiecare nuanță de ten.

Nu în ultimul rând, brandul atrage prin designul original și jucăuș, dar și practic, al produselor sale. Conferă machiajului tău stil și originalitate, cu Makeup Revolution London!'), -- 15
       ('MAC Cosmetics', 'Cosmetica decorativă profesională M·A·C dictează, de mulți ani, tendințele globale în culisele modei. Colaborează cu personalități proeminente ale artei, ale modei și ale culturii pop și își asumă motto-ul „Toate vârstele, toate rasele, toate genurile". Pentru milioane de oameni, a devenit mult mai mult decât un simplu brand de beauty.

Make-up Art Cosmetics s-a născut la Toronto, în Canada. Impulsul pentru apariția sa l-a constituit calitatea insuficientă a produselor de machiaj disponibile în acel moment în magazine. Artistul de machiaj și fotograful Frank Toskan, împreună cu Frank Angelo, proprietarul unui salon de coafură, au creat o colecție proprie de cosmetice decorative. Aceasta îndeplinea cele mai exigente cerințe ale fotografiei de modă și ale machiajului de artă, având în industria cosmetică efectul unui cutremur.

Bogăția unică a gamei de farduri, combinația de glamour și eleganță cu caracterul practic și „street style“, artiști de machiaj în locul vânzătorilor clasici și puțin spirit rebel - toate aceste atuuri au creat admirație și imaginea calității inovatoare pentru cosmeticele MAC. Astăzi, brandul este reprezentat în 90 de țări și lansează în fiecare an peste 50 de colecții.'), -- 16
       ('Estee Lauder' , 'Cosmeticele Estée Lauder poartă numele fondatoarei, care, în secolul al XX-lea, a revoluționat lumea frumuseții. Ca nepoată de farmacist, Estée era familiarizată cu producția cosmeticelor încă din copilărire, așa că prima ei cremă nu s-a lăsat prea mult așteptată. În 1946, Estée Lauder a demarat vânzarea propriilor produse.

Brandul Estée Lauder a fost construit pe principiile pasiunii, ale dăruirii și ale perseverenței. Estée vizita adesea saloanele de frumusețe din întreg orașul New York, brandul a prosperat datorită recomandărilor clienților direcți, iar tratamentele pentru ten Estée Lauder au devenit faimoase.

Mica firmă s-a dezvoltat treptat într-un brand de calitate, de talie internațională. Emblematicul fond de ten de la Estée Lauder este, pentru multe femei, o parte integrantă a arsenalului cosmetic, iar crema de față Estée Lauder este, datorită ingredientelor luxoase și abordării științifice, cel mai eficient răsfăț pentru pielea ta. Filosofia brandului Estée Lauder este simplă: fiecare femeie poate fi frumoasă, indiferent de vârstă.'); -- 17
    

INSERT INTO products (name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id, ingredients, description, how_to_use)
VALUES 
('Salicylic Acid 2% Solution', 41.00, 'src/img/product1.webp', 0, 0, 1, 5, 6, 
'AQUA (WATER). SACCHARIDE ISOMERATE. COCAMIDOPROPYL DIMETHYLAMINE. SALICYLIC ACID. HYDROXYETHYLCELLULOSE. POLYSORBATE 20. CITRIC ACID. SODIUM CITRATE. SODIUM HYDROXIDE. PHENOXYETHANOL. CHLORPHENESIN.',
'Serul facial The Ordinary Salicylic Acid 2% Solution este un produs cu un conținut de substanțe active ridicat. De aceea, oferă tenului cea mai luxoasă îngrijire.',
'Cu vârfurile degetelor, se tapotează o cantitate adecvată de ser, pe tenul curat.'), -- 1

 ('Hyaluronic Acid 2% + B5', 51.00, 'src/img/product2.webp', 0, 0, 1, 5, 4, 
'AQUA (WATER), SODIUM HYALURONATE, SODIUM HYALURONATE CROSSPOLYMER, PANTHENOL, AHNFELTIA CONCINNA EXTRACT, GLYCERIN, PENTYLENE GLYCOL, PROPANEDIOL, POLYACRYLATE CROSSPOLYMER-6, PPG-26-BUTETH-26, PEG-40 HYDROGENATED CASTOR OIL, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, CITRIC ACID, ETHOXYDIGLYCOL, CAPRYLYL GLYCOL, HEXYLENE GLYCOL, ETHYLHEXYLGLYCERIN, PHENOXYETHANOL, CHLORPHENESIN.',
'Eliminați aspectul uscat al tenului, asperitățile și ridurile. Vă va ajuta în acest sens îngrijirea cu acid hialuronic The Ordinary Hyaluronic Acid 2% + B5 Hydration Support Formula care asigură atât o hidratare instantanee, cât și menținerea nivelului ideal de hidratare a tenului pe termen lung. Datorită hidratării intense, tenul va avea un aspect plin, textura neuniformă va fi netezită și ridurile vor fi reduse.',
'Folosiți îngrijirea hidratantă cu acid hialuronic The Ordinary Hyaluronic Acid 2% + B5 Hydration Support Formula dimineața și seara, după curățarea tenului și înainte de aplicarea cremei hidratante. Folosiți o pipetă pentru a aplica câteva picături pe față și estompați. În caz de iritație, spălați imediat, întrerupeți utilizarea și consultați medicul. Aplicați numai pe tenul sănătos. Efectuați la început un test de toleranță.'), -- 2

('AHA 30% + BHA 2% Peeling Solution', 50.00, 'src/img/product3.webp', 0, 0, 1, 5, 6,
'GLYCOLIC ACID. AQUA (WATER). ALOE BARBADENSIS LEAF WATER. SODIUM HYDROXIDE. DAUCUS CAROTA SATIVA EXTRACT. PROPANEDIOL. COCAMIDOPROPYL DIMETHYLAMINE. SALICYLIC ACID. LACTIC ACID. TARTARIC ACID. CITRIC ACID. PANTHENOL. SODIUM HYALURONATE CROSSPOLYMER. TASMANNIA LANCEOLATA FRUIT/LEAF EXTRACT. GLYCERIN. PENTYLENE GLYCOL. XANTHAN GUM. POLYSORBATE 20. TRISODIUM ETHYLENEDIAMINE DISUCCINATE. POTASSIUM SORBATE. SODIUM BENZOATE. ETHYLHEXYLGLYCERIN. 1.2-HEXANEDIOL. CAPRYLYL GLYCOL.',
'Peelingul chimic The Ordinary AHA 30% + BHA 2% Peeling Solution asigură o exfoliere atât la suprafață, cât și în profunzimea tenului. Acționează cu o intensitate deosebit de ridicată, însă, datorită ingredientelor hidratante pe care le conține și a faptului că valorile pKa și pH sunt echilibrate, riscul iritațiilor este minimizat. Peelingul ajută la deblocarea porilor colmatați și la netezirea texturii neuniforme de la suprafață, conferind tenului un aspect mai luminos și o nuanță mai uniformă.',
'Aplicați peelingul The Ordinary AHA 30% + BHA 2% Peeling Solution 1–2× pe săptămână, de preferință seara, pe tenul curățat bine și uscat. Nu se utilizează pe tenul umed. Cu ajutorul vârfurilor degetelor, întindeți uniform pe față și pe gât. Nu aplicați pe tenul sensibil, descuamat sau deteriorat, evitați conturul ochilor și contactul direct cu ochii. Se lasă să acționeze timp de maximum 10 minute, nu mai mult, apoi se clătește bine cu apă călduță.'), -- 3

 ('Cleansers emulsie pentru curatare cu efect de hidratare', 54.00, 'src/img/product4.webp', 0, 0, 2, 2, 1, 
'AQUA / WATER, GLYCERIN, CETEARYL ALCOHOL, PHENOXYETHANOL, STEARYL ALCOHOL, CETYL ALCOHOL, PEG-40 STEARATE, BEHENTRIMONIUM METHOSULFATE, GLYCERYL STEARATE, POLYSORBATE 20, ETHYLHEXYLGLYCERIN, POTASSIUM PHOSPHATE, DISODIUM EDTA, DIPOTASSIUM PHOSPHATE, SODIUM LAUROYL LACTYLATE, CERAMIDE NP, CERAMIDE AP, PHYTOSPHINGOSINE, CHOLESTEROL, SODIUM HYALURONATE, XANTHAN GUM, CARBOMER, TOCOPHEROL, CERAMIDE EOP (F.I.L. D214629/3).',
'Demachiere delicată fără iritare? Emulsia de curățare CeraVe Hydrating Cleanser cu efect de hidratare elimină eficient fondul de ten și impuritățile de pe față și decolteu, fără a perturba bariera naturală și umiditatea pielii. Textura ușoară și cremoasă lasă tenul absolut curat și hidratat.',
'Se masează o cantitate adecvată de produs pe pielea umezită, și cu mișcări circulare se înlătură fondul de ten și impuritățile. Se clătește foarte bine cu apă.'), -- 4

 ('Moisturizers loțiune hidratantă pentru corp și față pentru pielea uscata sau foarte uscata', 110.00, 'src/img/product5.webp', 0, 0, 2, 4, 2, 
'AQUA / WATER, GLYCERIN, CAPRYLIC/CAPRIC TRIGLYCERIDE, CETEARYL ALCOHOL, CETYL ALCOHOL, DIMETHICONE, PHENOXYETHANOL, POLYSORBATE 20, CETEARETH-20, BEHENTRIMONIUM METHOSULFATE, POLYGLYCERYL-3 DIISOSTEARATE, SODIUM LAUROYL LACTYLATE, ETHYLHEXYLGLYCERIN, POTASSIUM PHOSPHATE, DISODIUM EDTA, DIPOTASSIUM PHOSPHATE, CERAMIDE NP, CERAMIDE AP, PHYTOSPHINGOSINE, CHOLESTEROL, XANTHAN GUM, CARBOMER, SODIUM HYALURONATE, TOCOPHEROL, CERAMIDE EOP (F.I.L. D213778/1).',
'Doriți o îngrijire pentru pielea uscată, eficientă întreaga zi? Loțiunea pentru față și corp CeraVe Moisturizing Lotion hidratează intens și promovează activ regenerarea barierei cutanate de protecție naturală.',
'Se aplică uniform și se masează în pielea feței sau a corpului. Se repetă după dorință.'), -- 5

 ('Hydro Boost® Face exfoliant facial pentru netezirea pielii', 31.00, 'src/img/product6.webp', 0, 0, 3, 5, 3, 
'AQUA, SODIUM C14-16 OLEFIN SULFONATE, COCAMIDOPROPYL HYDROXYSULTAINE, GLYCERIN, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, ACRYLATES CROSSPOLYMER-4, CELLULOSE, CARICA PAPAYA FRUIT EXTRACT, HYDROLYZED HYALURONIC ACID, SODIUM CHLORIDE, POLYSORBATE 20, DISODIUM TETRAPROPENYL SUCCINATE, DISODIUM EDTA, CITRIC ACID, GLYCOLIC ACID, LACTIC ACID, SODIUM HYDROXIDE, PHENOXYETHANOL, SODIUM BENZOATE, PARFUM.',
'Exfoliantul pentru față Neutrogena Hydro Boost®, cu conținut mare de microparticule, netezește vizibil pielea, îndepărtează impuritățile și hidratează intens.',
'Peelingul se aplică în fiecare dimineață pe tenul umezit și se masează ușor, cu mișcări circulare. Apoi se clătește atent cu apă. Se va evita zona ochilor.'), -- 6

('Clear & Defend exfoliant facial pentru netezirea pielii', 38.00, 'src/img/product7.webp', 0, 0, 3, 5, 3, 
'AQUA, SODIUM C14-16 OLEFIN SULFONATE, COCAMIDOPROPYL HYDROXYSULTAINE, SORBITOL, CELLULOSE, SALICYLIC ACID, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, ACRYLATES CROSSPOLYMER-4, C12-15 ALKYL LACTATE, PANTHENOL, COCAMIDOPROPYL PG-DIMONIUM CHLORIDE PHOSPHATE, TALC, DISODIUM TETRAPROPENYL SUCCINATE, CERA MICROCRISTALLINA, SODIUM CHLORIDE, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, BENZALKONIUM CHLORIDE, PARFUM, CI 19140, CI 73360.',
'Pentru o piele sănătoasă, fără pete și fără probleme, NEUTROGENA vine cu un exfoliant excepțional Clear & Defend Facial Scrub care curăță cu grijă și protejează pielea. Rezultate vizibile încă de la prima utilizare.',
'A se aplica o dată pe zi. Masați pe fața umedă, apoi clătiți bine.'), -- 7

('Clear & Radiant exfoliant facial revigorant', 29.00, 'src/img/product8.webp', 0, 0, 3, 2, 3, 
'AQUA, GLYCERIN, SODIUM LAURETH SULFATE, CELLULOSE, LAURYL GLUCOSIDE, ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER, CITRUS GRANDIS FRUIT EXTRACT, PROPYLENE GLYCOL, SODIUM BENZOTRIAZOLYL BUTYLPHENOL SULFONATE, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, SODIUM ASCORBYL PHOSPHATE, SODIUM BENZOATE, PARFUM, CI 16035, CI 60725.',
'Exfoliatorul pentru ten Neutrogena Clear & Radiant curăță tenul în profunzime, îl netezește și elimină toate impuritățile.',
'Se aplică pe fața umedă, prin masaj delicat și se clătește atent cu apă. Se utilizează 1- 3x săptămânal.'), -- 8

('Lip Scrub Watermelon Exfoliant pentru buze', 41.00, 'src/img/product9.webp', 0, 0, 4, 5, 11, 
'SUCROSE, OLEA EUROPAEA (OLIVE) FRUIT OIL, TOCOPHERYL ACETATE, PARFUM, SIMMONDSIA CHINENSIS (JOJOBA) SEED OIL, PERSEA GRATISSIMA (AVOCADO) OIL, CRAMBE ABYSSINICA SEED OIL, LINALOOL, RED 7 LAKE (CI 15850), RED 27 LAKE (CI 45410).',
'Exfoliantul de buze Barry M Lip Scrub Watermelon vă va oferi buze perfect catifelate în cel mai scurt timp. Particulele fine îndepărtează delicat, dar eficient, pielea uscată și moartă. Uleiurile naturale și vitamina E conținute în exfoliant conferă hidratare și lasă buzele minunat de delicate. Mirosul dulce și suculent al pepenelui va face ca procedura de exfoliere să fie cât se poate de plăcută. ',
'Aplicați exfoliantul de buze Barry M Lip Peel pe buzele uscate, masați ușor și apoi clătiți. Se utilizează în funcție de necesitate. '), -- 9

('Lip Scrub Exfoliant pentru buze', 35.00, 'src/img/product10.webp', 0, 0, 4, 5, 11, 
'SUCROSE, OLEA EUROPAEA (OLIVE) FRUIT OIL, TOCOPHERYL ACETATE, FLAVOUR, SIMMONDSIA CHINENSIS (JOJOBA) SEED OIL, PERSEA GRATISSIMA (AVOCADO) OIL, CRAMBE ABYSSINICA SEED OIL, RED 40 (CI 16035), RED 28 (CI 45410).',
'Exfoliantul de buze Barry M este îmbogățit cu vitamina E, ulei de avocado și ulei de jojoba pentru hidratare și catifelare maximă. Aveți grijă de buzele dvs. în mod regulat, acestea vă vor răsplăti cu un aspect frumos, neted și luxuriant. ',
'Dimineața și seara, aplicați o cantitate mică de exfoliant pe buze, masați ușor și apoi clătiți. '), -- 10

('Retinol Boost crema anti rid pentru ochi', 81.00, 'src/img/product11.webp', 0, 35, 3, 5, 9, 
'AQUA, PENTAERYTHRITYL TETRAETHYLHEXANOATE, DIMETHICONE, GLYCERIN, PPG-15 STEARYL ETHER, STEARYL ALCOHOL, CETEARYL ALCOHOL, BUTYLENE GLYCOL, CETEARETH-20, ISOHEXADECANE, RETINOL, HYDROLYZED MYRTUS COMMUNIS LEAF EXTRACT, CAPRYLIC/CAPRIC TRIGLYCERIDE, ETHYLHEXYLGLYCERIN, SODIUM HYALURONATE, CAPRYLYL GLYCOL, POLYACRYLAMIDE, CELLULOSE, C13-14 ISOPARAFFIN, LAURETH-7, DIMETHICONE CROSSPOLYMER, AMMONIUM ACRYLOYLDIMETHYLTAURATE/VP COPOLYMER, DISODIUM EDTA, SODIUM HYDROXIDE, BHT, ASCORBIC ACID, PHENOXYETHANOL, CHLORPHENESIN.',
'Căutați o cremă realmente eficientă, cu rezultate confirmate științific? Oferiți tenului dvs. un aspect mai tânăr și mai sănătos ‒ eficacitatea este confirmată de dermatologi la 100 % dintre cei testați*. Crema anti-îmbătrânire pentru ochi, Neutrogena Retinol Boost, nu conține parfum; se absoarbe foarte repede după aplicare, eliberând retinolul pur direct în straturile superioare ale tenului. ',
'O dată pe zi, aplicați trei picături mici de cremă pe zona de sub ochi, tapotând ușor conturul ochilor. Evitați contactul direct cu ochii.'), -- 11

('Liftactiv Collagen Specialist crema anti-rid intensiva', 185.00, 'src/img/product12.webp', 0, 35, 6, 5, 9, 
'AQUA / WATER / EAU • GLYCERIN • DIMETHICONE • SILICA • ISOHEXADECANE • ALCOHOL DENAT. • HYDROXYETHYLPIPERAZINE ETHANE SULFONIC ACID • NIACINAMIDE • PROPANEDIOL • SYNTHETIC WAX • PEG-10 DIMETHICONE • HYDROLYZED RICE PROTEIN • SODIUM PHYTATE • ADENOSINE • HYDROXYACETOPHENONE • PALMITOYL TETRAPEPTIDE-7 • PALMITOYL TRIPEPTIDE-1 • SODIUM HYDROXIDE • ASCORBYL GLUCOSIDE • DISTEARDIMONIUM HECTORITE • BUTYLENE GLYCOL • CAPRYLIC/CAPRIC TRIGLYCERIDE • CAPRYLYL GLYCOL • CARBOMER • CETEARETH-6 • CI 77891 / TITANIUM DIOXIDE • PEG-30 DIPOLYHYDROXYSTEARATE • PENTYLENE GLYCOL • POLYSORBATE 20 • PROPYLENE CARBONATE • SODIUM ACRYLATES COPOLYMER • SODIUM CITRATE • SODIUM LACTATE • SORBITAN OLEATE • STEARYL ALCOHOL • SYNTHETIC FLUORPHLOGOPITE • TOCOPHEROL • ZEA MAYS STARCH / CORN STARCH • DIMETHICONE/PEG-10/15 CROSSPOLYMER • DIMETHICONE/POLYGLYCERIN-3 CROSSPOLYMER • CI 15985 / YELLOW 6 • DIPROPYLENE GLYCOL • PARFUM / FRAGRANCE (F.I.L. N284487/1).',
'Odată cu vârsta, fibrele de colagen de la nivelul tenului se degradează. Crema intensivă antirid Vichy Liftactiv Collagen Specialist va împiedica acest lucru, oferind astfel fermitate tenului. Va corecta orice semne de pierdere de colagen datorită peptidelor pro-colagen, care sunt de 3 ori mai abundente decât în produsele obișnuite. Va lăsa tenul neted, hidratat și cu mai puține riduri vizibile.',
'Aplicați crema antirid Vichy Liftactiv Collagen Specialist dimineața, pe tenul curat și uscat, singură sau după aplicarea serului cu vitamina C Vichy Liftactiv. Evitați zona din jurul ochilor.'), -- 12

('Age Specialist 35+ crema de noapte antirid', 47.00, 'src/img/product13.webp', 0, 35, 5, 5, 9, 
'AQUA / WATER, GLYCERIN, ISOHEXADECANE, DIMETHICONE, ALUMINUM STARCH OCTENYLSUCCINATE, ISOPROPYL ISOSTEARATE, PROPYLENE GLYCOL, OXIDIZED STARCH ACETATE, OCTYLDODECANOL, CETYL ALCOHOL, BEHENYL ALCOHOL, ADENOSINE, ATELOCOLLAGEN, CAPRYLOYL SALICYLIC ACID, PENTAERYTHRITYL TETRAISOSTEARATE, SODIUM CHONDROITIN SULFATE, SODIUM HYALURONATE, TRIETHANOLAMINE, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, CAMELLIA OLEIFERA SEED OIL, BUTYLENE GLYCOL, CAPRYLYL GLYCOL, CETEARYL ALCOHOL, CETEARYL GLUCOSIDE, MYRISTIC ACID, PALMITIC ACID, PEG-100 STEARATE, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, SODIUM POLYACRYLATE, SODIUM STEAROYL GLUTAMATE, SOLUBLE COLLAGEN, STEARIC ACID, TOCOPHEROL, TRISODIUM EDTA, XANTHAN GUM, ALPHA-ISOMETHYL IONONE, BENZYL ALCOHOL, BENZYL SALICYLATE, CITRONELLOL, HEXYL CINNAMAL, LINALOOL, HEXYLENE GLYCOL, PHENOXYETHANOL, POTASSIUM SORBATE, PARFUM / FRAGRANCE (F.I.L. Z284743/1).',
'Prevenția este esențială în lupta împotriva ridurilor. Crema de noapte antirid L’Oréal Paris Age Specialist 35+ oferă o acțiune intensă anti-îmbătrânire ce ajută la netezirea ridurilor și liniilor fine. Formula bogată tonifică și hidratează tenul 24 de ore, conferindu-i o strălucire sănătoasă cu efect de lungă durată. Cu o utilizare continuă celulele pielii sunt hrănite, astfel încât să nu încetinească procesul natural de regenerare, odată cu înaintarea în vârstă.',
'Aplicați crema L’Oréal Paris Age Specialist 35+ în fiecare seară pe tenul curat și uscat, apoi masați cu mișcări delicate.'), -- 13

('Skin Naturals Vitamin C crema de ochi iluminatoare cu vitamina C', 47.00, 'src/img/product14.webp', 0, 0, 7, 5, 9, 
'919144 30 - INGREDIENTS: AQUA / WATER • GLYCERIN • DIMETHICONE • PRUNUS ARMENIACA KERNEL OIL / APRICOT KERNEL OIL • NIACINAMIDE • ACRYLAMIDE/SODIUM ACRYLOYLDIMETHYLTAURATE COPOLYMER • SILICA • CI 77891 / TITANIUM DIOXIDE • ISOHEXADECANE • DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER • HYDROXYPROPYL TETRAHYDROPYRANTRIOL • CAFFEINE • SYNTHETIC FLUORPHLOGOPITE • PROPYLENE GLYCOL • PHENOXYETHANOL • ACRYLATES/C10-30 ALKYL ACRYLATE CROSSPOLYMER • TOCOPHEROL • CHLORPHENESIN • POLYSORBATE 80 • ASCORBYL GLUCOSIDE • TRIETHANOLAMINE • CI 77492 / IRON OXIDES • TRISODIUM ETHYLENEDIAMINE DISUCCINATE • MUSA SAPIENTUM FRUIT EXTRACT / BANANA FRUIT EXTRACT • ADENOSINE • HYDROLYZED HYALURONIC ACID • HYDROXYETHYLPIPERAZINE ETHANE SULFONIC ACID • MICA • SORBITAN OLEATE • MUSA PARADISIACA FRUIT JUICE / BANANA FRUIT JUICE • ANANAS SATIVUS FRUIT EXTRACT / PINEAPPLE FRUIT EXTRACT • CITRIC ACID • SODIUM BENZOATE • DISODIUM STEAROYL GLUTAMATE • LACTIC ACID • TIN OXIDE • POTASSIUM SORBATE • ALUMINUM HYDROXIDE (F.I.L. Z70015852/1).',
'Tratamentul pentru ochi Garnier Skin Naturals Vitamin C îngrijește pielea din jurul ochilor, oferindu-i nutriția și hidratarea necesare.',
'Produsul se aplică în jurul ochilor dimineața și/sau seara, prin tapotare cu degetele, până la absorbție.'), -- 14

('Sébium Gel Moussant gel de curățare pentru ten gras și mixt', 76.00, 'src/img/product15.webp', 0, 0, 8, 1, 1, 
'',
'Gelul de curățare Bioderma Sébium Gel Moussant este destinat curățării minuțioase și blânde a tenurilor grase și mixte. Gelul este compus din substanțe non-iritante și nu conține săpun, fiind, prin urmare, foarte bine tolerat de piele. După utilizarea gelului de curățare Bioderma Sébium Gel Moussant, tenul va fi perfect curat, fără pori astupați și sebum în exces.',
'Folosiți gelul de spălat dimineața și seara, pe fața umedă, spumați, clătiți bine și uscați.'), -- 15

('Effaclar gel de curatare pentru ten sensibil', 65.00, 'src/img/product16.webp', 0, 0, 9, 1, 1, 
'AQUA / WATER, SODIUM LAURETH SULFATE, PEG-8, COCO-BETAINE, HEXYLENE GLYCOL, SODIUM CHLORIDE, PEG-120 METHYL GLUCOSE DIOLEATE, ZINC PCA, SODIUM HYDROXIDE, CAPRYLYL GLYCOL, CITRIC ACID, SODIUM BENZOATE, PHENOXYETHANOL, PARFUM / FRAGRANCE (F.I.L. B193153/1).',
'Vă deranjează acneea și problemele cu pielea? În acest caz, din baie nu trebuie să vă lipsească gelul pentru curățare profundă La Roche-Posay Effaclar. Gelul curăță toate impuritățile și sebumul în exces, fără a usca tenul. Lasă fața curată și fresh.',
'Spălați-vă foarte bine pe mâini și pe unghii, înainte de a atinge fața. Folosiți apă călduță, care dilatează porii. Spumați gelul în mâini cu puțină apă și aplicați-l pe față, masând ușor. Concentrați-vă asupra zonei T și a gâtului. Clătiți fața cu apă rece, pentru a contracta porii. Apoi uscați tenul cu un prosop curat, prin apăsarea sa ușoară pe față, fără a freca.'), -- 16

('Hydro Boost® Face gel de curatare facial', 35.00, 'src/img/product17.webp', 0, 0, 3, 5, 1, 
'AQUA, GLYCERIN, COCAMIDOPROPYL HYDROXYSULTAINE, SODIUM COCOYL ISETHIONATE, SODIUM METHYL COCOYL TAURATE, SODIUM HYDROLYZED POTATO STARCH DODECENYLSUCCINATE, HYDROLYZED HYALURONIC ACID, ETHYLHEXYLGLYCERIN, LINOLEAMIDOPROPYL PG-DIMONIUM CHLORIDE PHOSPHATE, POLYQUATERNIUM-10, POLYSORBATE 20, SODIUM ISETHIONATE, SODIUM LAURYL SULFATE, SODIUM C14-16 OLEFIN SULFONATE, POTASSIUM ACRYLATES COPOLYMER, SODIUM CHLORIDE, PROPYLENE GLYCOL, DISODIUM EDTA, CITRIC ACID, SODIUM HYDROXIDE, HYDROXYACETOPHENONE, TOCOPHERYL ACETATE, PHENOXYETHANOL, PARFUM.',
'Gelul de curățare Neutrogena Hydro Boost® oferă tenului o îngrijire complexă. Demachiază tenul și îndepărtează toate impuritățile, lăsându-l curat și intens hidratat.',
'Gelul se aplică pe fața umedă și se masează circular, pentru a forma o spumă. Se lasă să acționeze scurt timp și se clătește bine cu apă.'), -- 17

('Natural Moisturizing Factors + HA crema de fata hidratanta', 78.00, 'src/img/product18.webp', 0, 0, 1, 5, 2, 
'AQUA (WATER). CAPRYLIC/CAPRIC TRIGLYCERIDE. CETYL ALCOHOL. PROPANEDIOL. STEARYL ALCOHOL. GLYCERIN. SODIUM HYALURONATE. ARGININE. ASPARTIC ACID. GLYCINE. ALANINE. SERINE. VALINE. ISOLEUCINE. PROLINE. THREONINE. HISTIDINE. PHENYLALANINE. GLUCOSE. MALTOSE. FRUCTOSE. TREHALOSE. SODIUM PCA. PCA. SODIUM LACTATE. UREA. ALLANTOIN. LINOLEIC ACID. OLEIC ACID. PHYTOSTERYL CANOLA GLYCERIDES. PALMITIC ACID. STEARIC ACID. LECITHIN. TRIOLEIN. TOCOPHEROL. CARBOMER. ISOCETETH-20. POLYSORBATE 60. SODIUM CHLORIDE. CITRIC ACID. TRISODIUM ETHYLENEDIAMINE DISUCCINATE. PENTYLENE GLYCOL. TRIETHANOLAMINE. SODIUM HYDROXIDE. PHENOXYETHANOL. CHLORPHENESIN.',
'Crema de față The Ordinary Natural Moisturizing Factors + HA oferă tenului îngrijirea pe care o merită.',
'Se aplică pe pielea curată și se masează cu mișcări circulare. Se utilizează în fiecare dimineață și/sau seară.'), -- 18

('Minéral 89 crema de fata hidratanta 72 ore', 109.00, 'src/img/product19.webp', 0, 0, 6, 5, 2, 
'AQUA / WATER / EAU, GLYCERIN, DICAPRYLYL ETHER, PENTYLENE GLYCOL, POLYGLYCERYL-6 DISTEARATE, NIACINAMIDE, PROPANEDIOL, CETYL ESTERS, JOJOBA ESTERS, CETEARYL ISONONANOATE, SQUALANE, BEHENYL ALCOHOL, ADENOSINE, CAPRYLOYL SALICYLIC ACID, HYDROXYACETOPHENONE, MINERAL SALTS, SODIUM HYALURONATE, TRISODIUM ETHYLENEDIAMINE DISUCCINATE, VITREOSCILLA FERMENT, TOCOPHEROL, ACACIA DECURRENS FLOWER CERA / ACACIA DECURRENS FLOWER WAX, ACRYLAMIDE/SODIUM ACRYLOYLDIMETHYLTAURATE COPOLYMER, CETYL ALCOHOL, HELIANTHUS ANNUUS SEED CERA / SUNFLOWER SEED WAX, HYDROXYPROPYL STARCH PHOSPHATE, ISOHEXADECANE, POLYGLYCERIN-3, POLYGLYCERYL-3 BEESWAX, POLYSORBATE 80, SODIUM STEAROYL GLUTAMATE, SORBITAN OLEATE, PARFUM / FRAGRANCE (F.I.L. N70017704/1).',
'Crema de fațăVichy Minéral 89 oferă tenului îngrijirea pe care o merită.',
'Se aplică pe pielea curată, cu mișcări circulare și se masează ușor.'), -- 19

('Photoderm Aquafluid crema protectoare pentru fata SPF 50+', 107.00, 'src/img/product20.webp', 0, 0, 8, 5, 8, 
'',
'Dacă folosiți crema facială protectoare, Bioderma Photoderm Aquafluid, cu SPF 50+, înaintea fiecărei expuneri la soare, nu va fi cazul să vă temeți de efectele negative ale radiațiilor UVA și UVB. În plus, tehnologia folosită, Sun Active Defence, mărește capacitatea de autoapărare a tenului. Această cremă are o textură răcoritoare, pe bază de apă. După uscare, lasă un finisaj mat; tenul capătă un aspect natural, matifiat și pregătit pentru aplicarea oricărui fond de ten.',
'Întindeți uniform o cantitate generoasă de cremă solară pentru față, Bioderma Photoderm Aquafluid, pe față și pe gât. Aplicați crema înainte de expunerea la soare și repetați aplicarea după fiecare baie, dacă ați transpirat sau dacă v-ați șters cu prosopul.'), -- 20

('Ambre Solaire Super UV crema protectoare pentru fata antirid', 47.00, 'src/img/product21.webp', 0, 35, 7, 5, 8, 
'',
'Produsul oferă feței o protecție fiabilă împotriva radiațiilor solare.',
'Se aplică cu mișcări circulare, pe fața curată și pe gât și se masează ușor. Se repetă dacă este necesar, în special după îmbăiere, după uscarea cu prosopul sau în caz de transpirație excesivă. A se evita expunerea îndelungată la soare, chiar dacă pielea este protejată împotriva razelor solare.'), -- 21

('Photoderm AKN Mat fluid protector mat pentru fata SPF 30', 100.00, 'src/img/product22.webp', 0, 0, 8, 5, 8, 
'AQUA, OCTOCRYLENE, METHYLENE BISBENZOTRIAZOLYL TETRAMETHYLBUTYLPHENOL, BUTYLMETHOXYDIBENZOYLMETHANE, TRIDECYL SALICYLATE, TOCOPHERYL ACETATE, ECTOIN, MANNITOL, XYLITOL, RHAMNOSE, FRUCTO-OLIGO-SACHARIDES, LAMINARIAOCHROLEUCA EXTRACT, GLYCOLIC ACID, GINKGO BILOBA LEAF EXTRACT, DODECYL GALLATE, DECYL GLUCOSIDE, C 20-22 ALKYL PHOSPHATE, C 20-22 ALCOHOLS, XANTHAN GUM, PROPYLENE GLYCOL, CITRIC ACID, CAPRYLIC/CAPRIC TRI-GLYCERIDE, SODIUM HYDROXIDE, DISODIUM EDTA, CHLORPHENESIN, PHENOXYETHANOL, PARFUM.',
'',
''), -- 22

('Bio Graceful Lavandin crema anti-imbatranire pentru ochi si buze', 37.00, 'src/img/product23.webp', 0, 35, 7, 5, 10, 
'Tratamentul pentru ochi Garnier Bio Graceful Lavandin îngrijește pielea din jurul ochilor, oferindu-i nutriția și hidratarea necesare.',
'',
'Produsul se aplică în jurul ochilor dimineața și/sau seara, prin tapotare cu degetele, până la absorbție. Se poate folosi și în zona buzelor.'), -- 23

('Slim Lip Pencil creion de buze cu trasare precisă', 24.00, 'src/img/product24.webp', 1, 0, 10, 5, 23, 
'SORBITAN ISOSTEARATE, ISOCETYL STEARATE,PHENYL TRIMETHICONE, POLYETHYLENE, EUPHORBIA CERIFERA (CANDELILLA) WAX,BUTYROSPERMUM PARKII (SHEA BUTTER) UNSAPONIFIABLES, BEESWAX, SIMMONDSIACHINENSIS (JOJOBA) SEED OIL, CAPRYLIC/CAPRI TRIGLYCERIDE, NYLON-12,OCTYLDODECANOL, POLYGLYCERYL-2 DIISOSTEARATE, SILICA, COPERNICIACERIFERA (CARNAUBA) WAX, HYDROGENATED, COCONUT OIL, TOCOPHEROL,VP/HEXADECENE COPOLYMER, STEARALKONIUM HECTORITE, STEARYLGLYCYRRHETINATE, PROPYLPARABEN, PROLYLENE CARBONATE.',
'Preveniți ștergerea inestetică a rujului. Creionul de buze cu trasare precisă NYX Professional Makeup Slim Lip Pencil are grijă ca machiajul dvs. să arate absolut perfect. Vă permite să definiți contururile buzelor și are o textură persistentă, dar moale, care îl face ușor de utilizat. Buzele sunt mai pline, aplicarea rujului este precisă, iar zâmbetul dvs. înflorește în toată splendoarea sa.',
'Se aplică pe buzele curate, în mod ideal după exfoliere. Conturați buzele din centru spre colțuri, folosind un creion suficient de ascuțit. Apoi aplicați rujul sau glossul preferat.'), -- 24

('Intense Colour creion de buze cu trasare precisă', 8.00, 'src/img/product25.webp', 1, 0, 11, 5, 23, 
'RICINUS COMMUNIS SEED OIL, CERA MICROCRISTALLINA, PARAFFIN, ISOPROPYL MYRISTATE, PETROLATUM, SYNTHETIC WAX, MICA, TRIDECYL TRIMELLITATE, SILICA, PHENOXYETHANOL, CI 77891, CI 77491, CI 77492, CI 77499, CI 15850.',
'Creionul de buze MUA Makeup Academy Intense Colour previne migrarea neintenționată a rujului și ajută la crearea formei perfecte a buzelor.',
'Se conturează buzele cu creionul, apoi se aplică rujul sau luciul de buze.'), -- 25

('Dior Addict Lip Glow Oil ulei pentru buze', 187.00, 'src/img/product26.webp', 1, 0, 12, 5, 24, 
'',
'Devenit indispensabil pentru makeup artists, Dior Lip Glow este disponibil sub forma unui ulei de buze, care le protejeaza in profunzime si le accentueaza, scotand la iveala culoarea lor naturala in mod durabil.

Cu tehnologia sa Color Reviver, Lip Glow Oil reactioneaza direct cu buzele fiecarei femei, pentru o culoare personalizata, asigurand in acelasi timp o hidratare continua.
Buzele sunt mai frumoase, chiar si nemachiate, dupa 5 zile de aplicare. Textura non-grasa si non-lipicioasa a uleiului combina stralucirea de oglinda a unui luciu de buze cu confortul unui produs de ingrijire intensiva. Imbogatita cu ulei de cirese, formula rasfata buzele si creeaza o pelicula protectoare impotriva factorilor de stres si a uscaciunii.
Buzele sunt impregnate cu substante nutritive si revitalizate, efectul fiind imediat si de durata.

Noile nuante Lip Glow Oil se asorteaza cu nuantele proaspete de Lip Glow disponibile in acest moment:

001 Pink: roz deschis
004 Coral: corai aprins
006 Berry: rosu-purpuriu
007 Raspberry: roz de culoarea zmeurei',
''), -- 26

('Fat Oil Lip Drip ulei pentru buze', 49.00, 'src/img/product27.webp', 1, 0, 10, 5, 24, 
'2061220 1 INGREDIENTS:POLYISOBUTENE, HYDROGENATED POLYISOBUTENE, PENTAERYTHRITLY TETRAISOSTEARATE, PARAFFINUM LIQUIDUM / MINERAL OIL ˛HUILE MINERALE, DIISOSTEARYL MALATE, POLYGYCERYL-3 DIISOSTEARATE, ROSA CANINA FRUIT OIL, RUBUS CHAMAEMORUS SEED OIL, RUBUS IDAEUS SEED OIL / RASPBERRY SEED OIL, SQUALANE, BARIUM SULFATE, AROMA /FLAVOUR, ALUMINA, ALUMINIUM HYDROXIDE, CAPRYLIC TRIGLYCERIDE, DIBUTYL ETHYLHEXANOLY GLUTAMIDE, ETHYLHEXGLYCERIN, TOCOPHEROL, TOCOPHERYL ACETATE DIETHYLHEXLY SYRINGYLIDENEMALONATE, SORBIC ACID, PHENOXYETHANOL, CI 15850 / RED 7 LAKE, CI 77891 / TITANIUM DIOXIDE, CI 42090 / BLUE 1 LAKE, BENZYL ALCOHOL.',
'Luciul de buze NYX Professional Makeup Fat Oil Lip Drip dă buzelor un aspect minunat.',
'Se aplică pe buze un strat uniform, cu aplicatorul.'), -- 27

('Dior Addict Lip Maximizer luciu de buze pentru un volum suplimentar', 187.00, 'src/img/product28.webp', 1, 0, 12, 5, 24, 
'#17379 METHYL HYDROGENATED ROSINATE • DIMER DILINOLEYL DIMER DILINOLEATE • POLYGLYCERYL-2 TRIISOSTEARATE • POLYGLYCERYL-10 DECAISOSTEARATE • JOJOBA ESTERS • POLYGLYCERYL-3 BEESWAX • GLYCERYL BEHENATE/EICOSADIOATE • ETHYLHEXYL PALMITATE • DIPALMITOYL HYDROXYPROLINE • MENTHOXYPROPANEDIOL • PARFUM (FRAGRANCE) • PRUNUS AVIUM (SWEET CHERRY) SEED OIL • MICA • ETHYL VANILLIN • TOCOPHEROL • TRIHYDROXYSTEARIN • TRIMETHYLOLPROPANE TRIISOSTEARATE • SILICA • CAPSICUM FRUTESCENS FRUIT EXTRACT • SODIUM HYALURONATE • TIN OXIDE • PROPYL GALLATE • GLUCOMANNAN • [+/- CI 77891 (TITANIUM DIOXIDE) • CI 77491 (IRON OXIDES) • CI 45410 (RED 28 LAKE) • CI 19140 (YELLOW 5 LAKE)]',
'Descoperiți Dior Addict Lip Maximizer, luciul de buze Dior cu efect de volum, într-o formulă de îngrijire a buzelor compusă în proporție de 90%* din ingrediente de origine naturală. Infuzat cu ulei de cireșe și acid hialuronic, acesta le oferă buzelor hidratare timp de 24h**.

Luciul Dior Addict Lip Maximizer a fost reconceput într-o varietate de nuanțe și efecte cu strălucire de oglindă: transparent, intens, sidefat și hologafic. Buzele sunt netezite, hidratate și par mai pline imediat și pe termen lung.

Cutia Dior Addict Lip Maximizer primește un nou design, decorat cu literele DIOR în relief, în spiritul logomaniei.',
''), -- 28

('Lip Lingerie XXL ruj de buze lichid, cu finisaj matifiant', 45.00, 'src/img/product29.webp', 1, 0, 10, 5, 25, 
'DIMETHICONE, ISODODECANE, TRIMETHYLSILOXYSILICATE, NYLON-611/DIMETHICONE COPOLYMER, DIMETHICONE CROSSPOLYMER, C30-45 ALKYLDIMETHYLSILYL POLYPROPYLSILSESQUIOXANE, LAUROYL LYSINE, TRIETHOXYSILYLETHYL POLYDIMETHYLSILOXYETHYL DIMETHICONE, SILICA SILYLATE, ISOPROPYL TITANIUM TRIISOSTEARATE, SORBIC ACID, PHENOXYETHANOL, PARFUM / FRAGRANCE',
'Subliniați frumusețea naturală a buzelor dvs., printr-o culoare saturată, cu finisaj mat. Asemenea lenjeriei modelatoare preferate, rujul lichid NYX Professional Makeup Lip Lingerie XXL se adaptează complet contururilor dvs. și le accentuează atuurile. Catifelează buzele, oferindu-le o definiție clară și un aspect mai plin. După aplicarea simplă, datorită formei speciale a aplicatorului, rujul este complet uscat în 60 de secunde, iar culoarea mată nu migrează de pe buze timp de 16 ore.',
'Rujul lichid NYX Professional Makeup Lip Lingerie XXL se aplică pe buzele curate, folosind aplicatorul inclus. Forma sa specială, ascuțită, permite o aplicare precisă. Mai întâi trasați contururile cu vârful – începeți din centrul buzelor și continuați spre colțuri. Apoi umpleți complet spațiul dintre contururi cu ruj. Lăsați să se usuce aproximativ 60 de secunde.'), -- 29

('Dior Addict Lip Tint ruj de buze lichid', 186.00, 'src/img/product30.webp', 1, 0, 12, 5, 25, 
'#16283 AQUA (WATER), GLYCERIN, METHYL HYDROGENATED ROSINATE, BUTYLENE GLYCOL, POLYGLYCERYL-2 TRIISOSTEARATE, ALCOHOL, POLYGLYCERIN-3, HYDROXYETHYL ACRYLATE/SODIUM ACRYLOYLDIMETHYL TAURATE COPOLYMER, SQUALANE, POLYURETHANE-35, 1,2-HEXANEDIOL, LECITHIN, MENTHOXYPROPANEDIOL, TRIMETHYLOLPROPANE TRIISOSTEARATE, PARFUM (FRAGRANCE), SODIUM HYALURONATE, POLYSORBATE 60, HYDROXYACETOPHENONE, SODIUM BENZOATE, PRUNUS AVIUM (SWEET CHERRY) SEED OIL, AMMONIUM GLYCYRRHIZATE, SORBITAN ISOSTEARATE, TOCOPHEROL, METHYLPROPANEDIOL, ETHYL VANILLIN, CITRIC ACID, ALUMINUM HYDROXIDE, CAPRYLYL GLYCOL, PROPYL GALLATE, CAPSICUM FRUTESCENS FRUIT EXTRACT, PHENYLPROPANOL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, [+/- CI 77891 (TITANIUM DIOXIDE), CI 17200 (RED 33), CI 15985 (YELLOW 6), CI 15850 (RED 7), CI 77491, CI 77499 (IRON OXIDES), CI 19140 (YELLOW 5, YELLOW 5 LAKE), CI 42090 (BLUE 1)].',
'Antitransfer, 12 ore* de rezistență, 24 de ore** de hidratare și o formulă bazată în proporție de 95%*** pe ingrediente de origine naturală: Dior prezintă Dior Addict Lip Tint, rujul lichid cu efect cromatic semimat.

Aplicatoul Dior Addict Lip Tint se manevrează intuitiv și cu mare precizie, permițând aplicarea optimă a rujului lichid. Buzele sunt învăluite într-o culoare proaspătă și naturală.',
'1. Începeți prin a aplică nuanță Diornatural de balsam de buze Dior Addict Lip Glow că baza de machiaj hidratantă, apoi tamponati excesul de produs cu un șervețel.
2. Aplicați apoi Dior Addict Lip Tint plasând aplicatorul în centrul buzelor, chiar sub arcul lui Cupidon, și colorându-le de la dreapta la stânga.'), -- 30

('Color Riche Intense Volume Matte Colors of Worth ruj buze mat hidratant editie limitata', 55.00, 'src/img/product31.webp', 1, 0, 5, 5, 22, 
'',
'Rujul L’Oréal Paris Color Riche Intense Volume Matte Colors of Worth accentuează frumos buzele și subliniază perfect fondul de ten de zi și de seară.',
'Rujul se aplică pe buze cu tușe delicate, dinspre centru spre colțuri.'), -- 31

('Creamy Matte ruj crema cu efect matifiant', 15.00, 'src/img/product32.webp', 1, 0, 11, 5, 22, 
'HYDROGENATED POLYDECENE, POLYISOBUTENE, CERA MICROCRISTALLINA, ETHYLHEXYL PALMITATE, SILICA, ACRYLATES CROSSPOLYMER, OZOKERITE, BIS-DIGLYCERYL POLYACYLADIPATE-2, DIMETHICONE, SYNTHETIC WAX, POLYETHYLENE, TRIDECYL TRIMELLITATE, DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER, PHENOXYETHANOL, HYDROGENATED VEGETABLE OIL, PARFUM, ALUMINUM HYDROXIDE, STEARYL STEARATE, STEARIC ACID, LECITHIN, POLYHYDROXYSTEARIC ACID, ISOPROPYL MYRISTATE, ETHYLHEXYL PALMITATE, ISOSTEARIC ACID, POLYGLYCERYL-3 POLYRICINOLEATE, ETHYLHEXYLGLYCERIN, BENZYL ALCOHOL, BENZYL SALICYLATE, HEXYL CINNAMAL, HYDROXYCITRONELLAL, CI 77891, CI 77491, CI 77492, CI 77499, CI 15850.',
'Rujul MUA Makeup Academy Creamy Matte accentuează frumos buzele și subliniază perfect fondul de ten de zi și de seară.',
'Rujul se aplică pe buze cu tușe delicate, dinspre centru spre colțuri.'), -- 32

('Full Satin Nude ruj satinat', 22.00, 'src/img/product33.webp', 1, 0, 13, 5, 22, 
'HYDROGENATED POLYDECENE, HYDROGENATED POLYISOBUTENE, POLYGLYCERYL-2 TRIISOSTEARATE, EUPHORBIA CERIFERA CERA (EUPHORBIA CERIFERA (CANDELILLA) WAX), SILICA, ETHYLHEXYL PALMITATE, SYNTHETIC WAX, KAOLIN, OZOKERITE, TOCOPHEROL, ASCORBYL DIPALMITATE, ASCORBYL TETRAISOPALMITATE, ROSA CANINA FRUIT OIL, POLYHYDROXYSTEARIC ACID, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, MICA, TIN OXIDE, BENZYL ALCOHOL, PARFUM (FRAGRANCE), CI 15850 (RED 7), CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
'Dacă vă doriți un ruj care să se potrivească la orice ținută, nu ratați rujul satinat Catrice Full Satin Nude. Se mândrește cu o compoziție care hidratează buzele, iar textura sa cremoasă asigură o aplicare ușoară.

Cel mai mult vă va încânta datorită pigmentării sale intense, care creează buze perfecte la o singură trecere. Catrice Full Satin Nude va deveni sigur rujul dvs. de bază.',
'Rujul se aplică mai întâi pe buza de sus și apoi pe cea de jos. La buza de sus începeți de la arcul lui Cupidon și continuați de-a lungul contururilor, spre colțuri.'), -- 33

('False Lash Bambi Oversized Eye mascara pentru volum, alungire si separarea genelor', 65.00, 'src/img/product34.webp', 1, 0, 5, 5, 18, 
'AQUA / WATER, PARAFFIN, POTASSIUM CETYL PHOSPHATE, ACRYLATES COPOLYMER, CERA ALBA / BEESWAX, COPERNICIA CERIFERA CERA / CARNAUBA WAX, ETHYLENE/ACRYLIC ACID COPOLYMER, STEARETH-2, CETYL ALCOHOL, PHENOXYETHANOL, HYDROXYETHYLCELLULOSE, ACACIA SENEGAL GUM, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, SODIUM DEHYDROACETATE, CAPRYLYL GLYCOL, HYDROGENATED JOJOBA OIL, HYDROGENATED PALM OIL, PROPYLENE GLYCOL, DISODIUM EDTA, PENTAERYTHRITYL TETRAISOSTEARATE, SODIUM HYALURONATE, 2-OLEAMIDO-1,3-OCTADECANEDIOL, RAYON, PANTHENOL, LAURETH-21, SOLUBLE COLLAGEN, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, TRISODIUM EDTA, BUTYLENE GLYCOL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, POTASSIUM SORBATE, SODIUM CHONDROITIN SULFATE, ATELOCOLLAGEN, BHT, HEXYLENE GLYCOL, [+/- MAY CONTAIN: CI 77499 / IRON OXIDES]. (F.I.L. B259419/1).',
'Rimelul pentru volum, alungire și separarea genelor, Loreal Paris False Lash Bambi Oversized Eye, creează gene atât de frumoase, încât par ireale. Accentuează la maxim genele, le separă și creează un efect 3D dramatic. Toate acestea fără împovărare și, în plus, aproape imediat, datorită periei unice. Nimeni nu va rezista farmecului privirii dvs. extrem de pătrunzătoare.',
'Plasați periuța rimelului Bambi Oversized Eye la rădăcina genelor și periați spre vârfuri. Pentru o separare cât mai bună a genelor, efectuați mișcarea în zig-zag. Aplicați mai multe straturi, până când obțineți rezultatul dorit.'), -- 34

('False Lash Bambi Eye rimel cu efect de gene false', 58.00, 'src/img/product35.webp', 1, 0, 5, 5, 18, 
'G2004361, AQUA / WATER, PARAFFIN, POTASSIUM CETYL PHOSPHATE, ACRYLATES COPOLYMER, CERA ALBA / BEESWAX, COPERNICIA CERIFERA CERA / CARNAUBA WAX, ETHYLENE/ACRYLIC ACID COPOLYMER, CETYL ALCOHOL, STEARETH-2, PHENOXYETHANOL, HYDROXYETHYLCELLULOSE, ACACIA SENEGAL GUM, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, SYNTHETIC BEESWAX, BIS-DIGLYCERYL POLYACYLADIPATE-2, POLYBUTENE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, SODIUM DEHYDROACETATE, CAPRYLYL GLYCOL, HYDROGENATED JOJOBA OIL, HYDROGENATED PALM OIL, STEARETH-20, GLYCERYL DIBEHENATE, DISODIUM EDTA, PROPYLENE GLYCOL, PENTAERYTHRITYL TETRAISOSTEARATE, TRIBEHENIN, GLYCERYL BEHENATE, SODIUM HYALURONATE, 2-OLEAMIDO-1,3-OCTADECANEDIOL, RAYON, PANTHENOL, BUTYLENE GLYCOL, LAURETH-21, SOLUBLE COLLAGEN, SODIUM LAURETH SULFATE, SILICA DIMETHYL SILYLATE [NANO] / SILICA DIMETHYL SILYLATE, TETRASODIUM EDTA, POTASSIUM SORBATE, TRISODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SODIUM CHONDROITIN SULFATE, BHT, ATELOCOLLAGEN, HEXYLENE GLYCOL [+/- MAY CONTAIN: CI 77499 / IRON OXIDES]. (F.I.L. B233767/3). ,',
'Nimeni nu rezistă privirii dvs. de căprioară sfioasă. Rimelul cu efect de gene false Loreal Paris False Lash Bambi Eye are o perie inovatoare, cu fire scurte și lungi, pentru gene perfect întoarse, cu volum și lungime maxime.',
'Rimelul se aplică pe gene, prin tușe delicate, de la rădăcini la vârfuri. Pentru un plus de intensitate, se aplică mai multe straturi. Se înlătură simplu, cu apă și săpun.'), -- 35

('Lash Sensational mascara pentru gene lungi și dese', 37.00, 'src/img/product36.webp', 1, 0, 14, 5, 18, 
'AQUA/WATER, PROPYLENE GLYCOL, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, POLYURETHANE-25, CERA ALBA/BEESWAX, SYNTHETIC FLUORPHLOGOPITE, GLYCERYL STEARATE, CETYL ALCOHOL, PEG-200 GLYCERYL STEARATE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, COPERNICIA CERIFERA CERA/CARNAUBA WAX, STEARIC ACID, PALMITIC ACID, ETHYLENE/VA COPOLYMER, ALCOHOL DENAT., PARAFFIN, AMINOMETHYL PROPANEDIOL, GLYCERIN, HYDROXYETHYLCELLULOSE, PHENOXYETHANOL, CAPRYLYL GLYCOL, BUTYLENE GLYCOL, XANTHAN GUM, SODIUM LAURETH SULFATE, DISODIUM EDTA, TETRASODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SILICA, )+/- MAY CONTAIN CI 77491, CI 77492, CI 77499/IRON OXIDES, CI 77007/ULTRAMARINES, CI 77891/TITANIUM DIOXIDE, MICA, CI 75470/CARMINE, CI 77288/CHROMIUM OXIDE GREENS, CI 77742/MANGANESE VIOLET, CI 77510/FERRIC FERROCYANIDE).',
'Gene lungi și dese cu efect de evantai, asigurate de emblematicul rimel Maybelline Lash Sensational! Peria specială, cu zece rânduri de peri captează realmente fiecare geană, o întoarce și o alungește vizibil.',
'Plasați peria la rădăcina genelor și periați-le în sus. Utilizați vârful periei pentru genele din colțul intern al ochilor.'), -- 36

('Lash Sensational Sky High Mascara pentru volum si lungire', 61.00, 'src/img/product37.webp', 1, 0, 14, 5, 18, 
'AQUA / WATER, PROPYLENE GLYCOL, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, POLYURETHANE-35, CERA ALBA / BEESWAX, SYNTHETIC FLUORPHLOGOPITE, GLYCERYL STEARATE, CETYL ALCOHOL, PEG-200 GLYCERYL STEARATE, ETHYLENEDIAMINE/STEARYL DIMER DILINOLEATE COPOLYMER, COPERNICIA CERIFERA CERA / CARNAUBA WAX, STEARIC ACID, PALMITIC ACID, ETHYLENE/VA COPOLYMER, ALCOHOL DENAT., PARAFFIN, AMINOMETHYL PROPANEDIOL, PHENOXYETHANOL, CAPRYLYL GLYCOL, GLYCERIN, HYDROXYETHYLCELLULOSE, BUTYLENE GLYCOL, METHYLPROPANEDIOL, RAYON, XANTHAN GUM, CAPRYLIC/CAPRIC TRIGLYCERIDE, SODIUM LAURETH SULFATE, MYRISTIC ACID, TETRASODIUM EDTA, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, POTASSIUM SORBATE, SILICA, PHENYLPROPANOL, BAMBUSA VULGARIS EXTRACT, [+/- MAY CONTAIN: CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 77007 / ULTRAMARINES, MICA, CI 77891 / TITANIUM DIOXIDE, CI 75470 / CARMINE, CI 77288 / CHROMIUM OXIDE GREENS, CI 77742 / MANGANESE VIOLET, CI 77510 / FERRIC FERROCYANIDE]. (F.I.L. D268569/1).',
'Cerul este limita! Acest motto este adevărat mai ales pentru genele dvs. Dovada este rimelul pentru volum și alungire Maybelline Lash Sensational Sky High. Acest rimel nu doar că vă va oferi o alungire maximă, ci va și lungi genele într-un mod nemaipomenit – toate acestea în câteva mișcări!

La fel de ușor ca și aplicarea acestuia va fi și demachierea, deoarece rimelul se demachiază doar cu apă! Maybelline Lash Sensational Sky High vă oferă tot ce v-ați putea dori de la un rimel.',
'Apropiați aplicatorul de gene și întindeți rimelul de la rădăcini, până la vârfuri. Repetați procesul, până când veți obține rezultatul dorit.'), -- 37

('Calligraph Pro Precise 24h Matt dermatograf rezistent la apă', 20.00, 'src/img/product38.webp', 1, 0, 13, 5, 21, 
'AQUA (WATER), METHYLPROPANEDIOL, STYRENE/ACRYLATES COPOLYMER, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, CELLULOSE, PEG-60 HYDROGENATED CASTOR OIL, COCO-GLUCOSIDE, POLOXAMER 407, PHENYLPROPANOL, CAPRYLYL GLYCOL, SODIUM LAURETH-12 SULFATE, SODIUM LAURYL SULFATE, BHT, CITRIC ACID, PHENOXYETHANOL, POTASSIUM SORBATE, SODIUM BENZOATE, SODIUM DEHYDROACETATE, CI 77266 (BLACK 2) (NANO).',
'Obține linia de tuș perfectă cu Catrice Calligraph Pro Precise 24h Matt! Oferă un negru intens, acoperire puternică și precizie, datoriă vârfului ultra fin ca de stilou. Practic, dar cu o formulă rezistentă la apă, tușul are o durabilitate de până la 24 de ore.',
'Folosiți vârful fin pentru a trasa linia de tuș pe conturul ochiilor, în funcție de rezultatul dorit.'), -- 38

('Epic Ink contur de precizie, rezistent la apă', 52.00, 'src/img/product39.webp', 1, 0, 10, 5, 21, 
'AQUA / WATER, CI 77266 [NANO] / BLACK 2, PROPYLENE GLYCOL, ACRYLATES/ETHYLHEXYL ACRYLATE COPOLYMER, LAURETH-21, ACRYLATES/DIMETHYLAMINOETHYL METHACRYLATE COPOLYMER, C11-15 PARETH-7, PEG-40 HYDROGENATED CASTOR OIL, SODIUM LAURETH-12 SULFATE, SODIUM LAURYL SULFATE, AMMONIUM ACRYLATES COPOLYMER, DISODIUM LAURETH SULFOSUCCINATE, CAPRYLYL GLYCOL, BUTYLENE GLYCOL, POTASSIUM SORBATE, SODIUM DEHYDROACETATE, PHENOXYETHANOL (F.I.L. D193551/1).',
'Pentru o privire seducătoare, căreia nimeni nu-i rezistă. Tușul contur de ochi rezistent la apă NYX Professional Makeup Epic Ink are o culoare intensă și saturată, cu care subliniază și evidențiază orice machiaj. Este foarte ușor de aplicat și rezistă perfect. Puteți opta pentru seducătorii ochi de pisică - sau doar pentru un contur discret.',
'Se trasează ușor linia pe pleoapă. Se lasă să se usuce.'), -- 39

('Hyper Precise creion pentru conturul ochilor', 28.00, 'src/img/product40.webp', 1, 0, 14, 5, 21, 
'AQUA / WATER, METHYLPROPANEDIOL, STYRENE/ACRYLATES COPOLYMER, STYRENE/ACRYLATES/AMMONIUM METHACRYLATE COPOLYMER, CELLULOSE, PEG-60 HYDROGENATED CASTOR OIL, COCO-GLUCOSIDE, POLOXAMER 407, CITRIC ACID, PHENOXYETHANOL, POTASSIUM SORBATE, PHENYLPROPANOL, SODIUM BENZOATE, CAPRYLYL GLYCOL, SODIUM DEHYDROACETATE, SODIUM LAURETH SULFATE, SODIUM LAURYL SULFATE, BHT, [+/- MAY CONTAIN: CI 77266 [NANO] / BLACK 2]. (F.I.L. D218002/1).',
'Aplicare ușoară și precisă, persistență îndelungată și fără migrare – tușul de ochi Maybelline Hyper Precise împlinește toate așteptările pe care le-ați putea avea de la un contur de ochi. Vârful ultrasubțire vă ajută să trasați atât linii foarte subțiri, cât și groase. Datorită compoziției rezistente la apă, face față cu brio chiar și unor condiții solicitante, pentru siguranța ochilor perfect machiați în orice situație. Câștigător, în 2013, al concursului Allure Best of Beauty Award, vă va câștiga și pe dvs.',
'Trasați o linie subțire cu vârful aplicatorului, din colțul intern al ochiului spre cel extern. Se demachiază cu un produs pentru machiaj rezistent la apă.'), -- 40

('Epic Black Mousse Liner eyeliner rezistent la apă', 46.00, 'src/img/product41.webp', 1, 0, 10, 5, 21, 
'ISODODECANE, TRIMETHYLSILOXYSILICATE, POLYETHYLENE, PHENOXYETHANOL, TOCOPHERYL ACETATE, LECITHIN, BHT. MAY CONTAIN / PEUT CONTENIR (+/-)BLACK 2 (CI 77266)[NANO].',
'Pentru o linie perfectă și rezistentă de tuș, Nyx Professional Makeup Epic Black Mousse este produsul ideal! Cu o textură uimitor de cremoasă, în ambalajul inovator ca un borcănaș, tușul este rezistent la apă și oferă un aspect mat.',
'Utilizați cu o pensulă specială pentru tuș, aplicați într-un strat subțire pe conturul ochiilor în funcție de efectul dorit.'), -- 41

('Brow Artist Plump and Set gel pentru sprancene', 39.00, 'src/img/product42.webp', 1, 0, 5, 5, 19, 
'',
'Descoperiți gelul ideal pentru sprâncene mai pline L’Oréal Paris Brow Artist Plump and Set Eyebrow Gel! Periuța facilitează aplicarea iar formula modelează și setează firele de păr, oferind un aspect natural. Produsul are o durabilitate de până la 24 de ore și este rezistent la apă.',
'Aplicați gelul singur sau pentru a seta un alt produs pentru sprâncene. Periați sprâncenele cu mișcări ascendente.'), -- 42

('Tattoo Brow 36H gel de sprancene de lungă durată', 48.00, 'src/img/product43.webp', 1, 0, 14, 5, 19, 
'',
'Sprâncenele elegant modelate evidențiază imediat frumusețea naturală, deoarece încadrează întreaga față. Pentru un chip perfect, un simplu gest este suficient. Rimelul pentru sprâncene Maybelline Tattoo Brow 36H accentuează și fixează genele, într-un singur pas.',
'Periați de mai multe ori firele sprâncenelor, modelându-le totodată în forma dorită.'), -- 43

('Lash Brow Designer gel mascara a genelor si a sprancenelor', 11.00, 'src/img/product44.webp', 1, 0, 13, 5, 19, 
'AQUA (WATER), GLYCERIN, PROPYLENE GLYCOL, PANTHENOL, CARBOMER, ACRYLATES COPOLYMER, ETHYLHEXYLGLYCERIN, SODIUM HYDROXIDE, PHENOXYETHANOL.',
'Sprâncenele pot transforma incredibil aspectul feței dvs. De gene nici nu mai pomenim. Trebuie să fie perfect aranjate. Rimelul transparent pentru gene și sprâncene Catrice Lash Brow Designer are grijă de ambele. Sculptează sprâncenele și rimelează genele și le oferă fermitate, luciu și îngrijire, pentru o ameliorare durabilă a stării acestora.',
'Modelați sprâncenele cu peria într-o formă îngrijită. Periați genele pe întreaga lungime, de la rădăcini la vârfuri.'), -- 44

('Brow Ultra Slim creion pentru sprancene', 29.00, 'src/img/product45.webp', 1, 0, 14, 5, 20, 
'',
'Nimic nu oferă atât farmec privirii ca sprâncenele îngrijite. Creionul automat pentru sprâncene Maybelline Brow Ultra Slim are vârful lat de numai 1,5 mm, care imită perfect părul natural. Compoziția cremoasă nu lasă pete, are o persistență de lungă durată și previne ruperea creionului. Iar pensula practică vă ajută să modelați sprâncenele și să le sculptați într-o formă perfectă.',
'Completați sprâncenele pe toată lungimea, cu tușe subțiri, care imită firele naturale. Apoi, folosind peria, pieptănați firele de păr în sus și apoi în lateral.'), -- 45

('Lift&Snatch Brow Tint Pen creion pentru sprancene', 57.00, 'src/img/product46.webp', 1, 0, 10, 5, 20, 
'AQUA / WATER / EAU, GLYCERIN, ALCOHOL, PEG/PPG-14/4 DIMETHICONE, PVP, PEG-40 HYDROGENATED CASTOR OIL, TRIISOPROPANOLAMINE, PROPYLENE GLYCOL, CAPRYLYL GLYCOL, LAURETH-21, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, SODIUM DEHYDROACETATE, PHENOXYETHANOL. MAY CONTAIN / PEUT CONTENIR (+/-)CI 77266 [NANO] / BLACK 2, CI 16035 / RED 40, CI 19140 / YELLOW 5, CI 42090 / BLUE 1.',
'Sprâncene perfect definite cu aspect natural și o rezistență îndelungată. Creionul de sprâncene NYX Professional Makeup Lift&Snatch Brow Tint Pen este produsul potrivit pentru umplerea și definirea sprâncenelor, oferind un aspect instant de lifting. Având un vârf foarte subțire, creionul ajustează sprâncenele și le asigură un aspect natural care rezistă până la 16 ore.',
'Agitați produsul înainte de folosire. Prin mișcări ascendente trasați tușe delicate pentru a umple și defini sprânceana. Poate fi folosit atât singur, cât și alături de alte produse pentru sprâncene.'), -- 46

('Dear Universe paletă cu farduri de ochi', 49.00, 'src/img/product47.webp', 1, 0, 13, 5, 17, 
'',
'Paleta pentru machiaj ochilor Catrice Dear Universe oferă posibilitatea creării celor mai fantastice variante de farduri de pleoape.',
'Se aplică umbrele pe pleoape cu peria, cu buretele de fond de ten sau cu buricele degetelor.'), -- 47

('Soph X Super Spice paletă cu farduri de ochi', 64.00, 'src/img/product48.webp', 1, 0, 15, 5, 17, 
'',
'Lăsați-vă liberă imaginația și creați combinații surprinzătoare de make-up cu paleta de farduri pentru ochi Makeup Revolution Soph X Super Spice. Cele 18 nuanțe sunt potrivite unei personalități ce își dorește să fie în centrul atenției și să întoarcă toate privirile. Fardurile sunt pigmentate, ușor de amestecat și demachiat și au o textură cremoasă ce facilitează aplicarea. Bucurați-vă de zeci de înfățișări, cu o singură paletă.',
'Aplicați fard cu ajutorul unei pensule speciale sau chiar cu vârfurile degetelor pe pleoapa superioară. Pentru a contura privirea, aplicați fard în tușe fine și sub linia apei, în zona inferioară.'), -- 48

('Ultimate Shadow Palette paletă cu farduri de ochi', 78.00, 'src/img/product49.webp', 1, 0, 10, 5, 17, 
'',
'Paleta de farduri de pleoape NYX Professional Makeup Ultimate™ își merită numele - combinația a 16 nuanțe de farduri de ochi și pigmenți presați, de nivel profesional, vă vor cuceri, pur și simplu. Nuanțele excelent combinate sunt inspirate de culorile curcubeului și oferă o textură mătăsoasă, cu diverse finisaje',
'Fardurile în nuanțele dorite se aplică pe pleoape folosind pensula, aplicatorul sau degetele. Estompați zona de tranziție între culori, pentru un efect natural. Nu ezitați să folosiți mai multe culori, atât pe pleoapa de sus, cât și pe cea de jos.'), -- 49

('Ultimate Desire paletă cu farduri de ochi', 38.00, 'src/img/product50.webp', 1, 0, 15, 5, 17, 
'',
'Paleta pentru machiaj ochilor Makeup Revolution Ultimate Desire oferă posibilitatea creării celor mai fantastice variante de farduri de pleoape.',
'Se aplică umbrele pe pleoape cu peria, cu buretele de fond de ten sau cu buricele degetelor.'), -- 50

('Studio Fix Fluid fond de ten matifiant SPF 15', 157.00, 'src/img/product51.webp', 1, 0, 16, 5, 12, 
'',
'Descoperiți secretul unui ten de porțelan! Fondul de ten matifiant MAC Studio Fix Fluid, asigură un finisaj mat, natural, de lungă durată și protejează împotriva radiațiilor solare, SPF 15. Datorită texturii fluide, este foarte ușor de aplicat și acoperă eficient imperfecțiunile tenului.',
'Se aplică pe ten cu buretele de machiaj sau cu o pensulă destinată fondului de ten, prin tapotare.'), -- 51

('Cant Stop Wont Stop Full Coverage Foundation fond de ten cu acoperire ridicată', 85.00, 'src/img/product52.webp', 1, 0, 10, 5, 12, 
'WATER/AQUA/EAU, DIMETHICONE, ISODODECANE, NYLON-12, ACRYLATES/POLYTRIMETHYLSILOXYMETHACRYLATE COPOLYMER, SILICA, BUTYLENE GLYCOL, PEG-10 DIMETHICONE, ISOHEXADECANE, ISONONYL ISONONANOATE, PENTYLENE GLYCOL, SYNTHETIC FLUORPHLOGOPITE, BIS-PEG/PPG-14/14 DIMETHICONE, MAGNESIUM SULFATE, PHENOXYETHANOL, CAPRYLYL GLYCOL, ACRYLONITRILE/METHYL METHACRYLATE/VINYLIDENE CHLORIDE COPOLYMER, DISODIUM STEAROYL GLUTAMATE, DISTEARDIMONIUM HECTORITE, CALCIUM GLUCONATE, PERLITE, MAGNESIUM GLUCONATE, TOCOPHEROL, ALUMINUM HYDROXIDE, ISOBUTANE. MAY CONTAIN / PEUT CONTENIR (+/-)TITANIUM DIOXIDE (CI 77891), IRON OXIDES (CI 77491, CI 77492, CI 77499).',
'Un fond de ten care ține pasul cu dumneavoastră până la 24 de ore? Aveți încredere în fondul de ten Can‘t Stop Won‘t Stop, de la NYX Professional Makeup. Uniformizează perfect nuanța tenului, îi conferă un aspect mat și rezistă în stare perfectă toată ziua.',
'Fondul de ten se întinde pe față cu ajutorul buretelui aplicator și se întinde uniform, dinspre centrul feței spre exterior.'), -- 52

('Infaillible 32H Fresh Wear fard lichid de lunga durata', 77.00, 'src/img/product53.webp', 1, 0, 5, 5, 12, 
'AQUA / WATER, DIMETHICONE, ISODODECANE, ALCOHOL DENAT., ETHYLHEXYL METHOXYCINNAMATE, TRIMETHYLSILOXYSILICATE, BUTYLENE GLYCOL, TITANIUM DIOXIDE [NANO] / TITANIUM DIOXIDE, PEG-10 DIMETHICONE, PERLITE, SYNTHETIC FLUORPHLOGOPITE, NYLON-12, ISOPROPYL LAUROYL SARCOSINATE, DIISOPROPYL SEBACATE, HDI/TRIMETHYLOL HEXYLLACTONE CROSSPOLYMER, DISTEARDIMONIUM HECTORITE, BIS-PEG/PPG-14/14 DIMETHICONE, MAGNESIUM SULFATE, ALUMINUM HYDROXIDE, PHENOXYETHANOL, DISODIUM STEAROYL GLUTAMATE, HYDROGEN DIMETHICONE, CELLULOSE, DIPENTAERYTHRITYL TETRAHYDROXYSTEARATE/TETRAISOSTEARATE, ASCORBYL GLUCOSIDE, SILICA SILYLATE, PARFUM / FRAGRANCE, CALCIUM ALUMINUM BOROSILICATE, TOCOPHEROL, SILICA, HEXYL CINNAMAL, BENZYL SALICYLATE, BHT, LINALOOL, ALPHA-ISOMETHYL IONONE, BENZYL ALCOHOL, CITRONELLOL, [+/- MAY CONTAIN: CI 77891 / TITANIUM DIOXIDE, CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 77163 / BISMUTH OXYCHLORIDE, MICA]. (F.I.L. Z285169/1).',
'Bucurați-vă de un ten fără cusur. Loreal Paris prezintă Infaillible, inovatorul fond de ten care rezistă întreaga zi fără retușuri, permițând în același timp tenului să respire liber. Fondul de ten Loreal Paris Infaillible nu creează un efect de mască, iar formula sa specială rezistă la apă, la transpirație și la transfer. Datorită consistenței ultra-fine, Loreal Infaillible este ușor de întins, uniformizează tonul pielii și lasă o senzație durabilă, de prospețime și confort.',
'Fondul de ten Infaillible, de la Loreal, se aplică pe față folosind degetele, peria sau buretele de machiaj și se întinde uniform.'), -- 53

('Nude Drop Tinted Serum Foundation', 48.00, 'src/img/product33.webp', 1, 0, 13, 5, 12, 
'AQUA (WATER), ISODODECANE, DIMETHICONE, HYDROGENATED POLYDECENE, GLYCERIN, C12-15 ALKYL BENZOATE, PEG-10 DIMETHICONE, DIMETHICONE CROSSPOLYMER, BUTYLENE GLYCOL, CETYL PEG/PPG-10/1 DIMETHICONE, SILICA, TRIMETHYLSILOXYSILICATE, SODIUM HYALURONATE, TOCOPHEROL, SODIUM CHLORIDE, MAGNESIUM SULFATE, TOCOPHERYL ACETATE, TRIETHOXYCAPRYLYLSILANE, DISTEARDIMONIUM HECTORITE, METHICONE, PROPYLENE CARBONATE, ETHYLHEXYLGLYCERIN, ALUMINUM HYDROXIDE, PHENOXYETHANOL, SODIUM BENZOATE, SODIUM DEHYDROACETATE, BENZOIC ACID, DEHYDROACETIC ACID, CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
'Fondul de ten Catrice Nude Drop Tinted Serum Foundation uniformizează nuanța pielii, acoperind micile imperfecțiuni.',
'Se aplică fondul de ten pe punctele de bază ale feței, și anume fruntea, obrajii și bărbia. A se agita, înainte de utilizare.'), -- 54

('Mineral Finishing Powder', 48.00, 'src/img/product55.webp', 1, 0, 10, 5, 13, 
'SILICA, TALC, DIMETHICONE, METHYLPARABEN, PROPYLPARABEN.MAY CONTAIN / PEUT CONTENIR (+/-)IRON OXIDES (CI 77491, 77492, 77499).',
'Este aproape invizibilă pe piele și, totuși, reușește lucruri uimitoare. Pudra minerală NYX Professional Makeup Mineral Finishing Powder oferă feței un aspect mat, prelungește persistența machiajului și acoperă imperfecțiunile minore. Are un finisaj catifelat, este incredibil de ușoară și arată foarte natural.',
'Aplicați pudra pe față, cu peria sau cu puful. Poate fi aplicată atât peste un fond de ten, cât și individual, pe tenul hidratat și nemachiat.'), -- 55

('All Matt Plus', 18.00, 'src/img/product56.webp', 1, 0, 13, 5, 13, 
'TALC, ZINC STEARATE, ETHYLHEXYL PALMITATE, DIMETHYLIMIDAZOLIDINONE RICE STARCH, PHENYL TRIMETHICONE, OCTYLDODECYL STEAROYL STEARATE, GLYCERYL CAPRYLATE, p-ANISIC ACID, TOCOPHERYL ACETATE, SODIUM POTASSIUM ALUMINUM SILICATE, SILICA, PARFUM (FRAGRANCE), CI 77491 (IRON OXIDES), CI 77492 (IRON OXIDES), CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
'Un ten perfect uniform și matifiat este baza oricărui machiaj - indiferent dacă doriți să creați un look fin și natural sau un machiaj intens de seară. Pudra matifiantă Catrice All Matt Plus matifiază tenul timp de până la 12 ore, fixează machiajul și, datorită pigmenților care reflectă lumina, conferă tenului un aspect natural fresh.',
'Aplicați pudra pe față, cu peria sau buretele. Poate fi aplicată atât pe tenul hidratat și nemachiat, cât și peste un fond de ten.'), -- 56

('Mineralize Skinfinish Natural', 164.00, 'src/img/product57.webp', 1, 0, 16, 5, 13, 
'',
'Reprezintă cireașa de pe tort a oricărui machiaj și va fixa fondul de ten, astfel încât dvs. să vă puteți bucura de un aspect perfect o zi întreagă. Despre ce este vorba? Desigur, despre pudra MAC Cosmetics Mineralize Skinfinish Natural, cu pigmenți strălucitori delicați și un finisaj catifelat. Datorită conținutului de vitamina E și a unui complex mineral, tenul dvs. va fi iluminat și vă veți putea bucura de senzația de confort și de un aspect natural.',
'Aplicați pudra MAC Cosmetics Mineralize Skinfinish Natural pe față, cu ajutorul unei pensule mari pentru pudră, și estompați-o din centrul feței înspre exterior.'), -- 57

('Cheek Kit', 24.00, 'src/img/product58.webp', 1, 0, 16, 5, 15, 
'SHADES 1,2: MICA, MAGNESIUM ALUMINUM SILICATE, NYLON-12, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDE ( CI 77491). SHADE 3: MICA, NYLON-12, MAGNESIUM ALUMINUM SILICATE, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDES ( CI 77491, 77492, 77499). SHADE 4: MICA, SYNTHETIC FLUORPHLOGOPITE, MAGNESIUM ALUMINUM SILICATE, NYLON-12, PARAFFINUM LIQUIDUM/MINERAL OIL/HUILE MINERALE, ETHYLHEXYL PALMITATE, POLYBUTENE, DIMETHICONE, PHENOXYETHANOL, METHYLPARABEN, TITANIUM DIOXIDE ( CI 77891), IRON OXIDE ( CI 77491).',
'Paleta Makeup Revolution Cheek Kit cu nuanțe calde și reci, evidențiază contururile chipului, luminează fața, acoperă imperfecțiunile datorită pigmentării intense și dă un aspect profesional.',
'Cu Makeup Revolution Cheek Kit se poate atinge un look de înaltă calitate și fără mari cunoștințe în ale make-up-ului profesional. Se aplică nuanțele mai închise în adâncituri (precum se aplică bronzerul), iar nuanțele mai aprinse pe porțiunile care doriți să fie evidențiate.'), -- 58

('Dior Forever Couture Luminizer', 222.00, 'src/img/product59.webp', 1, 0, 12, 5, 15, 
'',
'Iluminatorul Dior Forever Couture Luminizer ii confera tenului un efect irizat spectaculos si ii amplifica luminozitatea.
Cu o concentratie ridicata de pigmenti sidefati cu stralucire multidimensionala, compusi din 95%** pigmenti de origine naturala, pudra iluminatoare fuzioneaza impecabil cu pielea, oferindu-i machiajului o rezistenta optima de dimineata pana seara.
Infuzat cu extract de pansea salbatica, iluminatorul protejeaza hidratarea naturala a pielii: pe toata durata zilei, confortul este garantat.',
'1. Cu ajutorul pensulei Dior Backstage Blush Brush N° 16, se aplica tuse de pudra iluminatoare Dior Forever Couture Luminizer pe contururile faciale.
2. Se incheie cu o tusa pe arcul lui Cupidon, pentru un efect de stralucire.

1. Efect sidefat surprinzator fara niciun compromis, datorita combinatiei de rezistenta si confort oferite de pudra iluminatoare Dior.
2. O pudra delicata, imbogatita cu extract floral si compusa din 95%* pigmenti de origine naturala, pentru a proteja hidratarea pielii.
3. Luminozitate intr-un format practic si ultrasubtire, couture .'), -- 59

('Bubble Balm', 25.00, 'src/img/product60.webp', 1, 0, 15, 5, 15, 
'MICA, TALC, DIMETHICONE, MAGNESIUM STEARATE, CALCIUM ALUMINUM BOROSILICATE, METHYLPARABEN, PROPYLPARABEN, TIN OXIDE, CI 77891 (TITANIUM DIOXIDE), CI 77491 (IRON OXIDES).',
'Iluminatorul Makeup Revolution Bubble Balm conferă chipului un aspect sănătos și plin de vitalitate.',
'Se aplică pe zonele feței care necesită accentuare și iluminare.'), -- 60

('Rue Royale Limited Edition', 73.00, 'src/img/product61.webp', 1, 0, 5, 5, 16, 
'',
'Bronzerul L’Oréal Paris Rue Royale Limited Edition îmbunătățește aspectul tenului și îi conferă un efect de bronz lejer.',
'Pentru un efect de bronz, se aplică o cantitate mică pe întreaga față. Pentru definirea feței și evidențierea contururilor, se va aplica pe părțile laterale ale frunții, sub pomeți, în josul bărbiei și pe marginile nasului.'), -- 61

('Matte Bronzer', 53.00, 'src/img/product62.webp', 1, 0, 10, 5, 16, 
'',
'Descoperiți produsul ideal pentru un aspect impecabil, care nu vă îngreunează geanta nici în cea mai lungă călătorie! Bronzerul NYX Professional Makeup Matte Bronzer lasă tenul neted și catifelat asigurând un efect de bronz confortabil care rezistă mult timp. Datorită texturii lejere puteți obține rapid și ușor un ten ca „sărutat de soare” fără ca măcar să petreceți timp pe plajă.',
'Pentru un efect de bronz lejer, aplicați o cantitate mică de pudră pe întreaga față. Pentru definirea feței și evidențierea contururilor, se va aplica pe părțile laterale ale frunții, sub pomeți, în josul bărbiei și pe marginile nasului.'), -- 62

('Mega Bronzer', 24.00, 'src/img/product63.webp', 1, 0, 15, 5, 16, 
'TALC, MICA, MAGNESIUM STEARATE, KAOLIN, ETHYLHEXYL PALMITATE, PARAFFINUM LIQUIDUM (MINERAL OIL, HUILE MINERALE), DIMETHICONE, POLYBUTENE, METHYLPARABEN, PROPYLPARABEN. I+/- MAY CDNTAIN EUT CONTENIR: IRON OXIDES (CL 77491, CL 77492, CL 77499)',
'Oferiți tenului dumneavoastră un aspect sărutat de soare cu pudra bronzantă  Makeup Revolution Mega Bronzer! Formula pudrată, compactă, cu finisaj mat oferă un aspect natural, bronzat al pielii conturând perfect forma feței.',
'Folosiți o pensulă destinată pudrei bronzante și aplicați foarte delicat pe întreaga față pentru un ten sărutat de soare sau utilizați pe pomeți, deasupra frunții, nasului și a bărbiei pentru a vă contura trăsăturile.'), -- 63

('Instant Anti Age Eraser', 47.00, 'src/img/product64.webp', 1, 0, 14, 5, 14,
'AQUA / WATER, DIMETHICONE, ISODODECANE, GLYCERIN, PEG-9 POLYDIMETHYLSILOXYETHYL DIMETHICONE, PROPYLENE GLYCOL, DISTEARDIMONIUM HECTORITE, SILICA, DIMETHICONE CROSSPOLYMER, PEG-10 DIMETHICONE, CETYL PEG/PPG-10/1 DIMETHICONE, PHENOXYETHANOL, SODIUM CHLORIDE, POLYGLYCERYL-4 ISOSTEARATE, CAPRYLYL GLYCOL, DISODIUM STEAROYL GLUTAMATE, ETHYLHEXYLGLYCERIN, CHLORPHENESIN, ALUMINUM HYDROXIDE, STEARETH-20, LYCIUM BARBARUM FRUIT EXTRACT, CHLORHEXIDINE DIGLUCONATE, SODIUM BENZOATE, N-HYDROXYSUCCINIMIDE, LACTIC ACID, POTASSIUM SORBATE, TOCOPHEROL, SODIUM CITRATE, PALMITOYL TRIPEPTIDE-1, CHRYSIN, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE',
'Pentru un look proaspăt și strălucitor, instantaneu. Corectorul lichid Maybelline Age Rewind camuflează eficient cearcănele, iluminând vizibil zona din jurul ochilor.',
'Pasul 1: Răsuciți partea inferioară a aplicatorului și corectorul îmbibă buretele. Pasul 2: Aplicați o cantitate mică de corector sub ochi, pentru camuflarea cearcănelor. Pasul 3: Pentru iluminarea întregii zone perioculare, aplicați produsul în triunghi, sub ochi și de-a lungul marginilor nasului.'), -- 64

('Cant Stop Wont Stop', 47.00, 'src/img/product65.webp', 1, 0, 10, 5, 14, 
'WATER/AQUA/EAU, CYCLOPENTASILOXANE, METHYL METHACRYLATE CROSSPOLYMER, CYCLOHEXASILOXANE, BUTYLENE GLYCOL, PEG-10 DIMETHICONE, TRIMETHYLSILOXYSILICATE, POLYGLYCERYL-3 POLYDIMETHYLSILOXYETHYL DIMETHICONE, SILICA DIMETHYL SILYLATE [NANO], SODIUM CHLORIDE, TRIETHOXYCAPRYLYLSILANE, DIMETHICONE, DIMETHICONE/VINYL DIMETHICONE CROSSPOLYMER, ALUMINUM HYDROXIDE, DISODIUM EDTA, PROPYLENE CARBONATE, DISTEARDIMONIUM HECTORITE, ETHYLHEXYLGLYCERIN, CETYL PEG/PPG-10/1 DIMETHICONE, TOCOPHEROL, PENTAERYTHRITYL TETRA-DI-T-BUTYL HYDROXYHYDROCINNAMATE, PHENOXYETHANOL. MAY CONTAIN / PEUT CONTENIR (+/-)IRON OXIDES (CI 77491, CI 77492, CI 77499), TITANIUM DIOXIDE (CI 77891).',
'Acoperă imperfecțiunile, accentuează atuurile și trăsăturile naturale ale feței și iluminează tenul - toate acestea sunt atributele corectorului lichid NYX Professional Makeup Can‘t Stop Won‘t Stop. Este foarte pigmentat, de aceea acoperă excelent coșurile și alte imperfecțiuni. Este minunat și la iluminarea zonei obosite de sub ochi și, în plus, se usucă producând un finisaj mat, deci arată mereu natural.

Corectorul multifuncțional Can‘t Stop Won‘t Stop este disponibil într-o gamă largă de nuanțe, pe care le puteți combina după dorință, pentru a crea o nuanță personalizată, specială pentru dvs. Rezistă pe piele până la 24 de ore, iar dvs. vă puteți bucura de un aspect perfect întreaga zi.',
'Tapotați ușor sub ochi, pe coșuri și pe celelalte imperfecțiuni ale tenului și întindeți folosind buretele sau pensula pentru corector.'), -- 65

('True Skin', 24.00, 'src/img/product66.webp', 1, 0, 13, 5, 14, 
'AQUA (WATER), TALC, DIMETHICONE, DICAPRYLYL ETHER, CETYL PEG/PPG-10/1 DIMETHICONE, GLYCERIN, ISODODECANE, TRIMETHYLSILOXYSILICATE, SODIUM HYALURONATE, TOCOPHEROL, HYDROGEN DIMETHICONE, SODIUM CHLORIDE, MAGNESIUM SULFATE, POLYSILICONE-11, DISTEARDIMONIUM HECTORITE, STEVIA REBAUDIANA EXTRACT, PROPYLENE CARBONATE, ETHYLHEXYLGLYCERIN, LAURETH-12, ALUMINUM HYDROXIDE, PHENOXYETHANOL, SODIUM DEHYDROACETATE, POTASSIUM SORBATE, BENZOIC ACID, DEHYDROACETIC ACID, SORBIC ACID, PARFUM (FRAGRANCE), CI 77491, CI 77492, CI 77499 (IRON OXIDES), CI 77891 (TITANIUM DIOXIDE).',
'Ascundeți imperfecțiunile și hidratați tenul cu corectorul lichid Catrice True Skin. Are o formulă ușoară care nu încarcă tenul și îi oferă lejeritate în purtare. Puterea sa de acoperire este una medie spre mare, cu o rezistență de până la 18 ore. Micile imperfecțiuni nu mai sunt o bătaie de cap!',
'Aplicați corectorul pe umbrele nedorite, roșeață sau imperfecțiuni. Împingeți produsul în piele cu ajutorul burețelului de machiaj sau a degetelor.'), -- 66

('Wild Hibiscus', 28.00, 'src/img/product67.webp', 1, 0, 13, 5, 26, 
'RICINUS COMMUNIS (CASTOR) SEED OIL, BIS-DIGLYCERYL POLYACYLADIPATE-1, OCTYLDODECANOL, CAPRYLIC/CAPRIC TRIGLYCERIDE, EUPHORBIA CERIFERA (CANDELILLA) WAX, SYNTHETIC WAX, CETYL ALCOHOL, COPERNICIA CERIFERA (CARNAUBA) WAX, HIBISCUS SABDARIFFA SEED OIL, BUTYROSPERMUM PARKII (SHEA) BUTTER, SILICA, TOCOPHEROL, HELIANTHUS ANNUUS (SUNFLOWER) SEED OIL, VACCINIUM MACROCARPON (CRANBERRY) SEED OIL, CAPRYLYL GLYCOL, HEXYLENE GLYCOL, LECITHIN, ASCORBYL PALMITATE, ROSMARINUS OFFICINALIS (ROSEMARY) FLOWER EXTRACT, PHENOXYETHANOL, PARFUM (FRAGRANCE), CI 15850 (RED 7 LAKE), CI 45380 (RED 21), CI 77492 (IRON OXIDES).',
'Tratamentul special pentru buze Catrice Wild Hibiscus asigură buze și mai frumoase.',
'Aplicați o cantitate mică pe buzele curate și împrejurul acestora, apoi lăsați să se absoarbă.'), -- 67

('Hemp & Mint Glow', 28.00, 'src/img/product68.webp', 1, 0, 13, 5, 26, 
'POLYISOBUTENE, CAPRYLIC/CAPRIC TRIGLYCERIDE, CERA MICROCRISTALLINA (MICROCRYSTALLINE WAX), EUPHORBIA CERIFERA (CANDELILLA) WAX, ETHOXYDIGLYCOL, PRUNUS AMYGDALUS DULCIS (SWEET ALMOND) OIL, CANNABIS SATIVA SEED OIL, MENTHOL, TOCOPHERYL ACETATE, GLYCINE SOJA (SOYBEAN) OIL, TOCOPHEROL, CAPRYLYL GLYCOL, ETHYLHEXYL PALMITATE, GLYCERIN, CAPRYLHYDROXAMIC ACID, BETA-SITOSTEROL, SQUALENE, RICINUS COMMUNIS (CASTOR) SEED OIL, CITRIC ACID, CI 19140 (YELLOW 5 LAKE), CI 45410 (RED 27 LAKE), CI 61565 (GREEN 6). THC 0 %.',
'Tânjiți după buze cu aspect mai plin? Folosiți balsamul de buze Catrice Hemp & Mint Glow, cu care buzele devin instantaneu mai pline și mai hidratate. Accentuează culoarea naturală a buzelor, lăsându-le fine și moi. Mentolul are un efect plăcut răcoritor.',
'Aplicați pe buze în orice moment al zilei, după cum este necesar.'), -- 68

('Glow Play Lip Balm', 112.00, 'src/img/product69.webp', 1, 0, 16, 5, 26, 
'',
'Dacă tânjiți după efectele balsamului, dar nu vă puteți lipsi nici de ruj, alegeți un balsam nuanțator lucios, care hrănește și colorează ușor buzele. Balsamul de buze nutritiv, Glow Play Lip Balm MAC Cosmetics, conține ingrediente benefice pentru buzele dvs., precum untul de shea și uleiurile din semințe de mango și de jojoba. Bucurați-vă de buze lucioase și hidratate, cu o aură de culoare seducătoare.',
'Aplicați balsamul de buze Glow Play Lip Balm direct pe buze.'), -- 69

('Green Edition', 51.00, 'src/img/product70.webp', 1, 0, 14, 5, 26, 
'CANOLA OIL, SQUALANE, PENTAERYTHRITYL TETRAISOSTEARATE, BIS-BEHENYL/ISOSTEARYL/PHYTOSTERYL DIMER DILINOLEYL DIMER DILINOLEATE, HELIANTHUS ANNUUS SEED CERA / SUNFLOWER SEED WAX, CAPRYLIC/CAPRIC TRIGLYCERIDE, CANDELILLA CERA / CANDELILLA WAX, TOCOPHEROL, ALUMINA, GLYCINE SOJA OIL / SOYBEAN OIL, LINALOOL, ALUMINUM HYDROXIDE, LIMONENE, HELIANTHUS ANNUUS SEED OIL / SUNFLOWER SEED OIL, MANGIFERA INDICA SEED OIL / MANGO SEED OIL, SILICA, BENZYL ALCOHOL, CITRAL, BENZYL SALICYLATE, CITRIC ACID, BARIUM SULFATE, COLOPHONIUM / ROSIN, PARFUM / FRAGRANCE, [+/- MAY CONTAIN: MICA, CI 77891 / TITANIUM DIOXIDE, CI 77491, CI 77492, CI 77499 / IRON OXIDES, CI 15850 / RED 7, CI 45380 / RED 22 LAKE, CI 45410 / RED 28 LAKE, CI 15985 / YELLOW 6 LAKE, CI 19140 / YELLOW 5 LAKE, CI 42090 / BLUE 1 LAKE, CI 15850 / RED 7 LAKE]. (F.I.L. Z281006/3).',
'Tratamentul special pentru buze Maybelline Green Edition asigură buze și mai frumoase.',
'Se aplică un strat uniform de culoare pe buze, folosind aplicatorul.'); -- 70

-- select * from products;