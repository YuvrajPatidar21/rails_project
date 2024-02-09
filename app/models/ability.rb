# frozen_string_literal: true

class Ability
  include CanCan::Ability

    def initialize(user)
    user ||= User.new

    if user.owner?
      can :manage, :all
    elsif user.manager?
      can :read, Hotel
      can :manage, User 
      can :read, Room
      can :create, Room
      can :update, Room
      can :destroy, Room
      can :create, Booking
      can :read, Booking
      can :destroy, Booking
      can :create, Payment
      can :read, Payment
    elsif user.customer?
      can :read, Hotel  
      can :read, Room
      can :create, Booking
      can :read, Booking
      can :destroy, Booking
      can :create, Payment
      can :read, Payment
    end
    
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
