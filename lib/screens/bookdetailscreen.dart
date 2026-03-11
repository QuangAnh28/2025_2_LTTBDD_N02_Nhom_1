import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/book.dart';
import '../data/books.dart';
import '../main.dart';
import 'readerscreen.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _expanded = false;
  int _rating = 0;

  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);
    final vi = appState.isVietnamese;

    final b = _getBookById(widget.book.id);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: darkBrown,
        elevation: 0,
        centerTitle: true,
        title: Text(
          b.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: darkBrown,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => _shareBook(context, b, vi),
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          children: [
            _cover(b),
            const SizedBox(height: 20),
            Text(
              b.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              b.author,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: textSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            _actionRow(b, vi),
            const SizedBox(height: 14),
            _ratingAndCategory(b, vi),
            const SizedBox(height: 16),
            _descriptionCard(b, vi),
          ],
        ),
      ),
    );
  }

  Book _getBookById(String id) {
    final idx = fakeBooks.indexWhere((e) => e.id == id);
    if (idx == -1) return widget.book;
    return fakeBooks[idx];
  }

  Widget _cover(Book b) {
    return Center(
      child: Container(
        width: 220,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            b.coverUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFEADFD7),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  size: 48,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _actionRow(Book b, bool vi) {
    return Row(
      children: [
        Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: () {
              setState(() {
                final index = fakeBooks.indexWhere((book) => book.id == b.id);
                if (index == -1) return;

                fakeBooks[index] = fakeBooks[index].copyWith(
                  isFavorite: !fakeBooks[index].isFavorite,
                );
              });
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 58,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor),
              ),
              child: Icon(
                b.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: b.isFavorite ? const Color(0xFFD87C7C) : textSoft,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Material(
            color: primaryBrown,
            borderRadius: BorderRadius.circular(26),
            child: InkWell(
              onTap: () => _startReading(context, b, vi),
              borderRadius: BorderRadius.circular(26),
              child: SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu_book_rounded, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      vi ? 'Bắt đầu đọc' : 'Start reading',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ratingAndCategory(Book b, bool vi) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(5, (i) {
                final idx = i + 1;
                return InkWell(
                  onTap: () => setState(() => _rating = idx),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      _rating >= idx
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: const Color(0xFFE0A85A),
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1E4DB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              b.category,
              style: const TextStyle(
                color: primaryBrown,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionCard(Book b, bool vi) {
    final title = vi ? "Mô tả" : "Description";
    final more = vi ? "Xem thêm" : "Read more";
    final less = vi ? "Thu gọn" : "Show less";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_outlined, color: primaryBrown, size: 20),
              SizedBox(width: 8),
              Text(
                "Mô tả",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: darkBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            b.description,
            maxLines: _expanded ? null : 5,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(
              color: darkBrown,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? less : more,
                style: const TextStyle(
                  color: primaryBrown,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startReading(BuildContext context, Book b, bool vi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderScreen(book: b),
      ),
    );
  }

  void _shareBook(BuildContext context, Book b, bool vi) {
    final text = '${b.title} - ${b.author}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primaryBrown,
        content: Text(
          vi ? 'Đã copy thông tin sách' : 'Copied book info',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}