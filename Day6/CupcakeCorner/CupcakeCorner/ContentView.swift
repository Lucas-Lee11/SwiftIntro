//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Lucas Lee on 9/29/20.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderContent.type) {
                        ForEach(0 ..< OrderContent.types.count) {
                            Text(OrderContent.types[$0])
                        }
                    }

                    Stepper(value: $order.orderContent.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderContent.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.orderContent.specialRequestEnabled) {
                        Text("Any special requests?")
                    }

                    if order.orderContent.specialRequestEnabled {
                        Toggle(isOn: $order.orderContent.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.orderContent.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
