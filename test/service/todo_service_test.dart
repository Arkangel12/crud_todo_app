import 'package:crud_todo_app/common/extension.dart';
import 'package:crud_todo_app/model/todo_model.dart';
import 'package:crud_todo_app/service/todo_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils/mocks.dart';
import '../test_utils/params_factory.dart';

void main() {
  late MockFirestore mockFirestoreInstance;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
  late MockQuery mockQuery;

  late TodoService todoService;

  setUpAll(() {
    mockFirestoreInstance = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot(existingTodo.id);
    mockQuery = MockQuery();

    todoService = TodoService(mockFirestoreInstance);
  });

  group('$TodoService', () {
    test('Get $Todo list from Firebase mock', () async {
      // arrange
      when(() => mockFirestoreInstance.collection(any()))
          .thenReturn(mockCollectionReference);

      when(() => mockCollectionReference.where(any(),
          isEqualTo: any(named: 'isEqualTo'))).thenReturn(mockQuery);

      when(() => mockQuery.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));

      when(() => mockQuerySnapshot.docs)
          .thenReturn([mockQueryDocumentSnapshot]);

      when(() => mockQueryDocumentSnapshot.toMap())
          .thenReturn(existingTodo.toJson());

      // act
      final result = todoService.getTodosByCategory(existingTodo.categoryId);
      final finalResult = await result.first;

      // assert
      expect(result, isA<Stream<List<Todo>>>());
      expect(finalResult, isA<List<Todo>>());
      verify(() => mockFirestoreInstance
          .collection(any())
          .where(any(), isEqualTo: any(named: 'isEqualTo'))).called(1);
    });

    test('Save $Todo from Firebase mock', () {
      // arrange
      when(() => mockFirestoreInstance.collection(any()))
          .thenReturn(mockCollectionReference);

      when(() => mockCollectionReference.add(any()))
          .thenAnswer((_) async => mockDocumentReference);

      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);

      when(() => mockDocumentReference.update(any()))
          .thenAnswer((_) => Future.value());

      // act
      final result = todoService.saveTodo(initialTodo);

      // assert
      expect(result, isA<Future<void>>());
      verify(() => mockFirestoreInstance.collection(any()).add(any()))
          .called(1);
    });

    test('Update $Todo from Firebase mock', () {
      // arrange
      when(() => mockFirestoreInstance.collection(any()))
          .thenReturn(mockCollectionReference);

      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);

      when(() => mockDocumentReference.update(any()))
          .thenAnswer((_) => Future.value());

      // act
      final result = todoService.saveTodo(existingTodo);

      // assert
      expect(result, isA<Future<void>>());
      verify(
        () => mockFirestoreInstance.collection(any()).doc(any()).update(any()),
      );
    });

    test('Remove $Todo from Firebase mock', () {
      // arrange
      when(() => mockFirestoreInstance.collection(any()))
          .thenReturn(mockCollectionReference);

      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);

      when(() => mockDocumentReference.delete())
          .thenAnswer((_) => Future.value());

      when(() => mockDocumentReference.update(any()))
          .thenAnswer((_) => Future.value());

      // act
      final result = todoService.deleteTodo(existingTodo.id, category.id!);

      // assert
      expect(result, isA<Future<void>>());
      verify(() => mockFirestoreInstance.collection(any()).doc(any()).delete())
          .called(1);
    });
  });
}
