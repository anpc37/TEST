//
//  ViewController.swift
//  Test
//
//  Created by 조형찬 on 2022/07/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.endFloatingCursor()
    }


    @IBAction func action(_ sender: Any) {
        
        let content = UNMutableNotificationContent()

        content.title = "로컬 타이틀"

        content.body = "로컬 바디"

        content.sound = UNNotificationSound.default

        content.categoryIdentifier = "image-message"



        let imageURLString = "https://i.ytimg.com/vi/7qkbRYM7YP8/maxresdefault.jpg"

        if let imagePath = DownloadManager.image(imageURLString) {

            let imageURL = URL(fileURLWithPath: imagePath)

            do {

                let attach = try UNNotificationAttachment(identifier: "imate-test", url: imageURL, options: nil)

                content.attachments = [attach]

            } catch {

                print(error)

            }

        }



        // Deliver the notification in five seconds.

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.

        let center = UNUserNotificationCenter.current()

        center.add(request) { (error : Error?) in

            if let theError = error {

                print(theError)

            }

        }
    }
}

open class DownloadManager: NSObject {

    open class func image(_ URLString: String) -> String? {

        let componet = URLString.components(separatedBy: "/")

        if let fileName = componet.last {

            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

            if let documentsPath = paths.first {

                let filePath = documentsPath.appending("/" + fileName)

                if let imageURL = URL(string: URLString) {

                    do {

                        let data = try NSData(contentsOf: imageURL, options: NSData.ReadingOptions(rawValue: 0))

                        if data.write(toFile: filePath, atomically: true) {

                            return filePath

                        }

                    } catch {

                        print(error)

                    }

                }

            }

        }

        

        return nil

    }

}


class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
