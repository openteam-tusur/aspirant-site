SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :permissions, t('app.manage'), manage_root_path,
      highlights_on: /manage$/,
      if: -> { can?(:manage, DissertationCouncil) }
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
