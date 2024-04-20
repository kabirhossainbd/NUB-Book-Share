class BookModel {
  String? id;
  String? name;
  String? email;
  String? photo;
  String? about;
  String? pushToken;
  String? publisherId;
  String? title;
  String? pdfUrl;
  String? coverPhoto;
  String? subjectCode;
  String? subName;
  String? topicName;
  String? description;
  int? progress;
  String? authorName;
  String? createAt;
  bool? isFav;

  BookModel(
      {this.id,
        this.name,
        this.email,
        this.photo,
        this.about,
        this.pushToken,
        this.title,
        this.pdfUrl,
        this.coverPhoto,
        this.publisherId,
        this.subjectCode,
        this.subName,
        this.topicName,
        this.description,
        this.progress,
        this.authorName,
        this.createAt,
        this.isFav,
      });

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    about = json['about'];
    pushToken = json['push_token'];
    publisherId = json['publisherId'];
    title = json['title'];
    pdfUrl = json['pdf_url'];
    coverPhoto = json['coverPhoto'];
    subjectCode = json['subject_code'];
    subName = json['sub_name'];
    topicName = json['topic_name'];
    description = json['description'];
    progress = json['progress'];
    authorName = json['author_name'];
    createAt = json['createAt'];
    isFav = json['isFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['about'] = about;
    data['push_token'] = pushToken;
    data['publisherId'] = publisherId;
    data['title'] = title;
    data['pdf_url'] = pdfUrl;
    data['coverPhoto'] = coverPhoto;
    data['subject_code'] = subjectCode;
    data['sub_name'] = subName;
    data['topic_name'] = topicName;
    data['description'] = description;
    data['progress'] = progress;
    data['author_name'] = authorName;
    data['createAt'] = createAt;
    data['isFav'] = isFav;
    return data;
  }
}
