import 'dart:convert';

/// 收藏
class Collection {

  int chapterId;
  int courseId;
  int id;
  int originId;
  int publishTime;
  int userId;
  int visible;
  int zan;
  String author;
  String chapterName;
  String desc;
  String envelopePic;
  String link;
  String niceDate;
  String origin;
  String title;

  Collection.fromParams({
    this.chapterId, 
    this.courseId, 
    this.id, 
    this.originId, 
    this.publishTime, 
    this.userId, 
    this.visible, 
    this.zan, 
    this.author, 
    this.chapterName, 
    this.desc, 
    this.envelopePic, 
    this.link, 
    this.niceDate, 
    this.origin, 
    this.title
  });
  
  Collection.fromJson(jsonRes) {
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    originId = jsonRes['originId'];
    publishTime = jsonRes['publishTime'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    origin = jsonRes['origin'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,"id": $id,"originId": ${origin != null?'${json.encode(origin)}':'null'}Id,"publishTime": $publishTime,"userId": $userId,"visible": $visible,"zan": $zan,"author": ${author != null?'${json.encode(author)}':'null'},"chapterName": ${chapterName != null?'${json.encode(chapterName)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"envelopePic": ${envelopePic != null?'${json.encode(envelopePic)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"niceDate": ${niceDate != null?'${json.encode(niceDate)}':'null'},"origin": ${origin != null?'${json.encode(origin)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}