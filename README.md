# UICMessenger v1.5.0
Custom chat application, with whatsapp interfaces on iOS built in Swift. No storyboard just edit from the code (if you want). Navigationbar button's action empty so you can handle them by your custom functions under delegate methods (ChatsNavigationBarDelegate & FloatingStartChatButtonDelegate, MessagesNavigationBarDelegate).  

- Multiple included cell types: text, large-emoji, image
- TableView based you can pre-load and cache something

### Screenshot: 
<img src="https://github.com/Coder-ACJHP/UICMessenger/blob/master/UICMessenger/Requirements/Assets.xcassets/iPhone8Plus.dataset/iPhone8Plus.gif">

## How to implement it? (use it)

Inside AppDelegate.swift class :
```
func application(_ application: UIApplication, 
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
   window = UIWindow(frame: UIScreen.main.bounds)
   window?.makeKeyAndVisible()
   window?.rootViewController = ChatsViewController()
   return true
}
```
## Next update for:
1- Adding audio message support

## Requirements
Xcode 9 or later <br>
iOS 10.0 or later <br>
Swift 4 or later <br>

#### Licence : 
The MIT License (MIT)

## Credits
[Coder ACJHP](https://github.com/Coder-ACJHP) (Onur Işık)
