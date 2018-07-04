//  This file was automatically generated and should not be edited.

import Apollo

public final class BrandsQuery: GraphQLQuery {
  public let operationDefinition =
    "query Brands {\n  brands {\n    __typename\n    ...BrandDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(BrandDetail.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("brands", type: .list(.object(Brand.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(brands: [Brand?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "brands": brands.flatMap { (value: [Brand?]) -> [ResultMap?] in value.map { (value: Brand?) -> ResultMap? in value.flatMap { (value: Brand) -> ResultMap in value.resultMap } } }])
    }

    public var brands: [Brand?]? {
      get {
        return (resultMap["brands"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Brand?] in value.map { (value: ResultMap?) -> Brand? in value.flatMap { (value: ResultMap) -> Brand in Brand(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Brand?]) -> [ResultMap?] in value.map { (value: Brand?) -> ResultMap? in value.flatMap { (value: Brand) -> ResultMap in value.resultMap } } }, forKey: "brands")
      }
    }

    public struct Brand: GraphQLSelectionSet {
      public static let possibleTypes = ["Brand"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Brand", "_id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var brandDetail: BrandDetail {
          get {
            return BrandDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class ChannelsQuery: GraphQLQuery {
  public let operationDefinition =
    "query Channels {\n  channels {\n    __typename\n    ...ChannelDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ChannelDetail.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("channels", type: .list(.object(Channel.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(channels: [Channel?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
    }

    public var channels: [Channel?]? {
      get {
        return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
      }
    }

    public struct Channel: GraphQLSelectionSet {
      public static let possibleTypes = ["Channel"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("integrationIds", type: .list(.scalar(String.self))),
        GraphQLField("memberIds", type: .list(.scalar(String.self))),
        GraphQLField("conversationCount", type: .scalar(Int.self)),
        GraphQLField("openConversationCount", type: .scalar(Int.self)),
        GraphQLField("integrations", type: .list(.object(Integration.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, description: String? = nil, integrationIds: [String?]? = nil, memberIds: [String?]? = nil, conversationCount: Int? = nil, openConversationCount: Int? = nil, integrations: [Integration?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Channel", "_id": id, "name": name, "description": description, "integrationIds": integrationIds, "memberIds": memberIds, "conversationCount": conversationCount, "openConversationCount": openConversationCount, "integrations": integrations.flatMap { (value: [Integration?]) -> [ResultMap?] in value.map { (value: Integration?) -> ResultMap? in value.flatMap { (value: Integration) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var integrationIds: [String?]? {
        get {
          return resultMap["integrationIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "integrationIds")
        }
      }

      public var memberIds: [String?]? {
        get {
          return resultMap["memberIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "memberIds")
        }
      }

      public var conversationCount: Int? {
        get {
          return resultMap["conversationCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "conversationCount")
        }
      }

      public var openConversationCount: Int? {
        get {
          return resultMap["openConversationCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "openConversationCount")
        }
      }

      public var integrations: [Integration?]? {
        get {
          return (resultMap["integrations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Integration?] in value.map { (value: ResultMap?) -> Integration? in value.flatMap { (value: ResultMap) -> Integration in Integration(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Integration?]) -> [ResultMap?] in value.map { (value: Integration?) -> ResultMap? in value.flatMap { (value: Integration) -> ResultMap in value.resultMap } } }, forKey: "integrations")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var channelDetail: ChannelDetail {
          get {
            return ChannelDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Integration: GraphQLSelectionSet {
        public static let possibleTypes = ["Integration"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .scalar(String.self)),
          GraphQLField("formId", type: .scalar(String.self)),
          GraphQLField("formData", type: .scalar(JSON.self)),
          GraphQLField("messengerData", type: .scalar(JSON.self)),
          GraphQLField("twitterData", type: .scalar(JSON.self)),
          GraphQLField("facebookData", type: .scalar(JSON.self)),
          GraphQLField("uiOptions", type: .scalar(JSON.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: String? = nil, formId: String? = nil, formData: JSON? = nil, messengerData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, uiOptions: JSON? = nil) {
          self.init(unsafeResultMap: ["__typename": "Integration", "code": code, "formId": formId, "formData": formData, "messengerData": messengerData, "twitterData": twitterData, "facebookData": facebookData, "uiOptions": uiOptions])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: String? {
          get {
            return resultMap["code"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var formId: String? {
          get {
            return resultMap["formId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "formId")
          }
        }

        public var formData: JSON? {
          get {
            return resultMap["formData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "formData")
          }
        }

        public var messengerData: JSON? {
          get {
            return resultMap["messengerData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "messengerData")
          }
        }

        public var twitterData: JSON? {
          get {
            return resultMap["twitterData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "twitterData")
          }
        }

        public var facebookData: JSON? {
          get {
            return resultMap["facebookData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "facebookData")
          }
        }

        public var uiOptions: JSON? {
          get {
            return resultMap["uiOptions"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "uiOptions")
          }
        }
      }
    }
  }
}

public final class TagsQuery: GraphQLQuery {
  public let operationDefinition =
    "query tags($type: String) {\n  tags(type: $type) {\n    __typename\n    ...TagDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(TagDetail.fragmentDefinition) }

  public var type: String?

  public init(type: String? = nil) {
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("tags", arguments: ["type": GraphQLVariable("type")], type: .list(.object(Tag.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tags: [Tag?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "tags": tags.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }])
    }

    public var tags: [Tag?]? {
      get {
        return (resultMap["tags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Tag?] in value.map { (value: ResultMap?) -> Tag? in value.flatMap { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, forKey: "tags")
      }
    }

    public struct Tag: GraphQLSelectionSet {
      public static let possibleTypes = ["Tag"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("type", type: .scalar(String.self)),
        GraphQLField("colorCode", type: .scalar(String.self)),
        GraphQLField("objectCount", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String? = nil, type: String? = nil, colorCode: String? = nil, objectCount: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "type": type, "colorCode": colorCode, "objectCount": objectCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var type: String? {
        get {
          return resultMap["type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var colorCode: String? {
        get {
          return resultMap["colorCode"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "colorCode")
        }
      }

      public var objectCount: Int? {
        get {
          return resultMap["objectCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "objectCount")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var tagDetail: TagDetail {
          get {
            return TagDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation Login($email: String!, $password: String!) {\n  login(email: $email, password: $password) {\n    __typename\n    token\n    refreshToken\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(Login.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.resultMap])
    }

    public var login: Login {
      get {
        return Login(unsafeResultMap: resultMap["login"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["AuthPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
        GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String, refreshToken: String) {
        self.init(unsafeResultMap: ["__typename": "AuthPayload", "token": token, "refreshToken": refreshToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }
    }
  }
}

public final class CurrentUserQuery: GraphQLQuery {
  public let operationDefinition =
    "query CurrentUser {\n  currentUser {\n    __typename\n    _id\n    username\n    email\n    role\n    details {\n      __typename\n      avatar\n      fullName\n      position\n    }\n    getNotificationByEmail\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> ResultMap in value.resultMap }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (resultMap["currentUser"] as? ResultMap).flatMap { CurrentUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("role", type: .scalar(String.self)),
        GraphQLField("details", type: .object(Detail.selections)),
        GraphQLField("getNotificationByEmail", type: .scalar(Bool.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, username: String? = nil, email: String? = nil, role: String? = nil, details: Detail? = nil, getNotificationByEmail: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "_id": id, "username": username, "email": email, "role": role, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }, "getNotificationByEmail": getNotificationByEmail])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var role: String? {
        get {
          return resultMap["role"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "role")
        }
      }

      public var details: Detail? {
        get {
          return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "details")
        }
      }

      public var getNotificationByEmail: Bool? {
        get {
          return resultMap["getNotificationByEmail"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "getNotificationByEmail")
        }
      }

      public struct Detail: GraphQLSelectionSet {
        public static let possibleTypes = ["UserDetailsType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatar", type: .scalar(String.self)),
          GraphQLField("fullName", type: .scalar(String.self)),
          GraphQLField("position", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(avatar: String? = nil, fullName: String? = nil, position: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar, "fullName": fullName, "position": position])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var avatar: String? {
          get {
            return resultMap["avatar"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar")
          }
        }

        public var fullName: String? {
          get {
            return resultMap["fullName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fullName")
          }
        }

        public var position: String? {
          get {
            return resultMap["position"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "position")
          }
        }
      }
    }
  }
}

public final class ConversationMessageAddMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation ConversationMessageAdd($conversationId: String!, $content: String!) {\n  conversationMessageAdd(conversationId: $conversationId, content: $content) {\n    __typename\n    _id\n  }\n}"

  public var conversationId: String
  public var content: String

  public init(conversationId: String, content: String) {
    self.conversationId = conversationId
    self.content = content
  }

  public var variables: GraphQLMap? {
    return ["conversationId": conversationId, "content": content]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationMessageAdd", arguments: ["conversationId": GraphQLVariable("conversationId"), "content": GraphQLVariable("content")], type: .object(ConversationMessageAdd.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationMessageAdd: ConversationMessageAdd? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "conversationMessageAdd": conversationMessageAdd.flatMap { (value: ConversationMessageAdd) -> ResultMap in value.resultMap }])
    }

    public var conversationMessageAdd: ConversationMessageAdd? {
      get {
        return (resultMap["conversationMessageAdd"] as? ResultMap).flatMap { ConversationMessageAdd(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "conversationMessageAdd")
      }
    }

    public struct ConversationMessageAdd: GraphQLSelectionSet {
      public static let possibleTypes = ["ConversationMessage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String) {
        self.init(unsafeResultMap: ["__typename": "ConversationMessage", "_id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }
    }
  }
}

public final class ConversationDetailQuery: GraphQLQuery {
  public let operationDefinition =
    "query ConversationDetail($_id: String!) {\n  conversationDetail(_id: $_id) {\n    __typename\n    messages {\n      __typename\n      ...MessageDetail\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(MessageDetail.fragmentDefinition) }

  public var _id: String

  public init(_id: String) {
    self._id = _id
  }

  public var variables: GraphQLMap? {
    return ["_id": _id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationDetail", arguments: ["_id": GraphQLVariable("_id")], type: .object(ConversationDetail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationDetail: ConversationDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversationDetail": conversationDetail.flatMap { (value: ConversationDetail) -> ResultMap in value.resultMap }])
    }

    public var conversationDetail: ConversationDetail? {
      get {
        return (resultMap["conversationDetail"] as? ResultMap).flatMap { ConversationDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "conversationDetail")
      }
    }

    public struct ConversationDetail: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("messages", type: .list(.object(Message.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(messages: [Message?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "messages": messages.flatMap { (value: [Message?]) -> [ResultMap?] in value.map { (value: Message?) -> ResultMap? in value.flatMap { (value: Message) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var messages: [Message?]? {
        get {
          return (resultMap["messages"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Message?] in value.map { (value: ResultMap?) -> Message? in value.flatMap { (value: ResultMap) -> Message in Message(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Message?]) -> [ResultMap?] in value.map { (value: Message?) -> ResultMap? in value.flatMap { (value: Message) -> ResultMap in value.resultMap } } }, forKey: "messages")
        }
      }

      public struct Message: GraphQLSelectionSet {
        public static let possibleTypes = ["ConversationMessage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("content", type: .scalar(String.self)),
          GraphQLField("attachments", type: .list(.scalar(JSON.self))),
          GraphQLField("conversationId", type: .scalar(String.self)),
          GraphQLField("customerId", type: .scalar(String.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(Int.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, content: String? = nil, attachments: [JSON?]? = nil, conversationId: String? = nil, customerId: String? = nil, userId: String? = nil, createdAt: Int? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "ConversationMessage", "_id": id, "content": content, "attachments": attachments, "conversationId": conversationId, "customerId": customerId, "userId": userId, "createdAt": createdAt, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var content: String? {
          get {
            return resultMap["content"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "content")
          }
        }

        public var attachments: [JSON?]? {
          get {
            return resultMap["attachments"] as? [JSON?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "attachments")
          }
        }

        public var conversationId: String? {
          get {
            return resultMap["conversationId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "conversationId")
          }
        }

        public var customerId: String? {
          get {
            return resultMap["customerId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "customerId")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var createdAt: Int? {
          get {
            return resultMap["createdAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var messageDetail: MessageDetail {
            get {
              return MessageDetail(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .scalar(String.self)),
            GraphQLField("email", type: .scalar(String.self)),
            GraphQLField("role", type: .scalar(String.self)),
            GraphQLField("getNotificationByEmail", type: .scalar(Bool.self)),
            GraphQLField("details", type: .object(Detail.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(username: String? = nil, email: String? = nil, role: String? = nil, getNotificationByEmail: Bool? = nil, details: Detail? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "username": username, "email": email, "role": role, "getNotificationByEmail": getNotificationByEmail, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var username: String? {
            get {
              return resultMap["username"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "username")
            }
          }

          public var email: String? {
            get {
              return resultMap["email"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "email")
            }
          }

          public var role: String? {
            get {
              return resultMap["role"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "role")
            }
          }

          public var getNotificationByEmail: Bool? {
            get {
              return resultMap["getNotificationByEmail"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "getNotificationByEmail")
            }
          }

          public var details: Detail? {
            get {
              return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "details")
            }
          }

          public struct Detail: GraphQLSelectionSet {
            public static let possibleTypes = ["UserDetailsType"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("avatar", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(avatar: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatar: String? {
              get {
                return resultMap["avatar"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "avatar")
              }
            }
          }
        }
      }
    }
  }
}

public final class CustomersQuery: GraphQLQuery {
  public let operationDefinition =
    "query Customers($page: Int, $perPage: Int, $segment: String, $tag: String, $ids: [String], $searchValue: String) {\n  customers(page: $page, perPage: $perPage, segment: $segment, tag: $tag, ids: $ids, searchValue: $searchValue) {\n    __typename\n    ...CustomerDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CustomerDetail.fragmentDefinition) }

  public var page: Int?
  public var perPage: Int?
  public var segment: String?
  public var tag: String?
  public var ids: [String?]?
  public var searchValue: String?

  public init(page: Int? = nil, perPage: Int? = nil, segment: String? = nil, tag: String? = nil, ids: [String?]? = nil, searchValue: String? = nil) {
    self.page = page
    self.perPage = perPage
    self.segment = segment
    self.tag = tag
    self.ids = ids
    self.searchValue = searchValue
  }

  public var variables: GraphQLMap? {
    return ["page": page, "perPage": perPage, "segment": segment, "tag": tag, "ids": ids, "searchValue": searchValue]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("customers", arguments: ["page": GraphQLVariable("page"), "perPage": GraphQLVariable("perPage"), "segment": GraphQLVariable("segment"), "tag": GraphQLVariable("tag"), "ids": GraphQLVariable("ids"), "searchValue": GraphQLVariable("searchValue")], type: .list(.object(Customer.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(customers: [Customer?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "customers": customers.flatMap { (value: [Customer?]) -> [ResultMap?] in value.map { (value: Customer?) -> ResultMap? in value.flatMap { (value: Customer) -> ResultMap in value.resultMap } } }])
    }

    public var customers: [Customer?]? {
      get {
        return (resultMap["customers"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Customer?] in value.map { (value: ResultMap?) -> Customer? in value.flatMap { (value: ResultMap) -> Customer in Customer(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Customer?]) -> [ResultMap?] in value.map { (value: Customer?) -> ResultMap? in value.flatMap { (value: Customer) -> ResultMap in value.resultMap } } }, forKey: "customers")
      }
    }

    public struct Customer: GraphQLSelectionSet {
      public static let possibleTypes = ["Customer"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("firstName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("phone", type: .scalar(String.self)),
        GraphQLField("isUser", type: .scalar(Bool.self)),
        GraphQLField("integrationId", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .scalar(Int.self)),
        GraphQLField("remoteAddress", type: .scalar(String.self)),
        GraphQLField("location", type: .scalar(JSON.self)),
        GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
        GraphQLField("customFieldsData", type: .scalar(JSON.self)),
        GraphQLField("twitterData", type: .scalar(JSON.self)),
        GraphQLField("facebookData", type: .scalar(JSON.self)),
        GraphQLField("ownerId", type: .scalar(String.self)),
        GraphQLField("position", type: .scalar(String.self)),
        GraphQLField("department", type: .scalar(String.self)),
        GraphQLField("leadStatus", type: .scalar(String.self)),
        GraphQLField("lifecycleState", type: .scalar(String.self)),
        GraphQLField("hasAuthority", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("doNotDisturb", type: .scalar(String.self)),
        GraphQLField("links", type: .object(Link.selections)),
        GraphQLField("owner", type: .object(Owner.selections)),
        GraphQLField("tagIds", type: .list(.scalar(String.self))),
        GraphQLField("getTags", type: .list(.object(GetTag.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, integrationId: String? = nil, createdAt: Int? = nil, remoteAddress: String? = nil, location: JSON? = nil, visitorContactInfo: JSON? = nil, customFieldsData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, ownerId: String? = nil, position: String? = nil, department: String? = nil, leadStatus: String? = nil, lifecycleState: String? = nil, hasAuthority: String? = nil, description: String? = nil, doNotDisturb: String? = nil, links: Link? = nil, owner: Owner? = nil, tagIds: [String?]? = nil, getTags: [GetTag?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "integrationId": integrationId, "createdAt": createdAt, "remoteAddress": remoteAddress, "location": location, "visitorContactInfo": visitorContactInfo, "customFieldsData": customFieldsData, "twitterData": twitterData, "facebookData": facebookData, "ownerId": ownerId, "position": position, "department": department, "leadStatus": leadStatus, "lifecycleState": lifecycleState, "hasAuthority": hasAuthority, "description": description, "doNotDisturb": doNotDisturb, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }, "owner": owner.flatMap { (value: Owner) -> ResultMap in value.resultMap }, "tagIds": tagIds, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var phone: String? {
        get {
          return resultMap["phone"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phone")
        }
      }

      public var isUser: Bool? {
        get {
          return resultMap["isUser"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isUser")
        }
      }

      public var integrationId: String? {
        get {
          return resultMap["integrationId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "integrationId")
        }
      }

      public var createdAt: Int? {
        get {
          return resultMap["createdAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var remoteAddress: String? {
        get {
          return resultMap["remoteAddress"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "remoteAddress")
        }
      }

      public var location: JSON? {
        get {
          return resultMap["location"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "location")
        }
      }

      public var visitorContactInfo: JSON? {
        get {
          return resultMap["visitorContactInfo"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "visitorContactInfo")
        }
      }

      public var customFieldsData: JSON? {
        get {
          return resultMap["customFieldsData"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "customFieldsData")
        }
      }

      public var twitterData: JSON? {
        get {
          return resultMap["twitterData"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "twitterData")
        }
      }

      public var facebookData: JSON? {
        get {
          return resultMap["facebookData"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "facebookData")
        }
      }

      public var ownerId: String? {
        get {
          return resultMap["ownerId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "ownerId")
        }
      }

      public var position: String? {
        get {
          return resultMap["position"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "position")
        }
      }

      public var department: String? {
        get {
          return resultMap["department"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "department")
        }
      }

      public var leadStatus: String? {
        get {
          return resultMap["leadStatus"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "leadStatus")
        }
      }

      public var lifecycleState: String? {
        get {
          return resultMap["lifecycleState"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lifecycleState")
        }
      }

      public var hasAuthority: String? {
        get {
          return resultMap["hasAuthority"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasAuthority")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var doNotDisturb: String? {
        get {
          return resultMap["doNotDisturb"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "doNotDisturb")
        }
      }

      public var links: Link? {
        get {
          return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "links")
        }
      }

      public var owner: Owner? {
        get {
          return (resultMap["owner"] as? ResultMap).flatMap { Owner(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "owner")
        }
      }

      public var tagIds: [String?]? {
        get {
          return resultMap["tagIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tagIds")
        }
      }

      public var getTags: [GetTag?]? {
        get {
          return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var customerDetail: CustomerDetail {
          get {
            return CustomerDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Link: GraphQLSelectionSet {
        public static let possibleTypes = ["CustomerLinks"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("linkedIn", type: .scalar(String.self)),
          GraphQLField("twitter", type: .scalar(String.self)),
          GraphQLField("facebook", type: .scalar(String.self)),
          GraphQLField("github", type: .scalar(String.self)),
          GraphQLField("youtube", type: .scalar(String.self)),
          GraphQLField("website", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(linkedIn: String? = nil, twitter: String? = nil, facebook: String? = nil, github: String? = nil, youtube: String? = nil, website: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CustomerLinks", "linkedIn": linkedIn, "twitter": twitter, "facebook": facebook, "github": github, "youtube": youtube, "website": website])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var linkedIn: String? {
          get {
            return resultMap["linkedIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "linkedIn")
          }
        }

        public var twitter: String? {
          get {
            return resultMap["twitter"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "twitter")
          }
        }

        public var facebook: String? {
          get {
            return resultMap["facebook"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "facebook")
          }
        }

        public var github: String? {
          get {
            return resultMap["github"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "github")
          }
        }

        public var youtube: String? {
          get {
            return resultMap["youtube"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "youtube")
          }
        }

        public var website: String? {
          get {
            return resultMap["website"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "website")
          }
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("details", type: .object(Detail.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(details: Detail? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var details: Detail? {
          get {
            return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "details")
          }
        }

        public struct Detail: GraphQLSelectionSet {
          public static let possibleTypes = ["UserDetailsType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fullName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(fullName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fullName: String? {
            get {
              return resultMap["fullName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fullName")
            }
          }
        }
      }

      public struct GetTag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("colorCode", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil, colorCode: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var colorCode: String? {
          get {
            return resultMap["colorCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "colorCode")
          }
        }
      }
    }
  }
}

public final class CompaniesQuery: GraphQLQuery {
  public let operationDefinition =
    "query Companies($page: Int, $perPage: Int, $segment: String, $tag: String, $ids: [String], $searchValue: String) {\n  companies(page: $page, perPage: $perPage, segment: $segment, tag: $tag, ids: $ids, searchValue: $searchValue) {\n    __typename\n    ...CompanyDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CompanyDetail.fragmentDefinition) }

  public var page: Int?
  public var perPage: Int?
  public var segment: String?
  public var tag: String?
  public var ids: [String?]?
  public var searchValue: String?

  public init(page: Int? = nil, perPage: Int? = nil, segment: String? = nil, tag: String? = nil, ids: [String?]? = nil, searchValue: String? = nil) {
    self.page = page
    self.perPage = perPage
    self.segment = segment
    self.tag = tag
    self.ids = ids
    self.searchValue = searchValue
  }

  public var variables: GraphQLMap? {
    return ["page": page, "perPage": perPage, "segment": segment, "tag": tag, "ids": ids, "searchValue": searchValue]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("companies", arguments: ["page": GraphQLVariable("page"), "perPage": GraphQLVariable("perPage"), "segment": GraphQLVariable("segment"), "tag": GraphQLVariable("tag"), "ids": GraphQLVariable("ids"), "searchValue": GraphQLVariable("searchValue")], type: .list(.object(Company.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(companies: [Company?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "companies": companies.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }])
    }

    public var companies: [Company?]? {
      get {
        return (resultMap["companies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Company?] in value.map { (value: ResultMap?) -> Company? in value.flatMap { (value: ResultMap) -> Company in Company(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }, forKey: "companies")
      }
    }

    public struct Company: GraphQLSelectionSet {
      public static let possibleTypes = ["Company"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("size", type: .scalar(Int.self)),
        GraphQLField("industry", type: .scalar(String.self)),
        GraphQLField("website", type: .scalar(String.self)),
        GraphQLField("plan", type: .scalar(String.self)),
        GraphQLField("customFieldsData", type: .scalar(JSON.self)),
        GraphQLField("tagIds", type: .list(.scalar(String.self))),
        GraphQLField("getTags", type: .list(.object(GetTag.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String? = nil, size: Int? = nil, industry: String? = nil, website: String? = nil, plan: String? = nil, customFieldsData: JSON? = nil, tagIds: [String?]? = nil, getTags: [GetTag?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Company", "_id": id, "name": name, "size": size, "industry": industry, "website": website, "plan": plan, "customFieldsData": customFieldsData, "tagIds": tagIds, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var size: Int? {
        get {
          return resultMap["size"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "size")
        }
      }

      public var industry: String? {
        get {
          return resultMap["industry"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "industry")
        }
      }

      public var website: String? {
        get {
          return resultMap["website"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "website")
        }
      }

      public var plan: String? {
        get {
          return resultMap["plan"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "plan")
        }
      }

      public var customFieldsData: JSON? {
        get {
          return resultMap["customFieldsData"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "customFieldsData")
        }
      }

      public var tagIds: [String?]? {
        get {
          return resultMap["tagIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tagIds")
        }
      }

      public var getTags: [GetTag?]? {
        get {
          return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var companyDetail: CompanyDetail {
          get {
            return CompanyDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct GetTag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("colorCode", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil, colorCode: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var colorCode: String? {
          get {
            return resultMap["colorCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "colorCode")
          }
        }
      }
    }
  }
}

public final class CustomerDetailQuery: GraphQLQuery {
  public let operationDefinition =
    "query customerDetail($_id: String!) {\n  customerDetail(_id: $_id) {\n    __typename\n    ...CustomerInfo\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(CustomerInfo.fragmentDefinition) }

  public var _id: String

  public init(_id: String) {
    self._id = _id
  }

  public var variables: GraphQLMap? {
    return ["_id": _id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("customerDetail", arguments: ["_id": GraphQLVariable("_id")], type: .object(CustomerDetail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(customerDetail: CustomerDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "customerDetail": customerDetail.flatMap { (value: CustomerDetail) -> ResultMap in value.resultMap }])
    }

    public var customerDetail: CustomerDetail? {
      get {
        return (resultMap["customerDetail"] as? ResultMap).flatMap { CustomerDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "customerDetail")
      }
    }

    public struct CustomerDetail: GraphQLSelectionSet {
      public static let possibleTypes = ["Customer"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("integration", type: .object(Integration.selections)),
        GraphQLField("conversations", type: .list(.object(Conversation.selections))),
        GraphQLField("firstName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("phone", type: .scalar(String.self)),
        GraphQLField("isUser", type: .scalar(Bool.self)),
        GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
        GraphQLField("position", type: .scalar(String.self)),
        GraphQLField("department", type: .scalar(String.self)),
        GraphQLField("leadStatus", type: .scalar(String.self)),
        GraphQLField("lifecycleState", type: .scalar(String.self)),
        GraphQLField("hasAuthority", type: .scalar(String.self)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("doNotDisturb", type: .scalar(String.self)),
        GraphQLField("links", type: .object(Link.selections)),
        GraphQLField("owner", type: .object(Owner.selections)),
        GraphQLField("companies", type: .list(.object(Company.selections))),
        GraphQLField("messengerData", type: .scalar(JSON.self)),
        GraphQLField("getTags", type: .list(.object(GetTag.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, integration: Integration? = nil, conversations: [Conversation?]? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, visitorContactInfo: JSON? = nil, position: String? = nil, department: String? = nil, leadStatus: String? = nil, lifecycleState: String? = nil, hasAuthority: String? = nil, description: String? = nil, doNotDisturb: String? = nil, links: Link? = nil, owner: Owner? = nil, companies: [Company?]? = nil, messengerData: JSON? = nil, getTags: [GetTag?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "integration": integration.flatMap { (value: Integration) -> ResultMap in value.resultMap }, "conversations": conversations.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "visitorContactInfo": visitorContactInfo, "position": position, "department": department, "leadStatus": leadStatus, "lifecycleState": lifecycleState, "hasAuthority": hasAuthority, "description": description, "doNotDisturb": doNotDisturb, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }, "owner": owner.flatMap { (value: Owner) -> ResultMap in value.resultMap }, "companies": companies.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }, "messengerData": messengerData, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var integration: Integration? {
        get {
          return (resultMap["integration"] as? ResultMap).flatMap { Integration(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "integration")
        }
      }

      public var conversations: [Conversation?]? {
        get {
          return (resultMap["conversations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Conversation?] in value.map { (value: ResultMap?) -> Conversation? in value.flatMap { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, forKey: "conversations")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var phone: String? {
        get {
          return resultMap["phone"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phone")
        }
      }

      public var isUser: Bool? {
        get {
          return resultMap["isUser"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isUser")
        }
      }

      public var visitorContactInfo: JSON? {
        get {
          return resultMap["visitorContactInfo"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "visitorContactInfo")
        }
      }

      public var position: String? {
        get {
          return resultMap["position"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "position")
        }
      }

      public var department: String? {
        get {
          return resultMap["department"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "department")
        }
      }

      public var leadStatus: String? {
        get {
          return resultMap["leadStatus"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "leadStatus")
        }
      }

      public var lifecycleState: String? {
        get {
          return resultMap["lifecycleState"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lifecycleState")
        }
      }

      public var hasAuthority: String? {
        get {
          return resultMap["hasAuthority"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasAuthority")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var doNotDisturb: String? {
        get {
          return resultMap["doNotDisturb"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "doNotDisturb")
        }
      }

      public var links: Link? {
        get {
          return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "links")
        }
      }

      public var owner: Owner? {
        get {
          return (resultMap["owner"] as? ResultMap).flatMap { Owner(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "owner")
        }
      }

      public var companies: [Company?]? {
        get {
          return (resultMap["companies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Company?] in value.map { (value: ResultMap?) -> Company? in value.flatMap { (value: ResultMap) -> Company in Company(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }, forKey: "companies")
        }
      }

      public var messengerData: JSON? {
        get {
          return resultMap["messengerData"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "messengerData")
        }
      }

      public var getTags: [GetTag?]? {
        get {
          return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var customerInfo: CustomerInfo {
          get {
            return CustomerInfo(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Integration: GraphQLSelectionSet {
        public static let possibleTypes = ["Integration"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("kind", type: .nonNull(.scalar(String.self))),
          GraphQLField("brand", type: .object(Brand.selections)),
          GraphQLField("channels", type: .list(.object(Channel.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(kind: String, brand: Brand? = nil, channels: [Channel?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Integration", "kind": kind, "brand": brand.flatMap { (value: Brand) -> ResultMap in value.resultMap }, "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var kind: String {
          get {
            return resultMap["kind"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "kind")
          }
        }

        public var brand: Brand? {
          get {
            return (resultMap["brand"] as? ResultMap).flatMap { Brand(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "brand")
          }
        }

        public var channels: [Channel?]? {
          get {
            return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
          }
        }

        public struct Brand: GraphQLSelectionSet {
          public static let possibleTypes = ["Brand"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Brand", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct Channel: GraphQLSelectionSet {
          public static let possibleTypes = ["Channel"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "Channel", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Conversation: GraphQLSelectionSet {
        public static let possibleTypes = ["Conversation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .scalar(Int.self)),
          GraphQLField("status", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(createdAt: Int? = nil, status: String? = nil, updatedAt: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Conversation", "createdAt": createdAt, "status": status, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var createdAt: Int? {
          get {
            return resultMap["createdAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var status: String? {
          get {
            return resultMap["status"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public var updatedAt: Int? {
          get {
            return resultMap["updatedAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }

      public struct Link: GraphQLSelectionSet {
        public static let possibleTypes = ["CustomerLinks"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("linkedIn", type: .scalar(String.self)),
          GraphQLField("twitter", type: .scalar(String.self)),
          GraphQLField("facebook", type: .scalar(String.self)),
          GraphQLField("github", type: .scalar(String.self)),
          GraphQLField("youtube", type: .scalar(String.self)),
          GraphQLField("website", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(linkedIn: String? = nil, twitter: String? = nil, facebook: String? = nil, github: String? = nil, youtube: String? = nil, website: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CustomerLinks", "linkedIn": linkedIn, "twitter": twitter, "facebook": facebook, "github": github, "youtube": youtube, "website": website])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var linkedIn: String? {
          get {
            return resultMap["linkedIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "linkedIn")
          }
        }

        public var twitter: String? {
          get {
            return resultMap["twitter"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "twitter")
          }
        }

        public var facebook: String? {
          get {
            return resultMap["facebook"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "facebook")
          }
        }

        public var github: String? {
          get {
            return resultMap["github"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "github")
          }
        }

        public var youtube: String? {
          get {
            return resultMap["youtube"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "youtube")
          }
        }

        public var website: String? {
          get {
            return resultMap["website"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "website")
          }
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("details", type: .object(Detail.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(details: Detail? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var details: Detail? {
          get {
            return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "details")
          }
        }

        public struct Detail: GraphQLSelectionSet {
          public static let possibleTypes = ["UserDetailsType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("fullName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(fullName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fullName: String? {
            get {
              return resultMap["fullName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fullName")
            }
          }
        }
      }

      public struct Company: GraphQLSelectionSet {
        public static let possibleTypes = ["Company"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("website", type: .scalar(String.self)),
          GraphQLField("industry", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil, website: String? = nil, industry: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Company", "_id": id, "name": name, "website": website, "industry": industry])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var website: String? {
          get {
            return resultMap["website"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "website")
          }
        }

        public var industry: String? {
          get {
            return resultMap["industry"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "industry")
          }
        }
      }

      public struct GetTag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("colorCode", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil, colorCode: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var colorCode: String? {
          get {
            return resultMap["colorCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "colorCode")
          }
        }
      }
    }
  }
}

public final class ConversationsQuery: GraphQLQuery {
  public let operationDefinition =
    "query Conversations {\n  conversations {\n    __typename\n    ...ConversationDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ConversationDetail.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversations", type: .list(.object(Conversation.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversations: [Conversation?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversations": conversations.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }])
    }

    public var conversations: [Conversation?]? {
      get {
        return (resultMap["conversations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Conversation?] in value.map { (value: ResultMap?) -> Conversation? in value.flatMap { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, forKey: "conversations")
      }
    }

    public struct Conversation: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .scalar(Int.self)),
        GraphQLField("customerId", type: .scalar(String.self)),
        GraphQLField("customer", type: .object(Customer.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, content: String? = nil, createdAt: Int? = nil, customerId: String? = nil, customer: Customer? = nil) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id, "content": content, "createdAt": createdAt, "customerId": customerId, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var content: String? {
        get {
          return resultMap["content"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "content")
        }
      }

      public var createdAt: Int? {
        get {
          return resultMap["createdAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var customerId: String? {
        get {
          return resultMap["customerId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "customerId")
        }
      }

      public var customer: Customer? {
        get {
          return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "customer")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var conversationDetail: ConversationDetail {
          get {
            return ConversationDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Customer: GraphQLSelectionSet {
        public static let possibleTypes = ["Customer"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("integrationId", type: .scalar(String.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("phone", type: .scalar(String.self)),
          GraphQLField("isUser", type: .scalar(Bool.self)),
          GraphQLField("createdAt", type: .scalar(Int.self)),
          GraphQLField("remoteAddress", type: .scalar(String.self)),
          GraphQLField("internalNotes", type: .scalar(JSON.self)),
          GraphQLField("location", type: .scalar(JSON.self)),
          GraphQLField("customFieldsData", type: .scalar(JSON.self)),
          GraphQLField("messengerData", type: .scalar(JSON.self)),
          GraphQLField("twitterData", type: .scalar(JSON.self)),
          GraphQLField("facebookData", type: .scalar(JSON.self)),
          GraphQLField("getIntegrationData", type: .scalar(JSON.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(integrationId: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, createdAt: Int? = nil, remoteAddress: String? = nil, internalNotes: JSON? = nil, location: JSON? = nil, customFieldsData: JSON? = nil, messengerData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, getIntegrationData: JSON? = nil) {
          self.init(unsafeResultMap: ["__typename": "Customer", "integrationId": integrationId, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "createdAt": createdAt, "remoteAddress": remoteAddress, "internalNotes": internalNotes, "location": location, "customFieldsData": customFieldsData, "messengerData": messengerData, "twitterData": twitterData, "facebookData": facebookData, "getIntegrationData": getIntegrationData])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var integrationId: String? {
          get {
            return resultMap["integrationId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "integrationId")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var phone: String? {
          get {
            return resultMap["phone"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phone")
          }
        }

        public var isUser: Bool? {
          get {
            return resultMap["isUser"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isUser")
          }
        }

        public var createdAt: Int? {
          get {
            return resultMap["createdAt"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var remoteAddress: String? {
          get {
            return resultMap["remoteAddress"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "remoteAddress")
          }
        }

        public var internalNotes: JSON? {
          get {
            return resultMap["internalNotes"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "internalNotes")
          }
        }

        public var location: JSON? {
          get {
            return resultMap["location"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "location")
          }
        }

        public var customFieldsData: JSON? {
          get {
            return resultMap["customFieldsData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "customFieldsData")
          }
        }

        public var messengerData: JSON? {
          get {
            return resultMap["messengerData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "messengerData")
          }
        }

        public var twitterData: JSON? {
          get {
            return resultMap["twitterData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "twitterData")
          }
        }

        public var facebookData: JSON? {
          get {
            return resultMap["facebookData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "facebookData")
          }
        }

        public var getIntegrationData: JSON? {
          get {
            return resultMap["getIntegrationData"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "getIntegrationData")
          }
        }
      }
    }
  }
}

public final class ObjectsQuery: GraphQLQuery {
  public let operationDefinition =
    "query objects($limit: Int, $channelId: String, $status: String, $unassigned: String, $brandId: String, $tag: String, $integrationType: String, $participating: String, $starred: String, $ids: [String], $startDate: String, $endDate: String) {\n  conversations(limit: $limit, channelId: $channelId, status: $status, unassigned: $unassigned, brandId: $brandId, tag: $tag, integrationType: $integrationType, participating: $participating, starred: $starred, ids: $ids, startDate: $startDate, endDate: $endDate) {\n    __typename\n    ...ObjectDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ObjectDetail.fragmentDefinition) }

  public var limit: Int?
  public var channelId: String?
  public var status: String?
  public var unassigned: String?
  public var brandId: String?
  public var tag: String?
  public var integrationType: String?
  public var participating: String?
  public var starred: String?
  public var ids: [String?]?
  public var startDate: String?
  public var endDate: String?

  public init(limit: Int? = nil, channelId: String? = nil, status: String? = nil, unassigned: String? = nil, brandId: String? = nil, tag: String? = nil, integrationType: String? = nil, participating: String? = nil, starred: String? = nil, ids: [String?]? = nil, startDate: String? = nil, endDate: String? = nil) {
    self.limit = limit
    self.channelId = channelId
    self.status = status
    self.unassigned = unassigned
    self.brandId = brandId
    self.tag = tag
    self.integrationType = integrationType
    self.participating = participating
    self.starred = starred
    self.ids = ids
    self.startDate = startDate
    self.endDate = endDate
  }

  public var variables: GraphQLMap? {
    return ["limit": limit, "channelId": channelId, "status": status, "unassigned": unassigned, "brandId": brandId, "tag": tag, "integrationType": integrationType, "participating": participating, "starred": starred, "ids": ids, "startDate": startDate, "endDate": endDate]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversations", arguments: ["limit": GraphQLVariable("limit"), "channelId": GraphQLVariable("channelId"), "status": GraphQLVariable("status"), "unassigned": GraphQLVariable("unassigned"), "brandId": GraphQLVariable("brandId"), "tag": GraphQLVariable("tag"), "integrationType": GraphQLVariable("integrationType"), "participating": GraphQLVariable("participating"), "starred": GraphQLVariable("starred"), "ids": GraphQLVariable("ids"), "startDate": GraphQLVariable("startDate"), "endDate": GraphQLVariable("endDate")], type: .list(.object(Conversation.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversations: [Conversation?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversations": conversations.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }])
    }

    public var conversations: [Conversation?]? {
      get {
        return (resultMap["conversations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Conversation?] in value.map { (value: ResultMap?) -> Conversation? in value.flatMap { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, forKey: "conversations")
      }
    }

    public struct Conversation: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("updatedAt", type: .scalar(Int.self)),
        GraphQLField("status", type: .scalar(String.self)),
        GraphQLField("assignedUser", type: .object(AssignedUser.selections)),
        GraphQLField("integration", type: .object(Integration.selections)),
        GraphQLField("customer", type: .object(Customer.selections)),
        GraphQLField("tagIds", type: .list(.scalar(String.self))),
        GraphQLField("tags", type: .list(.object(Tag.selections))),
        GraphQLField("readUserIds", type: .list(.scalar(String.self))),
        GraphQLField("twitterData", type: .object(TwitterDatum.selections)),
        GraphQLField("facebookData", type: .object(FacebookDatum.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, content: String? = nil, updatedAt: Int? = nil, status: String? = nil, assignedUser: AssignedUser? = nil, integration: Integration? = nil, customer: Customer? = nil, tagIds: [String?]? = nil, tags: [Tag?]? = nil, readUserIds: [String?]? = nil, twitterData: TwitterDatum? = nil, facebookData: FacebookDatum? = nil) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id, "content": content, "updatedAt": updatedAt, "status": status, "assignedUser": assignedUser.flatMap { (value: AssignedUser) -> ResultMap in value.resultMap }, "integration": integration.flatMap { (value: Integration) -> ResultMap in value.resultMap }, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }, "tagIds": tagIds, "tags": tags.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, "readUserIds": readUserIds, "twitterData": twitterData.flatMap { (value: TwitterDatum) -> ResultMap in value.resultMap }, "facebookData": facebookData.flatMap { (value: FacebookDatum) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var content: String? {
        get {
          return resultMap["content"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "content")
        }
      }

      public var updatedAt: Int? {
        get {
          return resultMap["updatedAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var assignedUser: AssignedUser? {
        get {
          return (resultMap["assignedUser"] as? ResultMap).flatMap { AssignedUser(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "assignedUser")
        }
      }

      public var integration: Integration? {
        get {
          return (resultMap["integration"] as? ResultMap).flatMap { Integration(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "integration")
        }
      }

      public var customer: Customer? {
        get {
          return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "customer")
        }
      }

      public var tagIds: [String?]? {
        get {
          return resultMap["tagIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tagIds")
        }
      }

      public var tags: [Tag?]? {
        get {
          return (resultMap["tags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Tag?] in value.map { (value: ResultMap?) -> Tag? in value.flatMap { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, forKey: "tags")
        }
      }

      public var readUserIds: [String?]? {
        get {
          return resultMap["readUserIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "readUserIds")
        }
      }

      public var twitterData: TwitterDatum? {
        get {
          return (resultMap["twitterData"] as? ResultMap).flatMap { TwitterDatum(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "twitterData")
        }
      }

      public var facebookData: FacebookDatum? {
        get {
          return (resultMap["facebookData"] as? ResultMap).flatMap { FacebookDatum(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "facebookData")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var objectDetail: ObjectDetail {
          get {
            return ObjectDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct AssignedUser: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("details", type: .object(Detail.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, details: Detail? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "_id": id, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var details: Detail? {
          get {
            return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "details")
          }
        }

        public struct Detail: GraphQLSelectionSet {
          public static let possibleTypes = ["UserDetailsType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatar", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatar: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var avatar: String? {
            get {
              return resultMap["avatar"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "avatar")
            }
          }
        }
      }

      public struct Integration: GraphQLSelectionSet {
        public static let possibleTypes = ["Integration"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("kind", type: .nonNull(.scalar(String.self))),
          GraphQLField("brand", type: .object(Brand.selections)),
          GraphQLField("channels", type: .list(.object(Channel.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, kind: String, brand: Brand? = nil, channels: [Channel?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Integration", "_id": id, "kind": kind, "brand": brand.flatMap { (value: Brand) -> ResultMap in value.resultMap }, "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var kind: String {
          get {
            return resultMap["kind"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "kind")
          }
        }

        public var brand: Brand? {
          get {
            return (resultMap["brand"] as? ResultMap).flatMap { Brand(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "brand")
          }
        }

        public var channels: [Channel?]? {
          get {
            return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
          }
        }

        public struct Brand: GraphQLSelectionSet {
          public static let possibleTypes = ["Brand"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Brand", "_id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["_id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct Channel: GraphQLSelectionSet {
          public static let possibleTypes = ["Channel"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "Channel", "_id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["_id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Customer: GraphQLSelectionSet {
        public static let possibleTypes = ["Customer"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("phone", type: .scalar(String.self)),
          GraphQLField("isUser", type: .scalar(Bool.self)),
          GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, visitorContactInfo: JSON? = nil) {
          self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "visitorContactInfo": visitorContactInfo])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var phone: String? {
          get {
            return resultMap["phone"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phone")
          }
        }

        public var isUser: Bool? {
          get {
            return resultMap["isUser"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isUser")
          }
        }

        public var visitorContactInfo: JSON? {
          get {
            return resultMap["visitorContactInfo"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "visitorContactInfo")
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct TwitterDatum: GraphQLSelectionSet {
        public static let possibleTypes = ["TwitterData"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("isDirectMessage", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isDirectMessage: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "TwitterData", "isDirectMessage": isDirectMessage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isDirectMessage: Bool? {
          get {
            return resultMap["isDirectMessage"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isDirectMessage")
          }
        }
      }

      public struct FacebookDatum: GraphQLSelectionSet {
        public static let possibleTypes = ["ConversationFacebookData"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("kind", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(kind: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ConversationFacebookData", "kind": kind])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var kind: String? {
          get {
            return resultMap["kind"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "kind")
          }
        }
      }
    }
  }
}

public final class ConversationCountsQuery: GraphQLQuery {
  public let operationDefinition =
    "query conversationCounts($limit: Int, $channelId: String, $status: String, $unassigned: String, $brandId: String, $tag: String, $integrationType: String, $participating: String, $starred: String, $ids: [String]) {\n  conversationCounts(limit: $limit, channelId: $channelId, status: $status, unassigned: $unassigned, brandId: $brandId, tag: $tag, integrationType: $integrationType, participating: $participating, starred: $starred, ids: $ids)\n}"

  public var limit: Int?
  public var channelId: String?
  public var status: String?
  public var unassigned: String?
  public var brandId: String?
  public var tag: String?
  public var integrationType: String?
  public var participating: String?
  public var starred: String?
  public var ids: [String?]?

  public init(limit: Int? = nil, channelId: String? = nil, status: String? = nil, unassigned: String? = nil, brandId: String? = nil, tag: String? = nil, integrationType: String? = nil, participating: String? = nil, starred: String? = nil, ids: [String?]? = nil) {
    self.limit = limit
    self.channelId = channelId
    self.status = status
    self.unassigned = unassigned
    self.brandId = brandId
    self.tag = tag
    self.integrationType = integrationType
    self.participating = participating
    self.starred = starred
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["limit": limit, "channelId": channelId, "status": status, "unassigned": unassigned, "brandId": brandId, "tag": tag, "integrationType": integrationType, "participating": participating, "starred": starred, "ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationCounts", arguments: ["limit": GraphQLVariable("limit"), "channelId": GraphQLVariable("channelId"), "status": GraphQLVariable("status"), "unassigned": GraphQLVariable("unassigned"), "brandId": GraphQLVariable("brandId"), "tag": GraphQLVariable("tag"), "integrationType": GraphQLVariable("integrationType"), "participating": GraphQLVariable("participating"), "starred": GraphQLVariable("starred"), "ids": GraphQLVariable("ids")], type: .scalar(JSON.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationCounts: JSON? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversationCounts": conversationCounts])
    }

    public var conversationCounts: JSON? {
      get {
        return resultMap["conversationCounts"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "conversationCounts")
      }
    }
  }
}

public final class UnreadCountQuery: GraphQLQuery {
  public let operationDefinition =
    "query unreadCount {\n  conversationsTotalUnreadCount\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationsTotalUnreadCount", type: .scalar(Int.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationsTotalUnreadCount: Int? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversationsTotalUnreadCount": conversationsTotalUnreadCount])
    }

    public var conversationsTotalUnreadCount: Int? {
      get {
        return resultMap["conversationsTotalUnreadCount"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "conversationsTotalUnreadCount")
      }
    }
  }
}

public final class GetLastQuery: GraphQLQuery {
  public let operationDefinition =
    "query getLast {\n  conversationsGetLast {\n    __typename\n    ...ObjectDetail\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ObjectDetail.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationsGetLast", type: .object(ConversationsGetLast.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationsGetLast: ConversationsGetLast? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "conversationsGetLast": conversationsGetLast.flatMap { (value: ConversationsGetLast) -> ResultMap in value.resultMap }])
    }

    public var conversationsGetLast: ConversationsGetLast? {
      get {
        return (resultMap["conversationsGetLast"] as? ResultMap).flatMap { ConversationsGetLast(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "conversationsGetLast")
      }
    }

    public struct ConversationsGetLast: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .scalar(String.self)),
        GraphQLField("updatedAt", type: .scalar(Int.self)),
        GraphQLField("status", type: .scalar(String.self)),
        GraphQLField("assignedUser", type: .object(AssignedUser.selections)),
        GraphQLField("integration", type: .object(Integration.selections)),
        GraphQLField("customer", type: .object(Customer.selections)),
        GraphQLField("tagIds", type: .list(.scalar(String.self))),
        GraphQLField("tags", type: .list(.object(Tag.selections))),
        GraphQLField("readUserIds", type: .list(.scalar(String.self))),
        GraphQLField("twitterData", type: .object(TwitterDatum.selections)),
        GraphQLField("facebookData", type: .object(FacebookDatum.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, content: String? = nil, updatedAt: Int? = nil, status: String? = nil, assignedUser: AssignedUser? = nil, integration: Integration? = nil, customer: Customer? = nil, tagIds: [String?]? = nil, tags: [Tag?]? = nil, readUserIds: [String?]? = nil, twitterData: TwitterDatum? = nil, facebookData: FacebookDatum? = nil) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id, "content": content, "updatedAt": updatedAt, "status": status, "assignedUser": assignedUser.flatMap { (value: AssignedUser) -> ResultMap in value.resultMap }, "integration": integration.flatMap { (value: Integration) -> ResultMap in value.resultMap }, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }, "tagIds": tagIds, "tags": tags.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, "readUserIds": readUserIds, "twitterData": twitterData.flatMap { (value: TwitterDatum) -> ResultMap in value.resultMap }, "facebookData": facebookData.flatMap { (value: FacebookDatum) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var content: String? {
        get {
          return resultMap["content"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "content")
        }
      }

      public var updatedAt: Int? {
        get {
          return resultMap["updatedAt"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var assignedUser: AssignedUser? {
        get {
          return (resultMap["assignedUser"] as? ResultMap).flatMap { AssignedUser(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "assignedUser")
        }
      }

      public var integration: Integration? {
        get {
          return (resultMap["integration"] as? ResultMap).flatMap { Integration(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "integration")
        }
      }

      public var customer: Customer? {
        get {
          return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "customer")
        }
      }

      public var tagIds: [String?]? {
        get {
          return resultMap["tagIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tagIds")
        }
      }

      public var tags: [Tag?]? {
        get {
          return (resultMap["tags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Tag?] in value.map { (value: ResultMap?) -> Tag? in value.flatMap { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, forKey: "tags")
        }
      }

      public var readUserIds: [String?]? {
        get {
          return resultMap["readUserIds"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "readUserIds")
        }
      }

      public var twitterData: TwitterDatum? {
        get {
          return (resultMap["twitterData"] as? ResultMap).flatMap { TwitterDatum(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "twitterData")
        }
      }

      public var facebookData: FacebookDatum? {
        get {
          return (resultMap["facebookData"] as? ResultMap).flatMap { FacebookDatum(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "facebookData")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var objectDetail: ObjectDetail {
          get {
            return ObjectDetail(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct AssignedUser: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("details", type: .object(Detail.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, details: Detail? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "_id": id, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var details: Detail? {
          get {
            return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "details")
          }
        }

        public struct Detail: GraphQLSelectionSet {
          public static let possibleTypes = ["UserDetailsType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("avatar", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(avatar: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var avatar: String? {
            get {
              return resultMap["avatar"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "avatar")
            }
          }
        }
      }

      public struct Integration: GraphQLSelectionSet {
        public static let possibleTypes = ["Integration"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("kind", type: .nonNull(.scalar(String.self))),
          GraphQLField("brand", type: .object(Brand.selections)),
          GraphQLField("channels", type: .list(.object(Channel.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, kind: String, brand: Brand? = nil, channels: [Channel?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Integration", "_id": id, "kind": kind, "brand": brand.flatMap { (value: Brand) -> ResultMap in value.resultMap }, "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var kind: String {
          get {
            return resultMap["kind"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "kind")
          }
        }

        public var brand: Brand? {
          get {
            return (resultMap["brand"] as? ResultMap).flatMap { Brand(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "brand")
          }
        }

        public var channels: [Channel?]? {
          get {
            return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
          }
        }

        public struct Brand: GraphQLSelectionSet {
          public static let possibleTypes = ["Brand"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Brand", "_id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["_id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct Channel: GraphQLSelectionSet {
          public static let possibleTypes = ["Channel"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "Channel", "_id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["_id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Customer: GraphQLSelectionSet {
        public static let possibleTypes = ["Customer"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("phone", type: .scalar(String.self)),
          GraphQLField("isUser", type: .scalar(Bool.self)),
          GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, visitorContactInfo: JSON? = nil) {
          self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "visitorContactInfo": visitorContactInfo])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var phone: String? {
          get {
            return resultMap["phone"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phone")
          }
        }

        public var isUser: Bool? {
          get {
            return resultMap["isUser"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isUser")
          }
        }

        public var visitorContactInfo: JSON? {
          get {
            return resultMap["visitorContactInfo"] as? JSON
          }
          set {
            resultMap.updateValue(newValue, forKey: "visitorContactInfo")
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["_id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct TwitterDatum: GraphQLSelectionSet {
        public static let possibleTypes = ["TwitterData"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("isDirectMessage", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isDirectMessage: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "TwitterData", "isDirectMessage": isDirectMessage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isDirectMessage: Bool? {
          get {
            return resultMap["isDirectMessage"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isDirectMessage")
          }
        }
      }

      public struct FacebookDatum: GraphQLSelectionSet {
        public static let possibleTypes = ["ConversationFacebookData"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("kind", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(kind: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ConversationFacebookData", "kind": kind])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var kind: String? {
          get {
            return resultMap["kind"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "kind")
          }
        }
      }
    }
  }
}

public final class ConversationsChangeStatusMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation conversationsChangeStatus($_ids: [String]!, $status: String!) {\n  conversationsChangeStatus(_ids: $_ids, status: $status) {\n    __typename\n    _id\n  }\n}"

  public var _ids: [String?]
  public var status: String

  public init(_ids: [String?], status: String) {
    self._ids = _ids
    self.status = status
  }

  public var variables: GraphQLMap? {
    return ["_ids": _ids, "status": status]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationsChangeStatus", arguments: ["_ids": GraphQLVariable("_ids"), "status": GraphQLVariable("status")], type: .list(.object(ConversationsChangeStatus.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationsChangeStatus: [ConversationsChangeStatus?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "conversationsChangeStatus": conversationsChangeStatus.flatMap { (value: [ConversationsChangeStatus?]) -> [ResultMap?] in value.map { (value: ConversationsChangeStatus?) -> ResultMap? in value.flatMap { (value: ConversationsChangeStatus) -> ResultMap in value.resultMap } } }])
    }

    public var conversationsChangeStatus: [ConversationsChangeStatus?]? {
      get {
        return (resultMap["conversationsChangeStatus"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ConversationsChangeStatus?] in value.map { (value: ResultMap?) -> ConversationsChangeStatus? in value.flatMap { (value: ResultMap) -> ConversationsChangeStatus in ConversationsChangeStatus(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [ConversationsChangeStatus?]) -> [ResultMap?] in value.map { (value: ConversationsChangeStatus?) -> ResultMap? in value.flatMap { (value: ConversationsChangeStatus) -> ResultMap in value.resultMap } } }, forKey: "conversationsChangeStatus")
      }
    }

    public struct ConversationsChangeStatus: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }
    }
  }
}

public final class ConversationsAssignMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation conversationsAssign($conversationIds: [String]!, $assignedUserId: String) {\n  conversationsAssign(conversationIds: $conversationIds, assignedUserId: $assignedUserId) {\n    __typename\n    _id\n  }\n}"

  public var conversationIds: [String?]
  public var assignedUserId: String?

  public init(conversationIds: [String?], assignedUserId: String? = nil) {
    self.conversationIds = conversationIds
    self.assignedUserId = assignedUserId
  }

  public var variables: GraphQLMap? {
    return ["conversationIds": conversationIds, "assignedUserId": assignedUserId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("conversationsAssign", arguments: ["conversationIds": GraphQLVariable("conversationIds"), "assignedUserId": GraphQLVariable("assignedUserId")], type: .list(.object(ConversationsAssign.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(conversationsAssign: [ConversationsAssign?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "conversationsAssign": conversationsAssign.flatMap { (value: [ConversationsAssign?]) -> [ResultMap?] in value.map { (value: ConversationsAssign?) -> ResultMap? in value.flatMap { (value: ConversationsAssign) -> ResultMap in value.resultMap } } }])
    }

    public var conversationsAssign: [ConversationsAssign?]? {
      get {
        return (resultMap["conversationsAssign"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ConversationsAssign?] in value.map { (value: ResultMap?) -> ConversationsAssign? in value.flatMap { (value: ResultMap) -> ConversationsAssign in ConversationsAssign(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [ConversationsAssign?]) -> [ResultMap?] in value.map { (value: ConversationsAssign?) -> ResultMap? in value.flatMap { (value: ConversationsAssign) -> ResultMap in value.resultMap } } }, forKey: "conversationsAssign")
      }
    }

    public struct ConversationsAssign: GraphQLSelectionSet {
      public static let possibleTypes = ["Conversation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String) {
        self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }
    }
  }
}

public final class GetUsersQuery: GraphQLQuery {
  public let operationDefinition =
    "query getUsers {\n  users {\n    __typename\n    ...UserData\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(UserData.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .list(.object(User.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "users": users.flatMap { (value: [User?]) -> [ResultMap?] in value.map { (value: User?) -> ResultMap? in value.flatMap { (value: User) -> ResultMap in value.resultMap } } }])
    }

    public var users: [User?]? {
      get {
        return (resultMap["users"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [User?] in value.map { (value: ResultMap?) -> User? in value.flatMap { (value: ResultMap) -> User in User(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [User?]) -> [ResultMap?] in value.map { (value: User?) -> ResultMap? in value.flatMap { (value: User) -> ResultMap in value.resultMap } } }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("details", type: .object(Detail.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, details: Detail? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "_id": id, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var details: Detail? {
        get {
          return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "details")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var userData: UserData {
          get {
            return UserData(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Detail: GraphQLSelectionSet {
        public static let possibleTypes = ["UserDetailsType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("fullName", type: .scalar(String.self)),
          GraphQLField("avatar", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(fullName: String? = nil, avatar: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName, "avatar": avatar])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fullName: String? {
          get {
            return resultMap["fullName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fullName")
          }
        }

        public var avatar: String? {
          get {
            return resultMap["avatar"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "avatar")
          }
        }
      }
    }
  }
}

public struct BrandDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment BrandDetail on Brand {\n  __typename\n  _id\n  name\n}"

  public static let possibleTypes = ["Brand"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Brand", "_id": id, "name": name])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }
}

public struct ChannelDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment ChannelDetail on Channel {\n  __typename\n  _id\n  name\n  description\n  integrationIds\n  memberIds\n  conversationCount\n  openConversationCount\n  integrations {\n    __typename\n    code\n    formId\n    formData\n    messengerData\n    twitterData\n    facebookData\n    uiOptions\n  }\n}"

  public static let possibleTypes = ["Channel"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("integrationIds", type: .list(.scalar(String.self))),
    GraphQLField("memberIds", type: .list(.scalar(String.self))),
    GraphQLField("conversationCount", type: .scalar(Int.self)),
    GraphQLField("openConversationCount", type: .scalar(Int.self)),
    GraphQLField("integrations", type: .list(.object(Integration.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String, description: String? = nil, integrationIds: [String?]? = nil, memberIds: [String?]? = nil, conversationCount: Int? = nil, openConversationCount: Int? = nil, integrations: [Integration?]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Channel", "_id": id, "name": name, "description": description, "integrationIds": integrationIds, "memberIds": memberIds, "conversationCount": conversationCount, "openConversationCount": openConversationCount, "integrations": integrations.flatMap { (value: [Integration?]) -> [ResultMap?] in value.map { (value: Integration?) -> ResultMap? in value.flatMap { (value: Integration) -> ResultMap in value.resultMap } } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var integrationIds: [String?]? {
    get {
      return resultMap["integrationIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "integrationIds")
    }
  }

  public var memberIds: [String?]? {
    get {
      return resultMap["memberIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "memberIds")
    }
  }

  public var conversationCount: Int? {
    get {
      return resultMap["conversationCount"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "conversationCount")
    }
  }

  public var openConversationCount: Int? {
    get {
      return resultMap["openConversationCount"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "openConversationCount")
    }
  }

  public var integrations: [Integration?]? {
    get {
      return (resultMap["integrations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Integration?] in value.map { (value: ResultMap?) -> Integration? in value.flatMap { (value: ResultMap) -> Integration in Integration(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Integration?]) -> [ResultMap?] in value.map { (value: Integration?) -> ResultMap? in value.flatMap { (value: Integration) -> ResultMap in value.resultMap } } }, forKey: "integrations")
    }
  }

  public struct Integration: GraphQLSelectionSet {
    public static let possibleTypes = ["Integration"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .scalar(String.self)),
      GraphQLField("formId", type: .scalar(String.self)),
      GraphQLField("formData", type: .scalar(JSON.self)),
      GraphQLField("messengerData", type: .scalar(JSON.self)),
      GraphQLField("twitterData", type: .scalar(JSON.self)),
      GraphQLField("facebookData", type: .scalar(JSON.self)),
      GraphQLField("uiOptions", type: .scalar(JSON.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(code: String? = nil, formId: String? = nil, formData: JSON? = nil, messengerData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, uiOptions: JSON? = nil) {
      self.init(unsafeResultMap: ["__typename": "Integration", "code": code, "formId": formId, "formData": formData, "messengerData": messengerData, "twitterData": twitterData, "facebookData": facebookData, "uiOptions": uiOptions])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var code: String? {
      get {
        return resultMap["code"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "code")
      }
    }

    public var formId: String? {
      get {
        return resultMap["formId"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "formId")
      }
    }

    public var formData: JSON? {
      get {
        return resultMap["formData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "formData")
      }
    }

    public var messengerData: JSON? {
      get {
        return resultMap["messengerData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "messengerData")
      }
    }

    public var twitterData: JSON? {
      get {
        return resultMap["twitterData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "twitterData")
      }
    }

    public var facebookData: JSON? {
      get {
        return resultMap["facebookData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "facebookData")
      }
    }

    public var uiOptions: JSON? {
      get {
        return resultMap["uiOptions"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "uiOptions")
      }
    }
  }
}

public struct TagDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment TagDetail on Tag {\n  __typename\n  _id\n  name\n  type\n  colorCode\n  objectCount\n}"

  public static let possibleTypes = ["Tag"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("type", type: .scalar(String.self)),
    GraphQLField("colorCode", type: .scalar(String.self)),
    GraphQLField("objectCount", type: .scalar(Int.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String? = nil, type: String? = nil, colorCode: String? = nil, objectCount: Int? = nil) {
    self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "type": type, "colorCode": colorCode, "objectCount": objectCount])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var type: String? {
    get {
      return resultMap["type"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "type")
    }
  }

  public var colorCode: String? {
    get {
      return resultMap["colorCode"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "colorCode")
    }
  }

  public var objectCount: Int? {
    get {
      return resultMap["objectCount"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "objectCount")
    }
  }
}

public struct MessageDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment MessageDetail on ConversationMessage {\n  __typename\n  _id\n  content\n  attachments\n  conversationId\n  customerId\n  userId\n  createdAt\n  user {\n    __typename\n    username\n    email\n    role\n    getNotificationByEmail\n    details {\n      __typename\n      avatar\n    }\n  }\n}"

  public static let possibleTypes = ["ConversationMessage"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("content", type: .scalar(String.self)),
    GraphQLField("attachments", type: .list(.scalar(JSON.self))),
    GraphQLField("conversationId", type: .scalar(String.self)),
    GraphQLField("customerId", type: .scalar(String.self)),
    GraphQLField("userId", type: .scalar(String.self)),
    GraphQLField("createdAt", type: .scalar(Int.self)),
    GraphQLField("user", type: .object(User.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, content: String? = nil, attachments: [JSON?]? = nil, conversationId: String? = nil, customerId: String? = nil, userId: String? = nil, createdAt: Int? = nil, user: User? = nil) {
    self.init(unsafeResultMap: ["__typename": "ConversationMessage", "_id": id, "content": content, "attachments": attachments, "conversationId": conversationId, "customerId": customerId, "userId": userId, "createdAt": createdAt, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var content: String? {
    get {
      return resultMap["content"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "content")
    }
  }

  public var attachments: [JSON?]? {
    get {
      return resultMap["attachments"] as? [JSON?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "attachments")
    }
  }

  public var conversationId: String? {
    get {
      return resultMap["conversationId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "conversationId")
    }
  }

  public var customerId: String? {
    get {
      return resultMap["customerId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "customerId")
    }
  }

  public var userId: String? {
    get {
      return resultMap["userId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "userId")
    }
  }

  public var createdAt: Int? {
    get {
      return resultMap["createdAt"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var user: User? {
    get {
      return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "user")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("username", type: .scalar(String.self)),
      GraphQLField("email", type: .scalar(String.self)),
      GraphQLField("role", type: .scalar(String.self)),
      GraphQLField("getNotificationByEmail", type: .scalar(Bool.self)),
      GraphQLField("details", type: .object(Detail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(username: String? = nil, email: String? = nil, role: String? = nil, getNotificationByEmail: Bool? = nil, details: Detail? = nil) {
      self.init(unsafeResultMap: ["__typename": "User", "username": username, "email": email, "role": role, "getNotificationByEmail": getNotificationByEmail, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var username: String? {
      get {
        return resultMap["username"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
      }
    }

    public var email: String? {
      get {
        return resultMap["email"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "email")
      }
    }

    public var role: String? {
      get {
        return resultMap["role"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "role")
      }
    }

    public var getNotificationByEmail: Bool? {
      get {
        return resultMap["getNotificationByEmail"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "getNotificationByEmail")
      }
    }

    public var details: Detail? {
      get {
        return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "details")
      }
    }

    public struct Detail: GraphQLSelectionSet {
      public static let possibleTypes = ["UserDetailsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatar", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(avatar: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var avatar: String? {
        get {
          return resultMap["avatar"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatar")
        }
      }
    }
  }
}

public struct CustomerDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CustomerDetail on Customer {\n  __typename\n  _id\n  firstName\n  lastName\n  email\n  phone\n  isUser\n  integrationId\n  createdAt\n  remoteAddress\n  location\n  visitorContactInfo\n  customFieldsData\n  twitterData\n  facebookData\n  ownerId\n  position\n  department\n  leadStatus\n  lifecycleState\n  hasAuthority\n  description\n  doNotDisturb\n  links {\n    __typename\n    linkedIn\n    twitter\n    facebook\n    github\n    youtube\n    website\n  }\n  owner {\n    __typename\n    details {\n      __typename\n      fullName\n    }\n  }\n  tagIds\n  getTags {\n    __typename\n    _id\n    name\n    colorCode\n  }\n}"

  public static let possibleTypes = ["Customer"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("firstName", type: .scalar(String.self)),
    GraphQLField("lastName", type: .scalar(String.self)),
    GraphQLField("email", type: .scalar(String.self)),
    GraphQLField("phone", type: .scalar(String.self)),
    GraphQLField("isUser", type: .scalar(Bool.self)),
    GraphQLField("integrationId", type: .scalar(String.self)),
    GraphQLField("createdAt", type: .scalar(Int.self)),
    GraphQLField("remoteAddress", type: .scalar(String.self)),
    GraphQLField("location", type: .scalar(JSON.self)),
    GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
    GraphQLField("customFieldsData", type: .scalar(JSON.self)),
    GraphQLField("twitterData", type: .scalar(JSON.self)),
    GraphQLField("facebookData", type: .scalar(JSON.self)),
    GraphQLField("ownerId", type: .scalar(String.self)),
    GraphQLField("position", type: .scalar(String.self)),
    GraphQLField("department", type: .scalar(String.self)),
    GraphQLField("leadStatus", type: .scalar(String.self)),
    GraphQLField("lifecycleState", type: .scalar(String.self)),
    GraphQLField("hasAuthority", type: .scalar(String.self)),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("doNotDisturb", type: .scalar(String.self)),
    GraphQLField("links", type: .object(Link.selections)),
    GraphQLField("owner", type: .object(Owner.selections)),
    GraphQLField("tagIds", type: .list(.scalar(String.self))),
    GraphQLField("getTags", type: .list(.object(GetTag.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, integrationId: String? = nil, createdAt: Int? = nil, remoteAddress: String? = nil, location: JSON? = nil, visitorContactInfo: JSON? = nil, customFieldsData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, ownerId: String? = nil, position: String? = nil, department: String? = nil, leadStatus: String? = nil, lifecycleState: String? = nil, hasAuthority: String? = nil, description: String? = nil, doNotDisturb: String? = nil, links: Link? = nil, owner: Owner? = nil, tagIds: [String?]? = nil, getTags: [GetTag?]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "integrationId": integrationId, "createdAt": createdAt, "remoteAddress": remoteAddress, "location": location, "visitorContactInfo": visitorContactInfo, "customFieldsData": customFieldsData, "twitterData": twitterData, "facebookData": facebookData, "ownerId": ownerId, "position": position, "department": department, "leadStatus": leadStatus, "lifecycleState": lifecycleState, "hasAuthority": hasAuthority, "description": description, "doNotDisturb": doNotDisturb, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }, "owner": owner.flatMap { (value: Owner) -> ResultMap in value.resultMap }, "tagIds": tagIds, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var phone: String? {
    get {
      return resultMap["phone"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var isUser: Bool? {
    get {
      return resultMap["isUser"] as? Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isUser")
    }
  }

  public var integrationId: String? {
    get {
      return resultMap["integrationId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "integrationId")
    }
  }

  public var createdAt: Int? {
    get {
      return resultMap["createdAt"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var remoteAddress: String? {
    get {
      return resultMap["remoteAddress"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "remoteAddress")
    }
  }

  public var location: JSON? {
    get {
      return resultMap["location"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "location")
    }
  }

  public var visitorContactInfo: JSON? {
    get {
      return resultMap["visitorContactInfo"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "visitorContactInfo")
    }
  }

  public var customFieldsData: JSON? {
    get {
      return resultMap["customFieldsData"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "customFieldsData")
    }
  }

  public var twitterData: JSON? {
    get {
      return resultMap["twitterData"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "twitterData")
    }
  }

  public var facebookData: JSON? {
    get {
      return resultMap["facebookData"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "facebookData")
    }
  }

  public var ownerId: String? {
    get {
      return resultMap["ownerId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "ownerId")
    }
  }

  public var position: String? {
    get {
      return resultMap["position"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "position")
    }
  }

  public var department: String? {
    get {
      return resultMap["department"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "department")
    }
  }

  public var leadStatus: String? {
    get {
      return resultMap["leadStatus"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "leadStatus")
    }
  }

  public var lifecycleState: String? {
    get {
      return resultMap["lifecycleState"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lifecycleState")
    }
  }

  public var hasAuthority: String? {
    get {
      return resultMap["hasAuthority"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasAuthority")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var doNotDisturb: String? {
    get {
      return resultMap["doNotDisturb"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "doNotDisturb")
    }
  }

  public var links: Link? {
    get {
      return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "links")
    }
  }

  public var owner: Owner? {
    get {
      return (resultMap["owner"] as? ResultMap).flatMap { Owner(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "owner")
    }
  }

  public var tagIds: [String?]? {
    get {
      return resultMap["tagIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "tagIds")
    }
  }

  public var getTags: [GetTag?]? {
    get {
      return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
    }
  }

  public struct Link: GraphQLSelectionSet {
    public static let possibleTypes = ["CustomerLinks"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("linkedIn", type: .scalar(String.self)),
      GraphQLField("twitter", type: .scalar(String.self)),
      GraphQLField("facebook", type: .scalar(String.self)),
      GraphQLField("github", type: .scalar(String.self)),
      GraphQLField("youtube", type: .scalar(String.self)),
      GraphQLField("website", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(linkedIn: String? = nil, twitter: String? = nil, facebook: String? = nil, github: String? = nil, youtube: String? = nil, website: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "CustomerLinks", "linkedIn": linkedIn, "twitter": twitter, "facebook": facebook, "github": github, "youtube": youtube, "website": website])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var linkedIn: String? {
      get {
        return resultMap["linkedIn"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "linkedIn")
      }
    }

    public var twitter: String? {
      get {
        return resultMap["twitter"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "twitter")
      }
    }

    public var facebook: String? {
      get {
        return resultMap["facebook"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "facebook")
      }
    }

    public var github: String? {
      get {
        return resultMap["github"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "github")
      }
    }

    public var youtube: String? {
      get {
        return resultMap["youtube"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "youtube")
      }
    }

    public var website: String? {
      get {
        return resultMap["website"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "website")
      }
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("details", type: .object(Detail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(details: Detail? = nil) {
      self.init(unsafeResultMap: ["__typename": "User", "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var details: Detail? {
      get {
        return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "details")
      }
    }

    public struct Detail: GraphQLSelectionSet {
      public static let possibleTypes = ["UserDetailsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("fullName", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fullName: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fullName: String? {
        get {
          return resultMap["fullName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fullName")
        }
      }
    }
  }

  public struct GetTag: GraphQLSelectionSet {
    public static let possibleTypes = ["Tag"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("colorCode", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String? = nil, colorCode: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var colorCode: String? {
      get {
        return resultMap["colorCode"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "colorCode")
      }
    }
  }
}

public struct CompanyDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CompanyDetail on Company {\n  __typename\n  _id\n  name\n  size\n  industry\n  website\n  plan\n  customFieldsData\n  tagIds\n  getTags {\n    __typename\n    _id\n    name\n    colorCode\n  }\n}"

  public static let possibleTypes = ["Company"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("size", type: .scalar(Int.self)),
    GraphQLField("industry", type: .scalar(String.self)),
    GraphQLField("website", type: .scalar(String.self)),
    GraphQLField("plan", type: .scalar(String.self)),
    GraphQLField("customFieldsData", type: .scalar(JSON.self)),
    GraphQLField("tagIds", type: .list(.scalar(String.self))),
    GraphQLField("getTags", type: .list(.object(GetTag.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String? = nil, size: Int? = nil, industry: String? = nil, website: String? = nil, plan: String? = nil, customFieldsData: JSON? = nil, tagIds: [String?]? = nil, getTags: [GetTag?]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Company", "_id": id, "name": name, "size": size, "industry": industry, "website": website, "plan": plan, "customFieldsData": customFieldsData, "tagIds": tagIds, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var size: Int? {
    get {
      return resultMap["size"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "size")
    }
  }

  public var industry: String? {
    get {
      return resultMap["industry"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "industry")
    }
  }

  public var website: String? {
    get {
      return resultMap["website"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "website")
    }
  }

  public var plan: String? {
    get {
      return resultMap["plan"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "plan")
    }
  }

  public var customFieldsData: JSON? {
    get {
      return resultMap["customFieldsData"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "customFieldsData")
    }
  }

  public var tagIds: [String?]? {
    get {
      return resultMap["tagIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "tagIds")
    }
  }

  public var getTags: [GetTag?]? {
    get {
      return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
    }
  }

  public struct GetTag: GraphQLSelectionSet {
    public static let possibleTypes = ["Tag"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("colorCode", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String? = nil, colorCode: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var colorCode: String? {
      get {
        return resultMap["colorCode"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "colorCode")
      }
    }
  }
}

public struct CustomerInfo: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment CustomerInfo on Customer {\n  __typename\n  _id\n  integration {\n    __typename\n    kind\n    brand {\n      __typename\n      name\n    }\n    channels {\n      __typename\n      name\n    }\n  }\n  conversations {\n    __typename\n    createdAt\n    status\n    updatedAt\n  }\n  firstName\n  lastName\n  email\n  phone\n  isUser\n  visitorContactInfo\n  position\n  department\n  leadStatus\n  lifecycleState\n  hasAuthority\n  description\n  doNotDisturb\n  links {\n    __typename\n    linkedIn\n    twitter\n    facebook\n    github\n    youtube\n    website\n  }\n  owner {\n    __typename\n    details {\n      __typename\n      fullName\n    }\n  }\n  companies {\n    __typename\n    _id\n    name\n    website\n    industry\n  }\n  messengerData\n  getTags {\n    __typename\n    _id\n    name\n    colorCode\n  }\n}"

  public static let possibleTypes = ["Customer"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("integration", type: .object(Integration.selections)),
    GraphQLField("conversations", type: .list(.object(Conversation.selections))),
    GraphQLField("firstName", type: .scalar(String.self)),
    GraphQLField("lastName", type: .scalar(String.self)),
    GraphQLField("email", type: .scalar(String.self)),
    GraphQLField("phone", type: .scalar(String.self)),
    GraphQLField("isUser", type: .scalar(Bool.self)),
    GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
    GraphQLField("position", type: .scalar(String.self)),
    GraphQLField("department", type: .scalar(String.self)),
    GraphQLField("leadStatus", type: .scalar(String.self)),
    GraphQLField("lifecycleState", type: .scalar(String.self)),
    GraphQLField("hasAuthority", type: .scalar(String.self)),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("doNotDisturb", type: .scalar(String.self)),
    GraphQLField("links", type: .object(Link.selections)),
    GraphQLField("owner", type: .object(Owner.selections)),
    GraphQLField("companies", type: .list(.object(Company.selections))),
    GraphQLField("messengerData", type: .scalar(JSON.self)),
    GraphQLField("getTags", type: .list(.object(GetTag.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, integration: Integration? = nil, conversations: [Conversation?]? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, visitorContactInfo: JSON? = nil, position: String? = nil, department: String? = nil, leadStatus: String? = nil, lifecycleState: String? = nil, hasAuthority: String? = nil, description: String? = nil, doNotDisturb: String? = nil, links: Link? = nil, owner: Owner? = nil, companies: [Company?]? = nil, messengerData: JSON? = nil, getTags: [GetTag?]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "integration": integration.flatMap { (value: Integration) -> ResultMap in value.resultMap }, "conversations": conversations.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "visitorContactInfo": visitorContactInfo, "position": position, "department": department, "leadStatus": leadStatus, "lifecycleState": lifecycleState, "hasAuthority": hasAuthority, "description": description, "doNotDisturb": doNotDisturb, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }, "owner": owner.flatMap { (value: Owner) -> ResultMap in value.resultMap }, "companies": companies.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }, "messengerData": messengerData, "getTags": getTags.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var integration: Integration? {
    get {
      return (resultMap["integration"] as? ResultMap).flatMap { Integration(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "integration")
    }
  }

  public var conversations: [Conversation?]? {
    get {
      return (resultMap["conversations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Conversation?] in value.map { (value: ResultMap?) -> Conversation? in value.flatMap { (value: ResultMap) -> Conversation in Conversation(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Conversation?]) -> [ResultMap?] in value.map { (value: Conversation?) -> ResultMap? in value.flatMap { (value: Conversation) -> ResultMap in value.resultMap } } }, forKey: "conversations")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var phone: String? {
    get {
      return resultMap["phone"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var isUser: Bool? {
    get {
      return resultMap["isUser"] as? Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isUser")
    }
  }

  public var visitorContactInfo: JSON? {
    get {
      return resultMap["visitorContactInfo"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "visitorContactInfo")
    }
  }

  public var position: String? {
    get {
      return resultMap["position"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "position")
    }
  }

  public var department: String? {
    get {
      return resultMap["department"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "department")
    }
  }

  public var leadStatus: String? {
    get {
      return resultMap["leadStatus"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "leadStatus")
    }
  }

  public var lifecycleState: String? {
    get {
      return resultMap["lifecycleState"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lifecycleState")
    }
  }

  public var hasAuthority: String? {
    get {
      return resultMap["hasAuthority"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasAuthority")
    }
  }

  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var doNotDisturb: String? {
    get {
      return resultMap["doNotDisturb"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "doNotDisturb")
    }
  }

  public var links: Link? {
    get {
      return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "links")
    }
  }

  public var owner: Owner? {
    get {
      return (resultMap["owner"] as? ResultMap).flatMap { Owner(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "owner")
    }
  }

  public var companies: [Company?]? {
    get {
      return (resultMap["companies"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Company?] in value.map { (value: ResultMap?) -> Company? in value.flatMap { (value: ResultMap) -> Company in Company(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Company?]) -> [ResultMap?] in value.map { (value: Company?) -> ResultMap? in value.flatMap { (value: Company) -> ResultMap in value.resultMap } } }, forKey: "companies")
    }
  }

  public var messengerData: JSON? {
    get {
      return resultMap["messengerData"] as? JSON
    }
    set {
      resultMap.updateValue(newValue, forKey: "messengerData")
    }
  }

  public var getTags: [GetTag?]? {
    get {
      return (resultMap["getTags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetTag?] in value.map { (value: ResultMap?) -> GetTag? in value.flatMap { (value: ResultMap) -> GetTag in GetTag(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [GetTag?]) -> [ResultMap?] in value.map { (value: GetTag?) -> ResultMap? in value.flatMap { (value: GetTag) -> ResultMap in value.resultMap } } }, forKey: "getTags")
    }
  }

  public struct Integration: GraphQLSelectionSet {
    public static let possibleTypes = ["Integration"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("kind", type: .nonNull(.scalar(String.self))),
      GraphQLField("brand", type: .object(Brand.selections)),
      GraphQLField("channels", type: .list(.object(Channel.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kind: String, brand: Brand? = nil, channels: [Channel?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Integration", "kind": kind, "brand": brand.flatMap { (value: Brand) -> ResultMap in value.resultMap }, "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var kind: String {
      get {
        return resultMap["kind"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "kind")
      }
    }

    public var brand: Brand? {
      get {
        return (resultMap["brand"] as? ResultMap).flatMap { Brand(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "brand")
      }
    }

    public var channels: [Channel?]? {
      get {
        return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
      }
    }

    public struct Brand: GraphQLSelectionSet {
      public static let possibleTypes = ["Brand"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Brand", "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }

    public struct Channel: GraphQLSelectionSet {
      public static let possibleTypes = ["Channel"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String) {
        self.init(unsafeResultMap: ["__typename": "Channel", "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }

  public struct Conversation: GraphQLSelectionSet {
    public static let possibleTypes = ["Conversation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("createdAt", type: .scalar(Int.self)),
      GraphQLField("status", type: .scalar(String.self)),
      GraphQLField("updatedAt", type: .scalar(Int.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createdAt: Int? = nil, status: String? = nil, updatedAt: Int? = nil) {
      self.init(unsafeResultMap: ["__typename": "Conversation", "createdAt": createdAt, "status": status, "updatedAt": updatedAt])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var createdAt: Int? {
      get {
        return resultMap["createdAt"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "createdAt")
      }
    }

    public var status: String? {
      get {
        return resultMap["status"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "status")
      }
    }

    public var updatedAt: Int? {
      get {
        return resultMap["updatedAt"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "updatedAt")
      }
    }
  }

  public struct Link: GraphQLSelectionSet {
    public static let possibleTypes = ["CustomerLinks"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("linkedIn", type: .scalar(String.self)),
      GraphQLField("twitter", type: .scalar(String.self)),
      GraphQLField("facebook", type: .scalar(String.self)),
      GraphQLField("github", type: .scalar(String.self)),
      GraphQLField("youtube", type: .scalar(String.self)),
      GraphQLField("website", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(linkedIn: String? = nil, twitter: String? = nil, facebook: String? = nil, github: String? = nil, youtube: String? = nil, website: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "CustomerLinks", "linkedIn": linkedIn, "twitter": twitter, "facebook": facebook, "github": github, "youtube": youtube, "website": website])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var linkedIn: String? {
      get {
        return resultMap["linkedIn"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "linkedIn")
      }
    }

    public var twitter: String? {
      get {
        return resultMap["twitter"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "twitter")
      }
    }

    public var facebook: String? {
      get {
        return resultMap["facebook"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "facebook")
      }
    }

    public var github: String? {
      get {
        return resultMap["github"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "github")
      }
    }

    public var youtube: String? {
      get {
        return resultMap["youtube"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "youtube")
      }
    }

    public var website: String? {
      get {
        return resultMap["website"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "website")
      }
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("details", type: .object(Detail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(details: Detail? = nil) {
      self.init(unsafeResultMap: ["__typename": "User", "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var details: Detail? {
      get {
        return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "details")
      }
    }

    public struct Detail: GraphQLSelectionSet {
      public static let possibleTypes = ["UserDetailsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("fullName", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fullName: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fullName: String? {
        get {
          return resultMap["fullName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fullName")
        }
      }
    }
  }

  public struct Company: GraphQLSelectionSet {
    public static let possibleTypes = ["Company"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("website", type: .scalar(String.self)),
      GraphQLField("industry", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String? = nil, website: String? = nil, industry: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Company", "_id": id, "name": name, "website": website, "industry": industry])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var website: String? {
      get {
        return resultMap["website"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "website")
      }
    }

    public var industry: String? {
      get {
        return resultMap["industry"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "industry")
      }
    }
  }

  public struct GetTag: GraphQLSelectionSet {
    public static let possibleTypes = ["Tag"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("colorCode", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String? = nil, colorCode: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name, "colorCode": colorCode])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var colorCode: String? {
      get {
        return resultMap["colorCode"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "colorCode")
      }
    }
  }
}

public struct ConversationDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment ConversationDetail on Conversation {\n  __typename\n  _id\n  content\n  createdAt\n  customerId\n  customer {\n    __typename\n    integrationId\n    firstName\n    lastName\n    email\n    phone\n    isUser\n    createdAt\n    remoteAddress\n    internalNotes\n    location\n    customFieldsData\n    messengerData\n    twitterData\n    facebookData\n    getIntegrationData\n  }\n}"

  public static let possibleTypes = ["Conversation"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("content", type: .scalar(String.self)),
    GraphQLField("createdAt", type: .scalar(Int.self)),
    GraphQLField("customerId", type: .scalar(String.self)),
    GraphQLField("customer", type: .object(Customer.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, content: String? = nil, createdAt: Int? = nil, customerId: String? = nil, customer: Customer? = nil) {
    self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id, "content": content, "createdAt": createdAt, "customerId": customerId, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var content: String? {
    get {
      return resultMap["content"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "content")
    }
  }

  public var createdAt: Int? {
    get {
      return resultMap["createdAt"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var customerId: String? {
    get {
      return resultMap["customerId"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "customerId")
    }
  }

  public var customer: Customer? {
    get {
      return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "customer")
    }
  }

  public struct Customer: GraphQLSelectionSet {
    public static let possibleTypes = ["Customer"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("integrationId", type: .scalar(String.self)),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("email", type: .scalar(String.self)),
      GraphQLField("phone", type: .scalar(String.self)),
      GraphQLField("isUser", type: .scalar(Bool.self)),
      GraphQLField("createdAt", type: .scalar(Int.self)),
      GraphQLField("remoteAddress", type: .scalar(String.self)),
      GraphQLField("internalNotes", type: .scalar(JSON.self)),
      GraphQLField("location", type: .scalar(JSON.self)),
      GraphQLField("customFieldsData", type: .scalar(JSON.self)),
      GraphQLField("messengerData", type: .scalar(JSON.self)),
      GraphQLField("twitterData", type: .scalar(JSON.self)),
      GraphQLField("facebookData", type: .scalar(JSON.self)),
      GraphQLField("getIntegrationData", type: .scalar(JSON.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(integrationId: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, createdAt: Int? = nil, remoteAddress: String? = nil, internalNotes: JSON? = nil, location: JSON? = nil, customFieldsData: JSON? = nil, messengerData: JSON? = nil, twitterData: JSON? = nil, facebookData: JSON? = nil, getIntegrationData: JSON? = nil) {
      self.init(unsafeResultMap: ["__typename": "Customer", "integrationId": integrationId, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "createdAt": createdAt, "remoteAddress": remoteAddress, "internalNotes": internalNotes, "location": location, "customFieldsData": customFieldsData, "messengerData": messengerData, "twitterData": twitterData, "facebookData": facebookData, "getIntegrationData": getIntegrationData])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var integrationId: String? {
      get {
        return resultMap["integrationId"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "integrationId")
      }
    }

    public var firstName: String? {
      get {
        return resultMap["firstName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "firstName")
      }
    }

    public var lastName: String? {
      get {
        return resultMap["lastName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

    public var email: String? {
      get {
        return resultMap["email"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "email")
      }
    }

    public var phone: String? {
      get {
        return resultMap["phone"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "phone")
      }
    }

    public var isUser: Bool? {
      get {
        return resultMap["isUser"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "isUser")
      }
    }

    public var createdAt: Int? {
      get {
        return resultMap["createdAt"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "createdAt")
      }
    }

    public var remoteAddress: String? {
      get {
        return resultMap["remoteAddress"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "remoteAddress")
      }
    }

    public var internalNotes: JSON? {
      get {
        return resultMap["internalNotes"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "internalNotes")
      }
    }

    public var location: JSON? {
      get {
        return resultMap["location"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "location")
      }
    }

    public var customFieldsData: JSON? {
      get {
        return resultMap["customFieldsData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "customFieldsData")
      }
    }

    public var messengerData: JSON? {
      get {
        return resultMap["messengerData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "messengerData")
      }
    }

    public var twitterData: JSON? {
      get {
        return resultMap["twitterData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "twitterData")
      }
    }

    public var facebookData: JSON? {
      get {
        return resultMap["facebookData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "facebookData")
      }
    }

    public var getIntegrationData: JSON? {
      get {
        return resultMap["getIntegrationData"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "getIntegrationData")
      }
    }
  }
}

public struct ObjectDetail: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment ObjectDetail on Conversation {\n  __typename\n  _id\n  content\n  updatedAt\n  status\n  assignedUser {\n    __typename\n    _id\n    details {\n      __typename\n      avatar\n    }\n  }\n  integration {\n    __typename\n    _id\n    kind\n    brand {\n      __typename\n      _id\n      name\n    }\n    channels {\n      __typename\n      _id\n      name\n    }\n  }\n  customer {\n    __typename\n    _id\n    firstName\n    lastName\n    email\n    phone\n    isUser\n    visitorContactInfo\n  }\n  tagIds\n  tags {\n    __typename\n    _id\n    name\n  }\n  readUserIds\n  twitterData {\n    __typename\n    isDirectMessage\n  }\n  facebookData {\n    __typename\n    kind\n  }\n}"

  public static let possibleTypes = ["Conversation"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("content", type: .scalar(String.self)),
    GraphQLField("updatedAt", type: .scalar(Int.self)),
    GraphQLField("status", type: .scalar(String.self)),
    GraphQLField("assignedUser", type: .object(AssignedUser.selections)),
    GraphQLField("integration", type: .object(Integration.selections)),
    GraphQLField("customer", type: .object(Customer.selections)),
    GraphQLField("tagIds", type: .list(.scalar(String.self))),
    GraphQLField("tags", type: .list(.object(Tag.selections))),
    GraphQLField("readUserIds", type: .list(.scalar(String.self))),
    GraphQLField("twitterData", type: .object(TwitterDatum.selections)),
    GraphQLField("facebookData", type: .object(FacebookDatum.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, content: String? = nil, updatedAt: Int? = nil, status: String? = nil, assignedUser: AssignedUser? = nil, integration: Integration? = nil, customer: Customer? = nil, tagIds: [String?]? = nil, tags: [Tag?]? = nil, readUserIds: [String?]? = nil, twitterData: TwitterDatum? = nil, facebookData: FacebookDatum? = nil) {
    self.init(unsafeResultMap: ["__typename": "Conversation", "_id": id, "content": content, "updatedAt": updatedAt, "status": status, "assignedUser": assignedUser.flatMap { (value: AssignedUser) -> ResultMap in value.resultMap }, "integration": integration.flatMap { (value: Integration) -> ResultMap in value.resultMap }, "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }, "tagIds": tagIds, "tags": tags.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, "readUserIds": readUserIds, "twitterData": twitterData.flatMap { (value: TwitterDatum) -> ResultMap in value.resultMap }, "facebookData": facebookData.flatMap { (value: FacebookDatum) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var content: String? {
    get {
      return resultMap["content"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "content")
    }
  }

  public var updatedAt: Int? {
    get {
      return resultMap["updatedAt"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "updatedAt")
    }
  }

  public var status: String? {
    get {
      return resultMap["status"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "status")
    }
  }

  public var assignedUser: AssignedUser? {
    get {
      return (resultMap["assignedUser"] as? ResultMap).flatMap { AssignedUser(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "assignedUser")
    }
  }

  public var integration: Integration? {
    get {
      return (resultMap["integration"] as? ResultMap).flatMap { Integration(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "integration")
    }
  }

  public var customer: Customer? {
    get {
      return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "customer")
    }
  }

  public var tagIds: [String?]? {
    get {
      return resultMap["tagIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "tagIds")
    }
  }

  public var tags: [Tag?]? {
    get {
      return (resultMap["tags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Tag?] in value.map { (value: ResultMap?) -> Tag? in value.flatMap { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, forKey: "tags")
    }
  }

  public var readUserIds: [String?]? {
    get {
      return resultMap["readUserIds"] as? [String?]
    }
    set {
      resultMap.updateValue(newValue, forKey: "readUserIds")
    }
  }

  public var twitterData: TwitterDatum? {
    get {
      return (resultMap["twitterData"] as? ResultMap).flatMap { TwitterDatum(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "twitterData")
    }
  }

  public var facebookData: FacebookDatum? {
    get {
      return (resultMap["facebookData"] as? ResultMap).flatMap { FacebookDatum(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "facebookData")
    }
  }

  public struct AssignedUser: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("details", type: .object(Detail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, details: Detail? = nil) {
      self.init(unsafeResultMap: ["__typename": "User", "_id": id, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var details: Detail? {
      get {
        return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "details")
      }
    }

    public struct Detail: GraphQLSelectionSet {
      public static let possibleTypes = ["UserDetailsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatar", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(avatar: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserDetailsType", "avatar": avatar])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var avatar: String? {
        get {
          return resultMap["avatar"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatar")
        }
      }
    }
  }

  public struct Integration: GraphQLSelectionSet {
    public static let possibleTypes = ["Integration"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("kind", type: .nonNull(.scalar(String.self))),
      GraphQLField("brand", type: .object(Brand.selections)),
      GraphQLField("channels", type: .list(.object(Channel.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, kind: String, brand: Brand? = nil, channels: [Channel?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Integration", "_id": id, "kind": kind, "brand": brand.flatMap { (value: Brand) -> ResultMap in value.resultMap }, "channels": channels.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var kind: String {
      get {
        return resultMap["kind"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "kind")
      }
    }

    public var brand: Brand? {
      get {
        return (resultMap["brand"] as? ResultMap).flatMap { Brand(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "brand")
      }
    }

    public var channels: [Channel?]? {
      get {
        return (resultMap["channels"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Channel?] in value.map { (value: ResultMap?) -> Channel? in value.flatMap { (value: ResultMap) -> Channel in Channel(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Channel?]) -> [ResultMap?] in value.map { (value: Channel?) -> ResultMap? in value.flatMap { (value: Channel) -> ResultMap in value.resultMap } } }, forKey: "channels")
      }
    }

    public struct Brand: GraphQLSelectionSet {
      public static let possibleTypes = ["Brand"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Brand", "_id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }

    public struct Channel: GraphQLSelectionSet {
      public static let possibleTypes = ["Channel"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String) {
        self.init(unsafeResultMap: ["__typename": "Channel", "_id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }

  public struct Customer: GraphQLSelectionSet {
    public static let possibleTypes = ["Customer"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("email", type: .scalar(String.self)),
      GraphQLField("phone", type: .scalar(String.self)),
      GraphQLField("isUser", type: .scalar(Bool.self)),
      GraphQLField("visitorContactInfo", type: .scalar(JSON.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, isUser: Bool? = nil, visitorContactInfo: JSON? = nil) {
      self.init(unsafeResultMap: ["__typename": "Customer", "_id": id, "firstName": firstName, "lastName": lastName, "email": email, "phone": phone, "isUser": isUser, "visitorContactInfo": visitorContactInfo])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var firstName: String? {
      get {
        return resultMap["firstName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "firstName")
      }
    }

    public var lastName: String? {
      get {
        return resultMap["lastName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

    public var email: String? {
      get {
        return resultMap["email"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "email")
      }
    }

    public var phone: String? {
      get {
        return resultMap["phone"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "phone")
      }
    }

    public var isUser: Bool? {
      get {
        return resultMap["isUser"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "isUser")
      }
    }

    public var visitorContactInfo: JSON? {
      get {
        return resultMap["visitorContactInfo"] as? JSON
      }
      set {
        resultMap.updateValue(newValue, forKey: "visitorContactInfo")
      }
    }
  }

  public struct Tag: GraphQLSelectionSet {
    public static let possibleTypes = ["Tag"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("_id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Tag", "_id": id, "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["_id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "_id")
      }
    }

    public var name: String? {
      get {
        return resultMap["name"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }

  public struct TwitterDatum: GraphQLSelectionSet {
    public static let possibleTypes = ["TwitterData"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("isDirectMessage", type: .scalar(Bool.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(isDirectMessage: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "TwitterData", "isDirectMessage": isDirectMessage])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var isDirectMessage: Bool? {
      get {
        return resultMap["isDirectMessage"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "isDirectMessage")
      }
    }
  }

  public struct FacebookDatum: GraphQLSelectionSet {
    public static let possibleTypes = ["ConversationFacebookData"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("kind", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kind: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "ConversationFacebookData", "kind": kind])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var kind: String? {
      get {
        return resultMap["kind"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "kind")
      }
    }
  }
}

public struct UserData: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment UserData on User {\n  __typename\n  _id\n  details {\n    __typename\n    fullName\n    avatar\n  }\n}"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("_id", type: .nonNull(.scalar(String.self))),
    GraphQLField("details", type: .object(Detail.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, details: Detail? = nil) {
    self.init(unsafeResultMap: ["__typename": "User", "_id": id, "details": details.flatMap { (value: Detail) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["_id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "_id")
    }
  }

  public var details: Detail? {
    get {
      return (resultMap["details"] as? ResultMap).flatMap { Detail(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "details")
    }
  }

  public struct Detail: GraphQLSelectionSet {
    public static let possibleTypes = ["UserDetailsType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("fullName", type: .scalar(String.self)),
      GraphQLField("avatar", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fullName: String? = nil, avatar: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "UserDetailsType", "fullName": fullName, "avatar": avatar])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var fullName: String? {
      get {
        return resultMap["fullName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "fullName")
      }
    }

    public var avatar: String? {
      get {
        return resultMap["avatar"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatar")
      }
    }
  }
}