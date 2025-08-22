# API响应处理系统

## 概述

本系统提供了一个统一的API响应处理方案，使用泛型来处理不同类型的接口响应，统一处理成功/失败逻辑。

## 核心组件

### 1. ApiResponseHandler

通用的响应处理工具类，提供两个主要方法：

#### handleResponse<T>
用于处理标准格式的API响应（包含code、msg、data字段）：

```dart
final userInfo = await ApiResponseHandler.handleResponse<UserInfoModel>(
  response: response,
  dataExtractor: (data) => UserInfoModel.fromJson(data),
  successCode: 200,
  codeField: 'code',
  messageField: 'msg',
  dataField: 'data',
);
```

#### handleDirectResponse<T>
用于处理特殊格式的API响应（如登录接口直接返回token）：

```dart
final token = await ApiResponseHandler.handleDirectResponse<String>(
  response: response,
  fieldName: 'token',
  dataField: 'token',
  successCode: 200,
  codeField: 'code',
  messageField: 'msg',
);
```

### 2. ApiService

使用ApiResponseHandler的API服务类，提供：

- 统一的错误处理
- 自动Token管理
- 请求拦截器
- 响应日志记录

## 使用方法

### 1. 标准API调用

```dart
// 获取用户信息
Future<UserInfoModel> getUserInfo() async {
  try {
    final response = await _dio.get('/user/info');
    
    return ApiResponseHandler.handleResponse<UserInfoModel>(
      response: response,
      dataExtractor: (data) => UserInfoModel.fromJson(data),
      successCode: 200,
      codeField: 'code',
      messageField: 'msg',
      dataField: 'data',
    );
  } on DioException catch (e) {
    throw Exception(ApiResponseHandler.handleDioException(e));
  } catch (e) {
    throw Exception('获取用户信息失败：$e');
  }
}
```

### 2. 特殊API调用（如登录）

```dart
// 登录
Future<String> login(String account, String password) async {
  try {
    final response = await _dio.post('/login', data: {
      'username': account,
      'password': password,
    });

    return ApiResponseHandler.handleDirectResponse<String>(
      response: response,
      fieldName: 'token',
      successCode: 200,
      codeField: 'code',
      messageField: 'msg',
    );
  } on DioException catch (e) {
    throw Exception(ApiResponseHandler.handleDioException(e));
  } catch (e) {
    throw Exception('未知错误：$e');
  }
}
```

## 响应格式

### 标准响应格式
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    // 具体数据内容
  }
}
```

### 特殊响应格式（如登录）
```json
{
  "code": 200,
  "msg": "登录成功",
  "token": "jwt_token_string"
}
```

### 错误响应格式
```json
{
  "code": 200,
  "msg": "用户名或密码错误"
}
```

## 错误处理

系统会自动处理以下情况：

1. **响应格式错误**：响应不是Map类型
2. **状态码错误**：code字段不等于successCode
3. **数据为空**：data字段为null
4. **数据类型不匹配**：期望类型与实际类型不符
5. **Dio异常**：网络请求异常，自动提取服务端msg

## 配置选项

所有方法都支持自定义配置：

- `successCode`: 成功的状态码（默认200）
- `codeField`: 状态码字段名（默认'code'）
- `messageField`: 消息字段名（默认'msg'）
- `dataField`: 数据字段名（默认'data'）

## 优势

1. **类型安全**：使用泛型确保类型安全
2. **统一处理**：所有API使用相同的响应处理逻辑
3. **易于维护**：集中管理响应处理逻辑
4. **灵活配置**：支持不同的响应格式
5. **错误友好**：自动提取服务端错误信息
6. **代码复用**：避免在每个API方法中重复编写响应处理代码
