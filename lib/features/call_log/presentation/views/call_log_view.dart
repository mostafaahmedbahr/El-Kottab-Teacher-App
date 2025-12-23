import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/call_log_model.dart';
import '../view_models/call_log_view_model.dart';
import 'widgets/call_log_item.dart';

class CallLogView extends StatefulWidget {
  const CallLogView({super.key});

  @override
  State<CallLogView> createState() => _CallLogViewState();
}

class _CallLogViewState extends State<CallLogView> {
  late CallLogViewModel _viewModel;
  int _selectedFilter = 0; // 0: All, 1: Completed, 2: Missed

  @override
  void initState() {
    super.initState();
    _viewModel = CallLogViewModel();
    _viewModel.addListener(_onViewModelChange);
    _loadData();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  void _onViewModelChange() {
    if (mounted) setState(() {});
  }

  Future<void> _loadData() async {
    await _viewModel.loadCallLogs();
  }

  List<CallLogModel> _getFilteredCalls() {
    switch (_selectedFilter) {
      case 0:
        return _viewModel.callLogs;
      case 1:
        return _viewModel.getCompletedCalls();
      case 2:
        return _viewModel.getMissedCalls();
      default:
        return _viewModel.callLogs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سجل المكالمات'),
          actions: [
            IconButton(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              tooltip: 'تحديث',
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<CallLogViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return _buildLoadingState();
        }

        if (viewModel.error != null) {
          return _buildErrorState(viewModel.error!);
        }

        return Column(
          children: [
            // Filter Toggle Buttons
            _buildFilterButtons(),
            const SizedBox(height: 16),

            // Stats Summary
            _buildStatsSummary(viewModel),

            // Call Logs List
            Expanded(
              child: _buildCallList(_getFilteredCalls()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildFilterButton('الكل', 0),
          const SizedBox(width: 8),
          _buildFilterButton('مكتملة', 1),
          const SizedBox(width: 8),
          _buildFilterButton('فائتة', 2),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, int index) {
    bool isSelected = _selectedFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300]!,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSummary(CallLogViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildStatItem(
            icon: Icons.call,
            value: viewModel.callLogs.length.toString(),
            label: 'إجمالي المكالمات',
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildStatItem(
            icon: Icons.check_circle,
            value: viewModel.getCompletedCalls().length.toString(),
            label: 'مكتملة',
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          _buildStatItem(
            icon: Icons.cancel,
            value: viewModel.getMissedCalls().length.toString(),
            label: 'فائتة',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallList(List<CallLogModel> calls) {
    if (calls.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.call_missed_outgoing,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد مكالمات',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عندما تكون هناك مكالمات، ستظهر هنا',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CallLogItem(call: call, viewModel: _viewModel),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'جاري تحميل سجل المكالمات...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'خطأ في تحميل البيانات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}