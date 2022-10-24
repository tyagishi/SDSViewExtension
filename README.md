# SDSViewExtension

Convenient View Extension collection.

## Text
### Token (show Text looks like Token)
```
public func token(cornerRadius: CGFloat = 8, useBackgroundColor: Bool = true, backgroundColor: Color = .green,
                  useBorderColor: Bool = true, borderColor: Color = .accentColor)

```

## View
### get GeometryProxy
```
Text("Hello")
  .readSize() { geometryProxy in
     // do what you want with GeometryProxy (for Text)
  }
```

### set frame size with using CGSize

```
public func frame(_ size: CGSize)
```

### change to AnyView
```
public func anyView() -> AnyView
```

### change push-out View 
```
public func pushOutView()
```

### control show/hide
```
let visible = false

SomeView()
  .visible(visible)
...

### optional onReceive
if nil is given as NotificationName, it will be ignored. otherwise receive the notification.
#### for NotificationCenter
```
SomeView()
  .optionalOnReceive(notificationName: optionalNotificationName, action: { _ in print("called") })

```
#### for Publisher
if nil is given as publisher, it will be ignored. otherwise published event will be received.
```
SomeView()
  .optionalOnReceive(publisher: optionalPublisher, action: { _ in print("called") })

```
