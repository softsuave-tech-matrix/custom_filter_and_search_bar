# custom_filter_and_search_bar
custom_filter_and_search_bar is a library that allows users to create a customised search bar with an inbuilt filter functionality. The library allows the user to filter the data according to the text typed in the search bar and the filters selected . 

## Features
- Allows user to filter data based on the search text
- Accepts an array of data which needs to be filtered
- User can add filters in the form of chips
- The number filters the user is allowed to add is customisable 
- Search bar can be customised as per requirement


## Properties
- text: Binding<String> - The text entered in the search bar
- filteredArray: Binding<[T]> - The array to be filtered based on the search text
- selectedFilters: Binding<[String]> - The filters that are selected
- filterOptions: Binding<[String: [String]]> - The options which are provided based on which the data is filtered
- placeHolderText: String - Placeholder for the search bar. Default is "Search ..."
- textColor: Color - Color of the text entered in the search bar. Default is primary
- borderColor: Color - Border color of the search bar. Default is grey
- backgroundColor: Color - Background color of the search bar. Default is Color(.systemGray6) 
- foregroundColor: Color - Color for the cancel text. Default is blue
- borderWidth: CGFloat - Border width of the search bar. Default is 1
- searchIcon: Image - Search icon on the search bar. Default is Image(systemName: "magnifyingglass")
- searchIconTintColor: Color - Foreground color for the search icon. Default is grey
- cancelText: String - Text to cancel the search filters  
- closeIcon: Image - Icon to end editing. Default is Image(systemName: "multiply.circle.fill")  
- filterIcon: Image - Icon to show the page with filters. Default is Image(systemName: "line.horizontal.3.decrease.circle") 
- filterIconTintColor: Color - Foreground color for the filter icon
- cornerRadius: CGFloat - Corner radius for the search bar. Default is 8 
- corners: UIRectCorner - Corners for the textfield. Default is .allCorners
- array: [T] - Array of the data to be filtered 
- height: CGFloat - Height of the text field. Default is 40
- searchIconWidth: CGFloat - Width of the search icon. Default is 25
- filterFunction: Bool - Filter function is optional. Default is false
- filterHeaderText: String - Title for the filter page. Default is “Filter Options”      

## Installation
- Add the package through swift package manager to your project
- Alternatively you can also install through cocoapods (pod custom_filter_and_search_bar)

## Useage

- Add the required properties to the search bar
- ‘array’ is the data which needs to filtered
- ‘filteredArray’ is the array of elements which have been filtered
- ‘selectedFilters’ are the filters selected by the user which is applied to the array which needs to filtered
- ‘text’ in the below example represents the text entered in the search bar
- ‘filterOptions’ is a key value pair of the types of filters 


<img width="230" alt="Screenshot 2024-08-20 at 6 36 59 PM" src="https://github.com/user-attachments/assets/bb2c48ba-c798-47d5-9cb6-ce03b8974c85">

<img width="224" alt="Screenshot 2024-08-20 at 6 30 46 PM" src="https://github.com/user-attachments/assets/705e7dcc-5d03-48fb-9041-de4dcfb157fa">

<img width="218" alt="Screenshot 2024-08-20 at 6 31 27 PM" src="https://github.com/user-attachments/assets/189f2c71-65bd-4616-936b-f5c4087a6537">

<img width="219" alt="Screenshot 2024-08-20 at 6 32 13 PM" src="https://github.com/user-attachments/assets/cbd19741-9cf7-4faa-a009-dfbba6e43773">



```swift
import SwiftUI
import SearchBarLibrary

struct ContentView: View {
    
    @State var text: String = ""
    @State var filteredArray: [Person] = []
    @State var selectedFilters: [String] = []
    @State private var filterOptions: [String: [String]] = ["Banks": banks, "Cards": cards]
    
    
    var body: some View {
        VStack {
            
            SearchBar(
                text: $text,
                filteredArray: $filteredArray,
                selectedFilters: $selectedFilters,
                filterOptions: $filterOptions,
                placeHolderText: "Contacts",
                borderWidth: 0,
                searchIcon: Image(systemName: "doc.text.magnifyingglass"),
                cancelText: "Clear",
                cornerRadius: 20,
                corners: UIRectCorner(arrayLiteral: .bottomLeft, .topRight),
                array: persons, searchIconWidth: 25,
                filterFunction: true,
                filterHeaderText: "Bank & Cards"
            )
            
            CellView(persons: text.isEmpty && selectedFilters.isEmpty ? persons : filteredArray)
            
        }
    }
}

```

- Sample structure of the array of data which has to be filtered

```swift
import Foundation


struct Person: Equatable, Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name &&
        lhs.first_name == rhs.first_name &&
        lhs.last_name == rhs.last_name &&
        lhs.phone_number == rhs.phone_number &&
        lhs.banks == rhs.banks
    }
    
    var name: String
    var first_name: String
    var last_name: String
    var phone_number: Int
    var banks: [Banks]
    
    init(name: String, first_name: String, last_name: String, phone_number: Int, banks: [Banks]) {
        self.name = name
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.banks = banks
    }
}

struct Banks: Equatable, Hashable {
    var name: String
    var cards: [CreditCard]
    
    init(name: String, cards: [CreditCard]) {
        self.name = name
        self.cards = cards
    }
}

struct CreditCard: Equatable, Hashable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// Dummy data for credit cards
let cards = ["Visa", "Mastercard", "American Express", "Discover"]
let card1 = CreditCard(name: "Visa")
let card2 = CreditCard(name: "Mastercard")
let card3 = CreditCard(name: "American Express")
let card4 = CreditCard(name: "Discover")

// Dummy data for banks with associated credit cards
let banks = ["Bank of America", "Chase Bank", "Wells Fargo", "Citibank"]
let bank1 = Banks(name: "Bank of America", cards: [card1, card2])
let bank2 = Banks(name: "Chase Bank", cards: [card3])
let bank3 = Banks(name: "Wells Fargo", cards: [card2, card4])
let bank4 = Banks(name: "Citibank", cards: [card1, card3])

// Dummy data for persons with associated banks and credit cards
let persons: [Person] = [
    Person(name: "John Doe", first_name: "John", last_name: "Doe", phone_number: 1234567890, banks: [bank1, bank2]),
    Person(name: "Jane Smith", first_name: "Jane", last_name: "Smith", phone_number: 9876543210, banks: [bank3]),
    Person(name: "Michael Johnson", first_name: "Michael", last_name: "Johnson", phone_number: 5678901234, banks: [bank1, bank4]),
    Person(name: "Emily Brown", first_name: "Emily", last_name: "Brown", phone_number: 2345678901, banks: [bank2, bank3]),
    Person(name: "Robert Wilson", first_name: "Robert", last_name: "Wilson", phone_number: 8901234567, banks: [bank4]),
    Person(name: "David Lee", first_name: "David", last_name: "Lee", phone_number: 4567890123, banks: [bank1]),
    Person(name: "Sarah Taylor", first_name: "Sarah", last_name: "Taylor", phone_number: 9012345678, banks: [bank2]),
    Person(name: "James Martinez", first_name: "James", last_name: "Martinez", phone_number: 3456789012, banks: [bank3, bank4]),
    Person(name: "Jennifer Davis", first_name: "Jennifer", last_name: "Davis", phone_number: 6789012345, banks: [bank1, bank2, bank3]),
    Person(name: "Daniel Anderson", first_name: "Daniel", last_name: "Anderson", phone_number: 1234509876, banks: [bank4]),
    Person(name: "Laura Thomas", first_name: "Laura", last_name: "Thomas", phone_number: 8901234501, banks: [bank1, bank2]),
    Person(name: "Matthew Clark", first_name: "Matthew", last_name: "Clark", phone_number: 2345678901, banks: [bank3, bank4]),
    Person(name: "Jessica Lewis", first_name: "Jessica", last_name: "Lewis", phone_number: 6789012345, banks: [bank1]),
    Person(name: "Christopher Walker", first_name: "Christopher", last_name: "Walker", phone_number: 4567890123, banks: [bank2]),
    Person(name: "Megan Hall", first_name: "Megan", last_name: "Hall", phone_number: 9012345678, banks: [bank3]),
    Person(name: "Ryan Young", first_name: "Ryan", last_name: "Young", phone_number: 1234509876, banks: [bank4]),
    Person(name: "Amanda Allen", first_name: "Amanda", last_name: "Allen", phone_number: 8901234501, banks: [bank1, bank2]),
    Person(name: "Kevin King", first_name: "Kevin", last_name: "King", phone_number: 2345678901, banks: [bank3]),
    Person(name: "Hannah Green", first_name: "Hannah", last_name: "Green", phone_number: 6789012345, banks: [bank4]),
    Person(name: "Brandon Baker", first_name: "Brandon", last_name: "Baker", phone_number: 4567890123, banks: [bank1, bank2, bank3, bank4])
]

 ```

## Contributing

Contributions are always welcome! For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Author

- [@softsuave-tech-matrix](https://github.com/softsuave-tech-matrix)

## Feedback

If you have any feedback, please reach out to us at techmatrix@softsuave.com

