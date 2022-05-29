import 'package:brightfuture/constant/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Providers/check_connectivity.dart';
import 'Providers/provider.dart';
import 'Screens/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
  
    statusBarColor: primaryColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    final connection = Provider.of<CheckConnectivity>(context, listen: false);
    connection.tryConnection();
    connection.checkConnectivityState();
    connection.connectivityStateChange();
  }

  @override
  void dispose() {
    Provider.of<CheckConnectivity>(context, listen: false)
        .connectivitySubscription
        ?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'bright future',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
