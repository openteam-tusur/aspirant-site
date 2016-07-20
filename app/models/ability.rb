class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :create, to: :modify

    return unless user

    if user.clerk?
      can :manage , [:dashboard, :angular]
      can :manage, [Person, CouncilSpeciality, FileCopy]

      can :manage, Advert, dissertation_council_id: user.available_contexts.map(&:id)
      can :create, Advert

      can :manage, DissertationCouncil, id: user.available_contexts.map(&:id)
    end

    can :manage, :all if user.admin?
  end

end
