import 'package:bloc/bloc.dart';
import 'package:medcomp/events/profile.event.dart';
import 'package:medcomp/repositories/home.repo.dart';
import 'package:medcomp/states/profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileStateNotLoaded();

  HomeRepo repo = HomeRepo();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileEventLoadData) {
      yield ProfileStateLoading();
      try {
        var user = await this.repo.getUserDetails();

        yield ProfileStateLoaded(user: user);
      } catch (e) {
        yield ProfileStateError(e);
      }
    }
  }
}
