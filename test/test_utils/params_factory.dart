import 'package:crud_todo_app/model/category_model.dart';
import 'package:crud_todo_app/model/todo_model.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

const categoryId = 'ABC123';
const categoryName = 'Test Category';
final categoryEmoji = EmojiParser().get('😀');

Category get initialCategory => Category(
      name: categoryName,
      emoji: categoryEmoji,
    );

Category get category => Category(
      id: categoryId,
      name: categoryName,
      emoji: categoryEmoji,
      todoSize: 0,
    );

const todoId = 'TODO-456';
const todoSubject = 'Test TODO';
final todoInitialDate = DateTime.now();
final todoFinalDate = DateTime.now().add(const Duration(days: 10));
final expiredDate = DateTime.now().add(const Duration(days: -1));

Todo get initialTodo => Todo(
      categoryId: categoryId,
      id: '',
      finalDate: todoInitialDate,
      subject: todoSubject,
    );

Todo get addingTodo => Todo(
      categoryId: categoryId,
      id: '',
      finalDate: todoFinalDate,
      subject: todoSubject,
    );

Todo get existingTodo => Todo(
      categoryId: categoryId,
      id: todoId,
      finalDate: todoFinalDate,
      subject: todoSubject,
    );

Todo get expiredTodo => Todo(
      categoryId: categoryId,
      id: todoId,
      finalDate: expiredDate,
      subject: todoSubject,
    );

Todo get completeTodo => Todo(
      categoryId: categoryId,
      id: todoId,
      finalDate: todoFinalDate,
      subject: todoSubject,
      isCompleted: true,
    );
