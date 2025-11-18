import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/header_section.dart';
import '../widgets/calendar_section.dart';
import '../widgets/recently_eaten_section.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_header.dart';
import '../widgets/calories_left_section.dart';
import '../widgets/macros_section.dart';
import '../widgets/meal_grid_section.dart';
import '../providers/app_providers.dart';
import '../models/calendar_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key}); // ✅ TAMBAH CONST

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  bool _isInitialized = false;

  // Cache untuk mencegah rebuild yang tidak perlu
  late List<CalendarData> _cachedCalendarData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize cached data
    _cachedCalendarData = _generateCalendarData();

    _scrollController.addListener(_throttleScrollListener);

    // Initialize data setelah build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarProvider.notifier).state = _cachedCalendarData;
      _isInitialized = true;
    });
  }

  List<CalendarData> _generateCalendarData() {
    final now = DateTime.now();
    List<CalendarData> data = [];

    for (int i = -3; i <= 3; i++) {
      DateTime day = now.add(Duration(days: i));
      bool isToday = _isSameDay(day, now);
      bool isSelected = i == 0;

      data.add(
        CalendarData(
          day: _getDayAbbreviation(day.weekday),
          date: day.day.toString(),
          isToday: isToday,
          isSelected: isSelected,
        ),
      );
    }
    return data;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getDayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return 'Err';
    }
  }

  DateTime _lastScrollUpdate = DateTime.now();
  void _throttleScrollListener() {
    final now = DateTime.now();
    if (now.difference(_lastScrollUpdate).inMilliseconds < 16) {
      return; 
    }
    _lastScrollUpdate = now;
    _handleScroll();
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;
    final scrollState = ref.read(scrollStateProvider);

    if (currentOffset > scrollState.lastOffset + 50 && currentOffset > 100) {
      if (scrollState.isHeaderVisible) {
        ref.read(scrollStateProvider.notifier).state = (
          isHeaderVisible: false,
          lastOffset: currentOffset,
        );
      }
    } else if (currentOffset < scrollState.lastOffset - 20) {
      if (!scrollState.isHeaderVisible) {
        ref.read(scrollStateProvider.notifier).state = (
          isHeaderVisible: true,
          lastOffset: currentOffset,
        );
      }
    }
  }

  void _onDateSelected(int index) {
    ref.read(selectedDateIndexProvider.notifier).state = index;

    // Update calendar data dengan selected state baru
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final updatedData = _cachedCalendarData.asMap().entries.map((entry) {
        final dataIndex = entry.key;
        final data = entry.value;
        return CalendarData(
          day: data.day,
          date: data.date,
          isToday: data.isToday,
          isSelected: dataIndex == index,
        );
      }).toList();

      _cachedCalendarData = updatedData;
      ref.read(calendarProvider.notifier).state = updatedData;
    });
  }

  void _onBottomNavTapped(int index) {
    ref.read(bottomNavIndexProvider.notifier).state = index;

    switch (index) {
      case 0:
        break; // Home
      case 1:
        _showComingSoonDialog('Activity');
        break;
      case 2:
        _showComingSoonDialog('Camera');
        break;
      case 3:
        _showComingSoonDialog('Chat');
        break;
      case 4:
        _showComingSoonDialog('Profile');
        break;
    }
  }

  void _showComingSoonDialog(String featureName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: Text('$featureName feature will be available soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_throttleScrollListener);
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isInitialized) {
      // Refresh calendar data ketika app resume
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _cachedCalendarData = _generateCalendarData();
        ref.read(calendarProvider.notifier).state = _cachedCalendarData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHeaderVisible = ref.watch(scrollStateProvider).isHeaderVisible;
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);
    final calendarData = ref.watch(calendarProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00E676),
              Color(0xFF69F0AE),
              Color(0xFFB9F6CA),
              Color(0xFFE8F5E8),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.25, 0.45, 0.6, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Animated Header Section
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isHeaderVisible ? null : 0,
                child: isHeaderVisible
                    ? CustomHeader(
                        onNotificationPressed: () =>
                            _showComingSoonDialog('Notifications'),
                        onOptionsPressed: () =>
                            _showComingSoonDialog('Options'),
                      )
                    : const SizedBox.shrink(),
              ),

              // Scrollable Content Area
              Expanded(
                child: _buildContent(
                  calendarData,
                  bottomNavIndex,
                  isHeaderVisible,
                ),
              ),

              // Bottom Navigation
              BottomNavigation(
                currentIndex: bottomNavIndex,
                onTap: _onBottomNavTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Pisahkan build content untuk optimization
  // Di dalam method _buildContent(), pastikan seperti ini:
  // Di dalam _buildContent method, pastikan seperti ini:
  Widget _buildContent(
    List<CalendarData> calendarData,
    int bottomNavIndex,
    bool isHeaderVisible,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            if (!isHeaderVisible) const SizedBox(height: 16),

            _buildCalendarCaloriesSection(calendarData),
            const SizedBox(height: 16),

            const MacrosSection(), // ✅ SEHARUSNYA TIDAK ERROR
            const SizedBox(height: 16),

            const MealGridSection(), // ✅ SEHARUSNYA TIDAK ERROR
            const SizedBox(height: 16),

            const RecentlyEatenSection(), // ✅ PASTIKAN INI JUGA CONST
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Pisahkan section calendar dan calories
  Widget _buildCalendarCaloriesSection(List<CalendarData> calendarData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Calendar Section
          CalendarSection(
            calendarData: calendarData,
            onDateSelected: _onDateSelected,
          ),
          const SizedBox(height: 20),

          // Divider
          Container(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 20),

          // Calories Left Section
          const CaloriesLeftSection(),
        ],
      ),
    );
  }
}
