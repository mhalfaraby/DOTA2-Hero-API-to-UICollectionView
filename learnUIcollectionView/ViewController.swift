//
//  ViewController.swift
//  learnUIcollectionView
//
//  Created by flow on 01/12/20.
//

import UIKit
struct Hero: Decodable {
    
    let localized_name: String
    let img: String
}
class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var heroes = [Hero]()
  
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
                let url = URL (string: "https://api.opendota.com/api/heroStats")
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    if error == nil {
                        do {
                            self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                        } catch {
                            print("Parse Error")
                        }
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                }
                } .resume()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 1
        
        layout.minimumInteritemSpacing = 1
        
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4,
    height:  (view.frame.size.width/3)-4)
        
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        

   
        
     
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
//        cell.configure(label: heroes[indexPath.row].localized_name)
         
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + heroes[indexPath.row].img
        
        
        //        imageView.image = UIImage(systemName: "house")
        

        cell.configure(label: heroes[indexPath.row].localized_name, image: completeLink)
        
    

        
        return cell
    }
   
    
}




        
        
//        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
    



