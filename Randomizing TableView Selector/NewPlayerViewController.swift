//
//  NewPlayerViewController.swift
//  Randomizing TableView Selector
//
//  Created by Jacob Davis on 2/29/24.
//

import UIKit

class NewPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerNameTextfield: UITextField!
    var playerToEdit: Player?
    
    init?(coder: NSCoder, player: Player?) {
        playerToEdit = player
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = playerNameTextfield.text, playerNameTextfield.text != nil else { return }
        playerToEdit = Player(name: name)
        
        performSegue(withIdentifier: "unwindToList", sender: sender)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

}
