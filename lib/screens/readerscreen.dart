import 'package:flutter/material.dart';
import '../models/book.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final max = _scrollController.position.maxScrollExtent;
      if (max == 0) return;

      double progress = _scrollController.offset / max;

      // Cập nhật chapter theo % scroll
      widget.book.currentChapter = (widget.book.totalChapters * progress)
          .round();

      if (progress > 0) {
        widget.book.isBookmarked = true;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: Column(
        children: [
          // Thanh tiến trình
          Padding(
            padding: const EdgeInsets.all(8),
            child: LinearProgressIndicator(value: widget.book.progress),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.book.description, // dùng description thay content
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
