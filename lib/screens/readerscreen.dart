import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  int _currentPage = 1;
  int _totalPages = 0;

  double _zoomLevel = 1.0;
  int? _bookmarkedPage;

  @override
  void initState() {
    super.initState();

    if (widget.book.currentChapter > 0) {
      _bookmarkedPage = widget.book.currentChapter;
      _currentPage = widget.book.currentChapter;
    }
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      _pdfViewerController.previousPage();
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      _pdfViewerController.nextPage();
    }
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel += 0.25;
      if (_zoomLevel > 3.0) _zoomLevel = 3.0;
      _pdfViewerController.zoomLevel = _zoomLevel;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel -= 0.25;
      if (_zoomLevel < 1.0) _zoomLevel = 1.0;
      _pdfViewerController.zoomLevel = _zoomLevel;
    });
  }

  void _bookmarkCurrentPage() {
    setState(() {
      _bookmarkedPage = _currentPage;
      widget.book.currentChapter = _currentPage;
      widget.book.isBookmarked = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã đánh dấu trang $_currentPage'),
      ),
    );
  }

  void _goToBookmark() {
    if (_bookmarkedPage != null && _bookmarkedPage! <= _totalPages) {
      _pdfViewerController.jumpToPage(_bookmarkedPage!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã chuyển tới trang $_bookmarkedPage'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chưa có trang được đánh dấu'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              'Trang $_currentPage / ${_totalPages == 0 ? "..." : _totalPages}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _zoomOut,
            icon: const Icon(Icons.zoom_out),
          ),
          IconButton(
            onPressed: _zoomIn,
            icon: const Icon(Icons.zoom_in),
          ),
          IconButton(
            onPressed: _bookmarkCurrentPage,
            icon: Icon(
              _bookmarkedPage == _currentPage
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
          ),
          IconButton(
            onPressed: _goToBookmark,
            icon: const Icon(Icons.bookmarks_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Trang $_currentPage / ${_totalPages == 0 ? "..." : _totalPages}   |   Zoom: ${_zoomLevel.toStringAsFixed(2)}x',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _goToPreviousPage,
                  icon: const Icon(Icons.chevron_left),
                ),
                IconButton(
                  onPressed: _goToNextPage,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfPdfViewer.asset(
              book.pdfPath,
              controller: _pdfViewerController,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              enableDoubleTapZooming: true,
              pageLayoutMode: PdfPageLayoutMode.continuous,
              onDocumentLoaded: (details) {
                setState(() {
                  _totalPages = details.document.pages.count;
                });

                if (_bookmarkedPage != null &&
                    _bookmarkedPage! > 0 &&
                    _bookmarkedPage! <= _totalPages) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _pdfViewerController.jumpToPage(_bookmarkedPage!);
                  });
                }
              },
              onPageChanged: (details) {
                setState(() {
                  _currentPage = details.newPageNumber;
                  widget.book.currentChapter = _currentPage;
                  widget.book.isBookmarked = true;

                  if (_totalPages > 0 && _currentPage >= _totalPages) {
                    widget.book.isCompleted = true;
                  } else {
                    widget.book.isCompleted = false;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
