//
//  View+Extension.swift
//
//  Created by : Tomoaki Yagishita on 2021/01/30
//  © 2021  SmallDeskSoftware
//

import Foundation
import SwiftUI

extension View {
    public func frame(_ size: CGSize) -> some View {
        return self.frame(width: size.width, height: size.height)
    }
    public func anyView() -> AnyView {
        return AnyView(self)
    }
}

struct ViewSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    /// retreive child view size (via preference change)
    /// - Parameter onChange: closure triggered when size is changed
    /// - Parameter size: new size of view
    /// - Returns: some View 
    public func readSize(onChange: @escaping (_ size: CGSize) -> Void) -> some View {
        background(
            GeometryReader{ geom in
                Color.clear
                    .preference(key: ViewSizePreferenceKey.self, value: geom.size)
            })
            .onPreferenceChange(ViewSizePreferenceKey.self, perform: onChange)
    }
}
