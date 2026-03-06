class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String category;
  final String description;
  final String pdfPath;

  int totalPages;
  int currentPage;

  bool isFavorite;
  bool isBookmarked;

  int minutesRead;
  bool isCompleted;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.category,
    required this.description,
    required this.pdfPath,
    this.totalPages = 0,
    this.currentPage = 1,
    this.isFavorite = false,
    this.isBookmarked = false,
    this.minutesRead = 0,
    this.isCompleted = false,
  });

  double get progress {
    if (totalPages <= 0) return 0;
    final p = currentPage / totalPages;
    if (p < 0) return 0;
    if (p > 1) return 1;
    return p;
  }

  void checkCompleted() {
    isCompleted = totalPages > 0 && currentPage >= totalPages;
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    String? category,
    String? description,
    String? pdfPath,
    int? totalPages,
    int? currentPage,
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
      pdfPath: pdfPath ?? this.pdfPath,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      isFavorite: isFavorite ?? this.isFavorite,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      minutesRead: minutesRead ?? this.minutesRead,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
