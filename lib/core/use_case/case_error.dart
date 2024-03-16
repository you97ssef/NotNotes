import 'package:not_notes/core/use_case/case_state.dart';

class CaseError<T> extends CaseState<T> {
  final Exception error;

  CaseError(this.error);
}
