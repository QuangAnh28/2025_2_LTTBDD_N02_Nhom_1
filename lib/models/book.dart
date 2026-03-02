class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String category;
  final String description;

  final int totalChapters;
  final int currentChapter;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.category,
    required this.description,
    required this.totalChapters,
    required this.currentChapter,
  });

  double get progress {
    if (totalChapters <= 0) return 0;
    final p = currentChapter / totalChapters;
    if (p < 0) return 0;
    if (p > 1) return 1;
    return p;
  }
}