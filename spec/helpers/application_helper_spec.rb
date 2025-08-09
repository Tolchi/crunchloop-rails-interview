require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#flash_class" do
    it "returns default flash class" do
      expect(helper.flash_class("dunno")).to eq("bg-gray-100 text-gray-800")
    end

    it "returns notice class" do
      expect(helper.flash_class("notice")).to eq("bg-green-100 text-green-800")
    end

    it "returns alert class" do
      expect(helper.flash_class("alert")).to eq("bg-red-100 text-red-800")
    end
  end
end
