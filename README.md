#### 1 用户系统

1 用户可以注册、登录。需要 id（可以自己决定 email 或者 username）和 password

参考：[devise](https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address ) 

#### 2 朋友系统

实现方法: 用关联表 friendship：

```
user_id
friend_id
```

防止重复加好友，在model 里面验证，在数据库中加上索引

- 用户登录后，进入联系人列表页面
- 可以看到自己所有的联系人""
- 每个联系人需要显示对方 id 
- 用户可以通过 id 添加新联系人 (不要重复)
- 用户可以删除某个联系人

#### 3 私信系统

创建两个model

1、message :user_id ,:conversation_Id,:content

2、conversation :sender_id,recipient_id

- 每个联系人需要显示对方 id 以及未读私信数量提醒
  - 找到与某个联系人的 conversation
  - 找到所有的通信 
  - 找出与某人的对话中未读信息数量
- 能够在这里收发私信（不需要实时，可以刷一下页面才看到新消息）
- 用户可以删除自己发的消息
- 当用户 A 发私信给用户 B 时，如果 A 还不是 B 的联系人，应该自动把 A 添加为 B 的联系人，并能够在 B 的联系人列表正常显示（不需要实时）
- 点击一个联系人会进入聊天界面，同时未读消息置为 0
  - ‘/conversation/:id/messages’
  - 找出特定 conversation 里面所有的会话，之后找出属于 sender 的所有message，将 is_read 置为 true。
- 可以看到和某个用户的历史消息
  - 1.1 用 ajax 动态显示
- 能够在这里收发私信
- 当用户 A 发私信给用户 B 时，如果 A 还不是 B 的联系人，应该自动把 A 添加为 B 的联系人，并能够在 B 的联系人列表正常显示（不需要实时）
- 用户可以删除某个联系人，但保留与对方用户的消息等数据。当再次添加新联系人时，消息等数据都还在

### 加分项：

### 4 实时更新

使用 rails 5 的 channel 来实现  web-sockets

- 聊天界面新消息实时接收[参考文章](https://www.nopio.com/blog/rails-chat-application-actioncable/) 

  - 当sender 发送信息的时候，将 message 的 partial 渲染好发给reciever
  - reciever 端通过 js 将收到的渲染好的部分显示在网页上

- A 与 B 联系人进行对话时时，如果 B里面没有 A 则将 B 添加为朋友

  - 与上一步的实现方式相似

-  自动把 A 添加为 B 联系人时，B 实时更新联系人列表 （待完成）

- 部署到网站（尝试参考[文章](https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable) 部署到 heroku 部署上去后没有成功，暂时没有发现问题）

  ​