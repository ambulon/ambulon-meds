import 'package:bloc/bloc.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/repositories/home.repo.dart';
import 'package:medcomp/states/home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeStateNotLoaded();

  HomeRepo _homeRepo = HomeRepo();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventLoadData) {
      yield HomeStateLoading();
      try {
        var home = await this._homeRepo.getDetails();

        if (home == null) {
          String error = this._homeRepo.message;
          yield HomeStateError(error);
        } else {
          yield HomeStateLoaded(home);
        }
      } catch (e) {
        yield HomeStateError(e);
      }
    }
  }
}
