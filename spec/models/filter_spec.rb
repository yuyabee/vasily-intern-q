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

  it "assigns default values to distance, lang, limit when not given in params" do
    filter = Filter.new({location: "location" })

    expect(filter.limit).to eq(5)
    expect(filter.distance).to eq(0.5)
    expect(filter.lang).to eq("ja")
  end
end
