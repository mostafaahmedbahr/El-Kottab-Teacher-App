
class NotificationsModel {
  String? message;
  int? code;
  List<Data>? data;
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  NotificationsModel({this.message, this.code, this.data, this.currentPage, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    code = json["code"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    currentPage = json["current_page"];
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["code"] = code;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["current_page"] = currentPage;
    _data["first_page_url"] = firstPageUrl;
    _data["from"] = from;
    _data["last_page"] = lastPage;
    _data["last_page_url"] = lastPageUrl;
    _data["next_page_url"] = nextPageUrl;
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["prev_page_url"] = prevPageUrl;
    _data["to"] = to;
    _data["total"] = total;
    return _data;
  }
}

class Data {
  String? id;
  String? formUserId;
  String? formUserTable;
  String? toUserId;
  String? toUserTable;
  String? title;
  String? message;
  bool? isRead;
  String? action;
  String? operationId;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.formUserId, this.formUserTable, this.toUserId, this.toUserTable, this.title, this.message, this.isRead, this.action, this.operationId, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    formUserId = json["form_user_id"];
    formUserTable = json["form_user_table"];
    toUserId = json["to_user_id"];
    toUserTable = json["to_user_table"];
    title = json["title"];
    message = json["message"];
    isRead = json["is_read"];
    action = json["action"];
    operationId = json["operation_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["form_user_id"] = formUserId;
    _data["form_user_table"] = formUserTable;
    _data["to_user_id"] = toUserId;
    _data["to_user_table"] = toUserTable;
    _data["title"] = title;
    _data["message"] = message;
    _data["is_read"] = isRead;
    _data["action"] = action;
    _data["operation_id"] = operationId;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}