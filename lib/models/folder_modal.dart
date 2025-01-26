class Folder {
  final String id;
  final String name;
  final bool isRoot;
  final String parentFolder;
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  final String userId;

  Folder(
      {required this.id,
      required this.name,
      required this.isRoot,
      this.parentFolder = "",
      required this.createdDate,
      required this.lastModifiedDate,
      required this.userId});

  factory Folder.fromMap(Map<String, dynamic> map) {
    print(map);
    return Folder(
        id: map['id'],
        name: map['name'],
        isRoot: map['isRoot'],
        parentFolder: map['parentFolder'],
        createdDate: DateTime.parse(map['createdDate']),
        lastModifiedDate: DateTime.parse(map['lastModifiedDate']),
        userId: map['userId']);
  }
}
