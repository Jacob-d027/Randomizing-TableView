//
//  ViewController.swift
//  Randomizing TableView Selector
//
//  Created by Jacob Davis on 2/28/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    var players: [Player] = [Player(name: "player 1"), Player(name: "player 2")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        playersTableView.backgroundColor = UIColor(red: 164/255, green: 181/255, blue: 191/255, alpha: 1.0)
        playersTableView.reloadData()
    }

    @IBSegueAction func addNewPlayer(_ coder: NSCoder) -> NewPlayerViewController? {
        return NewPlayerViewController(coder: coder, player: nil)
    }
    
    @IBAction func randomize(_ sender: Any) {
        let randomChoice = Int.random(in: 0..<players.count)
        
        playersTableView.visibleCells.forEach { cell in
            cell.contentView.backgroundColor = .clear
        }
        
        if let cell = playersTableView.cellForRow(at: IndexPath(row: randomChoice, section: 0)) {
            cell.contentView.backgroundColor = .green
        }
    }
    
    
    @IBSegueAction func editPlayerName(_ coder: NSCoder, sender: Any?) -> NewPlayerViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = playersTableView.indexPath(for: cell) else {
            return nil
        }
        let playerToEdit = players[indexPath.row]
        
        return NewPlayerViewController(coder: coder, player: playerToEdit)
    }
    
    @IBAction func unwindToPlayerListView(segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? NewPlayerViewController, let player = sourceVC.playerToEdit else { return }
        
        if let indexPath = playersTableView.indexPathForSelectedRow {
            players.remove(at: indexPath.row)
            players.insert(player, at: indexPath.row)
            playersTableView.deselectRow(at: indexPath, animated: true)
            playersTableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            players.append(player)
            playersTableView.reloadData()
        }
    }
    
    
}

// MARK: TableView Data Source and Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 156/255, green: 216/255, blue: 255/255, alpha: 1.0)

        var content = cell.defaultContentConfiguration()
        content.text = players[indexPath.row].name
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
