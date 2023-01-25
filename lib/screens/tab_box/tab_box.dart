import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/screens/tab_box/add_contacts/add_contact.dart';
import 'package:user_contacts/screens/tab_box/cubit/bottom_nav_cubit.dart';
import 'package:user_contacts/screens/tab_box/get_contacts/contacts.dart';

class TabBoxPage extends StatefulWidget {
  const TabBoxPage({super.key});

  @override
  State<TabBoxPage> createState() => _TabBoxPageState();
}

class _TabBoxPageState extends State<TabBoxPage> {
  List<Widget> screens = [];
  @override
  void initState() {
    screens.add(AddContactsPage());
    screens.add(ContactsPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          var index = context.watch<BottomNavCubit>().activePageIndex;
          return Scaffold(
            body: screens[index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.blue,
              onTap: (value) => BlocProvider.of<BottomNavCubit>(context)
                  .changePageIndex(value),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  label: "Add",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_page,
                    size: 40,
                  ),
                  label: "Contacts",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
