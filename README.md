# SDSViewExtension

Convenient View Extension collection.

## Text
show Text looks like Token
```
public func token(cornerRadius: CGFloat = 8, useBackgroundColor: Bool = true, backgroundColor: Color = .green,
                  useBorderColor: Bool = true, borderColor: Color = .accentColor)

```

## View
get GeometryProxy
```
Text("Hello")
  .readSize() { geometryProxy in
     // do what you want with GeometryProxy (for Text)
  }
```

set frame size with using CGSize

```
public func frame(_ size: CGSize)
```

change to AnyView
```
public func anyView() -> AnyView
```

change push-out View 
```
public func pushOutView()
```

