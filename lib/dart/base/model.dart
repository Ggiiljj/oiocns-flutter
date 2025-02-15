/// 统一返回结构模型
class ResultType<T> {
  // 代码，成功为200
  final int code;
  // 数据
  final T? data;
  // 消息
  final String msg;
  // 是否成功标志
  final bool success;

  ResultType({
    required this.code,
    this.data,
    required this.msg,
    required this.success,
  });

  ResultType.fromJson(Map<String, dynamic> json)
      : msg = json["msg"],
        data = json["data"],
        code = json["code"],
        success = json["success"];
}

/// 内核请求模型
class ReqestType {
  // 模块
  final String module;
  // 方法
  final String action;
  // 参数
  final dynamic params;

  ReqestType({
    required this.module,
    required this.action,
    required this.params,
  });
}

/// 事件接收模型
class ReceiveType {
  // 目标
  final String target;
  // 数据
  final dynamic data;

  ReceiveType({
    required this.target,
    required this.data,
  });
}

/// 桶支持的操作
enum BucketOpreates {
  list("List"),
  create("Create"),
  rename("Rename"),
  move("Move"),
  copy("Copy"),
  delete("Delete"),
  upload("Upload"),
  abortUpload("AbortUpload");

  const BucketOpreates(this.label);

  final String label;

  static String getName(BucketOpreates opreate) {
    return opreate.label;
  }
}

/// 桶操作携带的数据模型
class BucketOpreateModel {
  // 完整路径
  final String key;
  // 名称
  final String? name;
  // 共享域
  final String shareDomain;
  // 目标
  final String? destination;
  // 操作
  final BucketOpreates operate;
  // 携带的分片数据
  final FileChunkData? fileItem;

  BucketOpreateModel({
    required this.key,
    this.name,
    required this.shareDomain,
    this.destination,
    required this.operate,
    this.fileItem,
  });
}

/// 上传文件携带的数据
class FileChunkData {
  // 分片索引
  final int index;
  // 文件大小
  final int size;
  // 上传的唯一ID
  final String uploadId;
  // 分片数据编码字符串
  final String dataUrl;

  FileChunkData({
    required this.index,
    required this.size,
    required this.uploadId,
    required this.dataUrl,
  });
}

/// 文件系统项数据模型
class FileItemModel {
  // 完整路径
  String key;
  // 完整路径
  int size;
  // 名称
  String name;
  // 共享链接
  String shareLink;
  // 拓展名
  String extension;
  // 缩略图
  String thumbnail;
  // 创建时间
  DateTime dateCreated;
  // 修改时间
  DateTime dateModified;
  // 文件类型
  String contentType;
  // 是否是目录
  bool isDirectory;
  // 是否包含子目录
  bool hasSubDirectories;

  FileItemModel({
    required this.key,
    required this.size,
    required this.name,
    required this.shareLink,
    required this.extension,
    required this.thumbnail,
    required this.dateCreated,
    required this.dateModified,
    required this.contentType,
    required this.isDirectory,
    required this.hasSubDirectories,
  });
}

class IdReq {
  // 唯一ID
  final String id;

  //构造方法
  IdReq({
    required this.id,
  });

  //通过JSON构造
  IdReq.fromJson(Map<String, dynamic> json) : id = json["id"];

  //通过动态数组解析成List
  static List<IdReq> fromList(List<Map<String, dynamic>> list) {
    List<IdReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    return json;
  }
}

class CreateDefineReq {
  // 唯一Id
  String? id;
  // 名称
  late String name;
  // 编号
  late String code;
  // 备注
  late String remark;
  // 节点信息
  // FlowNode? resource;
  // 归属Id
  late String belongId;
  // 流程字段json
  String? fields;
}

class NameModel {
  // 名称
  final String name;
  // 图片
  final String photo;

  //构造方法
  NameModel({
    required this.name,
    required this.photo,
  });

  //通过JSON构造
  NameModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        photo = json["photo"];

  //通过动态数组解析成List
  static List<NameModel> fromList(List<Map<String, dynamic>> list) {
    List<NameModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(NameModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["photo"] = photo;
    return json;
  }
}

class IdReqModel {
  // 唯一ID
  final String id;
  // 实体类型
  final String typeName;
  // 归属ID
  late String belongId;

  //构造方法
  IdReqModel({
    required this.id,
    required this.typeName,
  });

  //通过JSON构造
  IdReqModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        typeName = json["typeName"],
        belongId = json["belongId"];

  //通过动态数组解析成List
  static List<IdReqModel> fromList(List<Map<String, dynamic>> list) {
    List<IdReqModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdReqModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["typeName"] = typeName;
    json["belongId"] = belongId;
    return json;
  }
}

class IdArrayReq {
  // 唯一ID数组
  final List<String> ids;
  // 分页
  final PageRequest? page;

  //构造方法
  IdArrayReq({
    required this.ids,
    required this.page,
  });

  //通过JSON构造
  IdArrayReq.fromJson(Map<String, dynamic> json)
      : ids = json["ids"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IdArrayReq> fromList(List<Map<String, dynamic>> list) {
    List<IdArrayReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdArrayReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["ids"] = ids;
    json["page"] = page?.toJson();
    return json;
  }
}

class IdSpaceReq {
  // 唯一ID
  final String id;
  // 工作空间ID
  final String spaceId;
  // 分页
  final PageRequest? page;

  //构造方法
  IdSpaceReq({
    required this.id,
    required this.spaceId,
    required this.page,
  });

  //通过JSON构造
  IdSpaceReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        spaceId = json["spaceId"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IdSpaceReq> fromList(List<Map<String, dynamic>> list) {
    List<IdSpaceReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdSpaceReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["spaceId"] = spaceId;
    json["page"] = page?.toJson();
    return json;
  }
}

class SpaceAuthReq {
  // 职权ID
  final String authId;
  // 工作空间ID
  final String spaceId;

  //构造方法
  SpaceAuthReq({
    required this.authId,
    required this.spaceId,
  });

  //通过JSON构造
  SpaceAuthReq.fromJson(Map<String, dynamic> json)
      : authId = json["authId"],
        spaceId = json["spaceId"];

  //通过动态数组解析成List
  static List<SpaceAuthReq> fromList(List<Map<String, dynamic>> list) {
    List<SpaceAuthReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(SpaceAuthReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["authId"] = authId;
    json["spaceId"] = spaceId;
    return json;
  }
}

class IDBelongReq {
  // 唯一ID
  final String id;
  // 分页
  final PageRequest? page;

  //构造方法
  IDBelongReq({
    required this.id,
    this.page,
  });

  //通过JSON构造
  IDBelongReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDBelongReq> fromList(List<Map<String, dynamic>> list) {
    List<IDBelongReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDBelongReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["page"] = page?.toJson();
    return json;
  }
}

class RelationReq {
  // 唯一ID
  final String id;
  // 子组织/个人ID
  final List<String> subIds;

  //构造方法
  RelationReq({
    required this.id,
    required this.subIds,
  });

  //通过JSON构造
  RelationReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        subIds = json["subIds"];

  //通过动态数组解析成List
  static List<RelationReq> fromList(List<Map<String, dynamic>> list) {
    List<RelationReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(RelationReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["subIds"] = subIds;
    return json;
  }
}

// 缓存结构体
class CacheReq {
  // 缓存key
  final String key;
  // 缓存数据
  final String value;
  // 过期时间s
  final String expire;

  //构造方法
  CacheReq({
    required this.key,
    required this.value,
    required this.expire,
  });

  //通过JSON构造
  CacheReq.fromJson(Map<String, dynamic> json)
      : key = json["key"],
        value = json["value"],
        expire = json["expire"];

  //通过动态数组解析成List
  static List<CacheReq> fromList(List<Map<String, dynamic>> list) {
    List<CacheReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(CacheReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["key"] = key;
    json["value"] = value;
    json["expire"] = expire;
    return json;
  }
}

class ThingAttrReq {
  // 唯一ID
  final String id;
  //类别Id
  final String specId;
  //类别代码
  final String specCode;
  //特性Id
  final String attrId;
  //特性代码
  final String attrCode;
  //关系Id
  final String relationId;
  //是否公开
  final bool public;
  // 分页
  final PageRequest? page;

  //构造方法
  ThingAttrReq({
    required this.id,
    required this.specId,
    required this.specCode,
    required this.attrId,
    required this.attrCode,
    required this.relationId,
    required this.public,
    required this.page,
  });

  //通过JSON构造
  ThingAttrReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        specId = json["specId"],
        specCode = json["specCode"],
        attrId = json["attrId"],
        attrCode = json["attrCode"],
        relationId = json["relationId"],
        public = json["public"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<ThingAttrReq> fromList(List<Map<String, dynamic>> list) {
    List<ThingAttrReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ThingAttrReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["specId"] = specId;
    json["specCode"] = specCode;
    json["attrId"] = attrId;
    json["attrCode"] = attrCode;
    json["relationId"] = relationId;
    json["public"] = public;
    json["page"] = page?.toJson();
    return json;
  }
}

class IDWithBelongReq {
  // 唯一ID
  final String id;
  // 归属ID
  final String belongId;

  //构造方法
  IDWithBelongReq({
    required this.id,
    required this.belongId,
  });

  //通过JSON构造
  IDWithBelongReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        belongId = json["belongId"];

  //通过动态数组解析成List
  static List<IDWithBelongReq> fromList(List<Map<String, dynamic>> list) {
    List<IDWithBelongReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDWithBelongReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["belongId"] = belongId;
    return json;
  }
}

class IDWithBelongPageReq {
  // 唯一ID
  final String id;
  // 归属ID
  final String belongId;
  // 分页
  final PageRequest? page;

  //构造方法
  IDWithBelongPageReq({
    required this.id,
    required this.belongId,
    required this.page,
  });

  //通过JSON构造
  IDWithBelongPageReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        belongId = json["belongId"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDWithBelongPageReq> fromList(List<Map<String, dynamic>> list) {
    List<IDWithBelongPageReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDWithBelongPageReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["belongId"] = belongId;
    json["page"] = page?.toJson();
    return json;
  }
}

class IDStatusPageReq {
  // 唯一ID
  final String id;
  // 状态
  final int status;
  // 分页
  final PageRequest? page;

  //构造方法
  IDStatusPageReq({
    required this.id,
    required this.status,
    required this.page,
  });

  //通过JSON构造
  IDStatusPageReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDStatusPageReq> fromList(List<Map<String, dynamic>> list) {
    List<IDStatusPageReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDStatusPageReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["status"] = status;
    json["page"] = page?.toJson();
    return json;
  }
}

class IDBelongTargetReq {
  // 唯一ID
  final String id;
  // 类型
  final String targetType;
  // 分页
  final PageRequest? page;

  //构造方法
  IDBelongTargetReq({
    required this.id,
    required this.targetType,
    required this.page,
  });

  //通过JSON构造
  IDBelongTargetReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        targetType = json["targetType"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDBelongTargetReq> fromList(List<Map<String, dynamic>> list) {
    List<IDBelongTargetReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDBelongTargetReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["targetType"] = targetType;
    json["page"] = page?.toJson();
    return json;
  }
}

class IDReqSubModel {
  // 唯一ID
  final String id;
  // 实体类型
  final List<String> typeNames;
  // 子节点类型
  final List<String> subTypeNames;
  // 分页
  final PageRequest? page;

  //构造方法
  IDReqSubModel({
    required this.id,
    required this.typeNames,
    required this.subTypeNames,
    required this.page,
  });

  //通过JSON构造
  IDReqSubModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        typeNames = json["typeNames"],
        subTypeNames = json["subTypeNames"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDReqSubModel> fromList(List<Map<String, dynamic>> list) {
    List<IDReqSubModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDReqSubModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["typeNames"] = typeNames;
    json["subTypeNames"] = subTypeNames;
    json["page"] = page?.toJson();
    return json;
  }
}

class IDReqJoinedModel {
  // 唯一ID
  final String id;
  // 实体类型
  final String typeName;
  // 加入的节点类型
  final List<String> JoinTypeNames;
  // 工作空间ID
  final String spaceId;
  // 分页
  final PageRequest? page;

  //构造方法
  IDReqJoinedModel({
    required this.id,
    required this.typeName,
    required this.JoinTypeNames,
    required this.spaceId,
    required this.page,
  });

  //通过JSON构造
  IDReqJoinedModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        typeName = json["typeName"],
        JoinTypeNames = json["JoinTypeNames"],
        spaceId = json["spaceId"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<IDReqJoinedModel> fromList(List<Map<String, dynamic>> list) {
    List<IDReqJoinedModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IDReqJoinedModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["typeName"] = typeName;
    json["JoinTypeNames"] = JoinTypeNames;
    json["spaceId"] = spaceId;
    json["page"] = page?.toJson();
    return json;
  }
}

class ChatsReqModel {
  // 工作空间ID
  final String spaceId;
  // 群组名称
  final String cohortName;
  // 空间类型名称
  final String spaceTypeName;

  //构造方法
  ChatsReqModel({
    required this.spaceId,
    required this.cohortName,
    required this.spaceTypeName,
  });

  //通过JSON构造
  ChatsReqModel.fromJson(Map<String, dynamic> json)
      : spaceId = json["spaceId"],
        cohortName = json["cohortName"],
        spaceTypeName = json["spaceTypeName"];

  //通过动态数组解析成List
  static List<ChatsReqModel> fromList(List<Map<String, dynamic>> list) {
    List<ChatsReqModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ChatsReqModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["spaceId"] = spaceId;
    json["cohortName"] = cohortName;
    json["spaceTypeName"] = spaceTypeName;
    return json;
  }
}

class PageRequest {
  // 偏移量
  final int offset;
  // 最大数量
  final int limit;
  //过滤条件
  final String filter;

  //构造方法
  PageRequest({
    required this.offset,
    required this.limit,
    required this.filter,
  });

  //通过JSON构造
  PageRequest.fromJson(Map<String, dynamic> json)
      : offset = json["offset"],
        limit = json["limit"],
        filter = json["filter"];

  //通过动态数组解析成List
  static List<PageRequest> fromList(List<Map<String, dynamic>> list) {
    List<PageRequest> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(PageRequest.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["offset"] = offset;
    json["limit"] = limit;
    json["filter"] = filter;
    return json;
  }
}

class RecursiveReqModel {
  // 唯一ID
  final String id;
  // 实体类型
  final String typeName;
  // 字节点类型
  final List<String> subNodeTypeNames;

  //构造方法
  RecursiveReqModel({
    required this.id,
    required this.typeName,
    required this.subNodeTypeNames,
  });

  //通过JSON构造
  RecursiveReqModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        typeName = json["typeName"],
        subNodeTypeNames = json["subNodeTypeNames"];

  //通过动态数组解析成List
  static List<RecursiveReqModel> fromList(List<Map<String, dynamic>> list) {
    List<RecursiveReqModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(RecursiveReqModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["typeName"] = typeName;
    json["subNodeTypeNames"] = subNodeTypeNames;
    return json;
  }
}

class IdWithNameModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;

  //构造方法
  IdWithNameModel({
    required this.id,
    required this.name,
  });

  //通过JSON构造
  IdWithNameModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];

  //通过动态数组解析成List
  static List<IdWithNameModel> fromList(List<Map<String, dynamic>> list) {
    List<IdWithNameModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdWithNameModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    return json;
  }
}

class IdNameArray {
  // 唯一ID数组
  final List<IdWithNameModel>? result;

  //构造方法
  IdNameArray({
    required this.result,
  });

  //通过JSON构造
  IdNameArray.fromJson(Map<String, dynamic> json)
      : result = IdWithNameModel.fromList(json["result"]);

  //通过动态数组解析成List
  static List<IdNameArray> fromList(List<Map<String, dynamic>> list) {
    List<IdNameArray> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdNameArray.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["result"] = result;
    return json;
  }
}

class ApprovalModel {
  // 唯一ID
  final String id;
  // 状态
  final int status;

  //构造方法
  ApprovalModel({
    required this.id,
    required this.status,
  });

  //通过JSON构造
  ApprovalModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"];

  //通过动态数组解析成List
  static List<ApprovalModel> fromList(List<Map<String, dynamic>> list) {
    List<ApprovalModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ApprovalModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["status"] = status;
    return json;
  }
}

class DictModel {
  // 唯一ID
  late String id;
  // 名称
  final String name;
  // 编号
  late String code;
  // 公开的
  final bool public;
  // 创建组织/个人
  final String belongId;
  // 类别Id
  late String speciesId;
  // 备注
  final String remark;

  //构造方法
  DictModel({
    required this.name,
    required this.public,
    required this.belongId,
    required this.speciesId,
    required this.remark,
  });

  //通过JSON构造
  DictModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        public = json["public"],
        belongId = json["belongId"],
        speciesId = json["speciesId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<DictModel> fromList(List<Map<String, dynamic>> list) {
    List<DictModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(DictModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["public"] = public;
    json["belongId"] = belongId;
    json["speciesId"] = speciesId;
    json["remark"] = remark;
    return json;
  }
}

class DictItemModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String value;
  // 公开的
  final bool public;
  // 创建组织/个人
  final String belongId;
  // 备注
  late String dictId;

  //构造方法
  DictItemModel({
    required this.id,
    required this.name,
    required this.value,
    required this.public,
    required this.belongId,
  });

  //通过JSON构造
  DictItemModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        value = json["value"],
        public = json["public"],
        belongId = json["belongId"],
        dictId = json["dictId"];

  //通过动态数组解析成List
  static List<DictItemModel> fromList(List<Map<String, dynamic>> list) {
    List<DictItemModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(DictItemModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["value"] = value;
    json["public"] = public;
    json["belongId"] = belongId;
    json["dictId"] = dictId;
    return json;
  }
}

class OperationModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 公开的
  final bool public;
  // 创建组织/个人
  final String belongId;
  // 类别Id
  late String speciesId;
  // 备注
  final String remark;

  //构造方法
  OperationModel({
    required this.id,
    required this.name,
    required this.code,
    required this.public,
    required this.belongId,
    required this.speciesId,
    required this.remark,
  });

  //通过JSON构造
  OperationModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        public = json["public"],
        belongId = json["belongId"],
        speciesId = json["speciesId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<OperationModel> fromList(List<Map<String, dynamic>> list) {
    List<OperationModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OperationModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["public"] = public;
    json["belongId"] = belongId;
    json["speciesId"] = speciesId;
    json["remark"] = remark;
    return json;
  }
}

class OperationItemModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 规则
  final String rule;
  // 创建组织/个人
  final String belongId;
  // 业务Id
  final String operationId;
  // 备注
  final String remark;

  //构造方法
  OperationItemModel({
    required this.id,
    required this.name,
    required this.code,
    required this.rule,
    required this.belongId,
    required this.operationId,
    required this.remark,
  });

  //通过JSON构造
  OperationItemModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        rule = json["rule"],
        belongId = json["belongId"],
        operationId = json["operationId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<OperationItemModel> fromList(List<Map<String, dynamic>> list) {
    List<OperationItemModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OperationItemModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["rule"] = rule;
    json["belongId"] = belongId;
    json["operationId"] = operationId;
    json["remark"] = remark;
    return json;
  }
}

class ThingModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 链上ID
  final String chainId;
  // 创建组织/个人
  final String belongId;
  // 备注
  final String remark;

  //构造方法
  ThingModel({
    required this.id,
    required this.name,
    required this.code,
    required this.chainId,
    required this.belongId,
    required this.remark,
  });

  //通过JSON构造
  ThingModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        chainId = json["chainId"],
        belongId = json["belongId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<ThingModel> fromList(List<Map<String, dynamic>> list) {
    List<ThingModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ThingModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["chainId"] = chainId;
    json["belongId"] = belongId;
    json["remark"] = remark;
    return json;
  }
}

class SpeciesModel {
  // 唯一ID
  late String id;
  // 名称
  final String name;
  // 编号
  late String code;
  // 公开的
  final bool public;
  // 父类别ID
  late String parentId;
  // 创建组织/个人
  final String belongId;
  // 工作职权Id
  final String authId;
  // 备注
  final String remark;

  //构造方法
  SpeciesModel({
    required this.id,
    required this.name,
    required this.code,
    required this.public,
    required this.parentId,
    required this.belongId,
    required this.authId,
    required this.remark,
  });

  //通过JSON构造
  SpeciesModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        public = json["public"],
        parentId = json["parentId"],
        belongId = json["belongId"],
        authId = json["authId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<SpeciesModel> fromList(List<Map<String, dynamic>> list) {
    List<SpeciesModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(SpeciesModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["public"] = public;
    json["parentId"] = parentId;
    json["belongId"] = belongId;
    json["authId"] = authId;
    json["remark"] = remark;
    return json;
  }
}

class AttributeModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 公开的
  final bool public;
  // 值类型
  final String valueType;
  // 单位
  final String unit;
  // 选择字典的类型ID
  final String dictId;
  // 备注
  final String remark;
  // 创建组织/个人
  final String belongId;
  // 类别Id
  late String speciesId;
  // 类别代码
  late String speciesCode;
  // 工作职权Id
  final String authId;

  //构造方法
  AttributeModel({
    required this.id,
    required this.name,
    required this.code,
    required this.public,
    required this.valueType,
    required this.unit,
    required this.dictId,
    required this.remark,
    required this.belongId,
    required this.speciesId,
    required this.speciesCode,
    required this.authId,
  });

  //通过JSON构造
  AttributeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        public = json["public"],
        valueType = json["valueType"],
        unit = json["unit"],
        dictId = json["dictId"],
        remark = json["remark"],
        belongId = json["belongId"],
        speciesId = json["speciesId"],
        speciesCode = json["speciesCode"],
        authId = json["authId"];

  //通过动态数组解析成List
  static List<AttributeModel> fromList(List<Map<String, dynamic>> list) {
    List<AttributeModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(AttributeModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["public"] = public;
    json["valueType"] = valueType;
    json["unit"] = unit;
    json["dictId"] = dictId;
    json["remark"] = remark;
    json["belongId"] = belongId;
    json["speciesId"] = speciesId;
    json["speciesCode"] = speciesCode;
    json["authId"] = authId;
    return json;
  }
}

class AuthorityModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 公开的
  final bool public;
  // 父类别ID
  final String parentId;
  // 创建组织/个人
  final String belongId;
  // 备注
  final String remark;

  //构造方法
  AuthorityModel({
    required this.id,
    required this.name,
    required this.code,
    required this.public,
    required this.parentId,
    required this.belongId,
    required this.remark,
  });

  //通过JSON构造
  AuthorityModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        public = json["public"],
        parentId = json["parentId"],
        belongId = json["belongId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<AuthorityModel> fromList(List<Map<String, dynamic>> list) {
    List<AuthorityModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(AuthorityModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["public"] = public;
    json["parentId"] = parentId;
    json["belongId"] = belongId;
    json["remark"] = remark;
    return json;
  }
}

class IdentityModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 职权Id
  final String authId;
  // 创建组织/个人
  late String belongId;
  // 备注
  final String remark;

  //构造方法
  IdentityModel({
    required this.id,
    required this.name,
    required this.code,
    required this.authId,
    required this.belongId,
    required this.remark,
  });

  //通过JSON构造
  IdentityModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        authId = json["authId"],
        belongId = json["belongId"],
        remark = json["remark"];

  //通过动态数组解析成List
  static List<IdentityModel> fromList(List<Map<String, dynamic>> list) {
    List<IdentityModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(IdentityModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["authId"] = authId;
    json["belongId"] = belongId;
    json["remark"] = remark;
    return json;
  }
}

class TargetModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 类型名
  late String typeName;
  // 头像
  final String avatar;
  // 创建组织/个人
  final String belongId;
  // 团队名称
  late String teamName;
  // 团队代号
  late String teamCode;
  // 团队备注
  late String teamRemark;

  //构造方法
  TargetModel({
    required this.id,
    required this.name,
    required this.code,
    required this.typeName,
    required this.avatar,
    required this.belongId,
    required this.teamName,
    required this.teamCode,
    required this.teamRemark,
  });

  //通过JSON构造
  TargetModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        typeName = json["typeName"],
        avatar = json["avatar"],
        belongId = json["belongId"],
        teamName = json["teamName"],
        teamCode = json["teamCode"],
        teamRemark = json["teamRemark"];

  //通过动态数组解析成List
  static List<TargetModel> fromList(List<Map<String, dynamic>> list) {
    List<TargetModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(TargetModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["typeName"] = typeName;
    json["avatar"] = avatar;
    json["belongId"] = belongId;
    json["teamName"] = teamName;
    json["teamCode"] = teamCode;
    json["teamRemark"] = teamRemark;
    return json;
  }
}

class RuleStdModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 组织/个人ID
  final String targetId;
  // 类型
  final String typeName;
  // 备注
  final String remark;
  // 标准
  final List<String> attrs;

  //构造方法
  RuleStdModel({
    required this.id,
    required this.name,
    required this.code,
    required this.targetId,
    required this.typeName,
    required this.remark,
    required this.attrs,
  });

  //通过JSON构造
  RuleStdModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        targetId = json["targetId"],
        typeName = json["typeName"],
        remark = json["remark"],
        attrs = json["attrs"];

  //通过动态数组解析成List
  static List<RuleStdModel> fromList(List<Map<String, dynamic>> list) {
    List<RuleStdModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(RuleStdModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["targetId"] = targetId;
    json["typeName"] = typeName;
    json["remark"] = remark;
    json["attrs"] = attrs;
    return json;
  }
}

class LogModel {
  // 唯一ID
  final String id;
  //类型
  final String type;
  //模块
  final String module;
  //内容
  final String content;

  //构造方法
  LogModel({
    required this.id,
    required this.type,
    required this.module,
    required this.content,
  });

  //通过JSON构造
  LogModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        type = json["type"],
        module = json["module"],
        content = json["content"];

  //通过动态数组解析成List
  static List<LogModel> fromList(List<Map<String, dynamic>> list) {
    List<LogModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(LogModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["type"] = type;
    json["module"] = module;
    json["content"] = content;
    return json;
  }
}

class MarketModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 创建组织/个人
  final String belongId;
  // 监管组织/个人
  final String samrId;
  // 备注
  final String remark;
  // 是否公开
  final bool public;
  // 照片
  final String photo;

  //构造方法
  MarketModel({
    required this.id,
    required this.name,
    required this.code,
    required this.belongId,
    required this.samrId,
    required this.remark,
    required this.public,
    required this.photo,
  });

  //通过JSON构造
  MarketModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        belongId = json["belongId"],
        samrId = json["samrId"],
        remark = json["remark"],
        public = json["public"],
        photo = json["photo"];

  //通过动态数组解析成List
  static List<MarketModel> fromList(List<Map<String, dynamic>> list) {
    List<MarketModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(MarketModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["belongId"] = belongId;
    json["samrId"] = samrId;
    json["remark"] = remark;
    json["public"] = public;
    json["photo"] = photo;
    return json;
  }
}

class MerchandiseModel {
  // 唯一ID
  final String id;
  // 标题
  final String caption;
  // 产品ID
  final String productId;
  // 单价
  final double price;
  // 出售权属
  final String sellAuth;
  // 商品出售市场ID
  final String marketId;
  // 描述信息
  final String information;
  // 有效期
  final String days;

  //构造方法
  MerchandiseModel({
    required this.id,
    required this.caption,
    required this.productId,
    required this.price,
    required this.sellAuth,
    required this.marketId,
    required this.information,
    required this.days,
  });

  //通过JSON构造
  MerchandiseModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        caption = json["caption"],
        productId = json["productId"],
        price = json["price"],
        sellAuth = json["sellAuth"],
        marketId = json["marketId"],
        information = json["information"],
        days = json["days"];

  //通过动态数组解析成List
  static List<MerchandiseModel> fromList(List<Map<String, dynamic>> list) {
    List<MerchandiseModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(MerchandiseModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["caption"] = caption;
    json["productId"] = productId;
    json["price"] = price;
    json["sellAuth"] = sellAuth;
    json["marketId"] = marketId;
    json["information"] = information;
    json["days"] = days;
    return json;
  }
}

class OrderModel {
  // 唯一ID
  final String id;
  // 存证ID
  final String nftId;
  // 名称
  final String name;
  // 编号
  final String code;
  // 创建组织/个人
  final String belongId;
  // 商品ID
  final List<String> merchandiseIds;

  //构造方法
  OrderModel({
    required this.id,
    required this.nftId,
    required this.name,
    required this.code,
    required this.belongId,
    required this.merchandiseIds,
  });

  //通过JSON构造
  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nftId = json["nftId"],
        name = json["name"],
        code = json["code"],
        belongId = json["belongId"],
        merchandiseIds = json["merchandiseIds"];

  //通过动态数组解析成List
  static List<OrderModel> fromList(List<Map<String, dynamic>> list) {
    List<OrderModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OrderModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["nftId"] = nftId;
    json["name"] = name;
    json["code"] = code;
    json["belongId"] = belongId;
    json["merchandiseIds"] = merchandiseIds;
    return json;
  }
}

class OrderModelByStags {
  // 唯一ID
  final String id;
  // 存证ID
  final String nftId;
  // 名称
  final String name;
  // 编号
  final String code;
  // 创建组织/个人
  final String belongId;
  // 暂存区ID集合
  final List<String> stagingIds;

  //构造方法
  OrderModelByStags({
    required this.id,
    required this.nftId,
    required this.name,
    required this.code,
    required this.belongId,
    required this.stagingIds,
  });

  //通过JSON构造
  OrderModelByStags.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        nftId = json["nftId"],
        name = json["name"],
        code = json["code"],
        belongId = json["belongId"],
        stagingIds = json["stagingIds"];

  //通过动态数组解析成List
  static List<OrderModelByStags> fromList(List<Map<String, dynamic>> list) {
    List<OrderModelByStags> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OrderModelByStags.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["nftId"] = nftId;
    json["name"] = name;
    json["code"] = code;
    json["belongId"] = belongId;
    json["stagingIds"] = stagingIds;
    return json;
  }
}

class OrderDetailModel {
  // 唯一ID
  final String id;
  // 订单
  final String caption;
  // 商品
  final String days;
  // 单价
  // 卖方ID
  final int status;
  // 空间ID
  final String spaceId;

  //构造方法
  OrderDetailModel({
    required this.id,
    required this.caption,
    required this.days,
    required this.status,
    required this.spaceId,
  });

  //通过JSON构造
  OrderDetailModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        caption = json["caption"],
        days = json["days"],
        status = json["status"],
        spaceId = json["spaceId"];

  //通过动态数组解析成List
  static List<OrderDetailModel> fromList(List<Map<String, dynamic>> list) {
    List<OrderDetailModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OrderDetailModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["caption"] = caption;
    json["days"] = days;
    json["status"] = status;
    json["spaceId"] = spaceId;
    return json;
  }
}

class OrderPayModel {
  // 唯一ID
  final String id;
  // 订单
  final String orderDetailId;
  // 支付总价
  final double price;
  // 支付方式
  final String paymentType;

  //构造方法
  OrderPayModel({
    required this.id,
    required this.orderDetailId,
    required this.price,
    required this.paymentType,
  });

  //通过JSON构造
  OrderPayModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        orderDetailId = json["orderDetailId"],
        price = json["price"],
        paymentType = json["paymentType"];

  //通过动态数组解析成List
  static List<OrderPayModel> fromList(List<Map<String, dynamic>> list) {
    List<OrderPayModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(OrderPayModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["orderDetailId"] = orderDetailId;
    json["price"] = price;
    json["paymentType"] = paymentType;
    return json;
  }
}

class ProductModel {
  // 唯一ID
  final String id;
  // 名称
  final String name;
  // 编号
  final String code;
  // 元数据Id
  final String thingId;
  // 产品类型名
  final String typeName;
  // 备注
  final String remark;
  // 所属ID
  final String belongId;
  // 照片
  final String photo;
  // 资源列
  final List<ResourceModel>? resources;

  //构造方法
  ProductModel({
    required this.id,
    required this.name,
    required this.code,
    required this.thingId,
    required this.typeName,
    required this.remark,
    required this.belongId,
    required this.photo,
    required this.resources,
  });

  //通过JSON构造
  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        code = json["code"],
        thingId = json["thingId"],
        typeName = json["typeName"],
        remark = json["remark"],
        belongId = json["belongId"],
        photo = json["photo"],
        resources = ResourceModel.fromList(json["resources"]);

  //通过动态数组解析成List
  static List<ProductModel> fromList(List<Map<String, dynamic>> list) {
    List<ProductModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ProductModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["code"] = code;
    json["thingId"] = thingId;
    json["typeName"] = typeName;
    json["remark"] = remark;
    json["belongId"] = belongId;
    json["photo"] = photo;
    json["resources"] = resources;
    return json;
  }
}

class ResourceModel {
  // 唯一ID
  final String id;
  // 编号
  final String code;
  // 名称
  final String name;
  // 产品ID
  final String productId;
  // 访问私钥
  final String privateKey;
  // 入口地址
  final String link;
  // 流程项
  final String flows;
  // 组件
  final String components;

  //构造方法
  ResourceModel({
    required this.id,
    required this.code,
    required this.name,
    required this.productId,
    required this.privateKey,
    required this.link,
    required this.flows,
    required this.components,
  });

  //通过JSON构造
  ResourceModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        code = json["code"],
        name = json["name"],
        productId = json["productId"],
        privateKey = json["privateKey"],
        link = json["link"],
        flows = json["flows"],
        components = json["components"];

  //通过动态数组解析成List
  static List<ResourceModel> fromList(List<Map<String, dynamic>> list) {
    List<ResourceModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ResourceModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["code"] = code;
    json["name"] = name;
    json["productId"] = productId;
    json["privateKey"] = privateKey;
    json["link"] = link;
    json["flows"] = flows;
    json["components"] = components;
    return json;
  }
}

class StagingModel {
  // 唯一ID
  final String id;
  // 商品
  final String merchandiseId;
  // 创建组织/个人
  final String belongId;

  //构造方法
  StagingModel({
    required this.id,
    required this.merchandiseId,
    required this.belongId,
  });

  //通过JSON构造
  StagingModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        merchandiseId = json["merchandiseId"],
        belongId = json["belongId"];

  //通过动态数组解析成List
  static List<StagingModel> fromList(List<Map<String, dynamic>> list) {
    List<StagingModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(StagingModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["merchandiseId"] = merchandiseId;
    json["belongId"] = belongId;
    return json;
  }
}

class ThingSpeciesModel {
  // 物的唯一ID
  final String id;
  // 赋予的类别Id
  final String speciesId;
  // 赋予的类别代码
  final String speciesCode;

  //构造方法
  ThingSpeciesModel({
    required this.id,
    required this.speciesId,
    required this.speciesCode,
  });

  //通过JSON构造
  ThingSpeciesModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        speciesId = json["speciesId"],
        speciesCode = json["speciesCode"];

  //通过动态数组解析成List
  static List<ThingSpeciesModel> fromList(List<Map<String, dynamic>> list) {
    List<ThingSpeciesModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ThingSpeciesModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["speciesId"] = speciesId;
    json["speciesCode"] = speciesCode;
    return json;
  }
}

class ThingAttrModel {
  // 物的唯一ID
  final String id;
  // 基于关系ID的度量
  final String relationId;
  // 类别Id
  final String speciesId;
  //类别代码
  final String specCode;
  //特性Id
  final String attrId;
  //特性代码
  final String attrCode;
  // 字符串类型的值
  final String strValue;
  // 数值类型的值
  final double numValue;

  //构造方法
  ThingAttrModel({
    required this.id,
    required this.relationId,
    required this.speciesId,
    required this.specCode,
    required this.attrId,
    required this.attrCode,
    required this.strValue,
    required this.numValue,
  });

  //通过JSON构造
  ThingAttrModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        relationId = json["relationId"],
        speciesId = json["speciesId"],
        specCode = json["specCode"],
        attrId = json["attrId"],
        attrCode = json["attrCode"],
        strValue = json["strValue"],
        numValue = json["numValue"];

  //通过动态数组解析成List
  static List<ThingAttrModel> fromList(List<Map<String, dynamic>> list) {
    List<ThingAttrModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ThingAttrModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["relationId"] = relationId;
    json["speciesId"] = speciesId;
    json["specCode"] = specCode;
    json["attrId"] = attrId;
    json["attrCode"] = attrCode;
    json["strValue"] = strValue;
    json["numValue"] = numValue;
    return json;
  }
}

class JoinTeamModel {
  // 团队ID
  final String id;
  // 团队类型
  final String teamType;
  // 待加入团队组织/个人ID
  final String targetId;
  // 待拉入组织/个人类型
  final String targetType;

  //构造方法
  JoinTeamModel({
    required this.id,
    required this.teamType,
    required this.targetId,
    required this.targetType,
  });

  //通过JSON构造
  JoinTeamModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        teamType = json["teamType"],
        targetId = json["targetId"],
        targetType = json["targetType"];

  //通过动态数组解析成List
  static List<JoinTeamModel> fromList(List<Map<String, dynamic>> list) {
    List<JoinTeamModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(JoinTeamModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["teamType"] = teamType;
    json["targetId"] = targetId;
    json["targetType"] = targetType;
    return json;
  }
}

class ExitTeamModel {
  // 团队ID
  final String id;
  // 团队类型
  final List<String> teamTypes;
  // 待退出团队组织/个人ID
  final String targetId;
  // 待退出组织/个人类型
  final String targetType;

  //构造方法
  ExitTeamModel({
    required this.id,
    required this.teamTypes,
    required this.targetId,
    required this.targetType,
  });

  //通过JSON构造
  ExitTeamModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        teamTypes = json["teamTypes"],
        targetId = json["targetId"],
        targetType = json["targetType"];

  //通过动态数组解析成List
  static List<ExitTeamModel> fromList(List<Map<String, dynamic>> list) {
    List<ExitTeamModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ExitTeamModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["teamTypes"] = teamTypes;
    json["targetId"] = targetId;
    json["targetType"] = targetType;
    return json;
  }
}

class TeamPullModel {
  // 团队ID
  final String id;
  // 团队类型
  final List<String> teamTypes;
  // 待拉入的组织/个人ID集合
  final List<String> targetIds;
  // 待拉入组织/个人类型
  final String targetType;

  //构造方法
  TeamPullModel({
    required this.id,
    required this.teamTypes,
    required this.targetIds,
    required this.targetType,
  });

  //通过JSON构造
  TeamPullModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        teamTypes = json["teamTypes"],
        targetIds = json["targetIds"],
        targetType = json["targetType"];

  //通过动态数组解析成List
  static List<TeamPullModel> fromList(List<Map<String, dynamic>> list) {
    List<TeamPullModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(TeamPullModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["teamTypes"] = teamTypes;
    json["targetIds"] = targetIds;
    json["targetType"] = targetType;
    return json;
  }
}

class CreateOrderByStagingModel {
  // 订单名称
  final String name;
  // 订单编号
  final String code;
  // 所属ID
  final String belongId;
  // 暂存区ID
  final List<String> StagingIds;

  //构造方法
  CreateOrderByStagingModel({
    required this.name,
    required this.code,
    required this.belongId,
    required this.StagingIds,
  });

  //通过JSON构造
  CreateOrderByStagingModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        code = json["code"],
        belongId = json["belongId"],
        StagingIds = json["StagingIds"];

  //通过动态数组解析成List
  static List<CreateOrderByStagingModel> fromList(
      List<Map<String, dynamic>> list) {
    List<CreateOrderByStagingModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(CreateOrderByStagingModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["code"] = code;
    json["belongId"] = belongId;
    json["StagingIds"] = StagingIds;
    return json;
  }
}

class GiveIdentityModel {
  // 身份ID
  final String id;
  // 人员ID
  final List<String> targetIds;

  //构造方法
  GiveIdentityModel({
    required this.id,
    required this.targetIds,
  });

  //通过JSON构造
  GiveIdentityModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        targetIds = json["targetIds"];

  //通过动态数组解析成List
  static List<GiveIdentityModel> fromList(List<Map<String, dynamic>> list) {
    List<GiveIdentityModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(GiveIdentityModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["targetIds"] = targetIds;
    return json;
  }
}

class SearchExtendReq {
  // 源ID
  final String sourceId;
  // 源类型
  final String sourceType;
  // 分配对象类型
  final String destType;
  // 归属ID
  final String spaceId;
  // TeamID
  final String teamId;

  //构造方法
  SearchExtendReq({
    required this.sourceId,
    required this.sourceType,
    required this.destType,
    required this.spaceId,
    required this.teamId,
  });

  //通过JSON构造
  SearchExtendReq.fromJson(Map<String, dynamic> json)
      : sourceId = json["sourceId"],
        sourceType = json["sourceType"],
        destType = json["destType"],
        spaceId = json["spaceId"],
        teamId = json["teamId"];

  //通过动态数组解析成List
  static List<SearchExtendReq> fromList(List<Map<String, dynamic>> list) {
    List<SearchExtendReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(SearchExtendReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["sourceId"] = sourceId;
    json["sourceType"] = sourceType;
    json["destType"] = destType;
    json["spaceId"] = spaceId;
    json["teamId"] = teamId;
    return json;
  }
}

class MarketPullModel {
  // 团队ID
  final String marketId;
  // 待拉入的组织/个人ID集合
  final List<String> targetIds;
  // 待拉入组织/个人类型
  final List<String> typeNames;

  //构造方法
  MarketPullModel({
    required this.marketId,
    required this.targetIds,
    required this.typeNames,
  });

  //通过JSON构造
  MarketPullModel.fromJson(Map<String, dynamic> json)
      : marketId = json["marketId"],
        targetIds = json["targetIds"],
        typeNames = json["typeNames"];

  //通过动态数组解析成List
  static List<MarketPullModel> fromList(List<Map<String, dynamic>> list) {
    List<MarketPullModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(MarketPullModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["marketId"] = marketId;
    json["targetIds"] = targetIds;
    json["typeNames"] = typeNames;
    return json;
  }
}

class UsefulProductReq {
  // 工作空间ID
  final String spaceId;
  // 拓展目标所属对象类型
  final List<String> typeNames;

  //构造方法
  UsefulProductReq({
    required this.spaceId,
    required this.typeNames,
  });

  //通过JSON构造
  UsefulProductReq.fromJson(Map<String, dynamic> json)
      : spaceId = json["spaceId"],
        typeNames = json["typeNames"];

  //通过动态数组解析成List
  static List<UsefulProductReq> fromList(List<Map<String, dynamic>> list) {
    List<UsefulProductReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(UsefulProductReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["spaceId"] = spaceId;
    json["typeNames"] = typeNames;
    return json;
  }
}

class UsefulResourceReq {
  // 工作空间ID
  final String spaceId;
  // 产品ID
  final String productId;
  // 拓展目标所属对象类型
  final List<String> typeNames;

  //构造方法
  UsefulResourceReq({
    required this.spaceId,
    required this.productId,
    required this.typeNames,
  });

  //通过JSON构造
  UsefulResourceReq.fromJson(Map<String, dynamic> json)
      : spaceId = json["spaceId"],
        productId = json["productId"],
        typeNames = json["typeNames"];

  //通过动态数组解析成List
  static List<UsefulResourceReq> fromList(List<Map<String, dynamic>> list) {
    List<UsefulResourceReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(UsefulResourceReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["spaceId"] = spaceId;
    json["productId"] = productId;
    json["typeNames"] = typeNames;
    return json;
  }
}

class SourceExtendModel {
  // 源对象ID
  final String sourceId;
  // 源对象类型
  final String sourceType;
  // 目标对象类型
  final String destType;
  // 目标对象ID
  final List<String> destIds;
  // 组织ID
  final String teamId;
  // 归属ID
  final String spaceId;

  //构造方法
  SourceExtendModel({
    required this.sourceId,
    required this.sourceType,
    required this.destType,
    required this.destIds,
    required this.teamId,
    required this.spaceId,
  });

  //通过JSON构造
  SourceExtendModel.fromJson(Map<String, dynamic> json)
      : sourceId = json["sourceId"],
        sourceType = json["sourceType"],
        destType = json["destType"],
        destIds = json["destIds"],
        teamId = json["teamId"],
        spaceId = json["spaceId"];

  //通过动态数组解析成List
  static List<SourceExtendModel> fromList(List<Map<String, dynamic>> list) {
    List<SourceExtendModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(SourceExtendModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["sourceId"] = sourceId;
    json["sourceType"] = sourceType;
    json["destType"] = destType;
    json["destIds"] = destIds;
    json["teamId"] = teamId;
    json["spaceId"] = spaceId;
    return json;
  }
}

class NameTypeModel {
  // 名称
  final String name;
  // 类型名
  final List<String> typeNames;
  // 分页
  final PageRequest? page;

  //构造方法
  NameTypeModel({
    required this.name,
    required this.typeNames,
    required this.page,
  });

  //通过JSON构造
  NameTypeModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        typeNames = json["typeNames"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<NameTypeModel> fromList(List<Map<String, dynamic>> list) {
    List<NameTypeModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(NameTypeModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["typeNames"] = typeNames;
    json["page"] = page?.toJson();
    return json;
  }
}

class NameCodeModel {
  // 名称
  final String name;
  // 代码
  final String code;
  // 分页
  final PageRequest? page;

  //构造方法
  NameCodeModel({
    required this.name,
    required this.code,
    required this.page,
  });

  //通过JSON构造
  NameCodeModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        code = json["code"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<NameCodeModel> fromList(List<Map<String, dynamic>> list) {
    List<NameCodeModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(NameCodeModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["code"] = code;
    json["page"] = page?.toJson();
    return json;
  }
}

class ImMsgModel {
  // 工作空间ID
  final String spaceId;
  // 发起方Id
  final String fromId;
  // 接收方Id
  final String toId;
  // 消息类型
  final String msgType;
  // 消息体
  final String msgBody;

  //构造方法
  ImMsgModel({
    required this.spaceId,
    required this.fromId,
    required this.toId,
    required this.msgType,
    required this.msgBody,
  });

  //通过JSON构造
  ImMsgModel.fromJson(Map<String, dynamic> json)
      : spaceId = json["spaceId"],
        fromId = json["fromId"],
        toId = json["toId"],
        msgType = json["msgType"],
        msgBody = json["msgBody"];

  //通过动态数组解析成List
  static List<ImMsgModel> fromList(List<Map<String, dynamic>> list) {
    List<ImMsgModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ImMsgModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["spaceId"] = spaceId;
    json["fromId"] = fromId;
    json["toId"] = toId;
    json["msgType"] = msgType;
    json["msgBody"] = msgBody;
    return json;
  }
}

class ChatResponse {
  // 会话分组
  final List<GroupChatModel>? groups;

  //构造方法
  ChatResponse({
    required this.groups,
  });

  //通过JSON构造
  ChatResponse.fromJson(Map<String, dynamic> json)
      : groups = GroupChatModel.fromList(json["groups"]);

  //通过动态数组解析成List
  static List<ChatResponse> fromList(List<Map<String, dynamic>> list) {
    List<ChatResponse> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ChatResponse.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["groups"] = groups;
    return json;
  }
}

class GroupChatModel {
  // 分组ID
  final String id;
  // 名称
  final String name;
  // 会话
  final List<ChatModel>? chats;

  //构造方法
  GroupChatModel({
    required this.id,
    required this.name,
    required this.chats,
  });

  //通过JSON构造
  GroupChatModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        chats = ChatModel.fromList(json["chats"]);

  //通过动态数组解析成List
  static List<GroupChatModel> fromList(List<Map<String, dynamic>> list) {
    List<GroupChatModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(GroupChatModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["chats"] = chats;
    return json;
  }
}

class ChatModel {
  // 会话ID
  final String id;
  // 名称
  final String name;
  // 头像
  final String photo;
  // 标签
  final String label;
  // 备注
  final String remark;
  // 类型名称
  final String typeName;
  // 消息体
  final String msgType;
  // 消息体
  final String msgBody;
  // 消息时间
  final String msgTime;

  //构造方法
  ChatModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.label,
    required this.remark,
    required this.typeName,
    required this.msgType,
    required this.msgBody,
    required this.msgTime,
  });

  //通过JSON构造
  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        photo = json["photo"],
        label = json["label"],
        remark = json["remark"],
        typeName = json["typeName"],
        msgType = json["msgType"],
        msgBody = json["msgBody"],
        msgTime = json["msgTime"];

  //通过动态数组解析成List
  static List<ChatModel> fromList(List<Map<String, dynamic>> list) {
    List<ChatModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ChatModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["name"] = name;
    json["photo"] = photo;
    json["label"] = label;
    json["remark"] = remark;
    json["typeName"] = typeName;
    json["msgType"] = msgType;
    json["msgBody"] = msgBody;
    json["msgTime"] = msgTime;
    return json;
  }
}

class FlowInstanceModel {
  // 应用Id
  final String productId;
  // 功能标识编号
  final String functionCode;
  // 空间Id
  final String SpaceId;
  // 展示内容
  final String content;
  // 内容类型
  final String contentType;
  // 单数据内容
  final String data;
  // 标题
  final String title;
  // 回调地址
  final String hook;

  //构造方法
  FlowInstanceModel({
    required this.productId,
    required this.functionCode,
    required this.SpaceId,
    required this.content,
    required this.contentType,
    required this.data,
    required this.title,
    required this.hook,
  });

  //通过JSON构造
  FlowInstanceModel.fromJson(Map<String, dynamic> json)
      : productId = json["productId"],
        functionCode = json["functionCode"],
        SpaceId = json["SpaceId"],
        content = json["content"],
        contentType = json["contentType"],
        data = json["data"],
        title = json["title"],
        hook = json["hook"];

  //通过动态数组解析成List
  static List<FlowInstanceModel> fromList(List<Map<String, dynamic>> list) {
    List<FlowInstanceModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(FlowInstanceModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["productId"] = productId;
    json["functionCode"] = functionCode;
    json["SpaceId"] = SpaceId;
    json["content"] = content;
    json["contentType"] = contentType;
    json["data"] = data;
    json["title"] = title;
    json["hook"] = hook;
    return json;
  }
}

class FlowRelationModel {
  //流程定义Id
  final String defineId;
  // 应用Id
  final String productId;
  // 功能标识编号
  final String functionCode;
  // 空间Id
  final String spaceId;

  //构造方法
  FlowRelationModel({
    required this.defineId,
    required this.productId,
    required this.functionCode,
    required this.spaceId,
  });

  //通过JSON构造
  FlowRelationModel.fromJson(Map<String, dynamic> json)
      : defineId = json["defineId"],
        productId = json["productId"],
        functionCode = json["functionCode"],
        spaceId = json["spaceId"];

  //通过动态数组解析成List
  static List<FlowRelationModel> fromList(List<Map<String, dynamic>> list) {
    List<FlowRelationModel> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(FlowRelationModel.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["defineId"] = defineId;
    json["productId"] = productId;
    json["functionCode"] = functionCode;
    json["spaceId"] = spaceId;
    return json;
  }
}

class FlowReq {
  // 应用Id
  final String productId;
  // 空间Id
  final String spaceId;
  // 状态
  final int status;
  // 分页
  final PageRequest? page;

  //构造方法
  FlowReq({
    required this.productId,
    required this.spaceId,
    required this.status,
    required this.page,
  });

  //通过JSON构造
  FlowReq.fromJson(Map<String, dynamic> json)
      : productId = json["productId"],
        spaceId = json["spaceId"],
        status = json["status"],
        page = PageRequest.fromJson(json["page"]);

  //通过动态数组解析成List
  static List<FlowReq> fromList(List<Map<String, dynamic>> list) {
    List<FlowReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(FlowReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["productId"] = productId;
    json["spaceId"] = spaceId;
    json["status"] = status;
    json["page"] = page?.toJson();
    return json;
  }
}

class ApprovalTaskReq {
  // 流程定义Id
  final String id;
  // 状态
  final int status;
  // 评论
  final String comment;

  //构造方法
  ApprovalTaskReq({
    required this.id,
    required this.status,
    required this.comment,
  });

  //通过JSON构造
  ApprovalTaskReq.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"],
        comment = json["comment"];

  //通过动态数组解析成List
  static List<ApprovalTaskReq> fromList(List<Map<String, dynamic>> list) {
    List<ApprovalTaskReq> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(ApprovalTaskReq.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["status"] = status;
    json["comment"] = comment;
    return json;
  }
}

// 文件系统项分享数据
class TargetShare {
  // 名称
  final String name;
  // 类型
  final String typeName;
  // 头像
  String? avatar;

  //构造方法
  TargetShare({
    required this.name,
    required this.typeName,
    this.avatar,
  });

  //通过JSON构造
  TargetShare.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        typeName = json["typeName"],
        avatar = json["avatar"];

  //通过动态数组解析成List
  static List<TargetShare> fromList(List<Map<String, dynamic>> list) {
    List<TargetShare> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(TargetShare.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["name"] = name;
    json["typeName"] = typeName;
    json["avatar"] = avatar;
    return json;
  }
}

// 文件系统项数据模型
class FileItemShare {
  // 大小
  final int size;
  // 名称
  final String name;
  // 共享链接
  final String shareLink;
  // 拓展名
  final String extension;
  // 缩略图
  final String thumbnail;

  FileItemShare({
    required this.size,
    required this.name,
    required this.shareLink,
    required this.extension,
    required this.thumbnail,
  });

  //通过JSON构造
  FileItemShare.fromJson(Map<String, dynamic> json)
      : size = json["size"],
        name = json["name"],
        shareLink = json["shareLink"],
        extension = json["extension"],
        thumbnail = json["thumbnail"];

  //通过动态数组解析成List
  static List<FileItemShare> fromList(List<Map<String, dynamic>> list) {
    List<FileItemShare> retList = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        retList.add(FileItemShare.fromJson(item));
      }
    }
    return retList;
  }

  //转成JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["size"] = size;
    json["name"] = name;
    json["shareLink"] = shareLink;
    json["extension"] = extension;
    json["thumbnail"] = thumbnail;
    return json;
  }
}
