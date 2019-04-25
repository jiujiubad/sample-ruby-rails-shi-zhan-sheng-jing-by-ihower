# 《Ruby On Rails 实战圣经》示例代码

作者 ihower：https://ihower.tw/rails/index-cn.html 

## 目录

* 1.Ruby on Rails简介
* 2.安装Rails开发环境
* 3.Rails起步走
* 4.Ruby程式语言入门
* 5.手工打造CRUD应用程式
* 6.RESTful应用程式
* 7.Active Record基本操作与关联设计
* 8.RESTful综合应用

## 常用代码

app/controllers/event_locations_controller.rb
```
def new
  @location = @event.build_location
end
```

form_with
```
<%= form_with model: [@event, @attendee], local: true do |f| %>

<%= form_with model: @location, url: event_location_path(@event), local: true do |f| %>
```

accepts_nested_attributes_for：<https://ruby-china.github.io/rails-guides/v4.1/form_helpers.html>


有效：云豹没有用 collection 之类的表单方法（像是旧版用的多），比如 collection_check_boxes：<https://ruby-china.github.io/rails-guides/v5.0/action_view_overview.html>

```
<%= f.collection_check_boxes(:group_ids, Group.all, :id, :name) %>
```

没效：check_box_tag：<https://ruby-china.github.io/rails-guides/form_helpers.html>

```
  <% @event.groups.each do |g| %>
    <%= check_box_tag "event[group_ids][]", g.id, @event.groups.map(&:id).include?(g.id) %> <%= g.name %>
  <% end %>
  <%= hidden_field_tag 'event[group_ids][]','' %>
```

## form_with

在 Rails 5.1 之前，处理 HTML 表单有两个接口：针对模型实例的 form_for 和针对自定义 URL 的 form_tag。<https://ruby-china.github.io/rails-guides/5_1_release_notes.html>

默认 post 改为 get：
```
<%= form_with method: :get, url: users_path, local: true do |form| %><% end %>
```

《rails guides》：<https://ruby-china.github.io/rails-guides/5_1_release_notes.html>

安道1：<https://rails.guide/book/getting_started.html>

安道2：<https://rails.guide/book/working_with_javascript_in_rails.html>
