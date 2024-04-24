
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/drawer_dashboard.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';

class SessionService {
  String? userId;
  static final SessionService _session = SessionService._internal();

  factory SessionService(){
    return _session;
  }

  SessionService._internal();
}

