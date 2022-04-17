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
        var banners = await this._homeRepo.getBanner();
        var searchHistory = await this._homeRepo.searchHistory();

        yield HomeStateTopPicksLoading(
          banners: banners,
          searchHistory: searchHistory,
          topPicks: [],
        );

        var toppicks = await this._homeRepo.getMoreicks();

        yield HomeStateLoaded(
          banners: banners,
          searchHistory: searchHistory,
          topPicks: toppicks,
        );
      } catch (e) {
        yield HomeStateError(e);
      }
    }
    if (event is HomeEventRefreshSearches) {
      var oldState = state as HomeStateLoaded;
      yield HomeStateLoading();
      try {
        var searchHistory = await this._homeRepo.searchHistory();
        yield HomeStateLoaded(
          banners: oldState.banners,
          searchHistory: searchHistory,
          topPicks: oldState.topPicks,
        );
      } catch (e) {
        yield HomeStateError(e);
      }
    }
    if (event is HomeEventRefreshToppicks) {
      var oldState = state as HomeStateLoaded;
      // yield HomeStateLoading();
      yield HomeStateTopPicksLoading(
        banners: oldState.banners,
        searchHistory: oldState.searchHistory,
        topPicks: oldState.topPicks,
      );
      try {
        var newData = await this._homeRepo.getMoreicks();
        yield HomeStateLoaded(
          banners: oldState.banners,
          searchHistory: oldState.searchHistory,
          topPicks: oldState.topPicks + newData,
        );
      } catch (e) {
        yield HomeStateError(e);
      }
    }
  }
}
