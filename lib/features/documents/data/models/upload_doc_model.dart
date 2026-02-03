class UploadDocumentsModel {
  final String? personalPhotoPath;
  final String? cvPath;
  final String? idFrontPath;
  final String? idBackPath;
  final String? qualification;
  final String? degreePath;
  const UploadDocumentsModel({
    this.personalPhotoPath,
    this.cvPath,
    this.idFrontPath,
    this.idBackPath,
    this.qualification,
    this.degreePath,
  });

  UploadDocumentsModel copyWith({
    String? personalPhotoPath,
    String? cvPath,
    String? idFrontPath,
    String? idBackPath,
    String? qualification,
    String? degreePath,
  }) {
    return UploadDocumentsModel(
      personalPhotoPath: personalPhotoPath ?? this.personalPhotoPath,
      cvPath: cvPath ?? this.cvPath,
      idFrontPath: idFrontPath ?? this.idFrontPath,
      idBackPath: idBackPath ?? this.idBackPath,
      degreePath: degreePath ?? this.degreePath,
      qualification: qualification ?? this.qualification,
    );
  }
}
