//=================================
import UIKit
//=================================
class GradeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //----------------
    @IBOutlet weak var student_name_label: UILabel!
    @IBOutlet weak var course_field: UITextField!
    @IBOutlet weak var grade_field: UITextField!
    @IBOutlet weak var course_grade_tableview: UITableView!
    
    //---------------
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    typealias poid = Double
    //----------------
    let userDefaultsObj = UserDefaultManager()
    var studentGrades: [studentName: [course : [grade : poid]]]!
    var arrOfCourses: [course] = []
    var arrOfGrades: [grade] = []
    var arrOfPoids : [poid] = []
    //----------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
        let name = userDefaultsObj.getValue(theKey: "name") as! String
        student_name_label.text = name
        fillUpArray()
        loadCourseAndGrade()
    }
    //----------------
    //virifier si il ya des valeur au pas
    func loadUserDefaults() {
        if userDefaultsObj.doesKeyExist(theKey: "grades") {
            studentGrades = userDefaultsObj.getValue(theKey: "grades") as! [studentName: [course : [grade : poid]]]
        } else {
            studentGrades = [studentName: [course : [grade : poid]]]() //une valeur assigner mais vide
        }
    }
    //----------------
    func fillUpArray() {
        let name = student_name_label.text
        let course_and_grade = studentGrades[name!]
        let grade2 = [course](course_and_grade!.keys)[0]
        let course_and_grade2 = course_and_grade?[grade2]
        
        arrOfCourses = [course](course_and_grade!.keys)
        arrOfGrades = [grade](course_and_grade2!.keys)
        arrOfPoids = [grade](course_and_grade2!.values)
    }
    //----------------
    func loadCourseAndGrade() {
        let name = student_name_label.text
        var course_and_grade = studentGrades[name!]
        let grade2 = [course](course_and_grade!.keys)[0]
        let course_and_grade2 = course_and_grade?[grade2]
        
        if course_and_grade?.keys.count == 0 {
            studentGrades[name!] = ["Example": [10 : 0]]
            course_and_grade = studentGrades[name!]
        }
        let the_course = [course](course_and_grade!.keys)[0]
        let the_grade = [grade](course_and_grade2!.keys)[0]
        course_field.text = the_course
        grade_field.text = String(the_grade)
        course_grade_tableview.reloadData()
    }
    //----------------
    @IBAction func save_course_and_grade(_ sender: UIButton) {
        //let value = [course_field.text!: Double(grade_field.text!)!]
        let name = student_name_label.text
        var student_courses = studentGrades[name!]
        student_courses![course_field.text!] = Double(grade_field.text!)
        studentGrades[name!] = student_courses
        userDefaultsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
        fillUpArray()
        course_grade_tableview.reloadData()
        print(studentGrades)
    }
    //----------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfCourses.count
    }
    //----------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = arrOfCourses[indexPath.row]
        return cell
    }
    //----------------
    //pour supprimer
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = student_name_label.text
            var student_courses1 = studentGrades[name!]
            student_courses1 = [:]
            arrOfCourses.remove(at: indexPath.row)
            arrOfGrades.remove(at: indexPath.row)
            
            if (arrOfCourses.count == 0) {
                student_courses1 = [:]
            } else {
                for a in 0...(arrOfCourses.count - 1) {
                student_courses1![arrOfCourses[a]] = Double(arrOfGrades[a])
                }
            }
            studentGrades[name!] = student_courses1
        
            userDefaultsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
//=================================



