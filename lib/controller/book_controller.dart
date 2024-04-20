
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nub_book_sharing/controller/base_controller.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/model/response/slider_model.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController implements GetxService, BaseController {




  /// for slider
  List<SliderModel> _sliderList = [];
  List<SliderModel> get sliderList => _sliderList;

  bool _isSliderEmpty = true;
  bool get isSliderEmpty => _isSliderEmpty;

  void getAllSlider() async {
    _sliderList = [];
    var books = await db.collection("slider").get();
    for (var book in books.docs) {
      _sliderList.add(SliderModel.fromJson(book.data()));
    }
    _isSliderEmpty = false;
    update();
  }


  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;

  String imageUrl = "";
  String pdfUrl = "";
  int index = 0;

  bool isImageUploading = false;
  bool isPdfUploading = false;
  bool isPostUploading = false;

  List<BookModel> _bookDataList = [];
  List<BookModel> get bookDataList => _bookDataList;

  bool _isBookEmpty = true;
  bool get isBookEmpty => _isBookEmpty;

  Future getAllBooks() async {
    _bookDataList = [];
    var books = await db.collection("Books").get();
    for (var book in books.docs) {
      _bookDataList.add(BookModel.fromJson(book.data()));
    }

    fetchUsersWhoUploadedBook();
    _isBookEmpty = false;
    update();
  }


  List<BookModel> _currentUserBooksList = [];
  List<BookModel> get currentUserBooksList => _currentUserBooksList;


  bool _isUserBooksEmpty = true;
  bool get isUserBooksEmpty => _isUserBooksEmpty;
  int _totalUserBooksSize = 0;
  int get totalUserBooksSize => _totalUserBooksSize;
  void getUserBook() async {
    _currentUserBooksList = [];
    var books = await db.collection("userBook").doc(fAuth.currentUser!.uid).collection("Books").get();
    _totalUserBooksSize = books.docs.length;
    for (var book in books.docs) {
      _currentUserBooksList.add(BookModel.fromJson(book.data()));
    }
    _isUserBooksEmpty = false;
    update();
  }



  List<BookModel> _authorBooksList = [];
  List<BookModel> get authorBooksList => _authorBooksList;


  bool _isAuthorBooksEmpty = true;
  bool get isAuthorBooksEmpty => _isAuthorBooksEmpty;
  void getAuthorBooks(String userId) async {
    _isAuthorBooksEmpty = true;
    _authorBooksList = [];
    var books = await db.collection("userBook").doc(userId).collection("Books").get();
    for (var book in books.docs) {
      _authorBooksList.add(BookModel.fromJson(book.data()));
    }
    _isAuthorBooksEmpty = false;
    update();
  }

  DateTime? _selectDate;
  DateTime? get selectDate => _selectDate;

  updateDate(DateTime? value, bool notify) {
    _selectDate = value;
    if (notify) {
      update();
    }
  }

  /// for image uploading
  File? _file;
  File? get file => _file;

  Future<void> pickImage() async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    _file = File.fromUri(Uri.parse(image!.path));
    if(_file != null){
      uploadImageToFirebase(_file!);
    }
    update();
  }
  // void pickImage() async {
  //   isImageUploading = true;
  //   final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     uploadImageToFirebase(File(image.path));
  //   }
  //   isImageUploading = false;
  //   update();
  // }

  void uploadImageToFirebase(File image) async {
    var uuid = const Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("Images/$filename");
    await storageRef.putFile(image);
    //var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    imageUrl = downloadURL;
    debugPrint("Download URL: $downloadURL");
    isImageUploading = false;
  }

  Future<void> createBook(BookModel bookModel) async {
    isPostUploading = true;
    var uuid = const Uuid();
    update();
    var newBook = BookModel(
      id: uuid.v4(),
      name: fAuth.currentUser!.displayName ?? '',
      email: fAuth.currentUser!.email ?? '',
      photo: APIs.me.profile,
      publisherId: fAuth.currentUser!.uid,
      about: APIs.me.about,
      pushToken: APIs.me.pushToken,
      title: bookModel.name,
      topicName: bookModel.topicName,
      authorName: bookModel.authorName,
      subjectCode: bookModel.subjectCode,
      description: bookModel.description,
      progress: bookModel.progress,
      createAt: bookModel.createAt,
      coverPhoto: imageUrl,
      pdfUrl: pdfUrl,
      isFav: false,
    );
    await db.collection("Books").add(newBook.toJson());
    addBookInUserDb(newBook);
    isPostUploading = false;
    isPdfUploading = false;
    imageUrl = "";
    _file = null;
    pdfUrl = "";
    APIs.sendAllPushNotification(bookModel.name ?? '','Book added successfully');
    myToast("Book added successfully");
   // getAllBooks();
    getUserBook();
    update();
  }


  Future<List<ChatUser>> fetchPublishersFromBooks(List<BookModel> books) async {
    final firestore = FirebaseFirestore.instance;

    final Set<String?> publisherIds = books.map((book) => book.publisherId).toSet();
    List<Future<ChatUser>> publisherFutures = publisherIds.map((id) async {
      final publisherSnapshot = await firestore.collection('users').doc(id).get();
      return ChatUser.fromJson(publisherSnapshot.data()!);
    }).toList();

    return Future.wait(publisherFutures);
  }

  List<ChatUser> _authorList = [];
  List<ChatUser> get authorList => _authorList;
  fetchUsersWhoUploadedBook() async {
    _authorList = await fetchPublishersFromBooks(_bookDataList);
    update();
  }



  double _progress = 0;
  double get progress => _progress;
  String pdfFileName = '';
  bool uploading = false;
  double fileSize = 0;

  void pickPDF() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).then((result) async{
      if (result != null){
        isPdfUploading = true;
        uploading = true;
        pdfFileName = result.files.first.name;
        update();
        File file = File(result.files.first.path!);
        if (file.existsSync()) {
          Uint8List fileBytes = await file.readAsBytes();
          String fileName = result.files.first.name;
          final response = await storage.ref().child("Pdf/$fileName").putData(fileBytes);
          UploadTask uploadTask = response.ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            _progress = (snapshot.bytesTransferred / snapshot.totalBytes);
            fileSize = (snapshot.totalBytes / 1024);
            update();
          });
          final downloadURL = await response.ref.getDownloadURL();
            await uploadTask.whenComplete(() {
              uploading = false;
              if(isPdfUploading){
                pdfUrl = downloadURL;
                //myToast('File uploaded successfully');
              }
              update();
            });
        } else {
          debugPrint("File does not exist");
        }
      } else {
        debugPrint("No file selected");
      }
    });
    update();
  }



  setProgress(double val){
    _progress = val;
    update();
  }
  deletePDFFile(){
    _progress = 0;
    isPdfUploading = false;
    uploading = false;
    pdfUrl = '';
    update();
  }

  void addBookInUserDb(BookModel book) async {
    await db.collection("userBook").doc(fAuth.currentUser!.uid).collection("Books").add(book.toJson());
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
