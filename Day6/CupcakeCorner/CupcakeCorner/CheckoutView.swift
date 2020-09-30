//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Lucas Lee on 9/29/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingConfirmation = false
    
    func placeOrder() -> Void{
        guard let encoded = try? JSONEncoder().encode(order.orderContent) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.confirmationMessage = "Network error"
                self.alertTitle = "Error"
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderContent.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderContent.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.alertTitle = "Thank You!"
                self.showingConfirmation = true
            } else {
                self.confirmationMessage = "Decoding error"
                self.alertTitle = "Error"
                self.showingConfirmation = true
            }
        }.resume()
        
        
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.orderContent.cost, specifier: "%.2f")").font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                    .alert(isPresented: $showingConfirmation) {
                        Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order:Order())
    }
}
