import 'package:equatable/equatable.dart';

class AswhUpTaskState extends Equatable {
  const AswhUpTaskState({
    this.currentPage = 1,
    this.total = 0,
    this.searchKey = '',
    this.toastMessage,
  });

  final int currentPage;
  final int total;
  final String searchKey;
  final String? toastMessage;

  AswhUpTaskState copyWith({
    int? currentPage,
    int? total,
    String? searchKey,
    String? toastMessage,
    bool clearToast = false,
  }) {
    return AswhUpTaskState(
      currentPage: currentPage ?? this.currentPage,
      total: total ?? this.total,
      searchKey: searchKey ?? this.searchKey,
      toastMessage: clearToast
          ? null
          : (toastMessage ?? this.toastMessage),
    );
  }

  @override
  List<Object?> get props => [currentPage, total, searchKey, toastMessage];
}
