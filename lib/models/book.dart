class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String category;
  final String description;

  final int totalChapters;
  int currentChapter;

  bool isFavorite;
  bool isBookmarked;

  // 🔥 Thêm cho thống kê
  int minutesRead; // tổng phút đã đọc
  bool isCompleted; // đã đọc xong chưa

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.category,
    required this.description,
    required this.totalChapters,
    required this.currentChapter,
    this.isFavorite = false,
    this.isBookmarked = false,
    this.minutesRead = 0,
    this.isCompleted = false,
  });

  // % tiến trình
  double get progress {
    if (totalChapters <= 0) return 0;
    final p = currentChapter / totalChapters;
    if (p < 0) return 0;
    if (p > 1) return 1;
    return p;
  }

  // 🔥 tự động kiểm tra hoàn thành
  void checkCompleted() {
    if (currentChapter >= totalChapters) {
      isCompleted = true;
    }
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    String? category,
    String? description,
    int? totalChapters,
    int? currentChapter,
    bool? isFavorite,
    bool? isBookmarked,
    int? minutesRead,
    bool? isCompleted,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      category: category ?? this.category,
      description: description ?? this.description,
      totalChapters: totalChapters ?? this.totalChapters,
      currentChapter: currentChapter ?? this.currentChapter,
      isFavorite: isFavorite ?? this.isFavorite,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      minutesRead: minutesRead ?? this.minutesRead,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
