import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/screen_size.dart';
import '../Providers/bottom_nav.dart';
import '../Providers/error_handler.dart';
import '../Providers/login_state.dart';
import '../Services/auth.dart';
import '../Widgets/Custom Button/custom_button.dart';
import '../Widgets/Custom Text Field/custom_textfield.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../Widgets/custom_snackbar.dart';
import '../Widgets/loading.dart';
import '../constant/image.dart';
import 'forgot_password.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, ctrl, child) {
        return Scaffold(
          body: ctrl.isLoading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        height: ScreenSize.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ScreenSize.height * 0.3,
                              child: Image.asset(logo),
                            ),
                            CustomTextField(
                              prefixIcon:
                                  const Icon(FontAwesomeIcons.solidEnvelope),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "email can not be empty";
                                }
                                return null;
                              },
                              onChanged: (String? email) {
                                ctrl.emailOnChanged(email);
                              },
                              isPassword: false,
                              label: 'Email',
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              prefixIcon: const Icon(FontAwesomeIcons.key),
                              validator: (password) {
                                if (password == null || password.isEmpty) {
                                  return 'password can not be empty';
                                }
                                return null;
                              },
                              onChanged: (String? password) {
                                ctrl.passwordOnChanged(password);
                              },
                              isPassword: true,
                              label: 'Password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            forgotPassword(context),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ctrl.loadingOnChanged(true);

                                  bool isLoggedIn = await AuthService()
                                      .signInWithEmailPassword(
                                          email: ctrl.email ?? '',
                                          password: ctrl.password ?? '',
                                          errorHandler:
                                              Provider.of<ErrorHandler>(context,
                                                  listen: false));
                                  if (isLoggedIn) {
                                    try {
                                      Provider.of<BottomNav>(context,
                                              listen: false)
                                          .onChange(0);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const Home();
                                      }));
                                      ctrl.loadingOnChanged(false);
                                    } on Exception catch (_, ex) {
                                      ctrl.loadingOnChanged(false);
                                      debugPrint(ex.toString());
                                    }
                                  } else {
                                    ctrl.loadingOnChanged(false);
                                    showSnackBar(
                                        isError: ErrorHandler.isError ?? true,
                                        message: ErrorHandler.message ?? '',
                                        ctx: context);
                                  }
                                }
                              },
                              radius: 25,
                              height: ScreenSize.height * 0.08,
                              minWidth: ScreenSize.width,
                              label: 'Login',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const Register();
                                }));
                              },
                              radius: 25,
                              height: ScreenSize.height * 0.08,
                              minWidth: ScreenSize.width,
                              label: 'Register',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

Widget forgotPassword(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: ScreenSize.height * 0.03,
      ),
      CustomText(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ForgotPassword()));
        },
        title: "Forgot Password? ",
        fontWeight: FontWeight.w300,
        fontSize: 17,
      ),
    ],
  );
}
