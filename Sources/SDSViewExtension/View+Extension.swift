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
