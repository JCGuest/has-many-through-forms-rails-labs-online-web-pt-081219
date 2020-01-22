class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      if category_attribute["name"].present?
      unless self.categories.include?(category_attribute)
        category = Category.find_or_create_by(category_attribute)
        self.post_categories.build(category: category)
        end
      end
    end
  end
end

#   def categories_attributes=(categories_hashes)
#     # {"0"=>{"name"=>"new cat"}}
#     categories_hashes.each do |i, cat_attributes|
#       category = Category.find_or_create_by(name: cat_attributes[:name])
#       self.post_categories.build(category: category)
#     end      
#   end
# end
 