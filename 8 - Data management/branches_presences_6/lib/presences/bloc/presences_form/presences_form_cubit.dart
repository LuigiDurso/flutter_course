import 'package:bloc/bloc.dart';
import 'package:branches_presences_6/app/domain/models/equatable_date_time.dart';
import 'package:branches_presences_6/presences/domain/models/presence.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repository/presences/presences_repository.dart';

part 'presences_form_state.dart';

class PresencesFormCubit extends Cubit<PresencesFormState> {
  final PresencesRepository presencesRepository;

  PresencesFormCubit({
    required branchId,
    required username,
    required this.presencesRepository,
  }) : super(PresencesFormState.initial(username, branchId));

  void selectDate(DateTime dateTime) {
    bool exists = presencesRepository.isPresenceExists(
      Presence(
        branchId: state.branchId,
        dateTime: EquatableDateTime.fromDateTime(dateTime),
        username: state.username,
      ),
    );
    emit(
        state.copyWith(
            selectedDate: dateTime,
            status: exists ?
            PresencesFormStatus.alreadyExists :
            PresencesFormStatus.dateSelected,
        ),
    );
  }

  void onFormSubmitted(bool isDelete) async {
    emit(state.copyWith(status: PresencesFormStatus.submissionInProgress));
    var isValid = state.selectedDate.isAfter(DateTime.now()) &&
        state.status != PresencesFormStatus.alreadyExists;
    if ( !isValid ) {
      emit(state.copyWith(status: PresencesFormStatus.submissionFailed));
      return;
    }
    var presence = Presence(
      branchId: state.branchId,
      dateTime: EquatableDateTime.fromDateTime(state.selectedDate),
      username: state.username,
    );
    isDelete ?
    presencesRepository.removePresence(presence) :
    presencesRepository.addPresence(presence);
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: PresencesFormStatus.submissionSuccess));
  }
}
