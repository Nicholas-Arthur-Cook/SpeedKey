//
//  KeyboardViewController.swift
//  SpeedKey_Keyboard
//
//  Created by Rain Tarango on 2/2/23.
//

import UIKit
import AudioToolbox

var caps = false
var buttons: Array<UIButton> = []

class KeyboardViewController: UIInputViewController {
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var testingKeyboard: UIButton!

    


    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
        // Add custom view sizing constraints here
    }
    
    func createButtonWithTitle(title:String) -> UIButton {
        let skiftKey = UIImage(systemName: "shift.fill")
        let deleteButton = UIImage(systemName: "delete.left")
        let button = UIButton(type: .system)
        
        if (title == "shift") {
            button.frame = CGRectMake(0, 0, 15, 15)
            button.setBackgroundImage(skiftKey, for: .normal)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: -1)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.sizeToFit()
            
        }
        
        if (title == "delete") {
            button.frame = CGRectMake(0, 0, 5, 5)
            button.setBackgroundImage(deleteButton, for: .normal)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 0)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.sizeToFit()
        }
        
        else {
            //let bubble = UIImage(systemName: "square")
           // button.setBackgroundImage(bubble, for: .normal)
            button.frame = CGRectMake(0, 0, 120, 120)
            button.setTitle(title, for: .normal)
            button.sizeToFit()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            //UIImage(systemName: "square.grid.3x2.fill")
        }
        
        //UIImage(systemName: "keyboard.fill")

        button.addTarget(self, action:#selector(didTapButton), for: .touchUpInside)
        buttons.append(button)
        
        return button
        
    }
    
    func createRowOfButtons(buttonTitles: [String]) -> UIView  {
        var buttons = [] as [UIButton]
        let keyboardRowView = UIView(frame: CGRectMake(0, 0, 420, 300))
        
        let SwipeLeft = UISwipeGestureRecognizer()
        let SwipeRight = UISwipeGestureRecognizer()
        let SwipeUp = UISwipeGestureRecognizer()
        let SwipeDown = UISwipeGestureRecognizer()
        
        SwipeLeft.direction = .left
        SwipeRight.direction = .right
        SwipeUp.direction = .up
        SwipeDown.direction = .down
        
        keyboardRowView.addGestureRecognizer(SwipeLeft)
        keyboardRowView.addGestureRecognizer(SwipeRight)
        keyboardRowView.addGestureRecognizer(SwipeUp)
        keyboardRowView.addGestureRecognizer(SwipeDown)
        
        SwipeLeft.addTarget(self, action: #selector(Swipe(sender:)))
        SwipeRight.addTarget(self, action: #selector(Swipe(sender:)))
        SwipeUp.addTarget(self, action: #selector(Swipe(sender:)))
        SwipeDown.addTarget(self, action: #selector(Swipe(sender:)))
        
        for buttonTitle in buttonTitles {
            let button = createButtonWithTitle(title: buttonTitle )
            buttons.append(button)
            keyboardRowView.addSubview(button)
        }
        addIndividualButtonConstraints(buttons: buttons, mainView: keyboardRowView)
        return keyboardRowView
        
    }
    
    func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]) {
        
        for (index, rowView) in rowViews.enumerated() {
            let rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: inputView, attribute: .right, multiplier: 1.0, constant: -1)
            
            let leftConstraint = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: inputView, attribute: .left, multiplier: 1.0, constant: 1)
            
            inputView.addConstraints([leftConstraint, rightSideConstraint])
            
            var topConstraint: NSLayoutConstraint
            
            if index == 0 {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1.0, constant: 0)
            }
            else {
                let prevRow = rowViews[index - 1]
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1.0, constant: 0)
                
                let firstRow = rowViews[0]
                let heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .height, relatedBy: .equal, toItem: rowView, attribute: .height, multiplier: 1.0, constant: 0)
                
                inputView.addConstraint(heightConstraint)
            }
            inputView.addConstraint(topConstraint)
            var bottomConstraint: NSLayoutConstraint
            
            if index == rowViews.count - 1 {
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1.0, constant: 0)
            }
            else {
                let nextRow = rowViews[index + 1]
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1.0, constant: 0)
            }
            inputView.addConstraint(bottomConstraint)
        }
    }
    
    func addIndividualButtonConstraints(buttons:[UIButton], mainView: UIView) {

        for (index, button) in buttons.enumerated() {
            let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 1)

            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: -1)

            var rightConstraint : NSLayoutConstraint!

            if index == buttons.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: mainView, attribute: .right, multiplier: 1.0, constant: -1)
            }
            else {
                let nextButton = buttons[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1.0, constant: -1)
            }
            var leftConstraint : NSLayoutConstraint!

            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: mainView, attribute: .left, multiplier: 1.0, constant: 1)
            }
            else {
                let prevtButton = buttons[index - 1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevtButton, attribute: .right, multiplier: 1.0, constant: 1)
                let firstButton = buttons[0]
                let widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                mainView.addConstraint(widthConstraint)
            }
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])

        }
    }
    
    @objc func didTapButton(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.title(for: .normal)
        var space: Bool = false
        let proxy = textDocumentProxy as UITextDocumentProxy

        //need lower/uppercase for shift funtionality
        switch title {
        case "delete" :
            proxy.deleteBackward()
        case "DELETE" :
            proxy.deleteBackward()
            
        case "return" :
            proxy.insertText("\n")
        case "RETURN" :
            proxy.insertText("\n")
            
        case "space" :
            proxy.insertText(" ")
            space = true
        case "SPACE" :
            proxy.insertText(" ")
            space = true
            
        case "shift" :
            if caps {caps = false}
            else {caps = true}
            redrawkeyboard()
        case "SHIFT" :
            if caps {caps = false}
            else {caps = true}
            redrawkeyboard()
            
        

            
        default :
            if caps {proxy.insertText(title!.uppercased())}
            else {proxy.insertText(title!)}
        }
        
        
        if space == true {
            let proxy = textDocumentProxy as UITextDocumentProxy
            let precedingText = proxy.documentContextBeforeInput ?? ""
            
            let isTypo = isRealWord(word: precedingText)
            
            if (isTypo == true) {
                print("We got a typo!")
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
            }
        }
        
            

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
    
        
        
        let buttonTitles1 = ["q", "w", "e", "r", "t", "y","u", "i", "o", "p"]
        let buttonTitles2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
        let buttonTitles3 = ["shift", "z", "x", "c", "v", "b", "n", "m", "delete" ]
        let buttonTitles4 = ["space", "return"]
        
        //var sparkle = UIImage(systemName: "sparkle")
        
        let row1 = createRowOfButtons(buttonTitles: buttonTitles1)
        let row2 = createRowOfButtons(buttonTitles: buttonTitles2)
        let row3 = createRowOfButtons(buttonTitles: buttonTitles3)
        let row4 = createRowOfButtons(buttonTitles: buttonTitles4)
        
        self.view.addSubview(row1)
        self.view.addSubview(row2)
        self.view.addSubview(row3)
        self.view.addSubview(row4)
        
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        row3.translatesAutoresizingMaskIntoConstraints = false
        row4.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsToInputView(inputView: self.view, rowViews: [row1, row2, row3, row4])
        
        

        


   
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
         

    
    
    }
    func deleteLastWord() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        var precedingText = proxy.documentContextBeforeInput ?? ""
        // Get the character before insertion point
        var lastChar = (precedingText.count != 0) ? precedingText[precedingText.index(before: precedingText.endIndex)] : " "
        
        if (lastChar == " "){
            // Probably from multiple delete actions in a row
            proxy.deleteBackward()
            precedingText = proxy.documentContextBeforeInput ?? ""
            lastChar = (precedingText.count != 0) ? precedingText[precedingText.index(before: precedingText.endIndex)] : " "
        }
        
        
        // Delete every character up to a space, or the start of the input field
        while(lastChar != " "){
            proxy.deleteBackward()
            precedingText = proxy.documentContextBeforeInput ?? ""
            lastChar = (precedingText.count != 0) ? precedingText[precedingText.index(before: precedingText.endIndex)] : " "
        }
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let newWord:String = String(word.dropLast())
        
        print("word: \(newWord)")
        //let range = NSRange(location: 0, length: newWord.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: newWord, range: NSRange(0..<newWord.utf16.count), startingAt: 0, wrap: false, language: "en_US")
        
        //print(misspelledRange.location == NSNotFound)

        return misspelledRange.location != NSNotFound
    }
 
        
        
    
    
    @objc func Swipe(sender: UISwipeGestureRecognizer)
    {
        
        switch sender.direction {
        case .up:
            print("Swipe Up")
        case .down:
            print("Swipe Down")
        case .left:
            deleteLastWord()
        case .right:
            print("Swipe Right")
        default:
            print("swipe error")
        }
    }
    

    

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        print("Did Change")
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.white
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}

func redrawkeyboard(){
    for button in buttons {
        var text = button.titleLabel?.text
        if caps {
            text = text?.uppercased()
        } else {
            text = text?.lowercased()
        }
        if (text != "SPACE" && text != "RETURN") {
            button.setTitle(text, for: UIControl.State.normal)
            button.titleLabel?.sizeToFit()
        }
    }
}
