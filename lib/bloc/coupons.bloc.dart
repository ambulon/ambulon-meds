import 'package:bloc/bloc.dart';
import 'package:medcomp/events/coupons.event.dart';
import 'package:medcomp/repositories/coupons.repo.dart';
import 'package:medcomp/states/coupons.state.dart';

class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  @override
  CouponsState get initialState => CouponsStateNotLoaded();

  CouponsRepo _couponsRepo = CouponsRepo();

  @override
  Stream<CouponsState> mapEventToState(CouponsEvent event) async* {
    if (event is CouponsEventLoadData) {
      yield CouponsStateLoading();
      try {
        var res = await this._couponsRepo.getData();
        yield CouponsStateLoaded(result: res);
      } catch (e) {
        yield CouponsStateError(e);
      }
    }
  }
}
