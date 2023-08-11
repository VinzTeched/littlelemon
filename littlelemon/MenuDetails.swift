//
//  MenuDetails.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 11/08/2023.
//

import SwiftUI

struct MenuDetails: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: dish.image ?? "")){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            Text(dish.title ?? "")
                .padding([.top, .bottom], 7)

            Text((dish.price ?? "") + " USD")
                .monospaced()
                .font(.callout)
            
            Text((dish.describe ?? ""))
                .padding([.top, .bottom], 7)
            
            Spacer()
        }
        .padding()
    }
}

/*struct MenuDetails_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetails()
    }
}
*/
