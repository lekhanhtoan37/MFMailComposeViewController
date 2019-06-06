//
//  ViewController.swift
//  MFMailComposeViewController
//
//  Created by Lê Toàn on 6/6/19.
//  Copyright © 2019 Lê Toàn. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,MFMailComposeViewControllerDelegate {
  lazy var button: UIButton = {
    let view = UIButton()
    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    return view
  }()
  
  let recipientsMail : String? = "Example@gmail.com"
  let subject : String? = "Example"
  let messageBody : String? = "Reason"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.addSubview(button)
    button.tintColor = .red
    button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
    button.setTitle("Send email", for: .normal)
    button.setTitleColor(.red, for: .normal)
    
  }
  @objc func sendEmail() {
    let mailComposeViewController = configureMailComposer()
    if MFMailComposeViewController.canSendMail() {
      self.present(mailComposeViewController, animated: true, completion: nil)
    } else {
      self .showerrorMessage()
    }
  }
  
  func configureMailComposer() -> MFMailComposeViewController{
    let mailComposeVC = MFMailComposeViewController()
    mailComposeVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
    mailComposeVC.setToRecipients([self.recipientsMail!])
    mailComposeVC.setSubject(self.subject!)
    mailComposeVC.setMessageBody(self.messageBody!, isHTML: false)
    return mailComposeVC
  }
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    switch result {
    case .cancelled:
      break
    case .saved:
      // Save to core data.
      break
    case .sent:
      break
    case .failed:
      break
    default:
      break
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  func showerrorMessage() {
    
    let alertMessage = UIAlertController(title: "Could not sent email", message: "Check if your device have email support!", preferredStyle: UIAlertController.Style.alert)
    
    let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
    
    alertMessage.addAction(action)
    
    self.present(alertMessage, animated: true, completion: nil)
    
  }
}




