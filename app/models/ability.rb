# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :read, Hotel
      can :manage, User
      # can :update, Hotel
      can :read, Room
      can :create, Room
      can :update, Room
      can :destroy, Room

      # Add other manager-specific abilities as needed
    elsif user.customer?
      can :read, Hotel  
      can :read, Room
      can :create, Booking
      can :read, Booking, user_id: user.id
      can :update, Booking, user_id: user.id
      can :destroy, Booking, user_id: user.id
    end
    
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
