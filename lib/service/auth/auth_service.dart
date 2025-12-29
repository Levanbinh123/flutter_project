import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

  //get instance of firebase store
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  //get current user
User? getCurrentUser(){
  return _firebaseAuth.currentUser;
}
  //sign in
Future<UserCredential> singinWithEmailPassword(String email, password)async{
  try{
    UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword
      (email: email, password: password);
    return userCredential;

  }
  on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }
}


  ///sign up
Future<UserCredential> sigupUpWithEmailPassword(String email,password)async{
  try{
    UserCredential userCredential=
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }
}

  //sign out
Future<void> signOut() async{
  return await _firebaseAuth.signOut();
}
}