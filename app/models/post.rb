class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :parent, class_name: "Post", :optional => true
  has_many :children, class_name: "Post", foreign_key: :parent_id

  # Recursively calculates the number of nodes above this one
  def number_of_parents
    if self.is_parent
      return 0
    else
      return 1 + self.parent.number_of_parents
    end
  end

  # https://swaac.tamouse.org/rails/2015/12/15/self-referential-models-categories/
  def is_parent
    !!self.parent.nil?
  end
end
