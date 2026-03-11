import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';
import '../data/books.dart';

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

  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color chipBg = Color(0xFFF1E4DB);

  @override
  void initState() {
    super.initState();
    _currentPage = widget.book.currentPage > 0 ? widget.book.currentPage : 1;
    _bookmarkedPage = widget.book.isBookmarked ? widget.book.currentPage : null;
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

      // Cập nhật vào fakeBooks để LibraryScreen đọc được dữ liệu mới
      final index = fakeBooks.indexWhere((b) => b.id == widget.book.id);
      if (index != -1) {
        fakeBooks[index].currentPage = _currentPage;
        fakeBooks[index].isBookmarked = true;
      }

      // Cập nhật object hiện tại
      widget.book.currentPage = _currentPage;
      widget.book.isBookmarked = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primaryBrown,
        content: Text(
          'Đã đánh dấu trang $_currentPage',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _goToBookmark() {
    if (_bookmarkedPage != null &&
        _bookmarkedPage! > 0 &&
        _bookmarkedPage! <= _totalPages) {
      _pdfViewerController.jumpToPage(_bookmarkedPage!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: primaryBrown,
          content: Text(
            'Chưa có trang được đánh dấu',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: darkBrown,
        elevation: 0,
        titleSpacing: 0,
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
                color: darkBrown,
              ),
            ),
            Text(
              'Trang $_currentPage / ${_totalPages == 0 ? "..." : _totalPages}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textSoft,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _zoomOut,
            icon: const Icon(Icons.zoom_out, color: primaryBrown),
          ),
          IconButton(
            onPressed: _zoomIn,
            icon: const Icon(Icons.zoom_in, color: primaryBrown),
          ),
          IconButton(
            onPressed: _bookmarkCurrentPage,
            icon: Icon(
              _bookmarkedPage == _currentPage
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: primaryBrown,
            ),
          ),
          IconButton(
            onPressed: _goToBookmark,
            icon: const Icon(Icons.bookmarks_outlined, color: primaryBrown),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    child: Text(
                      'Trang $_currentPage / ${_totalPages == 0 ? "..." : _totalPages}   •   Zoom: ${_zoomLevel.toStringAsFixed(2)}x',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: darkBrown,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: chipBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _goToPreviousPage,
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: primaryBrown,
                          ),
                        ),
                        IconButton(
                          onPressed: _goToNextPage,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: primaryBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
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
                      widget.book.totalPages = _totalPages;

                      final index =
                          fakeBooks.indexWhere((b) => b.id == widget.book.id);
                      if (index != -1) {
                        fakeBooks[index].totalPages = _totalPages;
                      }

                      if (widget.book.currentPage <= 0) {
                        widget.book.currentPage = 1;
                      }

                      if (widget.book.currentPage > _totalPages) {
                        widget.book.currentPage = _totalPages;
                      }
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final pageToOpen =
                          widget.book.currentPage > 0 ? widget.book.currentPage : 1;
                      _pdfViewerController.jumpToPage(pageToOpen);
                    });
                  },
                  onPageChanged: (details) {
                    setState(() {
                      _currentPage = details.newPageNumber;
                      widget.book.currentPage = _currentPage;
                      widget.book.checkCompleted();

                      final index =
                          fakeBooks.indexWhere((b) => b.id == widget.book.id);
                      if (index != -1) {
                        fakeBooks[index].currentPage = _currentPage;
                        fakeBooks[index].checkCompleted();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }