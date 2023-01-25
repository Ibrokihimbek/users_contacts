import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_contacts/bloc/add_contact_cubit/add_contact_state.dart';
import 'package:user_contacts/data/local/cached_user.dart';
import 'package:user_contacts/data/repository/contact_repo.dart';

class AddContactCubit extends Cubit<ContactState> {
  final ContactRepository contactRepository;
  AddContactCubit({required this.contactRepository})
      : super(InitialStateByContact());

  List<CachedUser> cachedUserContact = [];

  void insertContactAndUpdateDB(CachedUser cachedUser) async {
    CachedUser savedUser = await contactRepository.insertUser(cachedUser);
    if (savedUser.id != null) {
      cachedUserContact.add(savedUser);

      emit(AddContactState(cachedUserContact));
    }
  }
}
