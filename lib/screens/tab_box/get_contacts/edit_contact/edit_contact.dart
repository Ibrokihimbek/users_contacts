import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_db/local/cached_user.dart';
import 'package:user_contacts/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_cubit.dart';
import 'package:user_contacts/screens/tab_box/add_contacts/widgets/text_field.dart';

class EditContactPage extends StatefulWidget {
  final CachedUser cachedUser;
  const EditContactPage({super.key, required this.cachedUser});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  TextEditingController nameEditController = TextEditingController();
  TextEditingController phoneNumberEditController = TextEditingController();
  @override
  void initState() {
    nameEditController.text = widget.cachedUser.userName;
    phoneNumberEditController.text = widget.cachedUser.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Edit Contact',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        builder: (context, state) {
          return Column(
            children: [
              TextfieldWidget(
                word: 'Name',
                textController: nameEditController,
              ),
              TextfieldWidget(
                word: 'Phone number',
                textController: phoneNumberEditController,
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ContactsBloc>(context).add(
                    UpdateContact(
                      contact: CachedUser(
                        phoneNumber: phoneNumberEditController.text,
                        userName: nameEditController.text,
                        id: widget.cachedUser.id
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Edit contact',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ContactsBloc>(context).add(
                    DeleteContact(contactId: widget.cachedUser.id!),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete Contact',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.status == ContactStatus.contactAdded ||
              state.status == ContactStatus.contactUpdated ||
              state.status == ContactStatus.contactDeleted) {
            BlocProvider.of<GetContactCubit>(context).fetchAllContacts();
          }
        },
      ),
    );
  }
}
