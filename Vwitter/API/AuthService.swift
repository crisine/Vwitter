//
//  AuthService.swift
//  Vwitter
//
//  Created by Minho on 10/10/23.
//

import UIKit
import Firebase
import FirebaseAuth

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    // Singleton Pattern
    static let shared = AuthService()
    
    func logUserIn(withEmail email:String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser( credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let profileImage = credentials.profileImage
        let username = credentials.username
        
        // 이미지 압축률을 과하게 올리면 처리 시간이 늘어짐
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        // 임의의 128비트 고유 값 생성하여 파일 이름으로 전달
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // firebase 서버에 email, pass 보내서 result와 error 받아옴. completion 블럭 내에서 처리.
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("디버그: Error is \(error.localizedDescription)")
                        return // 에러가 나면 더 이상 코드가 실행되지 않도록 return
                    }
                    
                    // 사용자 등록이 성공하면 Firebase 로부터 result가 날아오고, 그 안에서 uid를 꺼내 저장.
                    guard let uid = result?.user.uid else { return }
                    
                    // 사용자 정보에 대한 딕셔너리 만들기
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    // Database.database().reference() = 데이터베이스 주소 String
                    // .child("users") = 해당 데이터베이스에서 "users" 라는 이름의 child 구조체
                    // .child(uid) = users 구조체 하위의 uid 구조체
                    // let ref = Database.database().reference().child("users").child(uid)
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    
                    // 전역변수 사용하도록 변경
                    REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                        print("디버그: 성공적으로 사용자의 정보를 업데이트했습니다.")
                    }
                }
            }
        }
    }
    
}
