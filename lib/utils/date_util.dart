
enum DateFormat {
  /// yyyy-MM-dd HH:mm:ss.SSS
  DEFAULT,
  /// yyyy-MM-dd HH:mm:ss 
  NORMAL, 
  /// yyyy-MM-dd HH:mm
  YEAR_MONTH_DAY_HOUR_MINUTE, 
  /// yyyy-MM-dd
  YEAR_MONTH_DAY, 
  /// yyyy-MM
  YEAR_MONTH, 
  /// MM-dd
  MONTH_DAY, 
  /// MM-dd HH:mm
  MONTH_DAY_HOUR_MINUTE, 
  /// HH:mm:ss
  HOUR_MINUTE_SECOND, 
  /// HH:mm
  HOUR_MINUTE, 

  /// yyyy年MM月dd日 HH时mm分ss秒SSS毫秒
  ZH_DEFAULT, 
  /// yyyy年MM月dd日 HH时mm分ss秒 / timeSeparate: ":" --> yyyy年MM月dd日 HH:mm:ss
  ZH_NORMAL, 
  /// yyyy年MM月dd日 HH时mm分 / timeSeparate: ":" --> yyyy年MM月dd日 HH:mm
  ZH_YEAR_MONTH_DAY_HOUR_MINUTE, 
  /// yyyy年MM月dd日
  ZH_YEAR_MONTH_DAY, 
  /// yyyy年MM月
  ZH_YEAR_MONTH, 
  /// MM月dd日
  ZH_MONTH_DAY, 
  /// MM月dd日 HH时mm分  /  timeSeparate: ":" --> MM月dd日 HH:mm
  ZH_MONTH_DAY_HOUR_MINUTE, 
  /// HH时mm分ss秒
  ZH_HOUR_MINUTE_SECOND, 
  /// HH时mm分
  ZH_HOUR_MINUTE, 
}

/// month -> days.
const Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};


/// 日期工具
class DateUtil {
  /// Get DateTime By DateStr.
  static DateTime getDateTime(String dateStr) {
    DateTime dateTime = DateTime.tryParse(dateStr);
    return dateTime;
  }

  /// Get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int milliseconds,
      {bool isUtc: false}) {
    DateTime dateTime =
        new DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    return dateTime;
  }

  /// Get DateMilliseconds By DateStr.
  static int getDateMsByTimeStr(String dateStr) {
    DateTime dateTime = DateTime.tryParse(dateStr);
    return dateTime == null ? null : dateTime.millisecondsSinceEpoch;
  }

  /// Get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return getDateStrByDateTime(DateTime.now());
  }

  /// Get DateStr By DateStr.
  /// 
  /// - [dateStr] date String.
  /// - [format] DateFormat type.
  /// - [dateSeparate] date separate.
  /// - [timeSeparate] time separate.
  static String getDateStrByTimeStr(String dateStr, {
    DateFormat format: DateFormat.NORMAL,
    String dateSeparate,
    String timeSeparate,
  }) {
    return getDateStrByDateTime(getDateTime(dateStr),
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// Get DateStr By Milliseconds.
  /// 
  /// - [milliseconds] milliseconds.
  /// - [format] DateFormat type.
  /// - [dateSeparate] date separate.
  /// - [timeSeparate] time separate.
  static String getDateStrByMs(int milliseconds, {
    DateFormat format: DateFormat.NORMAL,
    String dateSeparate,
    String timeSeparate,
    bool isUtc: false
  }) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getDateStrByDateTime(dateTime,
        format: format, dateSeparate: dateSeparate, timeSeparate: timeSeparate);
  }

  /// Get DateStr By DateTime.
  /// 
  /// - [dateTime] dateTime.
  /// - [format] DateFormat type.
  /// - [dateSeparate] date separate.
  /// - [timeSeparate] time separate.
  static String getDateStrByDateTime(DateTime dateTime,{ 
    DateFormat format: DateFormat.NORMAL,
    String dateSeparate,
    String timeSeparate
  }) {
    if (dateTime == null) return null;
    String dateStr = dateTime.toString();
    if (isZHFormat(format)) {
      dateStr = formatZHDateTime(dateStr, format, timeSeparate);
    } else {
      dateStr = formatDateTime(dateStr, format, dateSeparate, timeSeparate);
    }
    return dateStr;
  }

  /// Format ZH DateTime.
  /// 
  /// - [time] time string.
  /// - [format] DateFormat type.
  /// - [timeSeparate] time separate.
  static String formatZHDateTime(
      String time, DateFormat format, String timeSeparate) {
    time = convertToZHDateTimeString(time, timeSeparate);
    switch (format) {
      // yyyy年MM月dd日 HH时mm分ss秒
      case DateFormat.ZH_NORMAL: 
        time = time.substring(
            0,
            "yyyy年MM月dd日 HH时mm分ss秒".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      // yyyy年MM月dd日 HH时mm分
      case DateFormat.ZH_YEAR_MONTH_DAY_HOUR_MINUTE: 
        time = time.substring(0,
            "yyyy年MM月dd日 HH时mm分".length -(timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      // yyyy年MM月dd日
      case DateFormat.ZH_YEAR_MONTH_DAY: 
        time = time.substring(0, "yyyy年MM月dd日".length);
        break;
      // yyyy年MM月
      case DateFormat.ZH_YEAR_MONTH: 
        time = time.substring(0, "yyyy年MM月".length);
        break;
      // MM月dd日
      case DateFormat.ZH_MONTH_DAY: 
        time = time.substring("yyyy年".length, "yyyy年MM月dd日".length);
        break;
      // MM月dd日 HH时mm分
      case DateFormat.ZH_MONTH_DAY_HOUR_MINUTE: 
        time = time.substring("yyyy年".length,
            "yyyy年MM月dd日 HH时mm分".length - (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      // HH时mm分ss秒
      case DateFormat.ZH_HOUR_MINUTE_SECOND: 
        time = time.substring("yyyy年MM月dd日 ".length,
            "yyyy年MM月dd日 HH时mm分ss秒".length - (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      // HH时mm分
      case DateFormat.ZH_HOUR_MINUTE: 
        time = time.substring(
            "yyyy年MM月dd日 ".length,
            "yyyy年MM月dd日 HH时mm分".length -
                (timeSeparate == null || timeSeparate.isEmpty ? 0 : 1));
        break;
      default:
        break;
    }
    return time;
  }

  /// Format DateTime.
  ///
  /// - [time] time string.
  /// - [format] DateFormat type.
  /// - [dateSeparate] date separate.
  /// - [timeSeparate] time separate.
  static String formatDateTime(String time, DateFormat format,
      String dateSeparate, String timeSeparate) {
    switch (format) {
      // yyyy-MM-dd HH:mm:ss
      case DateFormat.NORMAL: 
        time = time.substring(0, "yyyy-MM-dd HH:mm:ss".length);
        break;
      // yyyy-MM-dd HH:mm  
      case DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE: 
        time = time.substring(0, "yyyy-MM-dd HH:mm".length);
        break;
      // yyyy-MM-dd  
      case DateFormat.YEAR_MONTH_DAY: 
        time = time.substring(0, "yyyy-MM-dd".length);
        break;
      // yyyy-MM
      case DateFormat.YEAR_MONTH: 
        time = time.substring(0, "yyyy-MM".length);
        break;
      // MM-dd
      case DateFormat.MONTH_DAY: 
        time = time.substring("yyyy-".length, "yyyy-MM-dd".length);
        break;
      // MM-dd HH:mm
      case DateFormat.MONTH_DAY_HOUR_MINUTE: 
        time = time.substring("yyyy-".length, "yyyy-MM-dd HH:mm".length);
        break;
      // HH:mm:ss
      case DateFormat.HOUR_MINUTE_SECOND: 
        time =
            time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm:ss".length);
        break;
      // HH:mm
      case DateFormat.HOUR_MINUTE: 
        time = time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm".length);
        break;
      default:
        break;
    }
    time = dateTimeSeparate(time, dateSeparate, timeSeparate);
    return time;
  }

  /// Is format to ZH DateTime String
  static bool isZHFormat(DateFormat format) {
    return format == DateFormat.ZH_DEFAULT 
        || format == DateFormat.ZH_NORMAL 
        || format == DateFormat.ZH_YEAR_MONTH_DAY_HOUR_MINUTE 
        || format == DateFormat.ZH_YEAR_MONTH_DAY 
        || format == DateFormat.ZH_YEAR_MONTH 
        || format == DateFormat.ZH_MONTH_DAY 
        || format == DateFormat.ZH_MONTH_DAY_HOUR_MINUTE 
        || format == DateFormat.ZH_HOUR_MINUTE_SECOND 
        || format == DateFormat.ZH_HOUR_MINUTE;
  }

  /// Convert To ZH DateTime String
  static String convertToZHDateTimeString(String time, String timeSeparate) {
    time = time.replaceFirst("-", "年");
    time = time.replaceFirst("-", "月");
    time = time.replaceFirst(" ", "日 ");
    if (timeSeparate == null || timeSeparate.isEmpty) {
      time = time.replaceFirst(":", "时");
      time = time.replaceFirst(":", "分");
      time = time.replaceFirst(".", "秒");
      time = time + "毫秒";
    } else {
      time = time.replaceAll(":", timeSeparate);
    }
    return time;
  }

  /// Date Time Separate.
  static String dateTimeSeparate(String time, String dateSeparate, String timeSeparate) {
    if (dateSeparate != null) {
      time = time.replaceAll("-", dateSeparate);
    }
    if (timeSeparate != null) {
      time = time.replaceAll(":", timeSeparate);
    }
    return time;
  }

  /// Get WeekDay By Milliseconds.
  static String getWeekDayByMs(int milliseconds, { bool isUtc = false }) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekDay(dateTime);
  }

  /// Get ZH WeekDay By Milliseconds.
  static String getZHWeekDayByMs(int milliseconds, { bool isUtc = false }) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getZHWeekDay(dateTime);
  }

  /// Get WeekDay.
  static String getWeekDay(DateTime dateTime) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = "Monday";
        break;
      case 2:
        weekday = "Tuesday";
        break;
      case 3:
        weekday = "Wednesday";
        break;
      case 4:
        weekday = "Thursday";
        break;
      case 5:
        weekday = "Friday";
        break;
      case 6:
        weekday = "Saturday";
        break;
      case 7:
        weekday = "Sunday";
        break;
      default:
        break;
    }
    return weekday;
  }

  /// Get ZH WeekDay.
  static String getZHWeekDay(DateTime dateTime) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = "星期一";
        break;
      case 2:
        weekday = "星期二";
        break;
      case 3:
        weekday = "星期三";
        break;
      case 4:
        weekday = "星期四";
        break;
      case 5:
        weekday = "星期五";
        break;
      case 6:
        weekday = "星期六";
        break;
      case 7:
        weekday = "星期日";
        break;
      default:
        break;
    }
    return weekday;
  }

  /// Return whether it is leap year.
  static bool isLeapYearByDateTime(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// Is yesterday by millis (是否是昨天).
  static bool isYesterdayByMillis(int millis, int locMillis) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// Is yesterday by dateTime.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = DateUtil.getDayOfYear(locDateTime) - DateUtil.getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// Get day of year (在今年的第几天).
  static int getDayOfYearByMillis(int millis) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(millis));
  }

  /// Get day of year.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i];
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// Year is equal (是否同年).
  static bool yearIsEqualByMillis(int millis, int locMillis) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// Year is equal (是否同年).
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }
}
