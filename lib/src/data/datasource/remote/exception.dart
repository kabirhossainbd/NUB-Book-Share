
class ErrorClass {
  List<ErrorsInfo>? _errors;

  List<ErrorsInfo>? get errors => _errors;

  ErrorClass({
    required List<ErrorsInfo> errors}){
    _errors = errors;
  }

  ErrorClass.fromJson(dynamic json) {
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        _errors!.add(ErrorsInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map["errors"] = _errors!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// code : "l_name"
/// message : "The last name field is required."

class ErrorsInfo {
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  ErrorsInfo({
    String? code,
    String? message}){
    _code = code;
    _message = message;
  }

  ErrorsInfo.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    return map;
  }

}