# UICMessenger 
Semi pro chat application, with whatsapp interface on iOS, built in Swift. No storyboard you can edit from the code only (if you want). Navigationbar button's action empty so you can handle them by your custom functions under delegate methods (ChatsNavigationBarDelegate & FloatingStartChatButtonDelegate, MessagesNavigationBarDelegate).  

- Multiple included cell types: text, emoji, image, audio
- Easy to integrate with backend service, messages will sort automatically (depended on message date) after fetch.
- TableView based you can pre-load and cache something
- Press and hold mic button to record and immediatly send voice message.
- Auto resize message textView depended on text size.
- Send button automatically will change to record button if textView is empty and vice versa.

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
Or create an instance of `ChatsViewController.swift` in you VC then add it as child VC.<br>

## Issues 🦠 🦗: 
- Some times cannot play voice messages. 🤔
- Minimum message bubble width is 180 px. (Easy to fix 😜)

## In next update I will try to add :
- Share images from camera roll<br>
- Video cell and send video from camera roll<br>
- Clickable link in messages

## Requirements
Xcode 9 or later <br>
iOS 10.0 or later <br>
Swift 4 or later <br>

## Licence : 
The MIT License (MIT)

## Credits
[Coder ACJHP](https://github.com/Coder-ACJHP) (Onur Işık)
