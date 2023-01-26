import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_cubit.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_state.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<GetContactCubit, GetContactsState>(
        builder: (context, state) {
          if (state is GetContactsInLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetContactsInSuccess) {
            return ListView(
              children: List.generate(
                state.cachedUser.length,
                (index) {
                  var item = state.cachedUser[index];
                  return ListTile(
                    onLongPress: ()async{
                      final Uri _phoneUri = Uri(
                          scheme: "tel",
                          path: item.phoneNumber
                      );
                      try {
                        if (await canLaunchUrl(_phoneUri)) {
                          await launchUrl(_phoneUri);
                        }
                      } catch (error) {
                        throw("Cannot dial");
                      }
                    },
                    title: Text(item.userName),
                    subtitle: Text(item.phoneNumber),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
