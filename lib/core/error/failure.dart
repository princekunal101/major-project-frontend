import 'dart:io';

import 'package:college_project/core/error/exceptions.dart';

String mapExceptionToMessage(Object error) {
  if (error is BadRequestException) return error.message;
  if (error is NetworkException) return 'No Internet Connection';
  if (error is HttpException) return 'Could not find the Server';
  if (error is FormatException) return 'Bad response format';
  if (error is ServerException) return error.message;
  if (error is TimeoutException) return 'Connection time out';
  return 'Unexpected Error Occupied!';
}
