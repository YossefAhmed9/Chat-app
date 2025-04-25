// void createDatabase() {
//   openDatabase(
//     'Users.db',
//     version: 1,
//     onCreate: (database, version) {
//       print('database created');
//       database
//           .execute(
//           'CREATE TABLE User (id INTEGER PRIMARY KEY, name TEXT, email TEXT, age INTEGER, account INTEGER)')
//           .then((value) {
//         print('table created');
//       }).catchError((error) {
//         print('Error When Creating Table ${error.toString()}');
//       });
//     },
//     onOpen: (database) {
//       getDataFromDatabase(database);
//       print('database opened');
//     },
//   ).then((value) {
//     database = value;
//     emit(AppCreateDatabase());
//   });
// }
//
//
// List result = [];
//
// void getDataFromDatabase(database) {
//   emit(AppGetDataLoading());
//   database.rawQuery('SELECT * FROM Users').then((value) {
//     result = [];
//     result.addAll(value);
//
//     print('THIS IS THE LENGTH: ${result.length}');
//     print(value);
//     emit(AppGetDataFromDB());
//   });
// }
//
//
//
// insertToDatabase({
//   required name,
//   required email,
//   required ages,
//   required account,
// }) async {
//   emit(AppLoadingInsertInDatabase());
//   await database?.transaction((txn) async {
//     txn
//         .rawInsert(
//       'INSERT INTO Users(name, email, age, account) VALUES("$name", "$email", "$ages", "$account")',
//     )
//         .then((value) {
//       print('$value inserted successfully');
//       getDataFromDatabase(database);
//       emit(AppInsertInDatabase());
//     }).catchError((error) {
//       emit(AppErrorInsertInDatabase(error));
//       print('Error When Inserting New Record ${error.toString()}');
//       print('Error When Inserting New Record ${error.runtimeType}');
//     });
//   });
// }
