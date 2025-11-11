class BiodataException implements Exception {
  final _message;
  final _prefix;

  BiodataException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataBiodataException extends BiodataException {
  FetchDataBiodataException([String? message])
      : super(message, "Error During Biodata Communication: ");
}

class BadRequestBiodataException extends BiodataException {
  BadRequestBiodataException([message]) : super(message, "Invalid Biodata Request: ");
}

class UnauthorisedBiodataException extends BiodataException {
  UnauthorisedBiodataException([message]) : super(message, "Unauthorised Biodata: ");
}

class UnprocessableBiodataEntityException extends BiodataException {
  UnprocessableBiodataEntityException([message])
      : super(message, "Unprocessable Biodata Entity: ");
}

class InvalidBiodataInputException extends BiodataException {
  InvalidBiodataInputException([String? message]) : super(message, "Invalid Biodata Input: ");
}
