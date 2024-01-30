//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2024/01/26
//  © 2024  SmallDeskSoftware
//

import SwiftUI

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
