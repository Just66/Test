//
//  ListOfData.swift
//  Test
//
//  Created by Dmytro Aprelenko on 18.07.2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ListOfData: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items = [Item]()
    var filteredItems = [Item]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //customData()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        Request.instance.getData { (items, err) in
            guard let items = items else {
                let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""), message: err?.localizedDescription ?? "Uncaught error", preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
                alert.addAction(cancel)
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func customData() {
        items.append(Item(itemId: "4546", name: "Hulk", image: "https://lh3.ggpht.com/mJDgTDUOtIyHcrb69WM0cpaxFwCNW6f0VQ2ExA7dMKpMDrZ0A6ta64OCX3H-NMdRd20=s180", description: "46432", time: "1531934763"))
        items.append(Item(itemId: "5564", name: "Morrow", image: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/03/27/105090813-GettyImages-832673210.530x298.jpg?v=1522123726", description: "No description", time: "1531934890"))
        items.append(Item(itemId: "5564", name: "Donkey", image: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/03/27/105090813-GettyImages-832673210.530x298.jpg?v=1522123726", description: "Elephant", time: "1531934820"))
        items.append(Item(itemId: "5564", name: "Kino", image: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/03/27/105090813-GettyImages-832673210.530x298.jpg?v=1522123726", description: "No description", time: "1531934890"))
        items.append(Item(itemId: "5564", name: "Elepghant", image: "https://fm.cnbc.com/applications/cnbc.com/resources/img/editorial/2018/03/27/105090813-GettyImages-832673210.530x298.jpg?v=1522123726", description: "No description", time: "1531934890"))
    }
    
}

extension ListOfData: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredItems.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! DataCell
        if isSearching {
            cell.item = filteredItems[indexPath.row]
        } else {
            cell.item = items[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = self.storyboard?.instantiateViewController(withIdentifier: "detailedVC") as! DetailedVC
        if isSearching {
            detailedVC.items = filteredItems
            detailedVC.currentIndex = indexPath.row
        } else {
            detailedVC.items = items
            detailedVC.currentIndex = indexPath.row
        }
        
        present(detailedVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.orientation {
        case .portrait:
            return 180
        default:
            return 120
        }
    }
    
}

extension ListOfData: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            isSearching = false
            tableView.reloadData()
            return
        }
        isSearching = true
        
        filteredItems = items.filter {($0.name?.lowercased().contains(searchText.lowercased()))!}
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
