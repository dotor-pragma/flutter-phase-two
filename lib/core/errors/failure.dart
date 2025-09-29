class Failure {
  final String message;
  final int? statusCode;
  final String? code;

  const Failure(this.message, {this.statusCode, this.code});

  @override
  String toString() =>
      '[🔻 Failure${statusCode != null ? ' $statusCode' : ''}] $message';
}
