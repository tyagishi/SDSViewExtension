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

// read general geometry size with specified coordinateSpace
public struct GeometryProxyInfo: Equatable {
    static public func == (lhs: GeometryProxyInfo, rhs: GeometryProxyInfo) -> Bool {
        return (lhs.name == rhs.name) && (lhs.geometryProxy.size == rhs.geometryProxy.size)
        && (lhs.geometryProxy.safeAreaInsets == rhs.geometryProxy.safeAreaInsets) && (lhs.geometryProxy.frame(in: .global) == rhs.geometryProxy.frame(in: .global))
    }
    
    public let name: String
    public let geometryProxy: GeometryProxy
}

public struct GeomReaderInfoPreferenceKey: PreferenceKey {
    public typealias Value = [GeometryProxyInfo]
    static public var defaultValue:[GeometryProxyInfo] = []
    static public func reduce(value: inout [GeometryProxyInfo], nextValue: () -> [GeometryProxyInfo]) {
        value.append(contentsOf: nextValue())
    }
}
extension View {
    /// retreive child view size (via preference change)
    /// - Parameter onChange: closure triggered when size is changed
    /// - Parameter size: new size of view
    /// - Returns: some View
    public func readGeom(name: String = UUID().uuidString, onChange: @escaping (_ geomProxy: GeometryProxy) -> Void) -> some View {
        background(
            GeometryReader{ geom in
                Color.clear
                    .preference(key: GeomReaderInfoPreferenceKey.self, value: [GeometryProxyInfo(name: name, geometryProxy: geom)])
            })
        .onPreferenceChange(GeomReaderInfoPreferenceKey.self, perform: { prefs in
            if let pref = prefs.first(where: {$0.name == name}) {
                onChange(pref.geometryProxy)
            }
        })
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

// MARK: PushOutView
extension View {
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

// MARK: conditional view modifier
extension View {
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
