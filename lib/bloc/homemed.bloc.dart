import 'package:bloc/bloc.dart';
import 'package:medcomp/events/homemed.event.dart';
import 'package:medcomp/repositories/homemed.repo.dart';
import 'package:medcomp/states/homemed.state.dart';

class HomeMedBloc extends Bloc<HomeMedEvent, HomeMedState> {
  @override
  HomeMedState get initialState => HomeMedStateNotLoaded();

  HomeMedRepo _searchRepo = HomeMedRepo();

  @override
  Stream<HomeMedState> mapEventToState(HomeMedEvent event) async* {
    if (event is HomeMedEventLoadData) {
      yield HomeMedStateLoading();
      try {
        var search = await this._searchRepo.getDetails();

        if (search == null) {
          yield HomeMedStateError();
        } else {
          yield HomeMedStateLoaded(search);
        }
      } catch (e) {
        yield HomeMedStateError();
      }
    }
  }
}
