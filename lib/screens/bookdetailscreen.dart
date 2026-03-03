import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/book.dart';
import '../data/books.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _expanded = false;
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final b = fakeBooks.firstWhere((e) => e.id == widget.book.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          b.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => _shareBook(context, b),
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
        child: Column(
          children: [
            _cover(b),
            const SizedBox(height: 18),
            Text(
              b.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              b.author,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            _actionRow(b),
            const SizedBox(height: 14),
            _ratingAndCategory(b),
            const SizedBox(height: 16),
            _descriptionCard(b),
          ],
        ),
      ),
    );
  }

  Widget _cover(Book b) {
    return Center(
      child: Container(
        width: 220,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(b.coverUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _actionRow(Book b) {
    return Row(
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: () {
              setState(() {
                final index = fakeBooks.indexWhere((book) => book.id == b.id);

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
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Icon(
                b.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: b.isFavorite ? Colors.redAccent : Colors.black54,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Material(
            color: const Color(0xFF1976D2),
            borderRadius: BorderRadius.circular(26),
            child: InkWell(
              onTap: () => _startReading(context),
              borderRadius: BorderRadius.circular(26),
              child: const SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Bắt đầu đọc',
                      style: TextStyle(
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

  Widget _ratingAndCategory(Book b) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(5, (i) {
                final idx = i + 1;
                return InkWell(
                  onTap: () => setState(() => _rating = idx),
                  child: Icon(
                    _rating >= idx
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: const Color(0xFFFFB300),
                  ),
                );
              }),
            ),
          ),
          Text(
            b.category,
            style: const TextStyle(
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionCard(Book b) {
    return Text(b.description);
  }

  void _startReading(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bắt đầu đọc: ${widget.book.title}')),
    );
  }

  void _shareBook(BuildContext context, Book b) {
    final text = '${b.title} - ${b.author}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã copy thông tin sách')));
  }
}
