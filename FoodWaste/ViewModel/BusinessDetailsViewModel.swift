import Foundation
import FirebaseFirestore

class BusinessDetailsViewModel: ObservableObject {
    @Published var businessDetails: BusinesssDetailsModel = BusinesssDetailsModel()
    private var db = Firestore.firestore()
    let BUSINESS_DETAILS = "business details"
    
    func saveToFirebase(onCompleted: @escaping (_ isSuccess: Bool) -> Void) {
        print("businessDetails called with ", businessDetails);
        let bizDetailsDict = try! businessDetails.asDictionary()
        db.collection(BUSINESS_DETAILS).document(businessDetails.uenNum).setData(bizDetailsDict) { err in
            if let err = err {
                print("Error saving to firebase \(err)")
                onCompleted(false)
            } else {
                print("Save to firebase successfully")
                onCompleted(true)
            }
        }
    }
}
