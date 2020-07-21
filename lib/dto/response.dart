import 'package:food4good_app/utils/constants.dart';

class ResponseDTO {
  final dynamic data;
  final bool is_error;
  final int errorCode;
  final String errorMsg;

  ResponseDTO(this.data, this.is_error, this.errorCode, this.errorMsg);

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : data = json[Constants.KEY_DATA],
        is_error = json[Constants.KEY_IS_ERROR],
        errorCode = json[Constants.KEY_ERROR_CODE],
        errorMsg = json[Constants.KEY_ERROR_MSG];

  Map<String, dynamic> toJson() => {
        Constants.KEY_DATA: data,
        Constants.KEY_IS_ERROR: is_error,
        Constants.KEY_ERROR_CODE: errorCode,
        Constants.KEY_ERROR_MSG: errorMsg
      };
}
