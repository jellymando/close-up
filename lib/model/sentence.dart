class Sentence {
  final String id;
  final String bookName;
  final String content;
  final String registrant;

  Sentence({
    required this.id,
    required this.bookName,
    required this.content,
    required this.registrant,
  });

  Sentence.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        bookName = map['bookName'],
        content = map['content'],
        registrant = map['registrant'];
}
