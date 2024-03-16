abstract class UseCase<Result, Params> {
  Future<Result> call({required Params params});
}
