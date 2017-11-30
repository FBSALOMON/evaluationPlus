//----------------------------------
import Foundation
//----------------------------------
class UserDefaultManager {
    //----------------------------------
    func doesKeyExist(theKey: String) -> Bool {
        if UserDefaults.standard.object(forKey: theKey) == nil {
            return false
        }
        return true
    }
    //----------------------------------save une valeur avec la cles cad la valeur de credit alle vas etre sauvgarder
    func setKey(theValue: AnyObject, theKey: String) {
        UserDefaults.standard.set(theValue, forKey: theKey)
    }
    //----------------------------------la cle ke je veu éliminer
    func removekey(theKey: String) {
        UserDefaults.standard.removeObject(forKey: theKey)
    }
    //----------------------------------
    func getValue(theKey: String) -> AnyObject {
        return UserDefaults.standard.object(forKey: theKey) as AnyObject
    }
    //----------------------------------
}
//----------------------------------
