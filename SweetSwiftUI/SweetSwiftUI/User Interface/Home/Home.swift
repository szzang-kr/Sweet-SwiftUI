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
            ProductRow()
            ProductRow()
            ProductRow()
            ProductRow()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
