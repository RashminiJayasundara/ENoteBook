import 'package:e_note_book/customWidgets/drawing_painter.dart';
import 'package:e_note_book/customWidgets/ruled_page_painter.dart';
import 'package:e_note_book/customWidgets/square_ruled_page_painter.dart';
import 'package:e_note_book/models/note_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NoteContentPage extends StatefulWidget {
  final Note note;

  NoteContentPage({required this.note});

  @override
  _NoteContentPage createState() => _NoteContentPage();
}

class _NoteContentPage extends State<NoteContentPage> {
  Color selectedColor = Colors.black;
  double selectedThickness = 5.0;
  String pageTemplate = 'single';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.note.title),
          actions: [
            PopupMenuButton<String>(
                onSelected: (String result) {
                  setState(() {
                    switch (result) {
                      case 'Insert':
                        //implement insert functionality
                        break;
                      case 'Save File':
                        //[todo]
                        break;
                      case 'Share':
                        //[todo]
                        break;
                      case 'Page Template':
                        _showPageTemplateMenu(context);
                        break;
                    }
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Page Template',
                        child: Row(
                          children: [
                            Icon(Icons.pages_outlined,
                                color: Colors.black), // Save File icon
                            SizedBox(width: 8),
                            Text('Page Template'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Insert',
                        child: Row(
                          children: [
                            Icon(Icons.add,
                                color: Colors.black), // Save File icon
                            SizedBox(width: 8),
                            Text('Insert'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Save File',
                        child: Row(
                          children: [
                            Icon(Icons.save,
                                color: Colors.black), // Save File icon
                            SizedBox(width: 8),
                            Text('Save File'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Share',
                        child: Row(
                          children: [
                            Icon(Icons.share,
                                color: Colors.black), // Share icon
                            SizedBox(width: 8),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                icon: Icon(Icons.menu))
          ],
        ),
        body: Stack(
          children: [
            pageTemplate == 'single'
                ? RuledPage(child: Container())
                : SquareRuledPage(child: Container()),
            Positioned.fill(
                child: DrawingArea(
              colour: selectedColor,
              thikness: selectedThickness,
              drawingId: 3, //[later change]
            )),
            Positioned(
              right: 0,
              top: 50,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'pen',
                    onPressed: () {
                      _showPenOptions();
                    },
                    child: Icon(Icons.brush),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void _showPageTemplateMenu(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 80, 0, 0),
        items: [
          const PopupMenuItem(
              value: 'single',
              child: Row(
                children: [
                  Icon(Icons.line_style),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Single Ruled')
                ],
              )),
          const PopupMenuItem(
              value: 'square',
              child: Row(
                children: [
                  Icon(Icons.grid_on),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Square Ruled')
                ],
              ))
        ]).then((value) {
      if (value != null) {
        _handlePageTemplateSelection(value);
      }
    });
  }

  void _handlePageTemplateSelection(String value) {
    // Handle the selection of the nested menu items
    switch (value) {
      case 'single':
        setState(() {
          pageTemplate = 'single';
        });
        break;
      case 'square':
        setState(() {
          pageTemplate = 'square';
        });
        break;
    }
  }

  void _showSaveFileMenu(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 80, 0, 0),
        items: [
          const PopupMenuItem(
              value: 'saveToLocal',
              child: Row(
                children: [
                  Icon(Icons.line_style),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Save to loacl')
                ],
              )),
          const PopupMenuItem(
              value: 'saveToCloud',
              child: Row(
                children: [
                  Icon(Icons.grid_on),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Square Ruled')
                ],
              ))
        ]).then((value) {
      if (value != null) {
        _handlePageTemplateSelection(value);
      }
    });
  }

  void _showPenOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 250,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Color'),
                    SizedBox(
                      height: 10,
                    ),
                    BlockPicker(
                        pickerColor: selectedColor,
                        onColorChanged: (Color color) {
                          setState(() {
                            selectedColor = color;
                          });
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Select Thickness'),
                    Slider(
                        value: selectedThickness,
                        min: 1.0,
                        max: 10.0,
                        onChanged: (value) {
                          setState(() {
                            selectedThickness = value;
                          });
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
