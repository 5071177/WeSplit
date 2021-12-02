import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    
    var currency: FloatingPointFormatStyle<Double>.Currency {
         .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
//    var tipPercentages = [0, 5, 10, 15, 20, 25]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPetPerson = grandTotal/peopleCount
        
        return amountPetPerson
    }
    
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0..<101) {
                        Text($0, format: .percent)
                    }
                }
            } header: {
                Text("How much tip do you want to leave?")
            }
            
            Section {
                Text(grandTotal, format: currency)
            } header: {
                Text("Amount with tips")
            }
            
            Section {
                Text(totalPerPerson, format: currency)
            } header: {
                Text("Amount per person")
            }
        }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer ()
                        
                        Button ("Done") {
                            amountIsFocused = false
                        }
                    }
                }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
