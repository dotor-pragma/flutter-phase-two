class Failure {
  final String message;
  final int? statusCode;
  final String? code; // opcional: categorizar ej. timeout, network, parse

  const Failure(this.message, {this.statusCode, this.code});

  @override
  String toString() =>
      '[🔻 Failure${statusCode != null ? ' $statusCode' : ''}] $message';
}
