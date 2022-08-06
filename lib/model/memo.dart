class Memo{
  String title;

  Memo({
    required this.title,
  });

  Memo.fromMap(Map<String, dynamic> map) :
        title = map['title'];

  Map toMap(){
    return {
      'title': title,
    };
  }
}