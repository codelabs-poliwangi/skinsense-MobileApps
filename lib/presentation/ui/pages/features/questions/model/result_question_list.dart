import 'package:json_annotation/json_annotation.dart';
part 'result_question_list.g.dart';
@JsonSerializable()
class ResultQuestionList {
    @JsonKey(name: "question_id")
    String questionId;
    @JsonKey(name: "option_id")
    String optionId;

    ResultQuestionList({
        required this.questionId,
        required this.optionId,
    });

    factory ResultQuestionList.fromJson(Map<String, dynamic> json) => _$ResultQuestionListFromJson(json);

    Map<String, dynamic> toJson() => _$ResultQuestionListToJson(this);
}
