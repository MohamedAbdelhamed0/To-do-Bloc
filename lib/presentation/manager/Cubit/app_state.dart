part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class changescreen extends AppState {}

class createDatabase extends AppState {}

class getDatabaseLoadingState extends AppState {}

class getDatabase extends AppState {}

class insertDatabase extends AppState {}

class ChangeBottomsheetstate extends AppState {}

class updatedatabase extends AppState {}

class Deletdatabase extends AppState {}
