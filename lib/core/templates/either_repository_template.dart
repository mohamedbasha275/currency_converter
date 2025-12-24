// This is a template file showing how to implement the Either pattern in domain repositories
// Copy this pattern to other repositories in your project


/// Template for implementing repositories with Either pattern
/// 
/// Usage:
/// 1. Define your repository interface with Future<Either<Failure, T>>
/// 2. Implement the repository using the Either pattern
/// 3. Handle errors gracefully in your use cases
/// 
/// Example:
/// ```dart
/// abstract class ExampleRepo {
///   Future<Either<Failure, List<ExampleEntity>>> fetchExamples();
///   Future<Either<Failure, ExampleEntity>> fetchExampleById(String id);
///   Future<Either<Failure, void>> createExample(ExampleEntity example);
///   Future<Either<Failure, void>> updateExample(ExampleEntity example);
///   Future<Either<Failure, void>> deleteExample(String id);
/// }
/// 
/// class ExampleRepoImpl implements ExampleRepo {
///   final ExampleDataSource dataSource;
/// 
///   ExampleRepoImpl(this.dataSource);
/// 
///   @override
///   Future<Either<Failure, List<ExampleEntity>>> fetchExamples() async {
///     try {
///       final examples = await dataSource.fetchExamples();
///       return Right(examples);
///     } catch (e) {
///       return Left(ServerFailure('Failed to fetch examples: $e'));
///     }
///   }
/// 
///   @override
///   Future<Either<Failure, ExampleEntity>> fetchExampleById(String id) async {
///     try {
///       final example = await dataSource.fetchExampleById(id);
///       if (example != null) {
///         return Right(example);
///       } else {
///         return Left(NotFoundFailure('Example with id $id not found'));
///       }
///     } catch (e) {
///       return Left(ServerFailure('Failed to fetch example: $e'));
///     }
///   }
/// 
///   @override
///   Future<Either<Failure, void>> createExample(ExampleEntity example) async {
///     try {
///       await dataSource.createExample(example);
///       return const Right(null);
///     } catch (e) {
///       return Left(ServerFailure('Failed to create example: $e'));
///     }
///   }
/// 
///   @override
///   Future<Either<Failure, void>> updateExample(ExampleEntity example) async {
///     try {
///       await dataSource.updateExample(example);
///       return const Right(null);
///     } catch (e) {
///       return Left(ServerFailure('Failed to update example: $e'));
///     }
///   }
/// 
///   @override
///   Future<Either<Failure, void>> deleteExample(String id) async {
///     try {
///       await dataSource.deleteExample(id);
///       return const Right(null);
///     } catch (e) {
///       return Left(ServerFailure('Failed to delete example: $e'));
///     }
///   }
/// }
/// ```
/// 
/// Benefits of this approach:
/// 1. **Type Safety**: Compile-time safety with Either pattern
/// 2. **Error Handling**: Explicit error handling for each operation
/// 3. **Consistency**: Uniform error handling across the entire repository layer
/// 4. **Testability**: Easy to test success and failure scenarios
/// 5. **Maintainability**: Clear separation of success and error cases
/// 
/// In your use cases, you can now handle the results like this:
/// ```dart
/// final result = await repo.fetchExamples();
/// 
/// result.fold(
///   (failure) {
///     // Handle failure
///     emit(ErrorState(failure.message));
///   },
///   (examples) {
///     // Handle success
///     emit(LoadedState(examples));
///   },
/// );
/// ```
/// 
/// This pattern ensures that all errors are handled explicitly and provides
/// a consistent way to deal with failures throughout your application.

// Common failure types you might want to use:
// - ServerFailure: For network/server errors
// - CacheFailure: For local storage errors
// - ValidationFailure: For input validation errors
// - NotFoundFailure: For resource not found errors
// - UnauthorizedFailure: For authentication errors
// - ForbiddenFailure: For permission errors
