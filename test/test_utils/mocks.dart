import 'package:crud_todo_app/model/category_model.dart';
import 'package:crud_todo_app/model/todo_model.dart';
import 'package:crud_todo_app/service/category_service.dart';
import 'package:crud_todo_app/service/todo_service.dart';
import 'package:crud_todo_app/viewmodel/category/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

/// Routes

class MockNavigator extends Mock implements NavigatorObserver {}

class MyRouteFake extends Fake implements Route<dynamic> {}

/// Services

class MockCategoryService extends Mock implements CategoryService {}

class MockTodoService extends Mock implements TodoService {}

/// Models

class MyCategoryFake extends Fake implements Category {}

class MyTodoFake extends Fake implements Todo {}

/// ViewModels

class MockCategoryViewModel extends Mock implements ICategoryViewModel {}
