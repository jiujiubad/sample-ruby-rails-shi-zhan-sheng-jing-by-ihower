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

在 Rails 5.1 之前，处理 HTML 表单有两个接口：针对模型实例的 form_for 和针对自定义 URL 的 form_tag。<https://ruby-china.github.io/rails-guides/5_1_release_notes.html>