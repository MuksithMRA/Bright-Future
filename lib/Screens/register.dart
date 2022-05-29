import 'package:brightfuture/Animations/page_transition_slide.dart';
import 'package:brightfuture/Providers/google_map_controller.dart';
import 'package:brightfuture/Screens/google_map.dart';
import 'package:brightfuture/Screens/verify_email.dart';
import 'package:brightfuture/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../Models/screen_size.dart';
import '../Models/user.dart';
import '../Providers/error_handler.dart';
import '../Providers/register_controller.dart';
import '../Providers/validations.dart';
import '../Services/auth.dart';
import '../Widgets/Custom Button/custom_button.dart';
import '../Widgets/Custom Text Field/custom_textfield.dart';
import '../Widgets/custom_snackbar.dart';
import '../Widgets/loading_dialog.dart';
import '../constant/image.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<RegisterController>(context, listen: false).city =
        Provider.of<GoogleMapCtrl>(context, listen: false).address;
  }

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _address.text = Provider.of<GoogleMapCtrl>(context, listen: true).address;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Consumer<RegisterController>(
              builder: (context, ctrl, child) {
                return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenSize.height * 0.3,
                          child: Image.asset(logo),
                        ),
                        CustomTextField(
                          prefixIcon: const Icon(FontAwesomeIcons.user),
                          validator: (String? fullName) {
                            return ValidationController.isFullNameValid(
                                fullName);
                          },
                          onChanged: (String? fullName) {
                            ctrl.setFullName(fullName);
                          },
                          label: 'Full Name',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.025,
                        ),
                        CustomTextField(
                          prefixIcon: const Icon(FontAwesomeIcons.envelope),
                          validator: (String? email) {
                            return ValidationController.isEmailValidated(email);
                          },
                          onChanged: (String? email) {
                            ctrl.setEmail(email);
                          },
                          label: 'Email',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.025,
                        ),
                        CustomTextField(
                          prefixIcon:
                              const Icon(FontAwesomeIcons.locationArrow),
                          validator: (String? val) {
                            return _address.text.isEmpty ||
                                    _address.text == "Add location"
                                ? "Address can not be empty"
                                : null;
                          },
                          isReadOnly: true,
                          controller: _address,
                          suffix: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, SlideTransition1(const ShowMap()));
                            },
                            child: Icon(
                              Icons.map,
                              color: primaryColor,
                            ),
                          ),
                          label: 'Address',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.025,
                        ),
                        IntlPhoneField(
                          decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              )),
                          onChanged: (phone) {
                            ctrl.setPhoneNumber(phone.completeNumber);
                          },
                          initialCountryCode: 'LK',
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.025,
                        ),
                        CustomTextField(
                          prefixIcon: const Icon(FontAwesomeIcons.userLock),
                          validator: (String? newPassword) {
                            return ValidationController.isNewPassValidated(
                                newPassword);
                          },
                          onChanged: (String? newPassword) {
                            ctrl.setNewPassword(newPassword);
                          },
                          label: 'New Password',
                          isPassword: true,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.025,
                        ),
                        CustomTextField(
                          prefixIcon: const Icon(FontAwesomeIcons.lock),
                          validator: (String? confirmPassword) {
                            return ValidationController.isConfirmPassValidated(
                                ctrl.newPassword, ctrl.confirmPassword);
                          },
                          onChanged: (String? confirmPassword) {
                            ctrl.setConfirmPassword(confirmPassword);
                          },
                          label: 'Confirm Password',
                          isPassword: true,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.05,
                        ),
                        CustomButton(
                          onPressed: () async {
                            final errorHandler = Provider.of<ErrorHandler>(
                                context,
                                listen: false);

                            if (_formKey.currentState!.validate()) {
                              showLoaderDialog(context);
                              bool isRegistered =
                                  await AuthService().registerWithEmailPassword(
                                user: AppUser(
                                  name: ctrl.fullName ?? '',
                                  city: _address.text,
                                  email: ctrl.email ?? '',
                                  phoneNumber: ctrl.phoneNumber ?? '',
                                ),
                                password: ctrl.confirmPassword ?? '',
                                errorHandler: errorHandler,
                              );

                              if (isRegistered) {
                                Navigator.pop(context);
                                debugPrint("Registered Success");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyEmail()),
                                  (Route<dynamic> route) => false,
                                );

                                Provider.of<GoogleMapCtrl>(context,
                                        listen: false)
                                    .setAddressDefault();
                              } else {
                                Provider.of<GoogleMapCtrl>(context,
                                        listen: false)
                                    .setAddressDefault();
                                Navigator.pop(context);
                                showSnackBar(
                                    isError: true,
                                    message: ErrorHandler.message ?? '',
                                    ctx: context);
                              }
                            }
                          },
                          label: 'Register',
                          height: ScreenSize.height * 0.08,
                          minWidth: ScreenSize.width,
                          radius: 25,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.02,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const Login();
                            }));
                          },
                          label: "Log In",
                          height: ScreenSize.height * 0.08,
                          minWidth: ScreenSize.width,
                          radius: 25,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.04,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
