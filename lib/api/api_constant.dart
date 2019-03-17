

class ErrorCode {
  
  /// 代表执行成功，不建议依赖任何非0的 errorCode.
  static const int SUCCESS = 0;

  /// 代表执行成功，不建议依赖任何非0的 errorCode.
  static const int TOKEN_INVALID = -1001;
}


class TodoType {

  /// 只用这一个
  static const int ONLY = 0;

  /// 工作
  static const int WORK = 1;

  /// 学习
  static const int STUDY = 2;

  /// 生活
  static const int LIFE = 3;
}


class TodoPriority {

  /// 不重要
  static const int LOW = 0;

  /// 普通
  static const int NORMAL = 1;

  /// 重要
  static const int IMPORTANT = 3;

  /// 非常重要
  static const int VERY_IMPORTANT = 4;
}

class TodoStatus {

  /// 未完成
  static const int TODO = 0;

  /// 完成
  static const int DONE = 1;
}

class TodoOrderBy {

  /// 完成日期顺序
  static const int DONE = 1;

  /// 完成日期逆序
  static const int DONE_REVERSE = 2;

  /// 创建日期顺序
  static const int CREATE = 3;

  /// 创建日期逆序(默认)
  static const int CREATE_REVERSE = 4;
}