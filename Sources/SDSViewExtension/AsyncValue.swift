//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2023/01/25
//  © 2023  SmallDeskSoftware
//

import Foundation
import SwiftUI
import Combine

public class AsyncValue<V, T: ObservableObject>: ObservableObject {
    @Published public var value: V
    let object: T
    let retriever: (T) async -> V
    var cancellable: AnyCancellable? = nil

    public init(displayValue: V, object: T,
         retriever: @escaping ((T) async -> V)) {
        self.value = displayValue
        self.object = object
        self.retriever = retriever
        Task { @MainActor in
            self.value = await retriever(object)
            cancellable = object.objectWillChange
                .sink(receiveValue: { _ in
                    Task { @MainActor in
                        self.value = await self.retriever(self.object)
                    }
                })
        }
    }
}
