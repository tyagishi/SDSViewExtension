//
//  OptionalNotificationReceive.swift
//
//  Created by : Tomoaki Yagishita on 2024/01/26
//  © 2024  SmallDeskSoftware
//

import SwiftUI
import Combine

// MARK: OptionalNotificationReceive
// onRecive only iff notificationName is given. With name == nil, view will be processed without onReceive
extension View {
    // onRecive only iff notificationName is given. With name == nil, view will ignore this modifier
    public func optionalOnReceive(notificationName: Notification.Name?, perform: ((NotificationCenter.Publisher.Output) -> Void)? = nil) -> some View {
        self.modifier(OptionalNotificationReceive(notificationName: notificationName, closure: perform))
    }
    // onRecive only iff publisher is given. With publisher == nil, view will ignore this modifier
    public func optionalOnReceive<P>(_ publisher: P?, perform: @escaping (P.Output) -> Void) -> some View where P: Publisher, P.Failure == Never {
        self.modifier(OptionalPublisherReceive(publisher: publisher, closure: perform))
    }
}

public struct OptionalNotificationReceive: ViewModifier {
    let notificationName: Notification.Name?
    let closure: ((NotificationCenter.Publisher.Output) -> Void)?

    public func body(content: Content) -> some View {
        if let notificationName = notificationName {
            content
                .onReceive(NotificationCenter.default.publisher(for: notificationName)) { notification in
                    closure?(notification)
                }
        } else {
            content
        }
    }
}

public struct OptionalPublisherReceive<P>: ViewModifier where P: Publisher, P.Failure == Never {
    let publisher: P?
    let closure: ((P.Output) -> Void)?

    public func body(content: Content) -> some View {
        if let publisher = publisher {
            content
                .onReceive(publisher) { output in
                    closure?(output)
                }
        } else {
            content
        }
    }
}
