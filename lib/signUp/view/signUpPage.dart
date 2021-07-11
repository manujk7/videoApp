import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_app_flutter/signUp/controller/signUpController.dart';

import '../../SizeConfig.dart';
import '../../editWidget.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() {
    return new SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());
  final focusPassword = FocusNode();
  final focusConfirmPassword = FocusNode();
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    var child = Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 4.6,
                    bottom: SizeConfig.blockSizeVertical * 2,
                    left: 12,
                    right: 12),
                child: Material(
                  elevation: 4,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.fromLTRB(
                        0.0,
                        SizeConfig.blockSizeVertical * 2.0,
                        0.0,
                        SizeConfig.blockSizeVertical * 2.2),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Form(
                      key: controller.formKey.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                16.0,
                                SizeConfig.blockSizeVertical * 0.5,
                                16.0,
                                SizeConfig.blockSizeVertical * 0.5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.spacing,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      EditText(
                                        textAlign: TextAlign.start,
                                        mController:
                                            controller.emailController.value,
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(focusPassword);
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        isSecure: false,
                                        hintText: "Email",
                                        isPassword: false,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.spacing,
                                      ),
                                      EditText(
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        focusNode: focusPassword,
                                        mController:
                                            controller.passwordController.value,
                                        onSubmitted: (v) {
                                          FocusScope.of(context).requestFocus(
                                              focusConfirmPassword);
                                        },
                                        isSecure: true,
                                        hintText: "Password",
                                        isPassword: true,
                                      ),
                                      SizedBox(
                                        height: SizeConfig.spacing,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.spacing * 1.3,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        child: Text("Submit"),
                                        onPressed: !controller.showLoader.value
                                            ? () => controller.registerUser()
                                            : null),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    widgetList.add(child);
    final modal = Obx(
      () => controller.showLoader.value
          ? Stack(
              children: [
                new Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(dismissible: false, color: Colors.grey),
                ),
                new Center(
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
    widgetList.add(modal);
    return Stack(children: widgetList);
  }

  /// ------------------------------------------------------------
  /// Method that handles click of Register button
  /// ------------------------------------------------------------

  /// ------------------------------------------------------------
  /// Method that handles Social Logins
  /// ------------------------------------------------------------
  loginWithSocialMedia(String type, String firstName, String lastName,
      String email, String id, String image) async {}
}
