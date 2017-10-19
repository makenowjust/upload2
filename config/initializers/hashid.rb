# frozen_string_literal: true

Hashid::Rails.configure do |config|
  config.override_find = false
  config.sign_hashids = false
end
