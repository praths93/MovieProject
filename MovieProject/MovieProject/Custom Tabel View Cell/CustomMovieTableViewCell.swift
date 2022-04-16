import UIKit

class CustomMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var actorNameLabel: UILabel!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
