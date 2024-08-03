//
//  ViewController.swift
//  CDAlerts
//
//  Created by Victor Lehr on 7/26/24.
//

import UIKit

public let choices = ["Simple UIAlertViewController", "UIAlertViewController with Multiple Buttons", "UIAlertViewController with TextField", "Standard UIActionSheet"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = choices[row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rowValue = choices[indexPath.row]
        print(rowValue)

        switch indexPath.row {
        case 0:
            let controller = UIAlertController(title: "Alert Controller", message: rowValue, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
        case 1:
            let controller = UIAlertController(title: "Alert Controller", message: rowValue, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "One", style: .default))
            controller.addAction(UIAlertAction(title: "Two", style: .default))
            controller.addAction(UIAlertAction(title: "Three", style: .default))
            controller.addAction(UIAlertAction(title: "Four", style: .default))
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(controller, animated: true)
        case 2:
            let controller = UIAlertController(title: "Alert Controller", message: rowValue, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            controller.addTextField() {
                textField in textField.placeholder = "Enter something"
            }
            controller.addAction(UIAlertAction(title: "OK", style: .default) {
                action in
                let enteredText = controller.textFields![0].text
                print(enteredText!)
            })
            present(controller, animated: true)
        case 3:
            let controller = UIAlertController(title: "Action Sheet", message: rowValue, preferredStyle: .actionSheet)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            controller.addAction(UIAlertAction(title: "Delete", style: .destructive))
            present(controller, animated:true)
        default:
            print("What are you doing bro")
        }

    }

}

