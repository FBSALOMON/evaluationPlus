//============================
import UIKit
//============================
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //---------------
    @IBOutlet weak var student_name_feild: UITextField!
    @IBOutlet weak var student_name_tableview: UITableView!
    //---------------
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    //---------------
    let userDefaultsObj = UserDefaultManager()
    var studentGrades: [studentName: [course: grade]]!
    //---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
    }
    //---------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentGrades.count
    }
    //---------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [studentName](studentGrades.keys)[indexPath.row]
        return cell
    }
    //---------------
    //la méthode qui devient active lorsque quand click sur une cellule
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = [studentName](studentGrades.keys)[indexPath.row] //chercher le nom de l acell que je vé cicker de su
        userDefaultsObj.setKey(theValue: name as AnyObject, theKey: "name") //j ai en memoir le nom de l'eleve ke j ai clicker ,sous la clé name
        performSegue(withIdentifier: "seg", sender: nil) //partir de segue
    }
    //---------------
    //pour supprimer
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = [studentName](studentGrades.keys)[indexPath.row]
            studentGrades[name] = nil
            userDefaultsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //---------------
    //func pour return le clavier
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //---------------
    //virifier si il ya des valeur au pas
    func loadUserDefaults() {
        if userDefaultsObj.doesKeyExist(theKey: "grades") {
            studentGrades = userDefaultsObj.getValue(theKey: "grades") as! [studentName: [course: grade]]
        } else {
            studentGrades = [studentName: [course: grade]]() //une valeur assigner mais vide
        }
    }
    //---------------
    @IBAction func addStudent(_ sender: UIButton) {
        if student_name_feild.text != "" {
            //il faut ajouter un alert que dit le champs est vide
            studentGrades[student_name_feild.text!] = ["EMPTY": 0.0]//quand je creer mon etudent au debut j pas de cours et j pa de note
            student_name_feild.text = "" //vider le champ
            userDefaultsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades") //garder l'information
            student_name_tableview.reloadData() //faire la mise a jour de mon tableview
        }
    }
    //---------------
}
//============================
