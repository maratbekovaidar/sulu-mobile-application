class CommentModel {

  final int id;
  final double stars;
  final List<String> images;
  final String text;
  final int userId;
  final String userfirstname;
  final String userlastname;
  final String userphonenumber;
  final int establishmentId;
  final int masterDataId;
  final String mastername;

  CommentModel({
    required this.id,
    required this.stars,
    required this.images,
    required this.text,
    required this.userId,
    required this.userfirstname,
    required this.userlastname,
    required this.userphonenumber,
    required this.establishmentId,
    required this.masterDataId,
    required this.mastername});

  factory CommentModel.fromJson(json) {

    List<String> images = [];
    json['photo1'] != null ? images.add(json['photo1']) : () {};
    json['photo2'] != null ? images.add(json['photo2']) : () {};
    json['photo3'] != null ? images.add(json['photo3']) : () {};


    return CommentModel(id: json['id'],
        stars: json['stars'],
        images: images,
        text: json['text'],
        userId: json['userId'],
        userfirstname: json['userfirstname'],
        userlastname: json['userlastname'],
        userphonenumber: json['userphonenumber'],
        establishmentId: json['establishmentId'],
        masterDataId: json['masterDataId'],
        mastername: json['mastername']);
  }

}