abstract class UseCase<Type, Params> {
  // use call() to be allowed to use as a callable object
  Future<Type> call({Params params});
}