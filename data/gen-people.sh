#!/bin/bash

# Output file
outputFile="$1"
size=${2:-2048}
SEED=12345
RANDOM=$SEED

# Sample data for random generation
firstNames=(
"Emma" "Olivia" "Noah" "Liam" "Sophia" "Ava" "Ethan" "Mason" "Mia" "Harper"
"Charlotte" "Amelia" "Evelyn" "Abigail" "Emily" "Ella" "Madison" "Scarlett"
"Victoria" "Aiden" "Jackson" "Logan" "Benjamin" "Lucas" "Jacob" "Michael"
"Alexander" "William" "Daniel" "Matthew" "James" "Carter" "Luke" "Emma"
"Ben" "Mia" "Paul" "Hanna" "Leon" "Sophia" "Finn" "Luisa" "Jonas" "Elias"
"Noah" "Lena" "Max" "Anna" "Felix" "Emil" "Lina" "Moritz" "Julian" "Lara"
"Linus" "Marie" "Leonie" "Luca" "Laura" "Lukas" "Nele" "Niklas" "Luis"
"Charlotte" "Henry" "Frieda" "Erik" "Lars" "Anders" "Ingrid" "Freja"
"Astrid" "Bjorn" "Stig" "Sven" "Nils" "Karin" "Signe" "Tove" "Lennart"
"Gunnar" "Birgit" "Magnus" "Elin" "Oskar" "Agnes" "Alva" "Axel" "Ella"
"Linnea" "Hugo" "Ida" "Maja" "Wilma" "Arvid" "Sigrid" "Greta" "Elias"
"Lovisa" "Emma" "Lucas" "Chloé" "Hugo" "Inès" "Louis" "Léa" "Gabriel"
"Jade" "Ethan" "Manon" "Raphaël" "Anna" "Jules" "Zoé" "Enzo" "Lola"
"Antoine" "Juliette" "Théo" "Lina" "Nathan" "Alice" "Léo" "Louise" "Mathis"
"Eva" "Axel" "Léna" "Maxime" "Clément" "Maëlys" "Alexis" "Sofia"
"Leonardo" "Aurora" "Alessandro" "Ginevra" "Lorenzo" "Giorgia" "Andrea"
"Martina" "Matteo" "Alice" "Gabriele" "Emma" "Francesco" "Chiara"
"Riccardo" "Anna" "Tommaso" "Giulia" "Davide" "Alessia" "Federico"
"Beatrice" "Giuseppe" "Elisa" "Vincenzo" "Sara" "Pietro" "Marta" "Marco"
"Giada" "Giovanni" "Sofia" "Sofía" "Mateo" "Martina" "Santiago"
"Valentina" "Sebastián" "Isabella" "Alejandro" "Camila" "Samuel" "Lucía"
"Diego" "Daniela" "Nicolás" "Victoria" "Gabriel" "Paula" "Daniel" "Carla"
"David" "Sara" "Adrián" "Alba" "Hugo" "Elena" "Ángel" "Julia" "Javier"
"Natalia" "Carlos" "Sofía" "Francisco" "Laura"
)
lastNames=(
"Smith" "Johnson" "Williams" "Jones" "Brown" "Davis" "Miller" "Wilson"
"Moore" "Taylor" "Anderson" "Thomas" "Jackson" "White" "Harris" "Martin"
"Thompson" "Garcia" "Martinez" "Robinson" "Clark" "Rodriguez" "Lewis"
"Lee" "Walker" "Hall" "Allen" "Young" "Hernandez" "King" "Wright" "Lopez"
"Hill" "Scott" "Green" "Adams" "Baker" "Gonzalez" "Nelson" "Carter"
"Mitchell" "Perez" "Roberts" "Turner" "Phillips" "Campbell" "Parker"
"Evans" "Edwards" "Collins" "Stewart" "Sanchez" "Morris" "Rogers"
"Reed" "Cook" "Morgan" "Bell" "Murphy" "Bailey" "Rivera" "Cooper" "Richardson"
"Cox" "Howard" "Ward" "Torres" "Peterson" "Gray" "Ramirez" "James" "Watson"
"Brooks" "Kelly" "Sanders" "Price" "Bennett" "Wood" "Barnes" "Ross"
"Henderson" "Coleman" "Jenkins" "Perry" "Powell" "Long" "Patterson"
"Hughes" "Flores" "Washington" "Butler" "Simmons" "Foster" "Gonzales"
"Bryant" "Alexander" "Russell" "Griffin" "Diaz" "Hayes" "Myers" "Ford"
"Hamilton" "Graham" "Sullivan" "Wallace" "Woods" "Cole" "West" "Jordan"
"Owens" "Reynolds" "Fisher" "Ellis" "Harrison" "Gibson" "McDonald"
"Cruz" "Marshall" "Ortiz" "Gomez" "Murray" "Freeman" "Wells" "Webb"
"Simpson" "Stevens" "Tucker" "Porter" "Hunter" "Hicks" "Crawford" "Henry"
"Boyd" "Mason" "Morales" "Kennedy" "Warren" "Dixon" "Ramos" "Reyes"
"Burns" "Gordon" "Shaw" "Holmes" "Rice" "Robertson" "Hunt" "Black"
"Daniels" "Palmer" "Mills" "Nichols" "Grant" "Knight" "Ferguson" "Rose"
"Stone" "Hawkins" "Dunn" "Perkins" "Hudson" "Spencer" "Gardner" "Stephens"
"Payne" "Pierce" "Berry" "Matthews" "Arnold" "Wagner" "Willis" "Ray"
"Watkins" "Olson" "Carroll" "Duncan" "Snyder" "Hart" "Cunningham"
"Bradley" "Lane" "Andrews" "Ruiz" "Harper" "Fox" "Riley" "Armstrong"
"Carpenter" "Weaver" "Greene" "Lawrence" "Elliott" "Chavez" "Sims"
"Austin" "Peters" "Kelley" "Franklin" "Lawson"
)
cities=(
"New York" "Los Angeles" "Chicago" "Houston" "Phoenix" "Philadelphia"
"San Antonio" "San Diego" "Dallas" "San Jose" "Austin" "Jacksonville"
"Fort Worth" "Columbus" "Charlotte" "San Francisco" "Indianapolis"
"Seattle" "Denver" "Washington" "Boston" "El Paso" "Nashville" "Detroit"
"Oklahoma City" "Portland" "Las Vegas" "Memphis" "Louisville" "Baltimore"
"Milwaukee" "Albuquerque" "Tucson" "Fresno" "Mesa" "Sacramento"
"Atlanta" "Kansas City" "Colorado Springs" "Miami" "Raleigh" "Omaha"
"Long Beach" "Virginia Beach" "Oakland" "Minneapolis" "Tulsa" "Arlington"
"Tampa" "New Orleans" "Wichita" "Cleveland" "Bakersfield" "Aurora"
"Anaheim" "Honolulu" "Santa Ana" "Riverside" "Corpus Christi" "Lexington"
"Stockton" "Henderson" "Saint Paul" "St. Louis" "Cincinnati" "Pittsburgh"
"Greensboro" "Anchorage" "Plano" "Lincoln" "Orlando" "Irvine" "Newark"
"Toledo" "Durham" "Chula Vista" "Fort Wayne" "Jersey City" "St. Petersburg"
"Laredo" "Madison" "Chandler" "Buffalo" "Lubbock" "Scottsdale" "Reno"
"Glendale" "Gilbert" "Winston–Salem" "North Las Vegas" "Norfolk"
"Chesapeake" "Garland" "Irving" "Hialeah" "Fremont" "Boise" "Richmond"
"Berlin" "Hamburg" "Munich" "Cologne" "Frankfurt" "Stuttgart" "Düsseldorf"
"Dortmund" "Essen" "Leipzig" "Bremen" "Dresden" "Hanover" "Nuremberg"
"Duisburg" "Bochum" "Wuppertal" "Bielefeld" "Bonn" "Münster" "Karlsruhe"
"Mannheim" "Augsburg" "Wiesbaden" "Gelsenkirchen" "Mönchengladbach"
"Braunschweig" "Chemnitz" "Kiel" "Aachen" "Halle" "Magdeburg" "Freiburg"
"Krefeld" "Lübeck" "Oberhausen" "Erfurt" "Mainz" "Rostock" "Kassel"
"Hagen" "Hamm" "Saarbrücken" "Mülheim" "Potsdam" "Ludwigshafen"
"Oldenburg" "Leverkusen" "Osnabrück" "Solingen" "Heidelberg" "Herne"
"Neuss" "Darmstadt" "Paderborn" "Regensburg" "Ingolstadt" "Würzburg"
"Wolfsburg" "Ulm" "Heilbronn" "Pforzheim" "Göttingen" "Bottrop" "Trier"
"Recklinghausen" "Reutlingen" "Bremerhaven" "Koblenz" "Bergisch Gladbach"
"Jena" "Remscheid" "Erlangen" "Moers" "Siegen" "Hildesheim" "Salzgitter"
)
countries=("USA" "Canada" "UK" "Australia")
city_countries=(
"New York/USA" "Los Angeles/USA" "Chicago/USA" "Houston/USA" "Phoenix/USA"
"Philadelphia/USA" "San Antonio/USA" "San Diego/USA" "Dallas/USA" "San Jose/USA"
"Austin/USA" "Jacksonville/USA" "Fort Worth/USA" "Columbus/USA" "Charlotte/USA"
"San Francisco/USA" "Indianapolis/USA" "Seattle/USA" "Denver/USA" "Washington/USA"
"Boston/USA" "El Paso/USA" "Nashville/USA" "Detroit/USA" "Oklahoma City/USA"
"Portland/USA" "Las Vegas/USA" "Memphis/USA" "Louisville/USA" "Baltimore/USA"
"Milwaukee/USA" "Albuquerque/USA" "Tucson/USA" "Fresno/USA" "Mesa/USA"
"Sacramento/USA" "Atlanta/USA" "Kansas City/USA" "Colorado Springs/USA"
"Miami/USA" "Raleigh/USA" "Omaha/USA" "Long Beach/USA" "Virginia Beach/USA"
"Oakland/USA" "Minneapolis/USA" "Tulsa/USA" "Arlington/USA" "Tampa/USA"
"New Orleans/USA" "Wichita/USA" "Cleveland/USA" "Bakersfield/USA" "Aurora/USA"
"Anaheim/USA" "Honolulu/USA" "Santa Ana/USA" "Riverside/USA" "Corpus Christi/USA"
"Lexington/USA" "Stockton/USA" "Henderson/USA" "Saint Paul/USA" "St. Louis/USA"
"Cincinnati/USA" "Pittsburgh/USA" "Greensboro/USA" "Anchorage/USA" "Plano/USA"
"Lincoln/USA" "Orlando/USA" "Irvine/USA" "Newark/USA" "Toledo/USA" "Durham/USA"
"Chula Vista/USA" "Fort Wayne/USA" "Jersey City/USA" "St. Petersburg/USA"
"Laredo/USA" "Madison/USA" "Chandler/USA" "Buffalo/USA" "Lubbock/USA"
"Scottsdale/USA" "Reno/USA" "Glendale/USA" "Gilbert/USA" "Winston–Salem/USA"
"North Las Vegas/USA" "Norfolk/USA" "Chesapeake/USA" "Garland/USA" "Irving/USA"
"Hialeah/USA" "Fremont/USA" "Boise/USA" "Richmond/USA" "Berlin/DEU" "Hamburg/DEU"
"München/DEU" "Köln/DEU" "Frankfurt am Main/DEU" "Stuttgart/DEU" "Düsseldorf/DEU"
"Dortmund/DEU" "Essen/DEU" "Leipzig/DEU" "Bremen/DEU" "Dresden/DEU" "Hannover/DEU"
"Nürnberg/DEU" "Duisburg/DEU" "Bochum/DEU" "Wuppertal/DEU" "Bielefeld/DEU"
"Bonn/DEU" "Münster/DEU" "Karlsruhe/DEU" "Mannheim/DEU" "Augsburg/DEU"
"Wiesbaden/DEU" "Gelsenkirchen/DEU" "Mönchengladbach/DEU" "Braunschweig/DEU"
"Chemnitz/DEU" "Kiel/DEU" "Aachen/DEU" "Halle/DEU" "Magdeburg/DEU" "Freiburg/DEU"
"Krefeld/DEU" "Lübeck/DEU" "Oberhausen/DEU" "Erfurt/DEU" "Mainz/DEU"
"Rostock/DEU" "Kassel/DEU" "Hagen/DEU" "Hamm/DEU" "Saarbrücken/DEU" "Mülheim/DEU"
"Potsdam/DEU" "Ludwigshafen/DEU" "Oldenburg/DEU" "Leverkusen/DEU" "Osnabrück/DEU"
"Solingen/DEU" "Heidelberg/DEU" "Herne/DEU" "Neuss/DEU" "Darmstadt/DEU"
"Paderborn/DEU" "Regensburg/DEU" "Ingolstadt/DEU" "Würzburg/DEU" "Wolfsburg/DEU"
"Ulm/DEU" "Heilbronn/DEU" "Pforzheim/DEU" "Göttingen/DEU" "Bottrop/DEU"
"Trier/DEU" "Recklinghausen/DEU" "Reutlingen/DEU" "Bremerhaven/DEU" "Koblenz/DEU"
"Bergisch Gladbach/DEU" "Jena/DEU" "Remscheid/DEU" "Erlangen/DEU" "Moers/DEU"
"Siegen/DEU" "Hildesheim/DEU" "Salzgitter/DEU" "London/GBR" "Manchester/GBR"
"Birmingham/GBR" "Leeds/GBR" "Glasgow/GBR" "Liverpool/GBR" "Bristol/GBR"
"Sheffield/GBR" "Edinburgh/GBR" "Cardiff/GBR" "Belfast/GBR" "Brighton/GBR"
"Newcastle/GBR" "Leicester/GBR" "Paris/FRA" "Marseille/FRA" "Lyon/FRA"
"Toulouse/FRA" "Nice/FRA" "Nantes/FRA" "Strasbourg/FRA" "Montpellier/FRA"
"Bordeaux/FRA" "Lille/FRA" "Rennes/FRA" "Reims/FRA" "Saint-Étienne/FRA"
"Toulon/FRA" "Le Havre/FRA" "Grenoble/FRA" "Dijon/FRA" "Angers/FRA" "Nîmes/FRA"
"Villeurbanne/FRA" "Clermont-Ferrand/FRA" "Saint-Denis/FRA" "La Rochelle/FRA"
"Le Mans/FRA" "Aix-en-Provence/FRA" "Brest/FRA" "Madrid/ESP" "Barcelona/ESP"
"Valencia/ESP" "Seville/ESP" "Zaragoza/ESP" "Málaga/ESP" "Murcia/ESP"
"Palma/ESP" "Las Palmas/ESP" "Bilbao/ESP" "Alicante/ESP" "Córdoba/ESP"
"Valladolid/ESP" "Vigo/ESP" "Gijón/ESP" "Eixample/ESP" "Latina/ESP"
"Carabanchel/ESP" "A Coruña/ESP" "Granada/ESP" "Vitoria-Gasteiz/ESP"
"Elche/ESP" "Ciudad de México/MEX" "Guadalajara/MEX" "Puebla/MEX"
"Tijuana/MEX" "Monterrey/MEX" "León/MEX" "Zapopan/MEX" "Naucalpan/MEX"
"Chihuahua/MEX" "Merida/MEX" "San Luis Potosi/MEX" "Aguascalientes/MEX"
"Hermosillo/MEX" "Saltillo/MEX" "Mexicali/MEX" "Culiacán/MEX" "Guadalupe/MEX"
"Acapulco/MEX" "Tlalnepantla/MEX" "Morelia/MEX" "Roma/ITA" "Milano/ITA"
"Napoli/ITA" "Torino/ITA" "Palermo/ITA" "Genova/ITA" "Bologna/ITA"
"Firenze/ITA" "Bari/ITA" "Catania/ITA" "Venezia/ITA" "Verona/ITA"
"Padova/ITA" "Trieste/ITA" "Brescia/ITA" "Parma/ITA" "Taranto/ITA"
"Prato/ITA" "Modena/ITA" "Reggio Calabria/ITA" "Reggio Emilia/ITA"
"Perugia/ITA" "Ravenna/ITA" "Zürich/CHE" "Genève/CHE" "Basel/CHE"
"Lausanne/CHE" "Bern/CHE" "Winterthur/CHE" "Lucerne/CHE" "St. Gallen/CHE"
"Lugano/CHE" "Biel/Bienne/CHE" "Thun/CHE" "Köniz/CHE" 
)

# Start the JSON array
echo "{" > "$outputFile"
echo "  \"people\": [" >> "$outputFile"

# Generate 2048 entries
for i in $(seq 1 $size); do
    firstName=${firstNames[$RANDOM % ${#firstNames[@]}]}
    lastName=${lastNames[$RANDOM % ${#lastNames[@]}]}
    age=$((RANDOM % 90 + 1))  # Age between 1 and 90
    salary=$((RANDOM % 100000 + 30000))  # Salary between 30000 and 130000
    street="Street $((RANDOM % 500 + 1))"
    postCode=$((RANDOM % 90000 + 10000))
    city_country=${city_countries[$RANDOM % ${#city_countries[@]}]}
    city="${city_country%%/*}"
    country="${city_country##*/}"

    # Comma handling for JSON formatting
    if [ $i -ne 1 ]; then
        echo "," >> "$outputFile"
    fi

    # JSON object
    echo -n "    { \"firstName\": \"$firstName\", \"lastName\": \"$lastName\", \"age\": $age, \"salary\": $salary, \"street\": \"$street\", \"postCode\": $postCode, \"city\": \"$city\", \"country\": \"$country\" }" >> "$outputFile"
done

# End the JSON array
echo "" >> "$outputFile"
echo "  ]" >> "$outputFile"
echo "}" >> "$outputFile"

echo "Data generation complete. File: $outputFile"
