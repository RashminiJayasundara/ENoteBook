import 'dart:convert';

import 'package:e_note_book/models/folder_modal.dart';
import 'package:e_note_book/utils/auth_manger.dart';
import 'package:http/http.dart' as http;

class FolderService {
  final String _folderUrl = 'http://10.0.2.2:8080/api/folders/';

  Future<List<Folder>> getFolderstoUser() async {
    final String? token = await getToken();
    final String? userId = await getUserId();
    final response = await http.get(
        Uri.parse('${_folderUrl}getFolders?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      List<dynamic> folderList = jsonDecode(response.body);
      return folderList.map((e) => Folder.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load folders');
    }
  }

  Future<List<Folder>> getFolderstoFolder(String folderId) async {
    final String? token = await getToken();
    final response = await http.get(
        Uri.parse('${_folderUrl}getFoldersByParent?folderId=$folderId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      List<dynamic> folderList = jsonDecode(response.body);
      return folderList.map((e) => Folder.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load folders');
    }
  }
}
