//
//  ViewController.swift
//  MFMailComposeViewController
//
//  Created by Lê Toàn on 6/6/19.
//  Copyright © 2019 Lê Toàn. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class ViewController: UIViewController,MFMailComposeViewControllerDelegate, SKStoreProductViewControllerDelegate {
  lazy var button: UIButton = {
    let view = UIButton()
    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    return view
  }()
  
  lazy var button2: UIButton = {
    let view = UIButton()
    view.frame = CGRect(x: 300, y: 100, width: 100, height: 100)
    return view
  }()
  
  let recipientsMail : String? = "Example@gmail.com"
  let subject : String? = "Example"
  let messageBody : String? = "Reason"
  
  let idDeveloper: String? = "526656015"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.addSubview(button)
    self.view.addSubview(button2)

    button.tintColor = .red
    button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
    button.setTitle("Send email", for: .normal)
    button.setTitleColor(.red, for: .normal)
    
    button2.addTarget(self, action: #selector(getMoreApp), for: .touchUpInside)
    button2.setTitle("More app", for: .normal)
    button2.setTitleColor(.red, for: .normal)
  }
  
  @objc func getMoreApp() {
    if #available(iOS 8.0, *) {
      guard let idDeveloper = idDeveloper else {return}
      openStoreProductWithiTunesItemIdentifier(identifier: idDeveloper)
    } else {
      let url  = NSURL(string: "itms://itunes.apple.com/vn/developer/king/id526656015?mt=8")
      if UIApplication.shared.canOpenURL(url! as URL) == true  {
        UIApplication.shared.openURL(url! as URL)
      }
      
    }
    
  }

  func openStoreProductWithiTunesItemIdentifier(identifier: String) {
    let storeViewController = SKStoreProductViewController()
    storeViewController.delegate = self
    
    let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
    storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
      if loaded {
        // Parent class of self is UIViewContorller
        self?.present(storeViewController, animated: true, completion: nil)
      }
    }
  }
  func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
    viewController.dismiss(animated: true, completion: nil)
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




