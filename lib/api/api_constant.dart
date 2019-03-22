

class ErrorCode {
  
  /// 代表执行成功，不建议依赖任何非0的 errorCode.
  static const int success = 0;

  /// 代表执行成功，不建议依赖任何非0的 errorCode.
  static const int tokenInvalid = -1001;
}


class TodoType {

  /// 只用这一个
  static const int only = 0;

  /// 工作
  static const int work = 1;

  /// 学习
  static const int study = 2;

  /// 生活
  static const int life = 3;
}


class TodoPriority {

  /// 不重要
  static const int low = 0;

  /// 普通
  static const int normal = 1;

  /// 重要
  static const int important = 3;

  /// 非常重要
  static const int veryImportant = 4;
}

class TodoStatus {

  /// 未完成
  static const int todo = 0;

  /// 完成
  static const int done = 1;
}

class TodoOrderBy {

  /// 完成日期顺序
  static const int done = 1;

  /// 完成日期逆序
  static const int doneReverse = 2;

  /// 创建日期顺序
  static const int create = 3;

  /// 创建日期逆序(默认)
  static const int createReverse = 4;
}