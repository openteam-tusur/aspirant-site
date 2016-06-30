SimpleNavigation::Configuration.run do |navigation|

  navigation.selected_class = 'active'

  navigation.items do |primary|

    primary.item :permissions, 'Диссертационные советы', manage_dissertation_councils_path,
      highlights_on: /\/manage\/manage_dissertation_councils/,
      if: -> { can?(:manage, DissertationCouncil) }

    primary.item :permissions, 'Управление правами', manage_permissions_path,
      highlights_on: /\/manage\/permissions/,
      if: -> { can?(:manage, Permission) }
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
