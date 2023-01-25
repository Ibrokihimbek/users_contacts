import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/bloc/get_contacts/get_contact_cubit.dart';
import 'package:user_contacts/data/repository/contact_repo.dart';
import 'package:user_contacts/screens/tab_box/tab_box.dart';

import 'bloc/add_contact_cubit/add_contact_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AddContactCubit(contactRepository: ContactRepository()),
        ),
        BlocProvider(
          create: (context) =>
              GetContactCubit(contactRepository: ContactRepository()),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBoxPage(),
    );
  }
}
