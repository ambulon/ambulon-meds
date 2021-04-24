import 'package:bloc/bloc.dart';
import 'package:medcomp/events/search.event.dart';
import 'package:medcomp/repositories/search.repo.dart';
import 'package:medcomp/states/search.state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchStateNotLoaded();

  SearchRepo _searchRepo = SearchRepo();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchEventLoadData) {
      yield SearchStateLoading();
      try {
        var search = await this._searchRepo.getDetails(event.strList);

        if (search == null) {
          String error = this._searchRepo.message;
          yield SearchStateError(error);
        } else {
          yield SearchStateLoaded(search);
        }
      } catch (e) {
        yield SearchStateError(e);
      }
    }
  }
}
