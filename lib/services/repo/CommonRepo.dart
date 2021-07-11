import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../authenticationFile.dart';

class ApiController  {

////////////////RegisterUser to firebase///////////////////////

  /*Future<User> createUser(
       String email, String password) async {
    Map<String, String> userdata = {
      "Email": email
    };
    try{
       await Authentication()
          .auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
         SaveDataToFirestore()
            .reference
            .add(userdata);

      }).catchError(
            (onError) =>
            Get.snackbar("Error while creating account ", onError.message),
      );
    }catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  Future createUser(String email, String password) async {
    try {
      UserCredential result = await Authentication()
          .auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }
}

class Users {
  final String uid;
  Users({this.uid});

}