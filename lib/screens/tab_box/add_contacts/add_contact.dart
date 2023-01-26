import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_cubit.dart';
import 'package:user_contacts/data/local/cached_user.dart';
import 'package:user_contacts/screens/tab_box/add_contacts/widgets/text_field.dart';

TextEditingController nameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      builder: (context, state) {
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
                onPressed: () {
                  BlocProvider.of<ContactsBloc>(context).add(
                    AddContact(
                      contact: CachedUser(
                        phoneNumber: phoneNumberController.text,
                        userName: nameController.text,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Add contact',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state.status == ContactStatus.contactAdded ||
            state.status == ContactStatus.contactUpdated || 
            state.status == ContactStatus.contactDeleted
            ) {
          BlocProvider.of<GetContactCubit>(context).fetchAllContacts();
        }
      },
    );
  }
}
