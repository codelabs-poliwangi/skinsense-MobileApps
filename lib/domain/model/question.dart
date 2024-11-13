import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';

@JsonSerializable()
class Question {
    @JsonKey(name: "statusCode")
    final int statusCode;
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "data")
    final List<Datum> data;

    Question({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    Question copyWith({
        int? statusCode,
        String? message,
        List<Datum>? data,
    }) => 
        Question(
            statusCode: statusCode ?? this.statusCode,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

    Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "question")
    final String question;
    @JsonKey(name: "option")
    final List<Option> option;

    Datum({
        required this.id,
        required this.question,
        required this.option,
    });

    Datum copyWith({
        String? id,
        String? question,
        List<Option>? option,
    }) => 
        Datum(
            id: id ?? this.id,
            question: question ?? this.question,
            option: option ?? this.option,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
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
