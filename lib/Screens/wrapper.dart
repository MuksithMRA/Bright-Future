
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/screen_size.dart';
import '../Providers/check_connectivity.dart';
import '../Providers/login_state.dart';
import '../Widgets/Error Page/error_page.dart';
import 'home.dart';
import 'login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<CheckConnectivity>(context, listen: true);
    bool _isLoggedIn = Provider.of<LoginState>(context).isLoggedIn;
    final Size screenSize = MediaQuery.of(context).size;
    ScreenSize.setScreenSize(h: screenSize.height, w: screenSize.width);
    

    Provider.of<LoginState>(context).checkLoginState();

    if (connection.isConnectionSuccessful ||
        connection.connectivityResult != ConnectivityResult.none) {
      return 
      
      _isLoggedIn ? const Home() : const Login();
    }
    return ErrorPage(isLoggedIn: _isLoggedIn);
  }
}
