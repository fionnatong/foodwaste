//
//  RecipientViewModel.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI
import FirebaseFirestore

// TODO: update this whole file after the donor side is complete.
class RecipientViewModel: ObservableObject {
    @Published var recipient: Recipient
    private var db = Firestore.firestore()
    let RECIPIENT_COLLECTION = "recipient"
    
    init (initialValue: Recipient?){
        guard let initialRecipient = initialValue  else {
            self.recipient = Recipient(organisationName: "", uenNumber: "", address: "")
            return
        }
        
        self.recipient = initialRecipient
    }
    
    func updateName(_ newValue: String) {
        recipient.organisationName = newValue
    }
    
    func updateUEN(_ newValue: String) {
        recipient.uenNumber = newValue
    }
    
    func updateAddress(_ newValue: String) {
        recipient.address = newValue
    }
    
    func updateId(_ newValue: String) {
        recipient.id = newValue
    }
    
    func addRecipient(onCompleted: @escaping (_ isSuccess: Bool) -> Void) {
        print("addRecipient called with ", recipient);
        var ref: DocumentReference? = nil
        ref = db.collection(RECIPIENT_COLLECTION).addDocument(data: ["organisationName": recipient.organisationName, "uenNumber": recipient.uenNumber, "address": recipient.address]) { err in
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
