// ignore_for_file: public_member_api_docs, sort_constructors_first

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isComplete;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isComplete.hashCode;
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isComplete,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
