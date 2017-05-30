require 'rails_helper'

RSpec.describe Filter, type: :model do
  it "validates lang, distance and limit" do
    invalid = Filter.new({location: "location", limit: -5, distance: -10, lang: "fr"})
    valid = Filter.new({location: "location", limit: 5, distance: 10, lang: "en"})

    expect(invalid).to be_invalid
    expect(invalid.errors.messages.keys).to include(:limit)
    expect(invalid.errors.messages.keys).to include(:distance)
    expect(invalid.errors.messages.keys).to include(:lang)

    expect(valid).to be_valid
  end
end
