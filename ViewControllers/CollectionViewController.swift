//
//  CollectionViewController.swift
//  project
//
//  Created by Maram Waleed on 07/08/2021.
//

import UIKit
import SDWebImage
import CoreData
class CollectionViewController: UICollectionViewController {
    var reviewArray :[Reviews] = []
    var MovieArray : [Result] = []
    var Appdelegate : AppDelegate!
    var managedobjcontext : NSManagedObjectContext!
    var coreDataMovieArray : [NSManagedObject] = []
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var sortBtnn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
      Appdelegate = UIApplication.shared.delegate as! AppDelegate
        managedobjcontext = Appdelegate.persistentContainer.viewContext
       
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
           collectionView.delegate = self
        collectionView.dataSource = self
        
        let menu = UIMenu(title: "", children:[ UIAction(title: "popularity", handler:{_ in
            
            ApiPopularServiceManager().fetchDataFromApiByAlamofire() {
                 (fetchMovieArray, error)->(Void)  in
                 self.spinner.stopAnimating()
                 if let unwrappedArray = fetchMovieArray{

                     self.MovieArray = unwrappedArray
                     DispatchQueue.main.async{
                         self.collectionView.reloadData()
                   print("good")
                     }


                 }
                 if let unwrappedError = error {

                       print("errpprr")
                     print(unwrappedError)

                 }
             }
            
         }
         ), UIAction(title: "upcoming", handler:{_ in
        
           ApiUpComingServiceManager().fetchDataFromApiByAlamofire() {
                (fetchMovieArray, error)->(Void)  in
                self.spinner.stopAnimating()
                if let unwrappedArray = fetchMovieArray{

                    self.MovieArray = unwrappedArray
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                  print("good")
                    }


                }
                if let unwrappedError = error {

                      print("errpprr")
                    print(unwrappedError)

                }
            }
           
        }
        )])
        self.toolbarItems = [UIBarButtonItem(title: nil, image:UIImage(systemName: "list.number"), menu: menu)]
        self.sortBtnn.menu = menu
        
        if NetwtorkManager.shared.isconnected(){
            self.collectionView.backgroundColor = .blue
            print("no internet connection")
             let alertController = UIAlertController(title: "alert", message: "please check your internet connection", preferredStyle: .alert)
             let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
             alertController.addAction(action)
             present(alertController, animated: true, completion: nil)
             
             
             
            let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            
            do{
                try managedobjcontext.save()
                coreDataMovieArray = try managedobjcontext.fetch(fetchrequest)
                MovieArray.removeAll()
                for movie in coreDataMovieArray{
                    
                    
                    
                    
                    let name = movie.value(forKey: "name") as? String ?? ""
                    let id  = movie.value(forKey: "id") as? Int ?? 0
                    let votAvg  = movie.value(forKey: "averagerating") as? Double ?? 0
                    let date  = movie.value(forKey: "date") as? String ?? ""
                    let overView = movie.value(forKey: "overview") as? String ?? ""
                    let rating = movie.value(forKey: "rating") as? Int ?? 0
                    let poster = movie.value(forKey: "poster") as? String ?? ""
                    
                    let favobj = Result(id: id, originalTitle: name, overview: overView, posterPath: poster, releaseDate: date, voteAverage: votAvg, voteCount: rating)
                    MovieArray.append(favobj)
                    try managedobjcontext.save()
                }
               collectionView.reloadData()
                
            }
            catch let error as NSError{
                
                
                print(error.localizedDescription)
                
            }
       }else
        {
            
            ApiServiceManager().fetchDataFromApiByAlamofire() {
                (fetchMovieArray, error)->(Void)  in
             self.spinner.stopAnimating()
                if let unwrappedArray = fetchMovieArray{

                    self.MovieArray = unwrappedArray
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                  print("good")
                    }


                }
                if let unwrappedError = error {

                      print("errpprr")
                    print(unwrappedError)

                }
            }
           
            print("reachable")
        }
             setupui()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return MovieArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.sspinner.startAnimating()
        let url = MovieArray[indexPath.row].posterPath
       
        cell.imageCell?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(url ?? "")")!, placeholderImage: UIImage(systemName: "exclamationmark.square.fill" ))
        cell.sspinner.stopAnimating()
        return cell
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        if let vc = storyboard?.instantiateViewController(identifier: "DVC") as? detailsViewController {
          vc.obj = MovieArray[indexPath.row]
            vc.Id = MovieArray[indexPath.row].id ?? 0

            self.navigationController?.pushViewController(vc, animated: true)

        }}

    
    func setupui() {


        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

          item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)



        let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitem: item, count: 2)



        let section = NSCollectionLayoutSection(group: horizontlGgroup)

        let layout = UICollectionViewCompositionalLayout(section: section)


        collectionView.collectionViewLayout = layout
    }
}
