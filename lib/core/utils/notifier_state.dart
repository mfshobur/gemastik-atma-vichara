import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/core/failure.dart';

class NotifierState<T> {
  T value;
  Failure? failure;
  RequestState state;

  NotifierState({
    required this.value,
    this.failure,
    this.state = RequestState.initial,
  });

  bool stateSuccess() {
    return state == RequestState.success;
  }

  bool stateError() {
    return state == RequestState.error;
  }

  bool stateLoading() {
    return state == RequestState.loading;
  }

  bool stateInitial() {
    return state == RequestState.initial;
  }

  void reset() {
    state = RequestState.initial;
    failure = null;
  }
}
