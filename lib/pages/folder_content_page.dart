import 'package:e_note_book/database/database_helper.dart';
import 'package:e_note_book/models/note_modal.dart';
import 'package:e_note_book/pages/drawing_content_page.dart';
import 'package:e_note_book/pages/note_content_page.dart';
import 'package:e_note_book/services/folder_service.dart';
import 'package:e_note_book/services/note_service.dart';
import 'package:flutter/material.dart';

import '../models/folder_modal.dart';

class ContentPage extends StatefulWidget {
  final String folderName;
  final String folderId;

  ContentPage({required this.folderId, required this.folderName});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  static final Map<String, List<Note>> _notesCache = {};
  static final Map<String, List<Folder>> _foldersCache = {};
  final dbHelper = DatabaseHelper();

  List<Note> notes = [];
  List<Folder> folders = [];
  bool isLoading_notes = true;
  bool isLoading_folders = true;
  final NoteService _noteService = NoteService();
  final FolderService _folderService = FolderService();
  @override
  void initState() {
    super.initState();
    if (_notesCache.containsKey(widget.folderId)) {
      notes = _notesCache[widget.folderId]!;
      isLoading_notes = false;
    } else {
      fetchNotes();
    }

    if (_foldersCache.containsKey(widget.folderId)) {
      folders = _foldersCache[widget.folderId]!;
      isLoading_folders = false;
    } else {
      fetchFolders();
    }
  }

  Future<void> fetchNotes() async {
    try {
      List<Note> fetchedNotes =
          await _noteService.getNotesForFolder(widget.folderId);
      setState(() {
        notes = fetchedNotes;
        isLoading_notes = false;
        _notesCache[widget.folderId] = fetchedNotes;
      });
    } catch (e) {
      setState(() {
        isLoading_notes = false;
      });
      print('Error fetching notes: $e');
    }
  }

  Future<void> fetchFolders() async {
    try {
      List<Folder> fetchedFolders =
          await _folderService.getFolderstoFolder(widget.folderId);
      setState(() {
        folders = fetchedFolders;
        isLoading_folders = false;
        _foldersCache[widget.folderId] = fetchedFolders;
      });
    } catch (e) {
      setState(() {
        isLoading_folders = false;
      });
      print('Error fetching folders: $e');
    }
  }

  void _addFolder() {
    // Implement the functionality to add a folder here
    print('Add Folder icon tapped');
  }

  void _addNote() async {
    int id = await dbHelper.insertDrawings();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DrawingContentPage(
                  id: id,
                )));
    print('Add Note icon tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.folderName),
          actions: [
            IconButton(
              icon: Icon(Icons.create_new_folder),
              onPressed: _addFolder,
            ),
            IconButton(
              icon: Icon(Icons.note_add),
              onPressed: _addNote,
            ),
          ],
        ),
        body: isLoading_folders && isLoading_notes
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.note),
                            title: Text(notes[index].title),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteContentPage(note: notes[index])));
                            },
                          );
                        },
                      )),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: folders.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.folder),
                            title: Text(folders[index].name),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContentPage(
                                          folderId: folders[index].id,
                                          folderName: folders[index].name)));
                            },
                          );
                        },
                      ))
                ],
              ));
  }
}
