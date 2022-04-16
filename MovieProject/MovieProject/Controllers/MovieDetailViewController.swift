import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: OUTLET
    @IBOutlet weak var MovieDetailTV: UITableView!
    
    //MARK: GLOBAL VARIABLES
    var movieArray: [MovieModal] = []
    
    
    //MARK: LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MovieDetailTV.dataSource = self
        self.MovieDetailTV.delegate = self
        
        let customMovieTableViewCellXib = UINib(nibName: "CustomMovieTableViewCell",
                                                bundle: nil)
        MovieDetailTV.register(customMovieTableViewCellXib, forCellReuseIdentifier:                                                         "CustomMovieTableViewCell")
        
    }
    
    //MARK: BUTTON ACTION
    @IBAction func addMovieDetails() {
        
        if let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AddMovieViewController") as? AddMovieViewController {
            vc2.movieClosure = { (movieC , rowIndex) in
                
                if let rowIndex = rowIndex {// Update
                    self.movieArray.remove(at: rowIndex)
                    self.movieArray.insert(movieC, at: rowIndex)
                } else { // Add
                    self.movieArray.append(movieC)
                }
                self.MovieDetailTV.reloadData()
            }
            //vc2.delegateVC2 = self
            self.navigationController?.pushViewController(vc2, animated: true)
        }
    }
}

//MARK: UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustomMovieTableViewCell"
        guard let cell = self.MovieDetailTV.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomMovieTableViewCell
        else {
            return UITableViewCell()
        }
        let movieIndex = movieArray[indexPath.row]
        cell.movieNameLabel.text = movieIndex.movieMC
        cell.actorNameLabel.text = movieIndex.actorMC
        cell.releaseYearLabel.text = movieIndex.yearMC
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension MovieDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Tapped \(indexPath)")
        if let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AddMovieViewController") as? AddMovieViewController {
            
            switch indexPath.row { // even cells not getting edited
            case 0,2,4:
                // Create new Alert
                let dialogMessage = UIAlertController(title: "Warning!!!!", message: "Cannot proceed this is a odd selection?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)

                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
                
                return
                
            default:
                let movie = self.movieArray[indexPath.row]
            
                vc2.indexToPass = indexPath.row
                vc2.movieClosure = { (movieC , rowIndex) in
                    
                    if let rowIndex = rowIndex {// Update
                        self.movieArray.remove(at: rowIndex)
                        self.movieArray.insert(movieC, at: rowIndex)
                    } else { // Add
                        self.movieArray.append(movieC)
                    }
                    self.MovieDetailTV.reloadData()
                }
                vc2.movie = movie
                
                //vc2.delegateVC2 = self
                              
                self.navigationController?.pushViewController(vc2, animated: true)
            }
            
        }
    }
}

//MARK: AddUpdateMovieDetailProtocol
extension MovieDetailViewController: AddUpdateMovieDetailProtocol {
    func passData(movie: MovieModal, indexValue:Int?) {
        
        if let rowIndex = indexValue {// Update
            self.movieArray.remove(at: rowIndex)
            self.movieArray.insert(movie, at: rowIndex)
        } else { // Add
            self.movieArray.append(movie)
        }
        self.MovieDetailTV.reloadData()
    }
}

