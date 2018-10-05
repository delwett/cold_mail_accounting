ActiveAdmin.register_page "Dashboard" do
  page_action :graph, method: :get do
    @states = Letter.aasm.states.map(&:name)
    @dataset = []

    User.find_each do |user|
      @dataset << {
        label: user.user_name,
        data: Letter.get_count(@states, user.letters).values,
        backgroundColor: '#' + Random.new.bytes(3).unpack('H*')[0]
      }
    end
  end
  page_action :index, method: :get do
    graph
  end
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    render partial: 'chart'
  end
end
