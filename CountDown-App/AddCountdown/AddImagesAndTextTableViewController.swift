//
//  AddImagesAndTextTableViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import PhotosUI
import UIKit

class AddImagesAndTextTableViewController: UITableViewController {

    var timer = Timer()
    
    var isFilledOut: Bool = false
    
    var name: String = ""
    var date: Date?
    var image: UIImage?
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var photoCollectionView: UICollectionView!
    
    
    
    @IBAction func returnButtonPressed(_ sender: UITextField) {
        textField.resignFirstResponder()
    }
    
    
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupHideKeyboardOnTap()
        
        datePicker.minimumDate = .now
    }

    // MARK: - Table view data source

   
    override func viewDidAppear(_ animated: Bool) {
        let addCountdownViewControllerParent = self.parent as! AddCountdownViewController
        addCountdownViewControllerParent.saveContainerViewReference(vc: self)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.validateFields()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func validateFields() {
        if name.isEmpty || date == nil || image == nil {
            isFilledOut = false
        } else {
            isFilledOut = true
        }
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true)
    }
   
    @IBAction func textEditingHappened(_ sender: UITextField) {
        name = textField.text!
        print("Name: ", name)
        
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        date = datePicker.date
        print("Date: ", date)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        image = images[indexPath.row]
        
    }
}

extension AddImagesAndTextTableViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [self] object, error in
                if let image = object as? UIImage {
                    images.append(image)
            
                    DispatchQueue.main.async {
                        
                        self.photoCollectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension AddImagesAndTextTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("images: ", images.count)
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        

        cell.photoImageView.image = images[indexPath.row]
        return cell
    }
    
    
}

extension AddImagesAndTextTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
}
