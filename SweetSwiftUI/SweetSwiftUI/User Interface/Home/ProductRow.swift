//
//  ProductRow.swift
//  SweetSwiftUI
//
//  Created by AhnSangHoon on 2022/03/09.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: .zero) {
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(
            color: .primaryShadow,
            radius: 1,
            x: 2,
            y: 2
        )
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        Image(product.imageName)
            .resizable() // 이미지의 크기를 변경할 수 있도록 설정
            .scaledToFill()
            .frame(width: 140, height: 140)
            .clipped() // 이미지를 frame에 맞게 자르기
    }
    
    var productDescription: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)
            Spacer()
            footerView
        }
        .padding(12)
    }
    
    var footerView: some View {
        HStack {
            Text("₩")
                .font(.footnote) +
            Text("\(product.price)")
                .font(.headline)
            Spacer()
            HStack {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundColor(.peach)
                Image(systemName: "cart")
                    .foregroundColor(.peach)
                    .frame(width: 32, height: 32)
            }
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product.samples[0])
    }
}
