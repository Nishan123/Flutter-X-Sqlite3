import 'package:flutter/material.dart';
import 'package:sqflite_example/custom%20widgets/custom_button.dart';
import 'package:sqflite_example/custom%20widgets/custom_text_field.dart';
import 'package:sqflite_example/services/database_service.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String _selectedPriority = 'High';
  TextEditingController headingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Priority: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  menuWidth: double.infinity,
                  value: _selectedPriority,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                  items: <String>['High', 'Low']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Heading",
              textEditingController: headingController,
              suffixIcon: const Icon(Icons.abc),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Description",
              textEditingController: descriptionController,
              suffixIcon: const Icon(Icons.abc),
            ),
            const Spacer(),
            CustomButton(
              text: "Add note",
              onPressed: () {
                // debugPrint(_selectedValue);

                _databaseService.addNote(
                    _selectedPriority,
                    headingController.text.toString(),
                    descriptionController.text.toString());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
