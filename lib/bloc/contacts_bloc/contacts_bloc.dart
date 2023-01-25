import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_contacts/data/local/cached_user.dart';
import 'package:user_contacts/data/repository/contact_repo.dart';
import 'package:equatable/equatable.dart';

part 'contacts_event.dart';

part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc(this.contactRepository)
      : super(const ContactsState(
          contacts: [],
          statusText: "",
          status: ContactStatus.pure,
        )) {
    on<AddContact>(_addContact);
    on<UpdateContact>(_updateContact);
    on<DeleteContact>(_deleteContact);
  }

  final ContactRepository contactRepository;

  _addContact(AddContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    var newContact = await contactRepository.insertUser(event.contact);
    if (newContact.id != null) {
      emit(state.copyWith(status: ContactStatus.contactAdded));
    }
  }

  _updateContact(UpdateContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    await contactRepository.updateUser(event.contact);
    emit(state.copyWith(status: ContactStatus.contactUpdated));
  }

  _deleteContact(DeleteContact event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    var deletedId = await contactRepository.deleteUSer(event.contactId);
    if (deletedId != -1) {
      emit(state.copyWith(status: ContactStatus.contactDeleted));
    }
  }
}
