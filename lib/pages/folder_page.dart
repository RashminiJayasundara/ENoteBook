import 'dart:ffi';

import 'package:e_note_book/models/folder_modal.dart';
import 'package:e_note_book/pages/folder_content_page.dart';
import 'package:e_note_book/services/folder_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FolderPage extends StatefulWidget {
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  List<Folder> folders = [];
  bool isLoading = true;
  final FolderService _folderService = FolderService();
  @override
  void initState() {
    super.initState();
    fetchFolders();
  }

  Future<void> fetchFolders() async {
    try {
      List<Folder> fetchedFolders = await _folderService.getFolderstoUser();
      setState(() {
        folders = fetchedFolders;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching folders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folders'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : folders.isEmpty
              ? Center(
                  child: Text('No folders available'),
                )
              : ListView.builder(
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
                                      folderName: folders[index].name,
                                      folderId: folders[index].id,
                                    )));
                      },
                    );
                  },
                ),
    );
  }
}
