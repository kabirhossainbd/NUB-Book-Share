class SessionService {
  String? userId;
  static final SessionService _session = SessionService._internal();

  factory SessionService(){
    return _session;
  }

  SessionService._internal();
}

