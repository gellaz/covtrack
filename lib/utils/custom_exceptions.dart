import 'package:meta/meta.dart';

class CustomException implements Exception {
  final String message;

  const CustomException([this.message]);
}

/// Interface that models a generic exception raised when an HTTP request
/// returns an error (status code 4xx or 5xx).
class HttpException extends CustomException {
  final int statusCode;
  final String name;
  final String message;

  const HttpException({
    @required this.statusCode,
    @required this.name,
    this.message,
  }) : super(message);

  @override
  String toString() => '[$statusCode - $name] $message';
}

/**
 * Client errors (4xx status codes).
 */

/// Class representing the `Bad Request` HTTP response with status code 400:
/// the request that was sent to the server has invalid syntax.
class BadRequestException extends HttpException {
  const BadRequestException([String message])
      : super(
          statusCode: 400,
          name: 'Bad Request',
          message: message,
        );
}

/// Class representing the `Unauthorized` HTTP response with status code 401:
/// the user trying to access the resource has not been authenticated or has
/// not been authenticated correctly (he must provide credentials to be able
/// to view the protected resource).
class UnauthorizedException extends HttpException {
  const UnauthorizedException([String message])
      : super(
          statusCode: 401,
          name: 'Unauthorized',
          message: message,
        );
}

/// Class representing the `Forbidden` HTTP response with status code 403:
/// the user made a valid request but the server is refusing to serve the
/// request, due to a lack of permission to access the requested resource.
class ForbiddenException extends HttpException {
  const ForbiddenException([String message])
      : super(
          statusCode: 403,
          name: 'Forbidden',
          message: message,
        );
}

/// Class representing the `Not Found` HTTP response with status code 404:
/// the user is able to communicate with the server but it is unable to
/// locate the requested file or resource.
class NotFoundException extends HttpException {
  const NotFoundException([String message])
      : super(
          statusCode: 404,
          name: 'Not Found',
          message: message,
        );
}

/**
 * Server errors (5xx status codes).
 */

/// Class representing the `Internal Server Error` HTTP response with status code 500:
/// the server cannot process the request for an unknown reason.
class InternalServerErrorException extends HttpException {
  const InternalServerErrorException([String message])
      : super(
          statusCode: 500,
          name: 'Internal Server Error',
          message: message,
        );
}

/// Class representing the `Bad Gateway` HTTP response with status code 502:
/// the server is a gateway or proxy server, and it is not receiving a valid
/// response from the backend servers that should actually fulfill the request.
class BadGatewayException extends HttpException {
  const BadGatewayException([String message])
      : super(
          statusCode: 502,
          name: 'Bad Gateway',
          message: message,
        );
}

/// Class representing the `Service Unavailable` HTTP response with status code 503:
/// the server is overloaded or under maintenance.
class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException([String message])
      : super(
          statusCode: 503,
          name: 'Service Unavailable',
          message: message,
        );
}

/// Class representing the `Gateway Timeout` HTTP response with status code 504:
/// the server is a gateway or proxy server, and it is not receiving a response
/// from the backend servers within the allowed time period.
class GatewayTimeoutException extends HttpException {
  const GatewayTimeoutException([String message])
      : super(
          statusCode: 504,
          name: 'Gateway Timeout',
          message: message,
        );
}
