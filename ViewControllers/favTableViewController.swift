//
//  favTableViewController.swift
//  project
//
//  Created by Maram Waleed on 07/08/2021.
//

import UIKit
import CoreData
class favTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var appDelegate : AppDelegate!
    var managedObjContext : NSManagedObjectContext!
    var coreDataFavArray : [NSManagedObject] = []
    var oobj : Result!
    var MovieArray :[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

//        if NetwtorkManager.shared.isconnected(){
//            self.tableView.backgroundColor = .blue
//            print("no internet connection")
//             let alertController = UIAlertController(title: "alert", message: "please check your internet connection", preferredStyle: .alert)
//             let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//             alertController.addAction(action)
//             present(alertController, animated: true, completion: nil)
//


            let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            
            do{
                MovieArray.removeAll()
                try managedObjContext.save()
                coreDataFavArray = try managedObjContext.fetch(fetchrequest)
                for movie in coreDataFavArray{
                    
                    
                    
                    
                    let name = movie.value(forKey: "name") as? String ?? ""
                    let id  = movie.value(forKey: "id") as? Int ?? 0
                    let votAvg  = movie.value(forKey: "averagerating") as? Double ?? 0
                    let date  = movie.value(forKey: "date") as? String ?? ""
                    let overView = movie.value(forKey: "overview") as? String ?? ""
                    let rating = movie.value(forKey: "rating") as? Int ?? 0
                    let poster = movie.value(forKey: "poster") as? String ?? ""
                    let favobj = Result(id: id, originalTitle: name, overview: overView, posterPath: poster, releaseDate: date, voteAverage: votAvg, voteCount: rating)
                    
                    MovieArray.append(favobj)
                    try managedObjContext.save()
                    print("savedd")
                }
               tableView.reloadData()
                
            }
            catch let error as NSError{
                
                
                print(error.localizedDescription)
                
            }
            
        
    }
          
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return MovieArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! FavTableViewCell
        oobj = MovieArray[indexPath.row]
        let url = MovieArray[indexPath.row].posterPath
        cell.imagePoster?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(url ?? "")")!, placeholderImage: UIImage(systemName: "exclamationmark.square.fill" ))
        cell.nameLabel?.text = MovieArray[indexPath.row].originalTitle
        
        func deleteRow(){

            MovieArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try managedObjContext.save()

            }catch let error as NSError{

                print(error.localizedDescription)

            }
        }
        return cell
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            
            MovieArray.remove(at: indexPath.row)
            managedObjContext.delete(coreDataFavArray[indexPath.row])
       
            do {
                try managedObjContext.save()
                
            }catch let error as NSError{

                print(error.localizedDescription)

            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
          
           
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let VC = storyboard?.instantiateViewController(identifier: "DVC")as?detailsViewController{
            
            VC.obj = MovieArray[indexPath.row]
            VC.Id = MovieArray[indexPath.row].id
            self.navigationController?.pushViewController(VC, animated: true)
            
        }

                    
        }
    

}
