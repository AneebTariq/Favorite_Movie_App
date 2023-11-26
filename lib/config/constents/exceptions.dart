abstract class Exceptions {}

class CommonException extends Exceptions {
  String message;
  CommonException(this.message);
}

class UnauthorizedAccess extends Exceptions {}
