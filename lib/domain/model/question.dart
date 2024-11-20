import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';
@JsonSerializable()
class Question {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "question")
    final String question;
    @JsonKey(name: "option")
    final List<Option> option;

    Question({
        required this.id,
        required this.question,
        required this.option,
    });

    Question copyWith({
        String? id,
        String? question,
        List<Option>? option,
    }) => 
        Question(
            id: id ?? this.id,
            question: question ?? this.question,
            option: option ?? this.option,
        );

    factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Option {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "option")
    final String option;

    Option({
        required this.id,
        required this.option,
    });

    Option copyWith({
        String? id,
        String? option,
    }) => 
        Option(
            id: id ?? this.id,
            option: option ?? this.option,
        );

    factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

    Map<String, dynamic> toJson() => _$OptionToJson(this);
}
