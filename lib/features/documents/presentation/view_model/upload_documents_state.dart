
import 'package:el_kottab_teacher_app/features/documents/data/models/upload_doc_model.dart';

abstract class UploadDocumentsState {
  final UploadDocumentsModel model;
  const UploadDocumentsState(this.model);
}

class UploadDocumentsInitial extends UploadDocumentsState {
  UploadDocumentsInitial() : super(const UploadDocumentsModel());
}

class UploadDocumentsUpdated extends UploadDocumentsState {
  const UploadDocumentsUpdated(super.model);
}
