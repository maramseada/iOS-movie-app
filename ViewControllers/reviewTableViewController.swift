//
//  reviewTableViewController.swift
//  project
//
//  Created by Maram Waleed on 07/08/2021.
//

import UIKit

class reviewTableViewController: UITableViewController {
    var ID : Int!
    var i = 0
    var reviewArray :[Reviews] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.dataSource = self
         tableView.delegate = self
//        tableView.register(UINib.init(nibName: "cell", bundle: nil), forCellReuseIdentifier: "cell")

    }
    override func viewWillAppear(_ animated: Bool) {
      
       ApiServiceReviewsManager().fetchDataFromApiByAlamofire(id: ID) { (fetchedMoviesArray, error) in


            if let unwrappedMovieArray = fetchedMoviesArray {



                self.reviewArray = unwrappedMovieArray

                 print(unwrappedMovieArray)
                DispatchQueue.main.async {
                   
                    self.tableView.reloadData()

                }
   }
          if let unwrappedError = error {


                print(unwrappedError)

            }
        }
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        return reviewArray.count
    }
   
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! revTableViewCell
        cell.nameLabel.text = reviewArray[indexPath.row].author
        cell.nameLabel.numberOfLines = 0
        cell.nameLabel.sizeToFit()
        cell.nameLabel.lineBreakMode = .byWordWrapping
        
        let content = self.reviewArray[indexPath.row].content
       
        cell.contenrlabel?.text = content
        cell.contenrlabel.numberOfLines = 0
        cell.frame.size.width = 300
        cell.frame.size = CGSize(width: 350 , height: cell.frame.size.height * CGFloat(cell.contenrlabel.numberOfLines))
        cell.contenrlabel.sizeToFit()
        cell.contenrlabel.lineBreakMode = .byWordWrapping
    
       
        return cell

        
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//
//        ApiServiceManager().fetchDataFromApiByAlamofire() { (fetchedMoviesArray, error) in
//
//            if let unwrappedMealArray = fetchedMoviesArray {
//
//
//
//                self.MovieArray = unwrappedMealArray
//
//
//                DispatchQueue.main.async {
//
//                    self.tableView.reloadData()
//                }
//
//
//
//            }
//
//
//            if let unwrappedError = error {
//
//
//                print(unwrappedError)
//
//            }
//
//        }
//
//
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return reviewArray.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//
//        for row in 0...(reviewArray.count){
//
//            let indexPath = NSIndexPath(row: row, section: 1)
//
//            let content = self.reviewArray[row].content
//            print(reviewArray)
//            cell.nameLabel.text = content
//
//
//        }
//        return cell
//
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
