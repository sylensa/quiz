// To parse this JSON data, do
//
//     final getQuestions = getQuestionsFromJson(jsonString);

import 'dart:convert';

GetQuestions getQuestionsFromJson(String str) => GetQuestions.fromJson(json.decode(str));

String getQuestionsToJson(GetQuestions data) => json.encode(data.toJson());

class GetQuestions {
  GetQuestions({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<QuestionsResponse>? data;

  factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<QuestionsResponse>.from(json["data"].map((x) => QuestionsResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class QuestionsResponse {
  QuestionsResponse({
    this.id,
    this.courseId,
    this.topicId,
    this.qid,
    this.text,
    this.instructions,
    this.resource,
    this.options,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.qtype,
    this.confirmed,
    this.public,
    this.flagged,
    this.deleted,
    this.editors,
    this.editorId,
    this.deletedAt,
    this.correct,
    this.topic,
    this.skipped,
    this.answers,
  });

  int? id;
  int? courseId;
  int? topicId;
  String? qid;
  String? text;
  String? instructions;
  String? resource;
  String? options;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? qtype;
  int? confirmed;
  int? public;
  int? flagged;
  int? deleted;
  String? editors;
  int? correct;
  int? skipped;
  dynamic editorId;
  dynamic deletedAt;
  Topic? topic;
  List<Answer>? answers;

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) => QuestionsResponse(
    id: json["id"] == null ? null : json["id"],
    courseId: json["course_id"] == null ? null : json["course_id"],
    topicId: json["topic_id"] == null ? null : json["topic_id"],
    qid: json["qid"] == null ? null : json["qid"],
    text: json["text"] == null ? null : json["text"],
    correct: json["correct"] == null ? 0 : json["correct"],
    skipped: json["skipped"] == null ? 1 : json["skipped"],
    instructions: json["instructions"] == null ? null : json["instructions"],
    resource: json["resource"] == null ? null : json["resource"],
    options: json["options"] == null ? null : json["options"],
    position: json["position"] == null ? null : json["position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    qtype: json["qtype"] == null ? null :json["qtype"],
    confirmed: json["confirmed"] == null ? null : json["confirmed"],
    public: json["public"] == null ? null : json["public"],
    flagged: json["flagged"] == null ? null : json["flagged"],
    deleted: json["deleted"] == null ? null : json["deleted"],
    editors: json["editors"] == null ? null : json["editors"],
    editorId: json["editor_id"],
    deletedAt: json["deleted_at"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
    answers: json["answers"] == null ? null : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "course_id": courseId == null ? null : courseId,
    "topic_id": topicId == null ? null : topicId,
    "qid": qid == null ? null : qid,
    "text": text == null ? null : text,
    "instructions": instructions == null ? null : instructions,
    "resource": resource == null ? null : resource,
    "options": options == null ? null : options,
    "position": position == null ? null : position,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "qtype": qtype == null ? null : qtype,
    "confirmed": confirmed == null ? null : confirmed,
    "public": public == null ? null : public,
    "flagged": flagged == null ? null : flagged,
    "deleted": deleted == null ? null : deleted,
    "editors": editors == null ? null : editors,
    "editor_id": editorId,
    "deleted_at": deletedAt,
    "topic": topic == null ? null : topic!.toJson(),
    "answers": answers == null ? null : List<dynamic>.from(answers!.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.id,
    this.questionId,
    this.text,
    this.value,
    this.solution,
    this.createdAt,
    this.updatedAt,
    this.answerOrder,
    this.responses,
    this.flagged,
    this.editors,
    this.editorId,
    this.deletedAt,
    this.answered,

  });

  int? id;
  int? questionId;
  String? text;
  int? value;
  String? solution;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? answerOrder;
  int? responses;
  int? flagged;
  String? editors;
  int? answered;
  dynamic editorId;
  dynamic deletedAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"] == null ? null : json["id"],
    questionId: json["question_id"] == null ? null : json["question_id"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
    solution: json["solution"] == null ? null : json["solution"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    answerOrder: json["answer_order"] == null ? null : json["answer_order"],

    answered: json["answered"] == null ? 0 : json["answered"],
    responses: json["responses"] == null ? null : json["responses"],
    flagged: json["flagged"] == null ? null : json["flagged"],
    editors: json["editors"] == null ? null : json["editors"],
    editorId: json["editor_id"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "question_id": questionId == null ? null : questionId,
    "text": text == null ? null : text,
    "value": value == null ? null : value,
    "solution": solution == null ? null : solution,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "answer_order": answerOrder == null ? null : answerOrder,
    "responses": responses == null ? null : responses,
    "flagged": flagged == null ? null : flagged,
    "editors": editors == null ? null : editors,
    "editor_id": editorId,
    "deleted_at": deletedAt,
  };
}


class Topic {
  Topic({
    this.id,
    this.courseId,
    this.topicId,
    this.name,
    this.author,
    this.description,
    this.notes,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.confirmed,
    this.public,
    this.n,
    this.p,
    this.editors,
    this.editorId,
    this.deletedAt,
  });

  int? id;
  int? courseId;
  String? topicId;
  String? name;
  String? author;
  String? description;
  String? notes;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? confirmed;
  int? public;
  int? n;
  int? p;
  String? editors;
  dynamic editorId;
  dynamic deletedAt;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"] == null ? null : json["id"],
    courseId: json["course_id"] == null ? null : json["course_id"],
    topicId: json["topicID"] == null ? null : json["topicID"],
    name: json["name"] == null ? null : json["name"],
    author: json["author"] == null ? null : json["author"],
    description: json["description"] == null ? null : json["description"],
    notes: json["notes"] == null ? null : json["notes"],
    category: json["category"] == null ? null : json["category"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    confirmed: json["confirmed"] == null ? null : json["confirmed"],
    public: json["public"] == null ? null : json["public"],
    n: json["N"] == null ? null : json["N"],
    p: json["p"] == null ? null : json["p"],
    editors: json["editors"] == null ? null : json["editors"],
    editorId: json["editor_id"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "course_id": courseId == null ? null : courseId,
    "topicID": topicId == null ? null : topicId,
    "name": name == null ? null : name,
    "author": author == null ? null : author,
    "description": description == null ? null : description,
    "notes": notes == null ? null : notes,
    "category": category == null ? null : category,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "confirmed": confirmed == null ? null : confirmed,
    "public": public == null ? null : public,
    "N": n == null ? null : n,
    "p": p == null ? null : p,
    "editors": editors == null ? null : editors,
    "editor_id": editorId,
    "deleted_at": deletedAt,
  };
}


