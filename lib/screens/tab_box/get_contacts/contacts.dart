import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
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
                    onLongPress: () =>
                        openMap(41.273247949372255, 69.1693130980523),
                    //onLongPress: () async {
                    // final Uri _phoneUri =
                    //     Uri(scheme: "tel", path: item.phoneNumber);
                    // try {
                    //   if (await canLaunchUrl(_phoneUri)) {
                    //     await launchUrl(_phoneUri);
                    //   }
                    // } catch (error) {
                    //   throw ("Cannot dial");
                    // }
                    //},
                    onTap: () {
                      Telephony telephony = Telephony.instance;

                      listener(SendStatus status) {
                        print("SMS STATUS:$status");
                      }

                      String message = r'''
                          /// - [to] : Address to send the SMS to.
  /// - [message] : Message to be sent. If message body is longer than standard SMS length limits set appropriate
  /// value for [isMultipart]
  /// - [statusListener] (optional) : Listen to the status of the sent SMS. Values can be one of [SmsStatus]
  /// - [isMultipart] (optional) : If message body is longer than standard SMS limit of 160 characters, set this flag to
  /// send the SMS in multiple parts.
                          ''';
                      // telephony.sendSms(
                      //     to: "+998974046760",
                      //     message: message,
                      //     statusListener: listener,
                      //     isMultipart: message.length > 160);
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

Future<void> openMap(double latitude, double longitude) async {
  Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
  await launchUrl(uri,mode: LaunchMode.externalApplication);

}
