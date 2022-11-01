//
//  ImageViewController.swift
//  BackgoundContent
//
//  Created by Julian Garcia  on 31/10/22.
//

import UIKit

class ImageViewController: UIViewController {
    
    var character: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = character?.name
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.networkMonitor.currentPath.status == .satisfied {
            openImage()
        } else {
            let ac = UIAlertController(title: "Error", message: "No hay conexion a internet", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func openImage() {
        guard let _ = character else {return}
        guard let url = URL(string: character!.image) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let safeData = data {
                DispatchQueue.main.async {
                    let iv = UIImageView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
                    iv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    iv.contentMode = .scaleAspectFit
                    iv.image = UIImage(data: safeData)
                    self.view.addSubview(iv)
                }
            }
        }
        task.resume()
    }
}
