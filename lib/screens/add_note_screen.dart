import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: ListView(children: [
        _createTextFieldTitle(),
        SizedBox(height: 5),
        _createTextFieldDesc(),
        SizedBox(height: 5),
        _createButtonSave()
      ]),
    );
  }

  Widget _createTextFieldTitle() {
    return TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }

  Widget _createTextFieldDesc() {
    return TextField(
        keyboardType: TextInputType.text,
        maxLines: 8,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }

  Widget _createButtonSave() {
    return ElevatedButton(
      child: Text('Save Note'),
      onPressed: () {},
    );
  }
}
