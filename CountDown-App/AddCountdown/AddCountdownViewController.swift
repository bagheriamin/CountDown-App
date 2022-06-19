//
//  AddCountdownViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import UIKit

protocol MadeCountdownDelegate {
    func didMakeChoices(name: String, date: Date, image: UIImage)
}

class AddCountdownViewController: UIViewController {

    @IBOutlet var okButton: UIBarButtonItem!
    
    var madeCountdownDelegate: MadeCountdownDelegate!
    var isFilledOut: Bool = false
    var timer = Timer()
    var addImagesAndTextReferenceVC: AddImagesAndTextTableViewController?
    
    func saveContainerViewReference(vc: AddImagesAndTextTableViewController) {
        self.addImagesAndTextReferenceVC = vc
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        okButton.isEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.updateOkButton()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
 
    func updateOkButton() {
        
        guard let isFilledOutInVC = addImagesAndTextReferenceVC?.isFilledOut else { return }
        isFilledOut = isFilledOutInVC
        
        if isFilledOut == false {
            okButton.isEnabled = false
        } else if isFilledOut {
            okButton.isEnabled = true
            name = addImagesAndTextReferenceVC!.name
            date = addImagesAndTextReferenceVC!.date
            image = addImagesAndTextReferenceVC!.image
        }
    }
    
    
    @IBAction func xButtonPressed(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    var name: String?
    var date: Date?
    var image: UIImage?
    
    @IBAction func okButtonPressed(_ sender: UIBarButtonItem) {
        
        
        
    }
    

    
}
