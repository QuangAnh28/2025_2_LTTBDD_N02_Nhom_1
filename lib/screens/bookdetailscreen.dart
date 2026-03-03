import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:flutter/services.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isFav = false;
  bool _expanded = false;
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final b = widget.book;

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
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
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
            _actionRow(context),
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
          child: Image.asset(
            b.coverUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                color: const Color(0xFFF3F4F6),
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined, size: 36),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _actionRow(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            onTap: () => setState(() => _isFav = !_isFav),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 58,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Icon(
                _isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: _isFav ? Colors.redAccent : Colors.black54,
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
              child: SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (i) {
                    final idx = i + 1;
                    return InkWell(
                      onTap: () => setState(() => _rating = idx),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          _rating >= idx
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 22,
                          color: const Color(0xFFFFB300),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  _rating == 0 ? 'Chưa có đánh giá' : '$_rating/5.0',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Danh mục',
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  b.category,
                  style: const TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _descriptionCard(Book b) {
    final text = _safeDesc(b);
    final showText = _expanded ? text : _shorten(text, 160);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Giới thiệu nội dung',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Text(
            showText,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          if (text.length > 160)
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? 'Thu gọn ↑' : 'Xem thêm ↓',
                style: const TextStyle(
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _safeDesc(Book b) {
    final dynamic bb = b;
    try {
      final String? d = bb.description as String?;
      if (d != null && d.trim().isNotEmpty) return d;
    } catch (_) {}
    return 'Chưa có mô tả cho cuốn sách này.';
  }

  String _shorten(String s, int max) {
    if (s.length <= max) return s;
    return '${s.substring(0, max)}...';
  }

  void _startReading(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bắt đầu đọc: ${widget.book.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareBook(BuildContext context, Book b) {
    final text = '${b.title} - ${b.author}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã copy thông tin sách'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}