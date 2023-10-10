//
//  Constants.swift
//  Vwitter
//
//  Created by Minho on 10/6/23.
//

/*
    여기에는 다른 파일들에서 사용할 Database URL Reference 를 만든다.
    매번 디비에 연결할 때 아래에 작성한 긴 chain을 매번 쓸 수는 없으므로 Global Variable로 만든다.
 
    Global Variables는 되도록 사용하지 않는게 좋으나,
    여기서 사용할 디비 주소는 let (constant, 변하지 않음) 이므로 괜찮다.
*/

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
