# Boilerplate Code for Swift
Jump start development projects.<br><br>
This repo serves as a tool for both old and new iOS developers. Every project needs tools to ease early development phases.<br>
While this could have been developed using an Xcode project and added using Cocoapods or SwiftPackageManager, it is designed to simply be folders of tool files that you can download into your project.

<br>**Boilerplate Tools**<br>
• [Utilities](#utilities)<br>
• [UIKit+](#uikit)<br><br>

## Utilities
This serves as a list of generalized tools that are not directly found in any iOS API, but we happen to use them quite a bit in iOS. It just made sense to add these in.
<br><br>**Alert** - This tool utilizes UIAlertController to display alerts on the given ViewController. While this comes with standard alerts (OK, Destructive, Decision) these can be edited and more can be added.
<br><br>**KeyboardToolbar** - Easily adds a toolbar to the keyboard including the arrows that can move to the previous or next textfield.
<br><br>**OpenLink**<br>
Easily open links in an externally browser once you add the links to your enum. Make sure to edit this and make security updates if necessary.
<br><br>**BiometricUnlock** - A pre-written tool that will use local authentication to authenticate the user. If using a username and password for your users, you must first provide a way to authenticate the user using a username and password before enabling local authentication.


## UIKit
Most of UIKit holds base variables that we want to expand when developing our projects. Here are a few tools added to UIKit to decrease written code and increase productivity.
<br><br>**UIPasteBoard+** - A simple addition to UIPasteBoard that creates an easier one line copy to clipboard method.
