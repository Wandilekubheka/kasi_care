import 'dart:io';

import 'package:clock_mate/features/home/blocs/home/files_state.dart';
import 'package:clock_mate/features/home/domain/repository/file_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesCupit extends Cubit<FilesState> {
  final FileRepository fileRepository;
  FilesCupit(this.fileRepository) : super(FilesInitial());

  Future<void> uploadFile() async {
    emit(FilesLoading());
    try {
      final results = await fileRepository.createAndSaveExcel();
      emit(FilesSuccess(results));
    } catch (e) {
      emit(FilesError("Failed to upload file"));
    }
  }

  Future<void> clearState() async {
    emit(FilesInitial());
  }

  Future<void> shareFile(File file) async {
    emit(FilesLoading());
    try {
      await fileRepository.shareFile(file);
      await clearState();
    } on FormatException catch (e) {
      emit(FilesError(e.message));
    }
  }
}
