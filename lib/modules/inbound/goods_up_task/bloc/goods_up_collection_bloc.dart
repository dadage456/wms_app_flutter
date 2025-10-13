import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/goods_up_collection_task.dart';
import '../services/goods_up_collection_service.dart';
import '../../../../services/user_manager.dart';

@immutable
abstract class GoodsUpCollectionState {
  const GoodsUpCollectionState();
}

class GoodsUpCollectionInitial extends GoodsUpCollectionState {
  const GoodsUpCollectionInitial();
}

class GoodsUpCollectionLoadInProgress extends GoodsUpCollectionState {
  const GoodsUpCollectionLoadInProgress();
}

class GoodsUpCollectionLoadSuccess extends GoodsUpCollectionState {
  const GoodsUpCollectionLoadSuccess(this.tasks);

  final List<GoodsUpCollectionTask> tasks;
}

class GoodsUpCollectionLoadFailure extends GoodsUpCollectionState {
  const GoodsUpCollectionLoadFailure(this.message);

  final String message;
}

class GoodsUpCollectionBloc extends Cubit<GoodsUpCollectionState> {
  GoodsUpCollectionBloc({
    required GoodsUpCollectionService service,
    required UserManager userManager,
  })  : _service = service,
        _userManager = userManager,
        super(const GoodsUpCollectionInitial());

  final GoodsUpCollectionService _service;
  final UserManager _userManager;

  Future<void> loadTasks() async {
    emit(const GoodsUpCollectionLoadInProgress());
    try {
      final tasks = await _service.fetchPendingTasks(
        userId: _userManager.currentUser?.userId,
      );
      emit(GoodsUpCollectionLoadSuccess(tasks));
    } catch (error) {
      emit(GoodsUpCollectionLoadFailure(error.toString()));
    }
  }
}
