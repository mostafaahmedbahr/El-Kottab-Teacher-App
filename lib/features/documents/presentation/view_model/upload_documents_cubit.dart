import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

import 'upload_documents_state.dart';

class UploadDocumentsCubit extends Cubit<UploadDocumentsState> {
  UploadDocumentsCubit() : super(UploadDocumentsInitial());

  Future<void> pickPersonalPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result?.files.single.path != null) {
      emit(
        UploadDocumentsUpdated(
          state.model.copyWith(personalPhotoPath: result!.files.single.path),
        ),
      );
    }
  }

  Future<void> pickCV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result?.files.single.path != null) {
      emit(
        UploadDocumentsUpdated(
          state.model.copyWith(cvPath: result!.files.single.path),
        ),
      );
    }
  }

  Future<void> pickIdFront() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result?.files.single.path != null) {
      emit(
        UploadDocumentsUpdated(
          state.model.copyWith(idFrontPath: result!.files.single.path),
        ),
      );
    }
  }

  Future<void> pickIdBack() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result?.files.single.path != null) {
      emit(
        UploadDocumentsUpdated(
          state.model.copyWith(idBackPath: result!.files.single.path),
        ),
      );
    }
  }
}
