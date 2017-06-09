//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Len512 on 08/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var iconImageView: UIImageView!
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    // Store the icon name in a temporary variable and copy that to the iconName propetry at the right time
    // Initialise Lists with the Folder icon (for new checklists only)
    var iconName = "Folder"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Change the title of the screen if the user is editing an existing checkist
        // and put the checklist's name into the text field
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            iconName = checklist.iconName
            iconImageView.image = UIImage(named: iconName)
        }
    }
    // Pop-up the keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            // Allow to tap the Icon cell to trigger the segue
            return indexPath
        } else {
            // Make sure the user cannot select the table cell with the text field
            return nil
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Tell the IconPickerViewController that this screen is now its delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
    
    // MARK: - Action methods
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!, iconName: iconName)
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        }
    }
    
    // MARK: - Delegate methods
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)
        return true
    }
    
    // MARK: - IconPickerViewControllerDelegate methods
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        let _ = navigationController?.popViewController(animated: true)
    }
}
