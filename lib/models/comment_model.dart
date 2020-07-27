
class CommentModel {
  final String text;
  final String name;
  final String uid;
  final String date;

  CommentModel({this.text, this.name, this.uid, this.date});

  CommentModel.fromData(Map<String, dynamic> data)
      : text = data['text'],
        name = data['name'],
        uid = data['uid'],
        date = data['date'];

  Map<String, dynamic> toJson() {
    return {'name': name, 'text': text, 'uid': uid, 'date': date};
  }
}
