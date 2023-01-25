import 'package:user_contacts/data/local/cached_user.dart';

abstract class ContactState {}

class InitialStateByContact extends ContactState {
  InitialStateByContact();
}

class AddContactState extends ContactState {
  AddContactState(this.users);

  List<CachedUser> users;
}

class GetContactState extends ContactState {
  GetContactState(this.users);

  List<CachedUser> users;
}

class DeleteState extends ContactState {
  DeleteState(this.users);

  List<CachedUser> users;
}

class UpdateState extends ContactState {
  UpdateState(this.users);

  List<CachedUser> users;
}
