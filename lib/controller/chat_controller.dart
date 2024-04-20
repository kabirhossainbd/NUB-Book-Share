import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nub_book_sharing/controller/base_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';
import 'package:random_string/random_string.dart';

class ChatController extends GetxController implements GetxService, BaseController {

  final DatabaseReference _chatUsersList = FirebaseDatabase.instance.ref("Users");
  DatabaseReference get chatUsersList => _chatUsersList;



  File? _file;
  File? get file => _file;

  String? _imagePath;

  String? get imagePath => _imagePath;

  void pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    _file = File.fromUri(Uri.parse(image!.path));
    update();
  }


  final CollectionReference _items = FirebaseFirestore.instance.collection("messages");
  CollectionReference get items => _items;

  Stream<QuerySnapshot> getUserMessages(String userId) {
    return _items.where('user_id', isEqualTo: userId).orderBy('timestamp', descending: true).snapshots();
  }

  Future uploadFile(String title, String description) async {
    if (_file == null) {
      debugPrint('--------->>>>>Image link:$_file');
    }
    showLoading();
    update();
    String fileName = _file!.path.split('/').last;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('images');
    Reference referenceImageaToUpload = referenceDireImages.child(fileName);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await referenceImageaToUpload.putFile(File(_file!.path), metadata);
      final imageUrl = await referenceImageaToUpload.getDownloadURL();
      String id = randomAlphaNumeric(10);
      if (title.isNotEmpty && description.isNotEmpty) {
        await _items.add({
          "name": title,
          "description": description,
          "image": imageUrl,
          'id': id,
        });
        _file = null;
        Get.back();
      }
    } catch (error) {
      //some error
    }
    hideLoading();
    update();
  }

  // for delete operation
  Future<void> delete(String productID) async {
    showLoading();
    update();
    await _items.doc(productID).delete();
    hideLoading();
    update();
    myToast('You have successfully deleted a items');
  }

  @override
  hideLoading() {
    try {
      DialogHelper.hideLoading();
    } catch (e) {
      throw UnimplementedError();
    }
  }


  @override
  showLoading([String? message]) {
    try {
      DialogHelper.showLoading(message);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
