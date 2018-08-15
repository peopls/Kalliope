#!/usr/bin/ruby

@rules = [
'V /V',    
'A /A',    
'T /T',    
'B /B',    
'S /S',    
'E /E',    
'oeg/æg',
'hoi/høi',
'hoj/høj',
'hsj/høj',
'folg/følg',
'fslge/følge',
'Skjod/Skjød',
'Skjon/Skjøn',
'skjon/skjøn',
'ffjon/skjøn',
'ssjon/skjøn',
'sijon/skjøn',
'stjon/skjøn',
'stjsn/skjøn',
'kjobe/kjøbe',
'doem/dæm',
'ce/æ',
'dfk/dsk',
'fkj/skj',
'fke/ske',
'oenk/ænk',
'Sæne/Scene',
'Oæan/Ocean',
'Bolg/Bølg',
'Hoi/Høi',
'Hoj/Høj',
'Hsi/Høi',
'Hoy/Høy',
'Hsy/Høy',
'Hpi/Høi',
'Hoj/Høj',
'Slor/Slør',
'Udlob/Udløb',
'Trsst/Trøst',
'Son/Søn',
'Ssn/Søn',
'Soen/Søen',
' rod/ rød',
'elfl/elsk',
'Solv/Sølv',
'Brond/Brønd',
'msrk/mørk',
'Msrk/Mørk',
'Mvrk/Mørk',
'Vlad/Blad',
'Bloes/Blæs',
'Gjog/Gjøg',
'modte/mødte',
'tsr/tør',
'Tsn/Tøn',
'bsn/bøn',
'gjor/gjør',
'gjvr/gjør',
'gjsr/gjør',
'Gjsr/Gjør',
'gjørt/gjort',
'gjørd/gjord',
'sial/skal',
'Ncer/Nær',
'M /M',
'scrt/sæt',
' stal/ skal',
'stodt/stødt',
'stsd/stød',
'storre/større',
'ftaae/staae',
'Oie/Øie',
'Oje/Øje',
'Ojne/Øjne',
'bce/bæ',
'Son /Søn ',
'Doren/Døren',
'Trest/Trøst',
'oi/øi/',
' Dod/ Død',
'S a a /Saa ',
'S a a/Saa',
'sortal/fortæl',
' sor / for ',
' soer/ foer',
'hsie/høie',
'heie/høie',
'hsit/høit',
'hvit/høit',
'Heit/Høit',
'hole/høie',
'soette/sætte',
'styld/skyld',
'Styld/Skyld',
'O g /Og ',
'Krast/Kraft',
'Kroeft/Kræft',
'forst(\W)/først\1',
'forste(\W)/første\1',
'førfte/første',
'tankte/tænkte',
'toenkt/tænkt',
'toend/tænd',
'voel/væl',
'svoev/svæv',
'svave/svæve',
'svsm/svøm',
'Svsm/Svøm',
'Svsb/Svøb',
'svsb/svøb',
'foerd/færd',
'stanke/stærke',
'speede/spæde',
'Lce/Læ',
'troeng/træng',
'troeder/træder',
'voede/væde',
'rce/ræ',
'loft/løft',
'lvft/løft',
'giore/giøre',
'flut/slut',
'siue/skue',
' flue/ skue',
' fode / føde ',
'fodt/født',
'fsdt/født',
'fsde/føde',
'nogn/nøgn',
'ipn/iøn',
'mce/mæ',
'Moen/Mæn',
'kloed/klæd',
'spoend/spænd',
'cen/æn',
'sæne/scene',
'Sæne/Scene',
'Rost/Røst',
'Rsst/Røst',
'Rvst/Røst',
'Gled/Glød',
'grod/grød',
'Grod/Grød',
'Fce/Fæ',
'cel/æl',
'ceb/æb',
'ced/æd',
'cer/ær',
'cet/æt',
'ceg/æg',
'cem/æm',
'cev/æv',
'crd/æd',
'crb/æb',
'crm/æm',
'crg/æg',
'crf/æf',
'crv/æv',
'crk/æk',
'crl/æl',
'crn/æn',
'crt/æt',
'crs/æs',
'Bp/Bø',
'Orne/Ørne',
'Oin/Øin',
'skion/skiøn',
'Groes/Græs',
'Skion/Skiøn',
'sierne/fierne',
'sorge/sørge',
'solvblaa/sølvblaa',
'rodme/rødme',
'rsdme/rødme',
'flimte/skimte',
' sode / søde ',
'sodt/sødt',
'Sodt/Sødt',
'Sodme/Sødme',
'smoekre/smækre',
'moel/mæl',
'Roeds/Ræds',
'Doem/Dæm',
'troste/trøste',
'troste/trøste',
'lobe/løbe',
'lvbe/løbe',
'tydste/tydske',
'rort/rørt',
'rvrt/rørt',
'rore/røre',
'rovet/røvet',
'prove/prøve',
'Prove/Prøve',
'Fadre/Fædre',
'Lanke/Lænke',
'Kjob/Kjøb',
'bonh/bønh',
'bonlig/bønlig',
'danste/danske',
'Jgjen/Igjen',
'Jdee/Idee',
'Jt/It',
'forte /førte ',
' vard/ værd',
'voerd/værd',
'Voerd/Værd',
'Voerk/Værk',
'Voer(\W)/Vær\1',
'fvoerg/sværg/',
'Voeld/Væld',
'fpl/føl',
'fvl/føl',
'fsr/før',
' fer/ før',
'elst/elsk',
'oedle/ædle',
'Redme/Rødme',
'Rodme/Rødme',
'Jnd/Ind',
'Jf/If',
'Jl/Il',
'ZE/Æ',
'LE/Æ',
'Sial/Siæl',
'Sjal/Sjæl',
'Sjoel/Sjæl',
'Loer/Lær',
'loer/lær',
'flukt/slukt',
'fmile/smile',
'Skrak/Skræk',
'Traer/Træer',
'Trerer/Træer',
'Laber/Læber',
'loenge/længe',
'Loeber/Læber',
'Langse/Længse',
'Langsl/Længsl',
'(\W)langes/\1længes',
'(\W)ftr/\1str',
'(\W)fpr/\1spr',
# 'Dine/Øine', # Volder mange fejl, så udkommenteret
'loeng/læng',
'Onske/Ønske',
'(\W)onste/\1ønske',
'drom/drøm',
'drsm/drøm',
'Drom/Drøm',
'Drsm/Drøm',
'Drem/Drøm',
'Boge/Bøge',
'Bslg/Bølg',
'(\W)fsle/\1føle',
'Bon(\W)/Bøn\1',
'Bvn(\W)/Bøn\1',
'Bonner/Bønner',
'Bonnen/Bønnen',
'Bonder/Bønder',
'Sporg/Spørg',
'Folg/Følg',
'Folelse/Følelse',
'Fodsel/Fødsel',
'Boek/Bæk',
'kjoek/kjæk',
'sporg/spørg',
'spsrg/spørg',
'Spsrg/Spørg',
'labe/læbe',
'overste/øverste',
'storst/størst',
'Strom/Strøm',
'Strem/Strøm',
'Strsm/Strøm',
'strom/strøm',
'hore/høre',
'hsre/høre',
'hort/hørt',
'hor(\W)/hør\1',
'hsrt/hørt',
'hvrt/hørt',
'hsire/høire',
'voere/være',
'Voer/Vær',
'soenk/sænk',
'fkab/skab',
'(\W)stab/\1skab',
'(\W)strar(\W)/\1strax\2',
'(\W)rafle(\W)/\1raske\2',
'(\W)raste(\W)/\1raske\2',
'(\W)omt(\W)/\1ømt\2',
'(\W)smt(\W)/\1ømt\2',
'(\W)bersmt/\1berømt',
'(\W)prsv/\1prøv',
'(\W)Kjsb/\1Kjøb',
'(\W)troet/\1træt',
'(\W)No(\W)/\1Ro\2',
'(\W)noevne(\W)/\1nævne\2',
'beromte/berømte',
'(\W)ssgt/\1søgt',
'(\W)spog/\1spøg',
'(\W)spsg/\1spøg',
'(\W)Spog/\1Spøg',
'(\W)Spsg/\1Spøg',
'cr/er',
'Soster/Søster',
'Sostre/Søstre',
'Sostre/Søstre',
'Osten/Østen',
'Øft/Øst',
'Kjon/Kjøn',
'voev/væv',
'nc/ne',
'gcn/gen',
'„/,,',
'"/\'\'',
' , /, ',
' ;/;',
' :/:',
' !/!',
'(\W)fom(\W)/\1som\2',
'(\W)soge(\W)/\1søge\2',
'(\W)ssge(\W)/\1søge\2',
'(\W)soger(\W)/\1søger\2',
'(\W)ssger(\W)/\1søger\2',
'(\W)vg(\W)/\1og\2',
'gbed/ghed',
'nbed/nhed',
'fole/føle',
'folte/følte',
'fslte/følte',
'doe(\W)/døe\1',
'doer(\W)/døer\1',
'Doe(\W)/Døe\1',
'Ded(\W)/Død\1',
'Deden(\W)/Døden\1',
'fidst(\W)/sidst\1',
'Dsd/Død',
'Dvd/Død',
'Udbrod/Udbrød',
'dsd/død',
'rvm/røm',
'flige/slige',
'fligt/sligt',
'flumre/slumre',
'bolge/bølge',
'bslge/bølge',
'boie/bøie',
'bsie/bøie',
'beier/bøier',
'(\W)flj/\1skj',
'(\W)fig(\W)/\1sig\2',
'(\W)nn(\W)/\1nu\2',
'(\W)oved(\W)/\1øved\2',
'(\W)rod(\W)/\1rød\2',
'(\W)rode(\W)/\1røde\2',
'(\W)Dre(\W)/\1Øre\2',
'(\W)Ore(\W)/\1Øre\2',
'(\W)Oret(\W)/\1Øret\2',
'(\W)lsd(\W)/\1lød\2',
'(\W)Lsd(\W)/\1Lød\2',
'(\W)Dn(\W)/\1Du\2',
'(\W)Nn(\W)/\1Nu\2',
'(\W)herste/\1herske',
'nnd/und',
'Iord/Jord',
'Nost/Røst',
'Trost/Trøst',
'Die/Øie',
'Dg/Og',
'O g /Og ',
'mrne/mme',
'lonlig/lønlig',
'svomme/svømme',
'kjolig/kjølig',
'kjsn/kjøn',
'kjob/kjøb',
'kjvn/kjøn',
'kjon/kjøn',
'strs/strø',
'lose/løse',
'jeel/jæl',
'Mre/Ære',
'Wre/Ære',
'Wth/Æth',
'AZre/Ære',
'AZlde/Ælde',
'Wg/Æg',
'bun /bun ',
'fngl/fugl',
'Fngl/Fugl',
'eek/æk',
' ban / han ',
'Foedre/Fædre',
'roeb/ræb',
'morke/mørke',
'moerke/mørke',
'morkt/mørkt',
'(\W)mork(\W)/\1mørk\2',
'(\W)mode(\W)/\1møde\2',
'(\W)hor(\W)/\1hør\2',
'imsde/imøde',
'Morke/Mørke',
'Morkt/Mørkt',
'Nod/Nød',
'Nsd/Nød',
'floi/fløi',
'Floi/Fløi',
'Torst/Tørst',
'Hnn(\W)/Hun\1',
'Hor(\W)/Hør\1',
'Dor(\W)/Dør\1',
'Bon(\W)/Bøn\1',
'Ovi[^d]/Qvi\1', # Qvinde, Quist
'Aftenrode/Aftenrøde',
'Morgenrode/Morgenrøde',
'rosenrode/rosenrøde',
' rode / røde ',
' tor / tør ',
'torste/tørste',
'sog/søg',
'(\W)flg(\W)/\1sig\2',
'dod/død',
'stott/støtt',
'Sovn/Søvn',
'Ssvn/Søvn',
'sovn/søvn',
'born/børn',
'Born/Børn',
'Bsrn/Børn',
'Brodre/Brødre',
'Brsdre/Brødre',
'gian/glan',
'Gian/Glan',
'Lon/Løn',
'Lsn/Løn',
'Lofter/Løfter',
'Lofted/Løfted',
'Lovet/Løvet',
'Lsvet/Løvet',
'Voekke/Vække',
'frelske/frelste',
'Ilv/Hv',
'Jis/Iis',
'Elstov/Elskov',
'Elstov/Elskov',
'Elssov/Elskov',
'Elste/Elske',
'Elsse/Elske',
'Elflov/Elskov',
'Elsie/Elske',
'Elfl/Elsk',
'elsie/elske',
'flaaer/slaaer',
'dolge/dølge',
'los /løs ',
'lost/løst',
'Kløster/Kloster',
'imode/imøde',
'blode/bløde',
'blsd/blød',
'bloe/blæ',
'blodt/blødt',
'gron/grøn',
'grsn/grøn',
'grvn/grøn',
'Gron/Grøn',
'Grsn/Grøn',
'Fodder/Fødder',
'kjar/kjær',
'kjoer/kjær',
'Kjerr/Kjær',
'Kjoer/Kjær',
' sra/ fra',
' flog/ slog',
' bun/ hun',
'krob/krøb',
'sterrk/stærk',
'stoerk/stærk',
'ftraa/straa',
'Sæpt/Scept',
'Sæne/Scene',
'tatte/tætte',
'Magtig/Mægtig',
'kolig/kølig',
' ester/ efter',
'bave/bæve',
'boere/bære',
'noerm/nærm',
'glode/gløde',
'Glod/Glød',
'Stov/Støv',
'Stvv/Støv',
'Stsv/Støv',
'Stevet/Støvet',
'Gloede/Glæde',
'Doemr/Dæmr',
'oeng/æng',
'sproel/spræl',
'Hander/Hænder',
'Hoende/Hænde',
'roend/rænd',
'hoev/hæv',
'roeder/ræder',
'Troeer/Træer',
'bedove/bedøve',
'Oval/Qval',
'Hoede/Hæde',
'Ssrge/Sørge',
'koemp/kæmp',
'Koemp/Kæmp',
'Kjoemp/Kjæmp',
'stjælv/skjælv',
'stjæn/skjæn',
'(\W)as(\W)/\1af\2',
'(\W)sug(\W)/\1siig\2',
'(\W)Huns(\W)/\1Huus\2',
'(\W)Dor(\W)/\1Dør\2',
'(\W)Sa a(\W)/\1Saa\2',
'(\W)P a a(\W)/\1Paa\2',
'(\W)H ar(\W)/\1Har\2',
'(\W)In d(\W)/\1Ind\2',
'(\W)D a(\W)/\1Da\2',
'(\W)D u(\W)/\1Du\2',
'(\W)O rd(\W)/\1Ord\2',
'(\W)D ig(\W)/\1Dig\2',
'(\W)D it(\W)/\1Dit\2',
'(\W)J a(\W)/\1Ja\2',
'(\W)v il(\W)/\1vil\2',
'(\W)t il(\W)/\1til\2',
'(\W)t il(\W)/\1til\2',
'(\W)Ti l(\W)/\1Til\2',
'(\W)t i l(\W)/\1til\2',
'(\W)Sj al(\W)/\1Sjæl\2',
'(\W)Sn a rt(\W)/\1Snart\2',
'(\W)Sv ar(\W)/\1Svar\2',
'(\W)D in(\W)/\1Din\2',
'(\W)In tet(\W)/\1Intet\2',
'(\W)J il(\W)/\1Iil\2',
'(\W)Jil(\W)/\1Iil\2',
'(\W)Sm iil(\W)/\1Smiil\2',
'(\W)Oer(\W)/\1Øer\2',
'Mo(\W)/Mø\1',
'Mø\'er/Mo\'er',
'So(\W)/Sø\1',
'Bie(\W)/Øie\1',
'fore(\W)/føre\1',
'Host(\W)/Høst\1',
'Hsst(\W)/Høst\1',
'Rog(\W)/Røg\1',
'mcd(\W)/med\1', 
'mcd(\W)/med\1', 
'tcs(\W)/tes\1', 
'tcd(\W)/ted\1', 
'Rogen/Røgen',
'Troek/Træk',
'troel/træl',
'(\W)noer/\1nær',
'(\W)Ost/\1Øst',
'(\W)voer/\1vær',
'(\W)stue/\1skue',
'(\W)fiue/\1skue',
'(\W)oerlig/\1ærlig',
'(\W)kjole/\1kjøle',
'fvæv/svæv',
'sonder/sønder',
'ssnder/sønner',
'lsnne/lønne',
'Logn/Løgn',
'lnk/luk',
'oedel/ædel',
'knoel/knæl',
'hoere/hære',
'Skjoeb/Skjæb',
'Skjoen/Skjæn',
'kjoek/kjæk',
'skjoend/skjænd',
'roek/ræk',
'Tjsrn/Tjørn',
'Klogt/Kløgt',
'Rodder/Rødder',
'Dsttre/Døttre',
'(\W)Fs/\1Fø',
'(\W)fk/\1sk',
'(\W)Forste/\1Første',
'(\W)Proest/\1Præst',
'(\W)noest/\1næst',
'(\W)voebne/\1væbne',
'(\W)gjoest/\1gjæst',
'(\W)Gjoest/\1Gjæst',
'(\W)Gjoest/\1Gjæst',
'gjoeves/gjæves',
'Dxe/Øxe',
'Dst/Øst',
'moend(\W)/mænd\1',
'Offiæ/Office',
'Froken/Frøken',
'Nand/Aand',
'moend(\W)/mænd\1',
'ramg/ræng',
'ramd/rænd',
'hamd/hænd',
'tamk/tænk',
'forfrist/forfrisk',
'Doren/Døren',
'Stoien/Støien',
'stoied/støied',
'Stoi(\W)/Støi\1',
'nnt/unt',
'tnr/tur',
'iff/isk',
'ssrg/sørg',
'kjsbe/kjøbe',
'Chør/Chor',
'Sø l/Sol',
'(\W)blod(\W)/\1blød\2',
'(\W)skjod(\W)/\1skjød\2',
];

@regexps = @rules.map { |rule| 
    m = /(.*)\/(.*)/.match(rule)
    [Regexp.new(m[1]), m[2]];
}

if ARGV.length != 1
  puts "Missing filename (try --help)"
  exit 0
end

text = File.open(ARGV[0]).read
text = text.gsub(/glode/,"gløde")
@regexps.each { |r| 
    text = text.gsub(r[0],r[1])
}
puts text

