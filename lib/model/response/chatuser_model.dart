class ChatUser {
  String? id;
  String? profile;
  String? about;
  String? occupation;
  String? address;
  String? name;
  String? phone;
  String? varsityId;
  String? createdAt;
  String? isOnline;
  String? lastActive;
  String? email;
  String? pushToken;

  ChatUser({
    required this.id,
    this.profile,
    this.about,
    this.occupation,
    this.address,
    required this.name,
    this.phone,
    this.varsityId,
    this.createdAt,
    this.isOnline,
    this.lastActive,
    required this.email,
    required this.pushToken,
  });

  ChatUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile = json['profile'];
    about = json['about'];
    address = json['address'];
    occupation = json['occupation'];
    name = json['name'];
    phone = json['phone'];
    varsityId = json['varsityId'];
    createdAt = json['created_at'];
    isOnline = json['is_online'];
    lastActive = json['last_active'];
    email = json['email'];
    pushToken = json['push_token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['profile'] = profile;
    data['about'] = about;
    data['occupation'] = occupation;
    data['address'] = address;
    data['name'] = name;
    data['phone'] = phone;
    data['varsityId'] = varsityId;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}
