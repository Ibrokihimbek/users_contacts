part of 'contacts_bloc.dart';

@immutable
abstract class ContactsEvent {}

class UpdateContact extends ContactsEvent {
  UpdateContact({required this.contact});

  final CachedUser contact;
}

class AddContact extends ContactsEvent{
  AddContact({required this.contact});

  final CachedUser contact;
}

class DeleteContact extends ContactsEvent{
  DeleteContact({required this.contactId});

  final int contactId;
}
