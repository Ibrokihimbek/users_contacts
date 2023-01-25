import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_cubit.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_state.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetContactCubit, UserSingleState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Contact',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            body: ListView(
              children: List.generate(
                state.cachedUser.length,
                (index) {
                  var item = state.cachedUser[index];
                  return ListTile(
                    title: Text(item.userName),
                    subtitle: Text(item.phoneNumber),
                  );
                },
              ),
            ));
      },
    );
  }
}
