//
//  Home.swift
//  SweetSwiftUI
//
//  Created by AhnSangHoon on 2022/02/15.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            ProductRow(product: Product.samples[0])
            ProductRow(product: Product.samples[1])
            ProductRow(product: Product.samples[2])
            ProductRow(product: Product.samples[3])
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
