import 'dart:typed_data';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  //final String userId;
  //final List<Uint8List> image;
  //save kre nathnm locally store karanna oone

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.lastModifiedDate,
    //required this.userId,
    //this.image = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdDate': createdDate,
      'lastModifiedDate': lastModifiedDate,

      ///'userId': userId,
      //'images': image.map((image) => image.toList()).toList(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    print(map);
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdDate: DateTime.parse(map['createdDate']),
      lastModifiedDate: DateTime.parse(map['lastModifiedDate']),
      //userId: map['userId'],
      // image: List<Uint8List>.from(map['image'].map((image) => Uint8List.fromList(image.cast<int>())))
    );
  }
}
