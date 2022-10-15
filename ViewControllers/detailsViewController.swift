//
//  detailsViewController.swift
//  project
//
//  Created by Maram Waleed on 09/08/2021.
//
import youtube_ios_player_helper
import UIKit
import SDWebImage
import CoreData
import Cosmos
class detailsViewController: UIViewController {
    func favMovie(result: Result) {
        MovieArray.append(result)
    }
    
    @IBOutlet weak var ratingView: CosmosView!
    var isActive : Bool = false
    @IBOutlet weak var changeImgBtn: UIButton!
    @IBOutlet weak var labell: UILabel!
    var reviewArray :[Reviews] = []
    var OObj : Reviews!
    var MovieArray : [Result] = []
    var obj : Result!
    var trailersArray :[Trailer] = []
    var trialerobj : Trailer!
    var Id : Int!
   
   
    @IBOutlet weak var reviewstableView: UITableView!
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var posterImgView: UIImageView!
    var appDelegate:AppDelegate!
    var managedObjectContext : NSManagedObjectContext!
   
    @IBAction func btnStart(_ sender: UIButton) {
        if isActive {
            
            isActive = false
            changeImgBtn.setImage(UIImage(systemName: "star"), for: .normal)
        
            if let VC = storyboard?.instantiateViewController(identifier: "FVC") as? favTableViewController{
//                VC.delete(OObj)
//                VC.tableView(UITableViewCell, editingStyleForRowAt: .delete)

                do{
                
                try managedObjectContext.save()
                
                print("data is saved")
                
                
            }catch  let error as NSError{
                print(error.localizedDescription)
                
                
            }}
        }else{
            
            isActive = true
            changeImgBtn.setImage(UIImage(systemName: "star.fill" ), for: .normal)
            if let VC = storyboard?.instantiateViewController(identifier: "FVC") as? favTableViewController{
                let name = obj.originalTitle
                let id = obj.id
                let overview = obj.overview
                let img = obj.posterPath
                let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext)!
                let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                movie.setValue(name, forKey: "name")
                movie.setValue(id, forKey: "id")
                movie.setValue(overview, forKey: "overview")
                movie.setValue(img, forKey: "poster")
                do{
                    
                    try managedObjectContext.save()
                    
                    print("data is saved")
                    
                    
                }catch  let error as NSError{
                    print(error.localizedDescription)
                    
                    
                }
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.settings.fillMode = .precise
        ratingView.settings.updateOnTouch = true
        ratingView.text = String( obj.voteAverage ?? 0)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext

        labell.text = obj.releaseDate
        nameLable.text = obj.originalTitle
          let url = obj.posterPath
          posterImgView?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(url ?? "")")!, placeholderImage: UIImage(systemName: "exclamationmark.square.fill" ))
          overViewTextView.text = obj.overview
     

    }
   
    
    
    
    
    
    
    
    @IBAction func revBtn(_ sender: Any) {

        if let vc = storyboard?.instantiateViewController(identifier: "RTVC") as? reviewTableViewController {
           
            vc.ID = Id
        
            self.navigationController?.pushViewController(vc, animated: true)

        }}
  override func viewWillAppear(_ animated: Bool) {
    
        reviewstableView.delegate = self
        reviewstableView.dataSource = self
        
       collectionView.delegate = self
        collectionView.dataSource = self
        
        
      
        
        
        ApiServiceReviewsManager().fetchDataFromApiByAlamofire(id: Id) { (fetchedMoviesArray, error) in
            if let unwrappedMovieArray = fetchedMoviesArray {
       self.reviewArray = unwrappedMovieArray

       DispatchQueue.main.async {

        self.reviewstableView.reloadData()
                }
   }
          if let unwrappedError = error {


                print(unwrappedError)

            }
        }
        ApiServicTrailerseManager().fetchDataFromApiByAlamofire(iid: Id) { (fetchedMoviesArray, error) in
      if let unwrappedMovieArray = fetchedMoviesArray {
       self.trailersArray = unwrappedMovieArray

                DispatchQueue.main.async {

                    self.collectionView.reloadData()
                }
   }
          if let unwrappedError = error {


                print(unwrappedError)

            }
        }
setupUi()

    }
}
extension detailsViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! revTableViewCell
        let content = self.reviewArray[indexPath.row].content
        cell.contenrlabel?.text = content
        cell.contenrlabel.numberOfLines = 0
        cell.frame.size.width = 300
        cell.frame.size = CGSize(width: 350 , height: cell.frame.size.height * CGFloat(cell.contenrlabel.numberOfLines))
        cell.contenrlabel.sizeToFit()
        cell.contenrlabel.lineBreakMode = .byWordWrapping
        cell.nameLabel.text = reviewArray[indexPath.row].author
        cell.nameLabel.numberOfLines = 0
        cell.nameLabel.sizeToFit()
        cell.nameLabel.lineBreakMode = .byWordWrapping
        
        return cell
    }









}
//
extension detailsViewController :UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! playerCollectionViewCell
       
        let key = trailersArray[indexPath.row].key ?? ""
        cell.playerview?.load(withVideoId: key)
        
     return cell
    }
    

func setupUi(){
    
    
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
    
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
    
    
    let section = NSCollectionLayoutSection(group: group)
    
    
    section.orthogonalScrollingBehavior = .continuous
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    
    collectionView.collectionViewLayout = layout
    
  
    
    
}





}
