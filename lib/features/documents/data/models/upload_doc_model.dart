
class UploadDocumentsModel {
  final String? personalPhotoPath;
  final String? cvPath;
  final String? idFrontPath;
  final String? idBackPath;

  const UploadDocumentsModel({
    this.personalPhotoPath,
    this.cvPath,
    this.idFrontPath,
    this.idBackPath,
  });

  UploadDocumentsModel copyWith({
    String? personalPhotoPath,
    String? cvPath,
    String? idFrontPath,
    String? idBackPath,
  }) {
    return UploadDocumentsModel(
      personalPhotoPath: personalPhotoPath ?? this.personalPhotoPath,
      cvPath: cvPath ?? this.cvPath,
      idFrontPath: idFrontPath ?? this.idFrontPath,
      idBackPath: idBackPath ?? this.idBackPath,
    );
  }
}
