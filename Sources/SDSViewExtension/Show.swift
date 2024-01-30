//
//  Show.swift
//
//  Created by : Tomoaki Yagishita on 2024/01/26
//  © 2024  SmallDeskSoftware
//

import SwiftUI

/// ViewModifier: .show
/// control view visibility with flag (true/false)
/// ``` example
/// @State private var showFlag = true/false
///
/// SomeView().show(showFlag)
///
/// ```
extension View {
    public func show(_ flag: Bool) -> some View {
        modifier(ViewShower(showFlag: flag))
    }
}
public struct ViewShower: ViewModifier {
    let showFlag: Bool
    public func body(content: Content) -> some View {
        if showFlag {
            content
        } else {
            content.hidden()
        }
    }
}
