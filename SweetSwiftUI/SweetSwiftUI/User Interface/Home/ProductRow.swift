//
//  ProductRow.swift
//  SweetSwiftUI
//
//  Created by AhnSangHoon on 2022/03/09.
//

import SwiftUI

struct ProductRow: View {
    var body: some View {
        HStack(spacing: .zero) {
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(
            color: Color.primary.opacity(0.33),
            radius: 1,
            x: 2,
            y: 2
        )
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        Image("apple")
            .resizable() // 이미지의 크기를 변경할 수 있도록 설정
            .scaledToFill()
            .frame(width: 140, height: 140)
            .clipped() // 이미지를 frame에 맞게 자르기
    }
    
    var productDescription: some View {
        VStack(alignment: .leading) {
            Text("백설공주 사과")
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            Text("달콤한 맛이 좋은 과일의 여왕 사과. 독은 없고 꿀만 가득해요!")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
            footerView
        }
        .padding(12)
    }
    
    var footerView: some View {
        HStack {
            Text("₩")
                .font(.footnote) +
            Text("2100")
                .font(.headline)
            Spacer()
            HStack {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundColor(Color("peach"))
                Image(systemName: "cart")
                    .foregroundColor(Color("peach"))
                    .frame(width: 32, height: 32)
            }
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}
