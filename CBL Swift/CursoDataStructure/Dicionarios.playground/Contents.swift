import Foundation

/*
 Cities to add:
 Bangalore (India, Asia)
 Atlanta (USA, North America)
 Cairo (Egypt, Africa)
 Shanghai (China, Asia)
 */

import Foundation

var locations = ["North America" : ["USA" : ["Mountain View"]]]

/*
 Print the following
 1. A list of all cities in the USA in
 alphabetical order. Hint: use the array sorted() method
 2. All cities in Asia, in alphabetical
 order, next to the name of the country.
 In your output, label each answer with a number
 so it looks like this:
 1
 American City
 American City
 2
 Asian City - Country
 Asian City - Country
 */

// Your code goes here

locations["Asia"] = ["India" : ["Bangalore"]]
locations["North America"]!["USA"]?.append("Atlanta")
locations["Africa"] = ["Egypt" : ["Cairo"]]
locations["Asia"]?["China"] = ["Shanghai"]

//Cidades americanas
var americanCity = locations["North America"]!["USA"]!.sorted()
print("\(1)\n\(americanCity[0])\n\(americanCity[1])")

//Cidades asiaticas
var asiaCities = [String]()
//For com chave valor
for (country, cities) in locations["Asia"]! {
    let cityCountry = "\(cities[0]) - \(country)"
    asiaCities.append(cityCountry)
}
for city in asiaCities.sorted() {
    print(city)
}
