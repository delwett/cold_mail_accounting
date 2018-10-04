ActiveAdmin.register_page "Dashboard" do

  page_action :graph, method: :get do
    @lable = []
    @data = []
    Letter.all.group_by(&:user_id).map do |id,letters|
      User.where(id: id).map do |record|
        @lable << record.user_name
      end
      @data << letters.count
    end
  end
  page_action :index, method: :get do
    graph
  end
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
    render partial: 'chart'
  end
end
