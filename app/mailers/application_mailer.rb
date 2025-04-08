include Rails.application.routes.url_helpers

class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
end
