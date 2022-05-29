import 'package:brightfuture/Providers/error_handler.dart';
import 'package:brightfuture/Services/Database/user_handeling.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/user_data.dart';
import '../Services/storage.dart';
import '../Widgets/loading_dialog.dart';

class ProfileScreenController extends ChangeNotifier {
  UserData? user;
  String? updatedData;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  setOnLoad(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  setUser(UserData? user) {
    this.user = user;
  }

  setUpdatedData(String? updatedData) {
    this.updatedData = updatedData;
    notifyListeners();
  }

  update(String title, BuildContext context) async {
    try {
      switch (title) {
        case "Name":
          await _auth.currentUser?.updateDisplayName(updatedData);
          await UserHandling.updateUser("fullName", updatedData);
          Navigator.pop(context);
          break;

        case "City":
          await UserHandling.updateUser("city", updatedData);
          Navigator.pop(context);
          break;
        case "Email":
          await _auth.currentUser?.updateEmail(updatedData ?? "");
          await UserHandling.updateUser("email", updatedData);
          Navigator.pop(context);
          break;
        case "Phone Number":
          await UserHandling.updateUser("phoneNumber", updatedData);
          Navigator.pop(context);
          break;

        case "PhotoUrl":
          await _auth.currentUser?.updatePhotoURL(updatedData);
          await UserHandling.updateUser("photoUrl", updatedData);
          Navigator.pop(context);
          break;

        default:
      }
    } on FirebaseException catch (e) {
      ErrorHandler.setError(i: true, m: e.code);
    } catch (e) {
      ErrorHandler.setError(i: true, m: "Something went wrong");
    }
  }



  uploadImage(BuildContext context)async{
    Storage storage = Storage();
    try {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);

                        if (image?.path != null) {
                          final path = image?.path;
                          final name = image?.name;

                          showLoaderDialog(context);
                          
                          await storage
                              .uploadFile(path.toString(), name.toString(),'user/${_auth.currentUser?.uid}')
                              .then((value) async {
                            String? url = await storage.getFile('user',_auth.currentUser?.uid ?? '').then((value){
                              return value
                            });

                            UserHandling.addImageUrl(url??dp);
                          });
                          Navigator.pop(context);
                        } else {
                          debugPrint("No Images");
                        }
                      } catch (e) {
                         debugPrint("Something went wrong");
                      }
  }
}
