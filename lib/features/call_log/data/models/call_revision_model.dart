class CallRevisionModel {
  final int? id;
  final int? callId;
  final int? teacherId;
  final String? revision;
  final String? createdAt;
  final String? updatedAt;

  CallRevisionModel({
    this.id,
    this.callId,
    this.teacherId,
    this.revision,
    this.createdAt,
    this.updatedAt,
  });

  CallRevisionModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      callId = json['call_id'],
      teacherId = json['teacher_id'],
      revision = json['revision'],
      createdAt = json['created_at'],
      updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['call_id'] = callId;
    data['teacher_id'] = teacherId;
    data['revision'] = revision;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
