import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  BoolColumn get content => boolean().nullable()();
  IntColumn get category => integer().nullable()();
}

@UseMoor(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getAllTodo() => select(todos).get();

  Future insertTodo(Todo todo) => into(todos).insert(todo);
}
