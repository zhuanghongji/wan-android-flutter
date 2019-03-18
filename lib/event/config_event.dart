
/// Todo 发生变化
class TodoChangedEvent {}

/// 主体发生变化
class ThemeChangedEvent {

  bool dark;

  ThemeChangedEvent(this.dark);
}