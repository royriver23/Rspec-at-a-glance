FactoryGirl.define do
  factory :achievement do
    # title "Title"
    sequence(:title) {|n| "Achievement #{n}"}
    description "description"
    featured false
    cover_image "some_file.png"

    # Other are inherited
    factory :public_achievement do
      privacy :public_access
    end

    factory :private_achievement do
      privacy :private_access
    end
  end
end
