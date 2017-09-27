class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      all_wikis = scope.all
      all_wikis.each do |wiki|
        if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user) || user.role == "admin"
          wikis << wiki
        end
      end
      wikis
    end
    
  end
  
end