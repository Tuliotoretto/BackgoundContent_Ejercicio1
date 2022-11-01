//
//  ViewController.swift
//  BackgoundContent
//
//  Created by Julian Garcia  on 29/10/22.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    
    @IBOutlet weak var characterTableView: UITableView!
    
    var rickAndMortyManager = RickAndMortyManager()
    var rickAndMorty: RickAndMorty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Characters!"
        
        rickAndMortyManager.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.networkMonitor.currentPath.status == .satisfied {
            rickAndMortyManager.fetchCharacters()
        } else {
            let ac = UIAlertController(title: "Error", message: "No hay conexion a internet", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rickAndMorty?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        cell.characterNameLabel.text = rickAndMorty?.results[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ImageViewControllerID") as? ImageViewController else {return}
        vc.character = rickAndMorty?.results[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - RickAndMortyDelegate
extension CharacterListViewController: RickAndMortyDelegate {
    
    func didUpdateData(_ rickAndMortyManager: RickAndMortyManager, _ rickAndMorty: RickAndMorty) {
        self.rickAndMorty = rickAndMorty
        
        DispatchQueue.main.async {
            self.characterTableView.reloadData()
        }
    }
    
    func didFailWithError(_ rickAndMortyManager: RickAndMortyManager, _ error: Error) {
        print(error.localizedDescription)
    }
}
