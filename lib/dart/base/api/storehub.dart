import 'package:logging/logging.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:orginone/dart/base/model.dart';

/// 存储集线器
class StoreHub {
  // 是否已经启动
  bool _isStarted = false;
  // 超时重试时间
  final int _timeout;
  // signalr 连接
  final HubConnection _connection;
  // 连接成功回调
  List<Function> _connectedCallbacks = [];
  // 日志
  final Logger log = Logger("StoreHub");
  // 连接断开回调
  List<Function(Exception?)> _disconnectedCallbacks = [];

  StoreHub(
    String url, {
    int timeout = 8000,
    int interval = 3000,
  })  : _timeout = timeout,
        _connection = HubConnectionBuilder().withUrl(url).build() {
    _connection.keepAliveIntervalInMilliseconds = timeout;
    _connection.serverTimeoutInMilliseconds = interval;
    _connection.onclose((err) {
      if (_isStarted && err != null) {
        for (final callback in _disconnectedCallbacks) {
          callback(err);
        }
        log.warning("连接断开,${_timeout}ms后重试。${err.toString()}`");
        Future.delayed(Duration(milliseconds: _timeout), () {
          _starting();
        });
      }
    });
  }

  /// 是否处于连接着的状态
  /// @return {boolean} 状态
  bool get isConnected {
    return _isStarted && _connection.state == HubConnectionState.connected;
  }

  /// 销毁连接
  /// @returns {Promise<void>} 异步Promise
  Future<void> dispose() async {
    _isStarted = false;
    _connectedCallbacks = [];
    _disconnectedCallbacks = [];
    return await _connection.stop();
  }

  /// 启动链接
  /// @returns {void} 无返回值
  void start() {
    if (!_isStarted) {
      _isStarted = true;
      _starting();
    }
  }

  /// 重新建立连接
  /// @returns {void} 无返回值
  void restart() {
    if (isConnected) {
      _connection.stop().then((_) {
        _starting();
      });
    }
  }

  /// 开始连接
  /// @returns {void} 无返回值
  void _starting() {
    _connection.start()?.then((_) {
      for (final callback in _connectedCallbacks) {
        callback();
      }
    }, onError: (err) {
      log.warning("连接失败,${_timeout}ms后重试。${err.toString()}`");
      for (final callback in _disconnectedCallbacks) {
        callback(err);
      }
      Future.delayed(Duration(milliseconds: _timeout), () {
        _starting();
      });
    });
  }

  /// 连接成功事件
  /// @param {Function} callback 回调
  /// @returns {void} 无返回值
  void onConnected(Function? callback) {
    if (callback != null) {
      _connectedCallbacks.add(callback);
    }
  }

  /// 断开连接事件
  /// @param {Function} callback 回调
  /// @returns {void} 无返回值
  void onDisconnected(Function(Exception?)? callback) {
    if (callback != null) {
      _disconnectedCallbacks.add(callback);
    }
  }

  /// 监听服务端方法
  /// @param {string} methodName 方法名
  /// @param {Function} newMethod 回调
  /// @returns {void} 无返回值
  void on(String methodName, void Function(List<dynamic>?) newMethod) {
    _connection.on(methodName, newMethod);
  }

  /// 请求服务端方法
  /// @param {string} methodName 方法名
  /// @param {any[]} args 参数
  /// @returns {Promise<ResultType>} 异步结果
  Future<ResultType<T>> invoke<T>(String methodName,
      {List<dynamic>? args}) async {
    try {
      final ResultType<T> res =
          await _connection.invoke(methodName, args: args);
      if (res.code == 401) {
        log.warning("登录已过期");
      }
      if (!res.success) {
        log.warning("操作失败,错误消息${res.msg}");
      }
      return res;
    } catch (err) {
      return ResultType(code: 400, msg: "请求异常", success: false);
    }
  }
}
