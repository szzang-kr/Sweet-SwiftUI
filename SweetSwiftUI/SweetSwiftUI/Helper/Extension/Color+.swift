//
//  Color+.swift
//  SweetSwiftUI
//
//  Created by AhnSangHoon on 2022/03/09.
//

import SwiftUI

extension Color {
    /// 앱에서 사용될 메인 컬러
    static let peach = Color("peach")
    /// 그림자에 사용될 컬러
    static let primaryShadow = Color.primary.opacity(0.2)
    /// Color.secondary를 대신 할 조금 더 진한 회색 컬러
    static let secondaryText = Color("#6e6e6e")
    /// 앱의 배경색 컬러
    static let background = Color(UIColor.systemGray6)
}

extension Color {
    init(_ hex: String) {
        let scanner = Scanner(string: hex) // parser
        _ = scanner.scanString("#") // iOS 13부터 지원. # 문자 제거
        
        var rgb: UInt64 = .zero
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0 // 좌측 2개
        let g = Double((rgb >> 8) & 0xFF) / 255.0  // 중간 2개
        let b = Double((rgb >> 0) & 0xFF) / 255.0  // 마지막 2개
        self.init(red: r, green: g, blue: b)
     }
}
