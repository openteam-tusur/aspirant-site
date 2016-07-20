class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    if user.clerk?
      can :manage, [Person, CouncilSpeciality, FileCopy]

      can :manage, Advert do |advert|
        user.available_contexts.include? advert.dissertation_council
      end
      can :manage, DissertationCouncil do |council|
        user.available_contexts.include? council
      end
    end

    can :manage, :all if user.admin?
  end

end
