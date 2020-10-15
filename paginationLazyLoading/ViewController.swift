//
//  ViewController.swift
//  paginationLazyLoading
//
//  Created by POORAN SUTHAR on 23/07/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

struct Characters : Codable {
    let results : [Result]
}

struct Result: Codable {
    let name ,gender: String
}

class ViewController: UIViewController {
    
    var page = 1
    var persons = [Result]()
    var isDataFetching = false
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(pageNumber: page)
        activityIndicator.isHidden = true
    }
    
    func getData(pageNumber : Int){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(pageNumber)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(error)
            DispatchQueue.main.async {
                self.isDataFetching = false
                self.activityIndicator.isHidden = true
            }
            if let _ = error {
                return
            }
            guard let response = response as? HTTPURLResponse,
                response.hasSuccessStatusCode,
                let data = data else {
                    //self.page -= 1
                    return
            }
            
            let decoder = JSONDecoder()
            do {
                let jsonData = try decoder.decode(Characters.self, from: data)
                let personData = jsonData.results
                self.persons.append(contentsOf: personData)
                DispatchQueue.main.async {
                    self.userTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

extension ViewController : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        let lastIndex = persons.count - 1
        if indexPath.row == lastIndex && page < 30 && !isDataFetching {
            isDataFetching = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            page += 1
            if isDataFetching {
                getData(pageNumber: page)
            }
        } 
        
        let user = persons[indexPath.row]
        cell.namlbl.text = user.name
        cell.genderlbl.text = user.gender
        cell.srnumber.text = "\(indexPath.row)"
        return cell
    }
    

    
}

extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
