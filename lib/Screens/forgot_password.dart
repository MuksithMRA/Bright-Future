
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/screen_size.dart';
import '../Providers/login_state.dart';
import '../Providers/validations.dart';
import '../Widgets/Custom Button/custom_button.dart';
import '../Widgets/Custom Text Field/custom_textfield.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../Widgets/custom_snackbar.dart';
import '../Widgets/loading.dart';
import '../constant/image.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _txtForgot = TextEditingController();
  Image? img;

  @override
  void initState() {
    super.initState();
    img = Image.asset(forgetPassImg);
  }

  @override
  void dispose() {
    _txtForgot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, loginCtrl, child) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Login()));
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const CustomText(
                title: "Forgot Password",
              ),
            ),
            body: loginCtrl.isLoading
                ? const LoadingWidget()
                : Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ScreenSize.height * 0.3,
                            width: ScreenSize.width * 0.9,
                            child: img,
                          ),
                          CustomTextField(
                            controller: _txtForgot,
                            validator: (val) {
                              return ValidationController.isEmailValidated(val);
                            },
                            hintText: 'Enter your email',
                            prefixIcon:
                                const Icon(FontAwesomeIcons.solidEnvelope),
                          ),
                          SizedBox(
                            height: ScreenSize.height * 0.03,
                          ),
                          CustomButton(
                            radius: 25,
                            height: ScreenSize.height * 0.08,
                            minWidth: ScreenSize.width,
                            label: "Reset Password",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  loginCtrl.loadingOnChanged(true);
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _txtForgot.text.trim());
                                  loginCtrl.loadingOnChanged(false);

                                  Navigator.pop(context);
                                  showSnackBar(
                                      isError: false,
                                      message: "Password reset email sent",
                                      ctx: context);
                                } on FirebaseException catch (e) {
                                  loginCtrl.loadingOnChanged(false);
                                  showSnackBar(
                                      isError: true,
                                      message: e.code,
                                      ctx: context);
                                } on Exception {
                                  loginCtrl.loadingOnChanged(false);
                                  showSnackBar(
                                      isError: true,
                                      message: "Something went wrong",
                                      ctx: context);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
