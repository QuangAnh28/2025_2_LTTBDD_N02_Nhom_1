import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../main.dart';
import '../data/books.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color chipBg = Color(0xFFF1E4DB);
  static const Color accentColor = Color(0xFFE0A85A);

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    final totalBooks = fakeBooks.length;

    final totalPagesRead =
        fakeBooks.fold<int>(0, (sum, book) => sum + book.currentPage);

    final completedBooks = fakeBooks.where((book) => book.isCompleted).length;

    final totalMinutes =
        fakeBooks.fold<int>(0, (sum, book) => sum + book.minutesRead);

    final avgMinutesPerDay = totalMinutes == 0 ? 0 : (totalMinutes / 7).round();

    final avgProgress = totalBooks == 0
        ? 0.0
        : fakeBooks.fold<double>(0.0, (sum, book) => sum + book.progress) /
            totalBooks;

    final progressPercent = (avgProgress * 100).clamp(0.0, 100.0);

    return Container(
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(vi),
              const SizedBox(height: 16),
              _buildTotalPagesCard(totalPagesRead, vi),
              const SizedBox(height: 16),
              if (fakeBooks.isNotEmpty) _buildChartCard(vi),
              const SizedBox(height: 16),
              _buildTimeAndBooksCard(avgMinutesPerDay, completedBooks, vi),
              const SizedBox(height: 16),
              _buildGoalCard(completedBooks, vi),
              const SizedBox(height: 16),
              _buildInfoCard(
                vi ? "📚 Tổng số sách" : "📚 Total books",
                totalBooks.toString(),
              ),
              _buildInfoCard(
                vi ? "⏳ Tổng thời gian đọc" : "⏳ Total reading time",
                vi ? "$totalMinutes phút" : "$totalMinutes min",
              ),
              _buildInfoCard(
                vi ? "📖 Tổng số trang đã đọc" : "📖 Total pages read",
                vi ? "$totalPagesRead trang" : "$totalPagesRead pages",
              ),
              const SizedBox(height: 16),
              _buildAverageProgressCard(avgProgress, progressPercent, vi),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool vi) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.bar_chart_rounded,
            color: primaryBrown,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          vi ? "Thống kê" : "Statistics",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: darkBrown,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPagesCard(int totalPagesRead, bool vi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB68468), Color(0xFFE0A85A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vi ? "Tổng số trang đã đọc" : "Total pages read",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  vi ? "$totalPagesRead trang" : "$totalPagesRead pages",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.menu_book_rounded,
            size: 58,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(bool vi) {
    final takeN = fakeBooks.length > 4 ? 4 : fakeBooks.length;

    final maxPage = fakeBooks
        .take(takeN)
        .map((b) => b.currentPage)
        .fold<int>(0, (m, v) => v > m ? v : m);

    final maxY = (maxPage + 5).toDouble().clamp(5.0, 9999.0);

    return Container(
      height: 280,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vi ? "📊 Trang đã đọc (Top $takeN)" : "📊 Pages read (Top $takeN)",
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: (maxY / 4).clamp(1, 9999),
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: borderColor,
                      strokeWidth: 1,
                    );
                  },
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 34,
                      interval: (maxY / 4).clamp(1, 9999),
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: textSoft,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= takeN) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            "B${i + 1}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: darkBrown,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(
                  takeN,
                  (index) => _makeGroup(
                    index,
                    fakeBooks[index].currentPage.toDouble(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(6),
          color: accentColor,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: y < 5 ? 5 : y,
            color: chipBg,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAndBooksCard(int avgMinutes, int completedBooks, bool vi) {
    return Row(
      children: [
        Expanded(
          child: _buildSmallCard(
            vi ? "Thời gian đọc" : "Reading time",
            vi ? "$avgMinutes phút/ngày" : "$avgMinutes min/day",
            Icons.schedule_rounded,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSmallCard(
            vi ? "Sách đã đọc xong" : "Completed books",
            vi ? "$completedBooks cuốn" : "$completedBooks books",
            Icons.check_circle_outline_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryBrown, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: textSoft,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(int completedBooks, bool vi) {
    const int goal = 20;
    final double percent = (completedBooks / goal).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vi ? "🎯 Mục tiêu năm" : "🎯 Year goal",
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              backgroundColor: chipBg,
              valueColor: const AlwaysStoppedAnimation(accentColor),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            vi
                ? "${(percent * 100).toInt()}% hoàn thành ($completedBooks/$goal cuốn)"
                : "${(percent * 100).toInt()}% completed ($completedBooks/$goal books)",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: textSoft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: darkBrown,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: primaryBrown,
          ),
        ),
      ),
    );
  }

  Widget _buildAverageProgressCard(
    double avgProgress,
    double progressPercent,
    bool vi,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vi ? "📈 Tiến trình trung bình" : "📈 Average progress",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: avgProgress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: chipBg,
              valueColor: const AlwaysStoppedAnimation(primaryBrown),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${progressPercent.toStringAsFixed(1)}%",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: primaryBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}