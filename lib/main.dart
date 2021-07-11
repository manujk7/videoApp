import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_app_flutter/player.dart';
import 'package:video_app_flutter/signUp/controller/signUpController.dart';
import 'package:video_app_flutter/signUp/view/signUpPage.dart';

import 'authenticationFile.dart';

import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Authentication.initializeFirebase();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final signUpController = Get.put(SignUpController());
    return GetMaterialApp(
        defaultTransition: Transition.leftToRightWithFade,
        debugShowCheckedModeBanner: false,
        home: SignUpPage() /*controller.getPage()*/);
  }
}
