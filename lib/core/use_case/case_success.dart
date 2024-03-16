import 'package:not_notes/core/use_case/case_state.dart';

class CaseSuccess<T> extends CaseState<T> {
  final T data;

  CaseSuccess(this.data);
}
