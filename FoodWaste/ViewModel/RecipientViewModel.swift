//
//  RecipientViewModel.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI
import FirebaseFirestore

class RecipientViewModel: ObservableObject {
    @Published var recipient: Recipient
    private var db = Firestore.firestore()
    let RECIPIENT_COLLECTION = "recipient"
    
    init (initialValue: Recipient?){
        guard let initialRecipient = initialValue  else {
            self.recipient = Recipient(organisationName: "", uenNumber: "", address: "", postalCode: "")
            return
        }
        
        self.recipient = initialRecipient
    }
    
    func updateId(_ newValue: String) {
        recipient.id = newValue
    }
    
    func addRecipient(onCompleted: @escaping (_ isSuccess: Bool) -> Void) {
        print("addRecipient called with ", recipient);
        var ref: DocumentReference? = nil
        ref = db.collection(RECIPIENT_COLLECTION).addDocument(data: ["organisationName": recipient.organisationName, "uenNumber": recipient.uenNumber, "address": recipient.address, "postalCode": recipient.postalCode]) { err in
            if let err = err {
                print("Error adding recipient: \(err)")
                onCompleted(false)
            } else {
                print("Recipient added with ID: \(ref!.documentID)")
                self.updateId(ref!.documentID)
                onCompleted(true)
            }
        }

    }
}
