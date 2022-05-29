import 'package:brightfuture/Models/faq.dart';
import 'package:brightfuture/Models/post_with_ref.dart';
import 'package:brightfuture/Models/user_data.dart';
import 'package:brightfuture/Providers/faq_controller.dart';
import 'package:brightfuture/Providers/register_controller.dart';
import 'package:brightfuture/Services/Database/faqs_handeling.dart';
import 'package:brightfuture/Services/Database/user_handeling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../Services/Database/post_handeling.dart';
import 'manage_post_controller.dart';
import 'bottom_nav.dart';
import 'check_connectivity.dart';
import 'drawer_tile_change.dart';
import 'error_handler.dart';
import 'google_map_controller.dart';
import 'home_screen_controller.dart';
import 'login_state.dart';
import 'my_post_controller.dart';
import 'profile_screen_controller.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<BottomNav>(
    create: (context) => BottomNav(),
  ),
  ChangeNotifierProvider<DrawerTileChange>(
    create: (context) => DrawerTileChange(),
  ),
  ChangeNotifierProvider<LoginState>(
    create: (context) => LoginState(),
  ),
  ChangeNotifierProvider<CheckConnectivity>(
    create: (context) => CheckConnectivity(),
  ),
  ChangeNotifierProvider<ErrorHandler>(
    create: (context) => ErrorHandler(),
  ),
  ChangeNotifierProvider<MyPostController>(
    create: (context) => MyPostController(),
  ),
  ChangeNotifierProvider<ProfileScreenController>(
    create: (context) => ProfileScreenController(),
  ),
  ChangeNotifierProvider<ManagePostController>(
    create: (context) => ManagePostController(),
  ),
  ChangeNotifierProvider<HomeScreenController>(
    create: (context) => HomeScreenController(),
  ),
  StreamProvider<User?>.value(
    value: FirebaseAuth.instance.authStateChanges(),
    initialData: null,
  ),
  StreamProvider<List<FAQ>>.value(
    value: FAQsHandeling.listOfFaqs(),
    initialData: const [],
  ),
  StreamProvider<List<UserData>>.value(
    value: UserHandling.getThisUser(),
    initialData: const [],
  ),
  StreamProvider<List<PostWithRef>>.value(
    value: PostHandling.listOfPosts(),
    initialData: const [],
  ),
  ChangeNotifierProvider<GoogleMapCtrl>(
    create: (context) => GoogleMapCtrl(),
  ),
  ChangeNotifierProvider<FAQController>(
    create: (context) => FAQController(),
  ),
  ChangeNotifierProvider<RegisterController>(
    create: (context) => RegisterController(),
  ),
];
