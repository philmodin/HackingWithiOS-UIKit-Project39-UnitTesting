//
//  ViewController.swift
//  Project39 UnitTesting
//
//  Created by endOfLine on 6/28/21.
//

import UIKit

class ViewController: UITableViewController {

    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(playData.filteredWords.count) words"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.filteredWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let word = playData.filteredWords[indexPath.row]
        cell.textLabel?.text = word
        cell.detailTextLabel?.text = "\(playData.wordCounts.count(for: word))"
        
        return cell
    }
    
    @objc func searchTapped() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Filter", style: .default) { [unowned self] _ in
            let userInput = ac.textFields?[0].text ?? "0"
            playData.applyUserFilter(userInput)
            title = "\(playData.filteredWords.count) words"
            tableView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Clear", style: .cancel) { [unowned self] _ in
            playData.applyUserFilter("")
            title = "\(playData.filteredWords.count) words"
            tableView.reloadData()
        })
        
        present(ac, animated: true)
    }

}

