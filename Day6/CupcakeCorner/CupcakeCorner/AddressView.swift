//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Lucas Lee on 9/29/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderContent.name)
                TextField("Street Address", text: $order.orderContent.streetAddress)
                TextField("City", text: $order.orderContent.city)
                TextField("Zip", text: $order.orderContent.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(order.orderContent.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order:Order())
    }
}
