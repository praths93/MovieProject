import UIKit

class AddMovieViewController: UIViewController {
    
    //MARK: OUTLET
    @IBOutlet weak var movieNameTF: UITextField!
    @IBOutlet weak var actorNameTF: UITextField!
    @IBOutlet weak var releaseYearTF: UITextField!
    
    //MARK: GLOBAL VARIABLES
    var movie: MovieModal?
    var indexToPass: Int?
    weak var delegateVC2: AddUpdateMovieDetailProtocol?
    var years: [String] = []
    var pickerView = UIPickerView()
    var movieClosure : ((MovieModal , Int?) -> ())? //Backdata Passing using Closure
    
    
    //MARK: LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieNameTF.text = movie?.movieMC
        self.actorNameTF.text = movie?.actorMC
        self.releaseYearTF.text = movie?.yearMC
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",                                                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addDetails))
        pickerView.dataSource = self
        pickerView.delegate = self
        years = fetchPickerData()
        releaseYearTF.inputView = pickerView
        createToolbar()
    }
    
    //MARK: DATA IN PICKER-VIEW
    func fetchPickerData() -> [String]{
        let yearlist = 1950...2022
        var yearArray  = [String]()
        for i in yearlist {
            //            yearArray.append("\(i)")
            let yearString = String(i)
            yearArray.append(yearString)
        }
        return yearArray
    }
    //MARK: "DONE BUTTON" ON PICKER-VIEW
    func createToolbar() // Creating Done Button on Picker View
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddMovieViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        releaseYearTF.inputAccessoryView = toolbar
    }
    @objc func closePickerView()
    {
        view.endEditing(true)
    }
    
    //MARK: DELEGATE METHODS
    @objc func addDetails() {
        
        if  let closure = movieClosure {
            let mName = self.movieNameTF.text
            let aName =  self.actorNameTF.text ?? ""
            let releaseYr =  self.releaseYearTF.text ?? ""
            
            let movieNm = ((mName ?? "").count > 0) ? mName : nil
            let actorNm = (aName.count > 0) ? aName : nil
            let rYear = (releaseYr.count > 0) ? releaseYr : nil
            let movieL = MovieModal(movieMC: movieNm, actorMC: actorNm, yearMC: rYear)
            
            closure(movieL, indexToPass)
            
            //delegate.passData(movie: movieL,
            //indexValue: self.indexToPass)
      
            self.navigationController?.popViewController(animated: true)
        }
        else {
            print("closure is Nil")
        }
    }
}

//MARK: UIPickerViewDataSource, UIPickerViewDelegate
extension AddMovieViewController: UIPickerViewDataSource , UIPickerViewDelegate {
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        1
    }
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        years.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        years[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        releaseYearTF.text = years[row]
        //releaseYearTF.resignFirstResponder() --> for Direct CutOff without Done Button
    }
    
}


