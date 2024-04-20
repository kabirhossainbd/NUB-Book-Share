
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/base_controller.dart';
import 'package:nub_book_sharing/services/firebase_auth_service.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/auth/login_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/drawer_dashboard.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';

class AuthController extends GetxController implements GetxService, BaseController {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _reference = FirebaseDatabase.instance.ref().child('Users');


  void registration(String userName,String email, String password, String phone) async {
    try{
      showLoading();
      update();
     await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        SessionService().userId = value.user!.uid.toString();
        User? user = value.user;
        _reference.child(value.user!.uid.toString()).set({
          'uid' : value.user!.uid.toString(),
          'email' : value.user!.email.toString(),
          "onlineStatus" : 'active',
        }).then((value){
          user?.updateDisplayName(userName).then((value){
            hideLoading();
            Get.off(const DashboardScreen());
          });
        }).onError((error, stackTrace){
          hideLoading();
          myToast(error.toString());
        });
      });
    }
    on FirebaseAuthException catch (error){
      hideLoading();
      if(error.code == "email-already-in-use"){
        myToast('There already exists an account with the given email address.');
      } else if (error.code == "auth/invalid-email") {
        myToast("The email address is not valid.");
      } else if (error.code == "auth/operation-not-allowed") {
        myToast("Operation not allowed.");
      } else if (error.code == "auth/weak-password") {
        myToast("The password is too weak.");
      }
    } catch (e) {
      myToast('Unexpected error during sign-in: $e');
      debugPrint('Firebase Authentication Exception: $e/////////////');
    }
  }



  Future login(String email, String password) async{
    try{
      showLoading();
      update();
     await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        SessionService().userId = value.user!.uid.toString();
        hideLoading();
        Get.off(const DashboardScreen());
      }).onError((error, stackTrace){
        hideLoading();
        myToast('User not found for this Email');
      });
    }on FirebaseAuthException catch (error){
      hideLoading();
      if (error.code == 'invalid-email') {
        myToast('Invalid Email');
        debugPrint('Firebase Authentication Exception: ${error.code}');

      } else if (error.code == 'user-not-found') {
        myToast('User not found for this Email');
        debugPrint('Firebase Authentication Exception: ${error.code}');

      } else if (error.code == 'wrong-password') {
        myToast('Wrong Password');
        debugPrint('Firebase Authentication Exception: ${error.code}');
      }
    }catch (e) {
      myToast('Unexpected error during sign-in: $e');
      debugPrint('Firebase Authentication Exception: $e');
    }
  }


  void isLogin(){
   final user = _auth.currentUser;
   if(user != null){
     SessionService().userId = user.uid.toString();
     Get.off(const DashboardScreen());
   }else{
     Get.off(const LoginScreen());
   }
  }

  logOut(){
    DialogHelper.showLoading();
    _auth.signOut().then((value){
      SessionService().userId = '';
      Get.off(const LoginScreen());
    });
    DialogHelper.hideLoading();
    update();
  }

  @override
  hideLoading() {
    DialogHelper.hideLoading();
  }


  @override
  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }
}
