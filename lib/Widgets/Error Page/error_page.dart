
import 'package:brightfuture/Models/screen_size.dart';
import 'package:brightfuture/Screens/home.dart';
import 'package:brightfuture/Screens/login.dart';
import 'package:brightfuture/Widgets/Custom%20Button/custom_button.dart';
import 'package:brightfuture/Widgets/CustomText/custom_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/check_connectivity.dart';

class ErrorPage extends StatelessWidget {
  final bool isLoggedIn;
  const ErrorPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<CheckConnectivity>(context, listen: true);
    return Scaffold(
        body: SizedBox(
      width: ScreenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomText(
            title: "No Internet Connection",
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            label: "Try Again",
            height: 50,
            minWidth: ScreenSize.width * 0.5,
            radius: 20,
            onPressed: () {
              connection.tryConnection();
              if (connection.isConnectionSuccessful ||
                  connection.connectivityResult != ConnectivityResult.none) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return isLoggedIn ? const Home() : const Login();
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
