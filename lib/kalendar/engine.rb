module Kalendar
  class Engine < Rails::Engine
    initializer "kalendar" do
      ActionView::Base.include(Helper)
    end
  end
end
