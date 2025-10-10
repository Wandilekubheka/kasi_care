import 'dart:io';

class FilesState {}

final class FilesInitial extends FilesState {}

final class FilesLoading extends FilesState {}

final class FilesSuccess extends FilesState {
  final File file;
  FilesSuccess(this.file);
}

final class FilesError extends FilesState {
  final String message;
  FilesError(this.message);
}
