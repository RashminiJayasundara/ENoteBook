import 'dart:convert';
import 'package:e_note_book/models/note_modal.dart';
import 'package:http/http.dart' as http;

import '../utils/auth_manger.dart';

class NoteService {
  final String _noteUrl = 'http://10.0.2.2:8080/api/notes/';

  Future<List<Note>> getNotesForFolder(String folderId) async {
    final String? token = await getToken();
    final response = await http.get(
        Uri.parse(_noteUrl + 'getNotesByFolderId?folderId=$folderId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      List<dynamic> notesList = jsonDecode(response.body);
      return notesList.map((e) => Note.fromMap(e)).toList();
    } else {
      throw Exception('Failed to Load Notes');
    }
  }
}
