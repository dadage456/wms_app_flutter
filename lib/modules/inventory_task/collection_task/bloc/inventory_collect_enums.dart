enum InventoryCollectStep { scanLocation, scanMaterial, inputQuantity }

enum InventoryCollectStatus {
  initial,
  loading,
  success,
  failure,
  submitting,
  cacheUpdating,
}
