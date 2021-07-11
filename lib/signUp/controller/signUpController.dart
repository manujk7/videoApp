import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app_flutter/player.dart';
import 'package:video_app_flutter/services/firestoreData/firestoreHandler.dart';
import 'package:video_app_flutter/services/repo/CommonRepo.dart';
import 'package:video_app_flutter/signUp/view/signUpPage.dart';

import '../../authenticationFile.dart';

import 'package:camera/camera.dart';

class SignUpController extends GetxController {
  final emailController = new TextEditingController().obs;
  final passwordController = new TextEditingController().obs;
  final confirmPasswordController = new TextEditingController().obs;
  var isLoggedIn = true.obs;
  var isHidden = true.obs;
  var showLoader = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  var isAutoValidate = false.obs;

  @override
  void onInit() {}

  void login(String email, String password) async {
    await Authentication()
        .auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Get.offAll(() => PlayerDemo()))
        .catchError(
            (onError) => Get.snackbar("Error while sign in ", onError.message));
  }

  void signOut() async {
    await Authentication()
        .auth
        .signOut()
        .then((value) => Get.offAll(() => PlayerDemo()));
  }

  registerUser() async {
    Map<String, String> userdata = {"Email": emailController.value.text};
    if (formKey.value.currentState.validate()) {
      var result = await ApiController().createUser(
          emailController.value.text, passwordController.value.text);
      if (result != null && result.uid != null) {
        await FireStoreHandler().userReference.add(userdata);
        final cameras = await availableCameras();

        // Get a specific camera from the list of available cameras.
        final firstCamera = cameras.last;
        Navigator.of(Get.context).push(MaterialPageRoute(
            builder: (context) => PlayerDemo(
                  camera: firstCamera,
                )));
      } else {
        Get.snackbar("error", "Something went wrong");
      }
    } else {}
  }

/*  loginUser() async{

    Result result = await firebaeHandler.logi(Map );
    jhgkjhg
   }

   login(){
    base.userRef
   }*/
}
