//
//  View+Extension.swift
//
//  Created by : Tomoaki Yagishita on 2021/01/30
//  © 2021  SmallDeskSoftware
//

import Foundation
import SwiftUI

extension View {
    public func position(_ pos: CGPoint) -> some View {
        return self.position(x: pos.x, y: pos.y)
    }
    public func frame(_ size: CGSize) -> some View {
        return self.frame(width: size.width, height: size.height)
    }
    public func anyView() -> AnyView {
        return AnyView(self)
    }
}


// MARK: deprecated (but keep for a while)

// MARK: PushOutView
extension View {
    @available(*, deprecated)
    public func pushOutView() -> some View {
        self.modifier(PushOutView())
    }
}

public struct PushOutView: ViewModifier {
    public func body(content: Content) -> some View {
        GeometryReader { _ in
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: for checking view size
struct ViewSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    /// retreive child view size (via preference change)
    /// - Parameter onChange: closure triggered when size is changed
    /// - Parameter size: new size of view
    /// - Returns: some View
    @available(*, deprecated, message: "use readGeom(name:,onChange:) instead")
    public func readSize(onChange: @escaping (_ size: CGSize) -> Void) -> some View {
        background(
            GeometryReader{ geom in
                Color.clear
                    .preference(key: ViewSizePreferenceKey.self, value: geom.size)
            })
            .onPreferenceChange(ViewSizePreferenceKey.self, perform: onChange)
    }
}

// MARK: conditional view modifier
extension View {
    @available(*, deprecated)
    @ViewBuilder
    public func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    @available(*, deprecated)
    @ViewBuilder
    public func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
}

// MARK: token (from Text extension)
extension View {
    @available(*, deprecated)
    public func token(cornerRadius: CGFloat = 8, useBackgroundColor: Bool = true, backgroundColor: Color = .green,
                      useBorderColor: Bool = true, borderColor: Color = .accentColor) -> some View {
        self.modifier(TokendText(cornerRadius: cornerRadius, useBackgroundColor: useBackgroundColor,  backgroundColor: backgroundColor,
                                 useBorderColor: useBorderColor, borderColor: borderColor))
    }
}

public struct TokendText: ViewModifier {
    let cornerRadius: CGFloat
    let useBackgroundColor: Bool
    let backgroundColor: Color
    let useBorderColor: Bool
    let borderColor: Color
    public func body(content: Content) -> some View {
        content
            .padding(2)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(useBackgroundColor ? backgroundColor : .clear))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(useBorderColor ? borderColor : .clear))
    }
}
