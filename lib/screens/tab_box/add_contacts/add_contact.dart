import 'package:flutter/material.dart';
import 'package:user_contacts/screens/tab_box/add_contacts/widgets/text_field.dart';

TextEditingController nameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Add Contact',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          TextfieldWidget(
            word: 'Name',
            textController: nameController,
          ),
          TextfieldWidget(
            word: 'Phone number',
            textController: phoneNumberController,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Add contact',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}