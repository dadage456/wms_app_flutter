import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/aswh_up_collection_models.dart';
import '../../services/aswh_up_task_service.dart';

class AswhUpPalletItemState extends Equatable {
  const AswhUpPalletItemState({
    required this.trayNo,
    this.isLoading = false,
    this.stocks = const <AswhUpCollectionStock>[],
    this.errorMessage,
  });

  final String trayNo;
  final bool isLoading;
  final List<AswhUpCollectionStock> stocks;
  final String? errorMessage;

  AswhUpPalletItemState copyWith({
    bool? isLoading,
    List<AswhUpCollectionStock>? stocks,
    String? errorMessage,
  }) {
    return AswhUpPalletItemState(
      trayNo: trayNo,
      isLoading: isLoading ?? this.isLoading,
      stocks: stocks ?? this.stocks,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [trayNo, isLoading, stocks, errorMessage];
}

class AswhUpPalletItemCubit extends Cubit<AswhUpPalletItemState> {
  AswhUpPalletItemCubit({
    required AswhUpTaskService service,
    required String trayNo,
  })  : _service = service,
        super(AswhUpPalletItemState(trayNo: trayNo));

  final AswhUpTaskService _service;

  Future<void> load() async {
    if (state.trayNo.isEmpty) {
      emit(state.copyWith(errorMessage: '托盘号不能为空'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final result = await _service.fetchPalletItems(state.trayNo);
      emit(state.copyWith(isLoading: false, stocks: result));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
